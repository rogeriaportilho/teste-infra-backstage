resource "aws_ecr_repository" "backstage-ecr-back" {
  name = "backstage-backend"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    Name = "Demo-DX"
  }
}

resource "aws_ecr_repository" "backstage-ecr-front" {
  name = "backstage-frontend"

  image_scanning_configuration {
    scan_on_push = false
  }

  tags = {
    Name = "Demo-DX"
  }
}