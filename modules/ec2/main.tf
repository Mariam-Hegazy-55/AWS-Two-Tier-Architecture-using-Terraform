
#Create EC2 instance
resource "aws_instance" "web1" {
    ami = var.ami
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    vpc_security_group_ids = var.sg_id
    key_name = var.key
    associate_public_ip_address = true

    tags = {
      name= "WebServer"
    }

    provisioner "remote-exec" {
    inline = [
    "sudo apt update -y",
    "sudo apt install -y apache2 php php-mysql mysql-client wget unzip",
    "sudo systemctl enable apache2",
    "sudo systemctl start apache2",
    "cd /tmp",
    "wget https://wordpress.org/latest.zip",
    "unzip latest.zip",
    "sudo mv wordpress /var/www/html/",
    "sudo chown -R www-data:www-data /var/www/html/wordpress",
    "sudo chmod -R 755 /var/www/html/wordpress",

  ]

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.private_key_path)
    host        = self.public_ip
    timeout     = "2m"
    
  }
} 

  
}











