extends CharacterBody2D

@onready var player: CharacterBody2D = $"."

@export var speed = 2000
var acceleration: int = 1.2
var distance_to_player = Vector2()
var direction
var detected_player: bool = false

func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	#if detected_player:
		#distance_to_player = player.position - position
		#direction = distance_to_player.normalized()
		#velocity = direction * speed * acceleration * delta
		#move_and_slide()
		pass



func _on_area_2d_body_entered(body: Node2D) -> void:
	#if body.is_in_group("Player"):
		#detected_player = true
		#print("Detected: ", body.name)
		pass
		
