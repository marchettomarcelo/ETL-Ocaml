open Sqlite3

let db_file = "orders.db"

let db = db_open db_file
let create_table () =
  let create_sql =
    "CREATE TABLE IF NOT EXISTS orders (
      order_id INTEGER PRIMARY KEY,
      total_amount REAL,
      total_taxes REAL
    );"
  in
  let delete_sql = "DELETE FROM orders;" in  (* Clear all records *)

  match exec db create_sql with
  | Rc.OK ->
      (match exec db delete_sql with
      | Rc.OK -> ()
      | _ -> failwith "Failed to delete old records")
  | _ -> failwith "Failed to create table"

  
let insert_data order_id final_price tax_paid =
  let sql = Printf.sprintf
    "INSERT INTO orders (order_id, total_amount, total_taxes) VALUES (%d, %f, %f);"
    order_id final_price tax_paid
  in
  match exec db sql with
  | Rc.OK -> ()
  | _ -> failwith "Failed to insert data"

let save_csv_to_sqlite rows =
 
  List.iter
    (fun row ->
      match row with
      | [order_id; final_price; tax_paid] ->
          insert_data (int_of_string order_id) (float_of_string final_price) (float_of_string tax_paid)
      | _ -> failwith "Malformed row")
    rows

