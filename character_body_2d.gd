extends CharacterBody2D

# Variables for controlling the character's state
var speed = 200
var jump_force = 400
var gravity = 800
var velocity = Vector2.ZERO
var is_jumping = false

# Variables for game management
var lives = 3
var score = 0

# UI Labels
onready var lives_label = $LivesLabel
onready var score_label = $ScoreLabel
onready var game_over_label = $GameOverLabel

# Called every frame
func _process(delta):
    # Handle controls
    handle_input(delta)

    # Apply gravity
    if not is_on_floor():
        velocity.y += gravity * delta
    else:
        if is_jumping:
            is_jumping = false

    # Move the character
    velocity.x = 0
    if Input.is_action_pressed("ui_right"):
        velocity.x += speed
    if Input.is_action_pressed("ui_left"):
        velocity.x -= speed

    move_and_slide(velocity, Vector2.UP)

# Function to handle input for keyboard and touch
func handle_input(delta):
    if Input.is_action_just_pressed("ui_accept") and is_on_floor():
        velocity.y = -jump_force
        is_jumping = true
    
    # Touch input for jumping
    if Input.touch_count() > 0:
        var touch = Input.get_touch(0)
        if touch.pressed and is_on_floor():
            velocity.y = -jump_force
            is_jumping = true

# Collision detection with NPCs
func _on_NPC_body_entered(body):
    if body.is_in_group("enemies"):
        lives -= 1
        update_ui()
        if lives <= 0:
            game_over()

# Update UI labels for lives and score
func update_ui():
    lives_label.text = "Lives: %d" % lives
    score_label.text = "Score: %d" % score

# Game over function
func game_over():
    get_tree().paused = true
    game_over_label.visible = true
    
# Restart functionality
func _on_RestartButton_pressed():
    lives = 3
    score = 0
    game_over_label.visible = false
    get_tree().paused = false
    update_ui()