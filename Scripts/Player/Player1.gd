extends KinematicBody2D

# Signal emitted when player's health changes
signal health_changed(current_health)
signal player1_killed()

# Maximum health of the player
const MAX_HEALTH = 25
# Current health of the player
var current_health: int = MAX_HEALTH

# Movement speed of the player
var movespeed = 500

# Bullet variables
var bullet_speed = 2000
var bullet = preload("res://Scenes/bullet/bullet1.tscn")

# Variables to control burst firing
var burst_count = 0
var burst_max = 7  # Number of bullets per burst
var burst_cooldown = 3.0  # Cooldown between bursts
var burst_timer = 0.0

# Variable to store the last motion direction
var last_motion_direction = Vector2.ZERO

# Process player actions and movements
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

	# Handle burst cooldown
	if burst_timer > 0:
		burst_timer -= delta
	elif burst_count >= burst_max:
		burst_count = 0
	if Input.is_action_just_pressed("fire1"):
		fire()
	if Input.is_action_pressed("rafale1"):
		rafale()

	# Rotate the player based on the last motion direction
	if last_motion_direction.length_squared() > 0:
		rotation = last_motion_direction.angle()
		rotation_degrees = rad2deg(rotation)
		self.rotation_degrees = rotation_degrees

# Fire a single bullet
func fire():
	var bullet_instance = bullet.instance()
	bullet_instance.position = get_global_position()
	bullet_instance.rotation_degrees = rotation_degrees
	bullet_instance.apply_impulse(Vector2(), Vector2(bullet_speed,0).rotated(rotation))
	get_tree().get_root().call_deferred("add_child",bullet_instance)

# Fire a burst of bullets
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

# Reload the current scene (used for player respawn or restart)
func kill():
	emit_signal("player1_killed")

# Handle collision with bullets
func _on_Area2D_body_entered(body):
	# If player's health is depleted, reload the scene to restart the game
	if "bullet2" in body.name and current_health <= 1:
		kill()
	# If player is hit by a bullet, decrement health and emit health_changed signal
	elif "bullet2" in body.name:
		current_health -= 1
		emit_signal("health_changed", current_health)
		
func heal():
	current_health = MAX_HEALTH
	emit_signal("health_changed", current_health)
