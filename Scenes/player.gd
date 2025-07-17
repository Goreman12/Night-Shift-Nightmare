extends CharacterBody2D

@export var speed = 1000

signal attacked(damage)

var player_damage: int = 25

var acceleration: float = 2.2
var direction
var can_attack: bool = true
var last_moved_direction = "right"
var is_attacking = false


func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	move_player(delta)
	attack_melee()

#Currently using flip_h to walk left, should revert this when we have an animation
func move_player(delta):
	direction = Input.get_axis("left", "right")
	if not is_attacking:
		if Input.is_action_pressed("right"):
			last_moved_direction = "right"
			$AnimatedSprite2D.flip_h = false
			$AnimatedSprite2D.play("walk")
			
		if Input.is_action_pressed("left"):
			last_moved_direction = "left"
			$AnimatedSprite2D.flip_h = true
			$AnimatedSprite2D.play("walk")
			
			
	velocity.x = direction * speed * acceleration * delta
	move_and_slide()
	
#Enemies get attacked twice if you attack while moving, unsure why, 
#maybe add an on_hit function that removes the hitbox, or bring back the 
#freeze movement effect
func attack_melee():
	var timer = $MeleeRecoveryTimer
	var collision = $MeleeArea2D/MeleeHitBox
	
	collision.set_deferred("disabled", 0)
	if Input.is_action_just_pressed("attack"):
		is_attacking = true
		if last_moved_direction == "right":
			collision.position.x = 14.718
			collision.set_deferred("disabled", 0)
			$AnimatedSprite2D.play("attack_right")
			timer.start()
		elif last_moved_direction == "left":
			collision.position.x = 0.135
			collision.set_deferred("disabled", 0)
			$AnimatedSprite2D.play("attack_left")
			timer.start()
	if timer.is_stopped() or !$AnimatedSprite2D.is_playing():
		is_attacking = false
		collision.set_deferred("disabled", 1)
		can_attack = true
		


func _on_melee_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.has_method("take_damage"):
		var current_target = area.get_parent() as Node
		current_target.take_damage(player_damage)
		$MeleeArea2D/MeleeHitBox.set_deferred("disabled", 1)
		attacked.emit(player_damage)
