@tool
class_name Level extends Resource

@export var stage_num: int = 1
@export var title: String = ""
@export var score: int = 0
@export var scale: float = 1

@export var Stage: PackedScene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
