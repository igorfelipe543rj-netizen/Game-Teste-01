extends CharacterBody2D

# Constants
const SPEED = 200
const JUMP_VELOCITY = -400
const GRAVITY = 900

# Variables
var is_jumping = false

# Called every frame
func _process(delta):
    # Process player input
    var direction = Vector2.ZERO
    if Input.is_action_pressed("ui_right"):
        direction.x += 1
    if Input.is_action_pressed("ui_left"):
        direction.x -= 1

    # Normalize the direction to ensure consistent speed
    direction = direction.normalized()

    # Move the player
    move_and_slide(direction * SPEED)

    # Check for jump input
    if Input.is_action_just_pressed("ui_up") and not is_jumping:
        is_jumping = true
        velocity.y = JUMP_VELOCITY

    # Apply gravity
    velocity.y += GRAVITY * delta

    # Check if the player is on the floor
    if is_on_floor():
        is_jumping = false
        velocity.y = 0
