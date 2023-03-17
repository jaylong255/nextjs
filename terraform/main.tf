terraform {
  cloud {
    organization = "cyberworld-builders"

    workspaces {
      name = "cw-landing"
    }
  }
}