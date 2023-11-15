resource "aws_launch_template" "as_conf" {
  name_prefix   = "example"
  image_id      = "ami-02872df47199586cc"
  instance_type = "t3.small"
}

resource "aws_autoscaling_group" "example" {
  availability_zones = ["us-east-1a"]
  desired_capacity   = 2
  max_size           = 10
  min_size           = 1
  launch_template {
    id      = aws_launch_template.as_conf.id
    version = "$Latest"
  
  }
  warm_pool {
    pool_state                  = "Stopped"
    min_size                    = 1
    max_group_prepared_capacity = 10

    instance_reuse_policy {
      reuse_on_scale_in = true
    }
  }
}