extends KinematicBody2D

signal player1_killed()

var movespeed = 500

#bullet var
var bullet_speed = 2000
var bullet = preload("res://Scenes/bullet/bullet1.tscn")

# Variable to store the last motion direction
var last_motion_direction = Vector2.ZERO

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var motion = Vector2()

	# Player movement code
	if Input.is_action_pressed("up1"):
		motion.y -= 1
	if Input.is_action_pressed("down1"):
		motion.y += 1
	if Input.is_action_pressed("left1"):
		motion.x -= 1
	if Input.is_action_pressed("right1"):
		motion.x += 1

	# Normalize the motion vector to ensure consistent movement speed in all directions
	motion = motion.normalized()

	# Move the player using move_and_slide
	motion = move_and_slide(motion * movespeed)

	# Update the last motion direction if the player is moving
	if motion.length_squared() > 0:
		last_motion_direction = motion
	
	# Rotate the player based on the last motion direction
	if last_motion_direction.length_squared() > 0:
		rotation = last_motion_direction.angle()
		rotation_degrees = rad2deg(rotation)
		self.rotation_degrees = rotation_degrees
		

	if Input.is_action_just_pressed("fire1"):
		fire()
	


func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)


func kill():
	emit_signal("player killed")


func _on_Area2D_body_entered(body):
	if "ennemy" in body.name:
		kill()
