variable "ami_id" {
  default = "ami-02dfbd4ff395f2a1b"
}

variable "project" {
  default = "expense"
}

variable "environment" {
  default = "dev"
}

variable "instances" {
  type = map(any)
  default = {
    database = {
      instance_type = "t3.micro"
    },
    backend = {
      instance_type = "t3.micro"
    },
    frontend = {
      instance_type = "t3.micro"
    },
    lb = {
      instance_type = "t3.micro"
    }
  }
}

variable "ingress_rules" {
  type = map(any)
  default = {
    "ssh" = {
      port        = 22
      protocol    = "TCP"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
}

variable "domain" {
  default = "mrmotam.online"
}

variable "zoneid" {
  default = "Z00263282318BT9FBW1XK"
}

variable "common_tags" {
  default = {
    Project     = "expense"
    Environment = "dev"
  }
}