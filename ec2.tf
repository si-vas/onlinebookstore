resource "aws_instance" "web" {
  ami                         = "ami-0149b2da6ceec4bb0"
  instance_type               = "t2.nano"
  associate_public_ip_address = "true"
  key_name                    = "Ubuntu-N.V"
  subnet_id                   = "subnet-0594350f7ee6ae425"
  vpc_security_group_ids      = ["sg-00f8f7435032d1375"]
  tags = {
    Name = "Server-1"
  }
  user_data = <<EOF
#!/bin/bash
apt update -y
apt install unzip
echo 'ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQCxFQajaC5J/ZabF7VSRe8m0FlZRyMERi4Vr4S2Nsl4YHtjOHytEhugbHzgbKUvB1p5T8PYZXnHgh5vLxQuZZVhx19MfnD2lOgmqJs16LzNM5I/yub725wJLspoQ5nOrK9BUEDB2uki0Z3jP5vOgRole7avxLSiZO/a70h2mhtAEd0nOSZDBBVJBBwaS5UVHJRRvZUK/nkmwjTMF3ZSowroEknXX5oRc3AMlW+r649kZMoT3V/ImycxEKodgpgm/2qNqX2cMuIySbdGDt59OMWoVGGM8H59giA8AMPpeLn9TCz/I4z+BIV1JNPFkQaCcb7hfyWeCYSppp+6lWnM4RnAdClJS/r66OaPhCTM4CMwBhQ8fac44yINvOgJMzLzMsgW7iajDGdlcw7DkACqOlu0Ip7k+6gzYIj9dALpB6XrRLqNZZPXLqv1sOxYqXEIBQAvYDG4Ux1fy6jCPCRDIaV4Ybsa4UYSqyuOyFusIMKIvwa/BK7KuXkeNoARxJKCG20= jenkins@ip-172-31-15-47' >> /home/ubuntu/.ssh/authorized_keys
EOF
}
