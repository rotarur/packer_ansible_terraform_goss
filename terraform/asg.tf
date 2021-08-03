resource "aws_launch_configuration" "main" {
  name_prefix     = var.project_name
  image_id        = data.aws_ami.main.image_id
  instance_type   = var.instance_type
  key_name        = aws_key_pair.main.key_name
  security_groups = [aws_security_group.main.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  name                = var.project_name
  vpc_zone_identifier = [var.private_subnet_id]
  desired_capacity    = 1
  max_size            = 1
  min_size            = 1

  launch_configuration = aws_launch_configuration.main.name

  target_group_arns    = [aws_lb_target_group.main.arn]
  termination_policies = ["OldestInstance", "OldestLaunchTemplate"]
}

resource "aws_autoscaling_attachment" "main" {
  autoscaling_group_name = aws_autoscaling_group.main.id
  alb_target_group_arn   = aws_lb_target_group.main.arn
}
