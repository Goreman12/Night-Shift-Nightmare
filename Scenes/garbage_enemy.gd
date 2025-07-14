extends CharacterBody2D

@onready var player: CharacterBody2D = $"../Player"
@export var speed = 250

var acceleration: float = 1.2
var distance_to_player = Vector2()
var direction
var detected_player: bool = false

@export var max_hp: int = 100
var current_hp: int = max_hp
var new_hp: int

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if detected_player:
		distance_to_player = player.position - position
		direction = distance_to_player.normalized()
		if direction.x <= 0:
			$AnimatedSprite2D.flip_h = true
			$CollisionShape2D2.position.x = -4.0
		velocity = direction * speed * acceleration * delta
		move_and_slide()
		pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		detected_player = true
		

func take_damage(damage):
	$AnimatedSprite2D.modulate = Color.RED
	var old_speed = speed
	speed = 0
	await get_tree().create_timer(0.5).timeout
	speed = old_speed
	await get_tree().create_timer(0.15).timeout
	$AnimatedSprite2D.modulate = Color.WHITE
	
	print("Took ", damage, " damage!")
	if current_hp > 0:
		current_hp -= damage
		print("Enemy took damage! Current HP: ", current_hp)
	if current_hp <= 0:
		queue_free()
	


#func _on_player_attacked(damage: Variant) -> void:
	#take_damage(damage)
