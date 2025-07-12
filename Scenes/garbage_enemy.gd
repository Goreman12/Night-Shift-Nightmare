extends CharacterBody2D

@export var speed = 2000
var acceleration: int = 5
var distance_to_player = Vector2.ZERO

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	var player_pos = $"../Player".positition
	



func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("Player"):
		
