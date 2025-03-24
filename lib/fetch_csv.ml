open Cohttp_lwt_unix

let fetch_csv_from_url url =
  Lwt_main.run
    (let open Lwt.Infix in
    Client.get (Uri.of_string url) >>= fun (_, body) ->
    body |> Cohttp_lwt.Body.to_string >|= fun csv_data ->
    Csv.of_string csv_data |> Csv.input_all |> List.tl)
