open Etl

let () =

  let status = Sys.argv.(1) in
  let origin = Sys.argv.(2) in
  
  (* Read csv file *)
  let order_item =
    Read_csv_file.read_csv_file "order_item.csv"
    |> List.map Utils.row_to_order_item
  in

  let order =
    Read_csv_file.read_csv_file "order.csv"
    |> List.map Utils.row_to_order
    |> List.filter (fun (order : Utils.order) ->
           order.status = status && order.origin = origin)
  in

  
  (* Create output with total_amount for each order *)
  let result =
    List.map
      (fun (order : Utils.order) : Utils.output ->
        {
          order_id = order.id;
          total_amount = Utils.sum_by_order_id (fun item -> item.final_price) order.id order_item;
          total_taxes = Utils.sum_by_order_id (fun item -> item.tax_paid) order.id order_item;
        })
      order
  in



  result
|> List.map (fun (item : Utils.output) ->
    [ string_of_int item.order_id;
      string_of_float item.total_amount;
      string_of_float item.total_taxes ])
|> List.cons ["order_id"; "final_price"; "tax_paid"]
|> Csv.save "output.csv"

;;
