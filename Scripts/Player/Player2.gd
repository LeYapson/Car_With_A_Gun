extends KinematicBody2D

signal health_changed(new_health)

const MAX_HEALTH = 25
var current_health = MAX_HEALTH

var movespeed = 500
var lock_rotate = false
#bullet var
var bullet_speed = 2000
var bullet = preload("res://Scenes/bullet/bullet2.tscn")

# Declare variables to control burst firing
var burst_count = 0
var burst_max = 7  # Number of bullets per burst
var burst_cooldown = 3.0  # Cooldown between bursts
var burst_timer = 0.0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _physics_process(delta):
	var motion = Vector2()
	var Player1 = get_parent().get_node("Player1")
	#player mvnt code
	if Input.is_action_pressed("up2"):
		motion.y -= 1
	if Input.is_action_pressed("down2"):
		motion.y += 1
	if Input.is_action_pressed("left2"):
		motion.x -= 1
	if Input.is_action_pressed("right2"):
		motion.x += 1
	if Input.is_action_pressed("rotate1"):
		lock_rotate = true
	else:
		lock_rotate = false
	
	motion = motion.normalized()
	motion = move_and_slide(motion * movespeed)
	# Lock rotation if enabled
	if not lock_rotate:
		look_at(Player1.position)
	
	# Handle burst cooldown
	if burst_timer > 0:
		burst_timer -= delta
	elif burst_count >= burst_max:
		burst_count = 0
	
	if Input.is_action_just_pressed("fire2"):
		fire()
	
	if Input.is_action_pressed("rafale2"):
		rafale()



func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)


func rafale():
	if burst_count < burst_max:
		var bullet_instance = bullet.instance()
		bullet_instance.position = get_global_position()
		bullet_instance.rotation_degrees = rotation_degrees
		bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
		get_tree().get_root().call_deferred("add_child",bullet_instance)
		burst_count += 1
	
	if burst_count >= burst_max:
		burst_timer = burst_cooldown

	
func kill():
	get_tree().reload_current_scene()


func _on_Area2D_body_entered(body):
	if "bullet1" in body.name and current_health <= 1:
		kill()
	elif "bullet1" in body.name:
		current_health -= 1
	emit_signal("health_changed", current_health)
