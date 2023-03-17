terraform {
  cloud {
    organization = "cyberworld-builders"

    workspaces {
      name = "cw-landing"
    }
  }


}

provider "aws" {
  region = "us-east-1"
}
