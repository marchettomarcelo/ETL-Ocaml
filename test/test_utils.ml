open OUnit2
open Etl   (* Replace with the actual module name containing your functions *)

(* Test suite for row_to_order *)
let test_row_to_order _ =
  let valid_row = ["1"; "100"; "2025-03-24"; "pending"; "web"] in
  let order = Utils.row_to_order valid_row in
  assert_equal 1 order.id ~msg:"ID should be 1";
  assert_equal 100 order.client_id ~msg:"Client ID should be 100";
  assert_equal "2025-03-24" order.order_date ~msg:"Order date should match";
  assert_equal "pending" order.status ~msg:"Status should be pending";
  assert_equal "web" order.origin ~msg:"Origin should be web";
  assert_equal 0. order.total_amount ~msg:"Total amount should be 0.";
  
  (* Test invalid row *)
  assert_raises 
    (Failure "Invalid CSV row format") 
    (fun () -> Utils.row_to_order ["1"; "100"]) 
    ~msg:"Should fail with invalid row format"

(* Test suite for row_to_order_item *)
let test_row_to_order_item _ =
  let valid_row = ["1"; "200"; "2"; "10.5"; "0.2"] in
  let item = Utils.row_to_order_item valid_row in
  assert_equal 1 item.order_id ~msg:"Order ID should be 1";
  assert_equal 200 item.product_id ~msg:"Product ID should be 200";
  assert_equal 2 item.quantity ~msg:"Quantity should be 2";
  assert_equal 10.5 item.price ~msg:"Price should be 10.5";
  assert_equal 0.2 item.tax ~msg:"Tax should be 0.2";
  assert_equal (0.2 *. 2. *. 10.5) item.tax_paid ~msg:"Tax paid should be calculated correctly";
  assert_equal (2. *. 10.5) item.final_price ~msg:"Final price should be calculated correctly";
  
  (* Test invalid row *)
  assert_raises 
    (Failure "Invalid CSV row format") 
    (fun () -> Utils.row_to_order_item ["1"; "200"]) 
    ~msg:"Should fail with invalid row format"

(* Test suite for order_to_row *)
let test_order_to_row _ =
  let order: Utils.order = {
    id = 1;
    client_id = 100;
    order_date = "2025-03-24";
    status = "pending";
    origin = "web";
    total_amount = 0.;
  } in
  let row = Utils.order_to_row order in
  assert_equal ["1"; "100"; "2025-03-24"; "pending"; "web"] row 
    ~msg:"Order should be converted to correct row format"

(* Test suite for sum_by_order_id *)
let test_sum_by_order_id _ =
  let items: Utils.order_item list = [
    { order_id = 1; product_id = 200; quantity = 2; price = 10.5; tax = 0.2; tax_paid = 4.2; final_price = 21. };
    { order_id = 1; product_id = 201; quantity = 1; price = 5.0; tax = 0.1; tax_paid = 0.5; final_price = 5. };
    { order_id = 2; product_id = 202; quantity = 3; price = 8.0; tax = 0.15; tax_paid = 3.6; final_price = 24. };
  ] in
  let sum_tax_paid = Utils.sum_by_order_id (fun item -> item.tax_paid) 1 items in
  assert_equal (4.2 +. 0.5) sum_tax_paid ~msg:"Sum of tax_paid for order_id 1 should be 4.7";
  
  let sum_final_price = Utils.sum_by_order_id (fun item -> item.final_price) 2 items in
  assert_equal 24. sum_final_price ~msg:"Sum of final_price for order_id 2 should be 24.";
  
  let sum_empty = Utils.sum_by_order_id (fun item -> item.final_price) 3 items in
  assert_equal 0. sum_empty ~msg:"Sum for non-existent order_id should be 0."


(* Test suite *)
let suite =
  "order_tests" >::: [
    "test_row_to_order" >:: test_row_to_order;
    "test_row_to_order_item" >:: test_row_to_order_item;
    "test_order_to_row" >:: test_order_to_row;
    "test_sum_by_order_id" >:: test_sum_by_order_id;
  ]

(* Run the tests *)
let () =
  run_test_tt_main suite 