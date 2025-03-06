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

type output = {
  order_id : int;
  total_amount : float;
  total_taxes : float;
}


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
        final_price = (float_of_string quantity) *. (float_of_string price);  (* Use multiplication for float *)
      
      }
  | _ -> failwith "Invalid CSV row format"

let order_to_row order =
  [ string_of_int order.id;
    string_of_int order.client_id;
    order.order_date;
    order.status;
    order.origin ]
