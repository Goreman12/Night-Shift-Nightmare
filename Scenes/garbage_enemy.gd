extends CharacterBody2D

@onready var player: CharacterBody2D = $"../Player"

@export var speed = 250
var acceleration: float = 1.2
var distance_to_player = Vector2()
var direction
var detected_player: bool = false

var max_hp: int = 100
var current_hp: int = max_hp

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if detected_player:
		distance_to_player = player.position - position
		direction = distance_to_player.normalized()
		velocity = direction * speed * acceleration * delta
		move_and_slide()
		pass


func _on_area_2d_body_entered(body: CharacterBody2D) -> void:
	if body.is_in_group("Player"):
		detected_player = true
		print("Detected: ", body.name)
		pass
		

func take_damage():
	print("Took {} damage!")
	


func _on_player_attacked(damage: Variant) -> void:
	if current_hp > 0:
		current_hp -= damage
		print("Enemy took damage! Current HP: ", current_hp)
	if current_hp <= 0:
		queue_free()
