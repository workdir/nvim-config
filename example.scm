"return" @keyword.return

[
 "goto"
 "in"
 "local"
]

(break_statement) @keyword

(function_call ; [44, 0] - [44, 43]
    name: (dot_index_expression ; [44, 0] - [44, 14]
      table: (dot_index_expression ; [44, 0] - [44, 10]
        table: (identifier) ; [44, 0] - [44, 3]
        field: (identifier)) ; [44, 4] - [44, 10]
      field: (identifier)) ; [44, 11] - [44, 14]
    arguments: (arguments ; [44, 14] - [44, 43]
      (string ; [44, 15] - [44, 18]
        content: (string_content)) ; [44, 16] - [44, 17]
      (string ; [44, 20] - [44, 27]
        content: (string_content)) ; [44, 21] - [44, 26]
      (string ; [44, 29] - [44, 42]
        content: (string_content ; [44, 30] - [44, 41]
          (escape_sequence)))))
