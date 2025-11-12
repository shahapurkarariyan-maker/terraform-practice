output "publicip" {
    value = aws_instance.webserver.publicip

  
}
output "az" {
  
  value = aws_instence.server.available.az
}
output "pvtip" {
    value = aws_instance.server.publicip
  
}