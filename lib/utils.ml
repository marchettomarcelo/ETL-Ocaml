type order = {
  id : int;
  client_id : int;
  order_date : string;
  status : string;
  origin : string;
  total_amount: float;
}

type order_item = {
  order_id : int;
  product_id : int;
  quantity : int;
  price : float;
  tax : float;
  tax_paid: float;
  final_price: float;
}

(**
  Converts a CSV row (list of strings) into an order record.
  @param row A list of strings representing the columns of a CSV row.
  @return An order record parsed from the CSV row.
  @raise Failure if the row format is invalid.
*)
let row_to_order row =
  match row with
  | [ id; client_id; order_date; status; origin ] ->
      {
        id = int_of_string id;
        client_id = int_of_string client_id;
        order_date;
        status;
        origin;
        total_amount = 0.;
      }
  | _ -> failwith "Invalid CSV row format"

(**
  Converts a CSV row (list of strings) into an order_item record.
  @param row A list of strings representing the columns of a CSV row.
  @return An order_item record parsed from the CSV row.
  @raise Failure if the row format is invalid.
*)
let row_to_order_item row =
  match row with
  | [ order_id; product_id; quantity; price; tax ] ->
      {
        order_id = int_of_string order_id;
        product_id = int_of_string product_id;
        quantity = int_of_string quantity;
        price = float_of_string price;
        tax = float_of_string tax;
        tax_paid = (float_of_string tax) *. (float_of_string quantity) *. (float_of_string price);
        final_price = (float_of_string quantity) *. (float_of_string price);
      }
  | _ -> failwith "Invalid CSV row format"

(**
  Converts an order record into a list of strings for CSV output.
  @param order The order record to be converted.
  @return A list of strings representing the order as a CSV row.
*)
let order_to_row order =
  [ string_of_int order.id;
    string_of_int order.client_id;
    order.order_date;
    order.status;
    order.origin ]

(**
  Sums a specific field for all order items that match a given order ID.
  @param field_extractor A function that extracts the field to sum from an order_item.
  @param order_id_compare The order ID to match.
  @param order_items A list of order_item records.
  @return The sum of the extracted field for the matching order items.
*)
let sum_by_order_id field_extractor order_id_compare order_items =
    List.fold_left
      (fun acc (item : order_item) ->
        if item.order_id = order_id_compare then acc +. field_extractor item
        else acc)
      0. order_items


