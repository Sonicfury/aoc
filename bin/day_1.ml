open Core

let input: string = In_channel.read_all "inputs/day_1.txt" 
let codes_list: string list = input 
|> String.split_lines

let find_first_and_last_digits str =
  let len = String.length str in
  let rec find_first_digit i =
    if i < len then
      match str.[i] with
      | '0' .. '9' as digit ->
        Some (int_of_string (String.make 1 digit))
      | _ -> find_first_digit (i + 1)
    else
      None
  in
  let rec find_last_digit i =
    if i >= 0 then
      match str.[i] with
      | '0' .. '9' as digit ->
        Some (int_of_string (String.make 1 digit))
      | _ -> find_last_digit (i - 1)
    else
      None
  in
  match (find_first_digit 0, find_last_digit (len - 1)) with
  | (Some first_digit, Some last_digit) -> Some (first_digit, last_digit)
  | _ -> None

let rec iterate_over_list lst counter = 
  match lst with 
  | [] -> Printf.printf "Somme: %d\n" counter
  | head :: tail ->
    let concat = (match find_first_and_last_digits head with
    | Some (first_digit, last_digit) -> 
        let digit_string = Fmt.str "%d%d" first_digit last_digit in
        int_of_string digit_string
    | None -> 0) in
    let new_total = counter + concat in
    iterate_over_list tail new_total
    
let () =
    iterate_over_list codes_list 0;

