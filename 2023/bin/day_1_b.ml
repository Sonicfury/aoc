open Core

let input: string = In_channel.read_all "inputs/day_1.txt" 

let replacement_map = [
  "one", "1";
  "two", "2";
  "three", "3";
  "four", "4";
  "five", "5";
  "six", "6";
  "seven", "7";
  "eight", "8";
  "nine", "9";
  "1", "1";
  "2", "2";
  "3", "3";
  "4", "4";
  "5", "5";
  "6", "6";
  "7", "7";
  "8", "8";
  "9", "9";
]

let rec replace_substring str start_pos direction nb_replacements =
  let len = String.length str in
  if start_pos >= len || start_pos < 0 || nb_replacements = 2 then
    str
  else
    let rec find_and_replace = function
      | [] -> replace_substring str (start_pos + direction) direction (nb_replacements + 1)
      | (pattern, replacement)::rest ->
        let pattern_len = String.length pattern in
        let match_start_pos =
          if direction = 1 then
            start_pos
          else
            start_pos - pattern_len + 1
        in
        let substr = String.sub str ~pos:match_start_pos ~len:pattern_len in
        let is_length_ok = start_pos + (pattern_len * direction) <= len in
        if (is_length_ok) && (substr = pattern) then
          let new_str =
            String.concat ""
              [ String.sub str ~pos:0 ~len:match_start_pos;
                replacement;
                String.sub str ~pos:(match_start_pos + pattern_len) ~len:(len - match_start_pos - pattern_len)
              ]
          in
          Printf.printf "Match found: %s -> %s\n" pattern replacement;
          Printf.printf "New string: %s\n" new_str;
          let next_pos =
            if direction = 1 then
              String.length new_str - 1
            else
              0
          in
          replace_substring new_str next_pos (-direction) nb_replacements
        else
          find_and_replace rest
    in
    Printf.printf "Processing position: %d\n" start_pos;
    find_and_replace replacement_map

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
  | [] -> Printf.printf "Sum: %d\n" counter
  | head :: tail ->
    let concat = (match find_first_and_last_digits head with
      | Some (first_digit, last_digit) -> 
          let digit_string = Fmt.str "%d%d" first_digit last_digit in
          int_of_string digit_string
      | None -> 0) in
    let new_total = counter + concat in
    iterate_over_list tail new_total
    
let () =
    replace_substring input[0] 0 1 0 |> Printf.printf "Somme: %d\n"
  (* input  *)
  (* |> String.split_lines *)
  (* |> List.map (fun code -> replace_substring code 0 1 0) *)
  (* |> iterate_over_list 0 *)

