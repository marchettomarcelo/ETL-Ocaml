open Etl

let () =
  Db_utils.create_table ();

  if Array.length Sys.argv < 3 then failwith "Please provide an order status and origin:";

  let status = Sys.argv.(1) in
  let origin = Sys.argv.(2) in

  let order_item = 
    Fetch_csv.fetch_csv_from_url "https://raw.githubusercontent.com/marchettomarcelo/order-data/refs/heads/main/order_item.csv"
    |> List.map Utils.row_to_order_item
  in

  Fetch_csv.fetch_csv_from_url "https://raw.githubusercontent.com/marchettomarcelo/order-data/refs/heads/main/order.csv"
  |> List.map Utils.row_to_order
  |> List.filter (fun (order : Utils.order) -> (status = "all" || order.status = status) && (origin = "all" || order.origin = origin))
  |> List.map (fun (order : Utils.order) ->
         [
           string_of_int order.id;
           string_of_float (Utils.sum_by_order_id (fun item -> item.final_price) order.id order_item);
           string_of_float (Utils.sum_by_order_id (fun item -> item.tax_paid) order.id order_item);
         ])
  |> Db_utils.save_csv_to_sqlite
