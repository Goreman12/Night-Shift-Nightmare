extends CharacterBody2D

@export var speed = 1000

signal attacked(damage)

var player_damage: int = 25

var acceleration: float = 2.2
var direction
var last_moved_direction = "right"

var can_attack: bool = true
var is_attacking = false

var can_enter_room = false

func _ready() -> void:
	pass
	
func _physics_process(delta: float) -> void:
	attack_melee()
	move_player(delta)
	

#Currently using flip_h to walk left, should revert this when we have an animation
func move_player(delta):
	direction = Input.get_axis("left", "right")
	if velocity.x == 0 and not is_attacking:
			$AnimatedSprite2D.play("idle")
	if not is_attacking and velocity.x != 0:
		if Input.is_action_pressed("right"):
			last_moved_direction = "right"
			$AnimatedSprite2D.play("walk_right")
			
		if Input.is_action_pressed("left") and velocity.x != 0:
			last_moved_direction = "left"
			$AnimatedSprite2D.play("walk_left")
		
		
			
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
			collision.set_deferred("disabled", false)
			$AnimatedSprite2D.play("attack_right")
			timer.start()
		else:
			collision.position.x = 0.135
			collision.set_deferred("disabled", false)
			$AnimatedSprite2D.play("attack_left")
			timer.start()
	if timer.is_stopped() or !$AnimatedSprite2D.is_playing():
		collision.set_deferred("disabled", true)
		can_attack = true
		is_attacking = false
	
		


func _on_melee_area_2d_area_entered(area: Area2D) -> void:
	if area.owner.has_method("take_damage"):
		var current_target = area.get_parent() as Node
		current_target.take_damage(player_damage)
		$MeleeArea2D/MeleeHitBox.set_deferred("disabled", 1)
		attacked.emit(player_damage)


func _on_door_area_2d_area_entered(area: Area2D) -> void:
	if area.get_parent().is_in_group("Door"):
		can_enter_room = true
		print("This is a door!")
		if Input.is_action_just_pressed("Interact") and can_enter_room:
			var current_target = area.get_parent() as Node
			print("Entering room...")
			current_target.enter_room()
