extends KinematicBody2D

var movespeed = 500

#bullet var
var bullet_speed = 2000
var bullet = preload("res://Scenes/bullet/bullet1.tscn")

#guard var
var is_guarding = false
var guard_duration = 3.0
var guard_cooldown = 5.0
var guard_timer = 0.0
var cooldown_timer = 0.0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var motion = Vector2()
	var ennemy = get_parent().get_node("ennemy")

	#player mvnt code
	if Input.is_action_pressed("up1"):
		motion.y -= 1
	if Input.is_action_pressed("down1"):
		motion.y += 1
	if Input.is_action_pressed("left1"):
		motion.x -= 1
	if Input.is_action_pressed("right1"):
		motion.x += 1

	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	look_at(ennemy.position)
	
	if Input.is_action_just_pressed("fire1"):
		fire()
	


func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)


func kill():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if "ennemy" in body.name:
		kill()
