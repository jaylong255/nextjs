variable "stack" {
    type = string
    default = "cyberworld"
}

variable "env" {
    type = string
    default = "dev"
}

# TODO: Make these pull from terraform in the future
variable "certificate_arn" {
    type = string
    default = "arn:aws:acm:us-east-1:792312727657:certificate/490f488d-0184-4ddc-8829-5371c577ce25"
}

variable "aliases" {
    type = list(string)
    default = ["dev.cyberworldbuilders.com"]
}

variable "principal" {
    type = string
    default = "*"
}