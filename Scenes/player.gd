extends CharacterBody2D

@export var speed = 500
var acceleration: float = 5
var move_direction: Vector2
var can_attack: bool = true

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_direction = Vector2.ZERO
	move_player(delta)
	
	attack_melee()
	pass


func move_player(delta):
	
	if Input.is_action_pressed("right"):
		move_direction = Vector2.RIGHT
	if Input.is_action_pressed("left"):
		move_direction = Vector2.LEFT
	if move_direction.x == 0 and can_attack:
		$AnimatedSprite2D.play("idle")
	velocity = move_direction * speed * acceleration * delta
	move_and_slide()
	

func attack_melee():
	var timer = $MeleeRecoveryTimer
	var collision = $MeleeArea2D/CollisionShape2D
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and timer.is_stopped():
		collision.set_deferred("disabled", 0)
		$AnimatedSprite2D.play("attack_left")
		timer.start()
	if timer.is_stopped() or not can_attack:
		$AnimatedSprite2D.stop()
		collision.set_deferred("disabled", 1)
		can_attack = true


func _on_melee_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Enemy"):
		print("You attacked an enemy!")
		$MeleeArea2D/CollisionShape2D.set_deferred("disabled", 1)
