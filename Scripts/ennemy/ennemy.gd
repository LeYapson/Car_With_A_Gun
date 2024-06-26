extends KinematicBody2D

var motion = Vector2()
var speed = 100


func _physics_process(delta):
	var Player = get_parent().get_node("Player1solo")
	position += (Player.position - position) / speed
	look_at(Player.position)
	move_and_collide(motion * speed)


func _on_Area2D_body_entered(body):
	if "bullet1" in body.name:
		queue_free()


func increase_speed():
	speed -= 10
