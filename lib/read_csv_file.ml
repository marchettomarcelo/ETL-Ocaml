(* lib/marcelo.ml *)

let read_csv_file file_name = Csv.load file_name |> List.tl ;;