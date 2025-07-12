extends CharacterBody2D

@export var speed = 2000
var acceleration: int = 5
var move_direction = Vector2.ZERO

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_player(delta)
	attack_melee()


func move_player(delta):
	move_direction = Vector2.ZERO
	
	if Input.is_action_pressed("right"):
		move_direction = Vector2.RIGHT
	if Input.is_action_pressed("left"):
		move_direction = Vector2.LEFT
	velocity = move_direction * speed * acceleration * delta
	
	move_and_slide()


func attack_melee():
	var timer = $MeleeRecoveryTimer
	var collision = $MeleeArea2D/CollisionShape2D
	var can_attack: bool = true
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer.is_stopped():
		collision.set_deferred("disabled", 0)
		timer.start()
	if timer.is_stopped() or not can_attack:
		collision.set_deferred("disabled", 1)
		can_attack = true


func _on_melee_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print("You attacked an enemy!")
		$MeleeArea2D/CollisionShape2D.set_deferred("disabled", 1)
