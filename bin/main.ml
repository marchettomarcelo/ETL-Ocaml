open Etl

let () =
  if Array.length Sys.argv < 2 then failwith "Please provide an order origin:";

  let status = Sys.argv.(1) in
  let origin = Sys.argv.(2) in

  let order_item = 
    Lwt_main.run    (Fetch_csv.fetch_csv "https://raw.githubusercontent.com/marchettomarcelo/order-data/refs/heads/main/order_item.csv")    
    |> List.map Utils.row_to_order_item
  in

  Lwt_main.run (Fetch_csv.fetch_csv "https://raw.githubusercontent.com/marchettomarcelo/order-data/refs/heads/main/order.csv")

  |> List.map Utils.row_to_order
  |> (if status = "all" && origin = "all" then fun x -> x
     else
       List.filter (fun (order : Utils.order) ->
           order.status = status && order.origin = origin))
  |> List.map (fun (order : Utils.order) ->
         [
           string_of_int order.id;
           string_of_float (Utils.sum_by_order_id
                (fun item -> item.final_price)
                order.id order_item);
           string_of_float
             (Utils.sum_by_order_id
                (fun item -> item.tax_paid)
                order.id order_item);
         ])
  |> List.cons [ "order_id"; "final_price"; "tax_paid" ]
  |> Csv.save "output.csv"