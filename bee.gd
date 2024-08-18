@tool
extends Node2D

@onready var wings = $Wings
@onready var face = $Face
@onready var animations = face.get_animation_list()

var animation_tabel = [0,1,3]

@export_enum("Angry","Happy","Sad",) var emotion:
	set(value):
		if value != emotion:
			emotion = value

func _ready() -> void:
	play_face()
	
func play_face():
	face.current_animation = animations[animation_tabel[emotion]]
