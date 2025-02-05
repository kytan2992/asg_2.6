resource "aws_dynamodb_table_item" "item1" {
  table_name = aws_dynamodb_table.bookinventory.name
  hash_key   = var.hash_key
  range_key  = var.sort_key

  item = <<ITEM
{
  "ISBN": {"S": "978-0134685991"},
  "Genre": {"S": "Technology"},
  "Title": {"S": "Effective Java"},
  "Author": {"S": "Joshua Bloch"},
  "Stock": {"N": "1"}
}
ITEM
}

resource "aws_dynamodb_table_item" "item2" {
  table_name = aws_dynamodb_table.bookinventory.name
  hash_key   = var.hash_key
  range_key  = var.sort_key

  item = <<ITEM
{
  "ISBN": {"S": "978-0134685009"}, 
  "Genre": {"S": "Technology"}, 
  "Title": {"S": "Learning Python"}, 
  "Author": {"S": "Mark Lutz"}, 
  "Stock": {"N": "2"}
}
ITEM
}

resource "aws_dynamodb_table_item" "item3" {
  table_name = aws_dynamodb_table.bookinventory.name
  hash_key   = var.hash_key
  range_key  = var.sort_key

  item = <<ITEM
{
  "ISBN": {"S": "974-0134789698"}, 
  "Genre": {"S": "Fiction"}, 
  "Title": {"S": "The Hitchhiker"}, 
  "Author": {"S": "Douglas Adams"}, 
  "Stock": {"N": "10"}
}
ITEM
}