variable "ami_id" {
    description = "passing ami values"
    default = "t3micro"
    type = string
  
}
variable "type" {
    description = "passing values to instance type"
    default = "t3micro"
    type = string
  
}