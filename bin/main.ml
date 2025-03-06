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

  let sum_by_order_id field_extractor order_id_compare order_items =
    List.fold_left
      (fun acc (item : Utils.order_item) ->
        if item.order_id = order_id_compare then acc +. field_extractor item
        else acc)
      0. order_items
  in

  (* Create output with total_amount for each order *)
  let result =
    List.map
      (fun (order : Utils.order) : Utils.output ->
        {
          order_id = order.id;
          total_amount =
            sum_by_order_id (fun item -> item.final_price) order.id order_item;
          total_taxes =
            sum_by_order_id (fun item -> item.tax_paid) order.id order_item;
        })
      order
  in

  (* Print updated results *)
  List.iter
    (fun (output : Utils.output) ->
      Printf.printf "Order ID: %d, Total Amount: %f, Total Taxes: %f\n"
        output.order_id output.total_amount output.total_taxes)
    result
