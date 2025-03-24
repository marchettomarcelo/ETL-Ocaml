(* 

open Lwt
open Cohttp
open Cohttp_lwt_unix

let fetch_csv url =
  let open Lwt.Infix in
  Client.get (Uri.of_string url) >>= fun (_, body) ->
  body |> Cohttp_lwt.Body.to_string >|= fun csv_data ->
  Csv.of_string csv_data |> Csv.input_all 


let () =
  let url = "https://raw.githubusercontent.com/marchettomarcelo/order-data/refs/heads/main/order_item.csv" in
  let data = Lwt_main.run (fetch_csv url) in
  List.iter (fun row -> print_endline (String.concat ", " row)) data 
 *)
