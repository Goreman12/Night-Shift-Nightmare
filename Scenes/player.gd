extends CharacterBody2D

@export var speed = 2000
var acceleration: int = 5
var move_direction = Vector2.ZERO


func _physics_process(delta: float) -> void:
	move_player(delta)
	


func move_player(delta):
	move_direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		move_direction = Vector2.RIGHT
	if Input.is_action_pressed("left"):
		move_direction = Vector2.LEFT
	velocity = move_direction * speed * acceleration * delta
	
	move_and_slide()
