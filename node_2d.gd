extends Node2D
@export var connected_room = preload("res://Scenes/door_1.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func enter_room():
	print("Entering Room!")
