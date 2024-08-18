@tool
extends Node2D

@export var levels_path:String:
	set(value):
		levels_path = value
		load_all_levles()

@export var stage: int:
	set(value):
		load_all_levles()
		for i in all_levels:
			#i as Level
			print(i.stage_num)
			if value == i.stage_num:
				current_stage = i
				stage = value
				load_stage(i)
				break


var current_stage:Level 
var all_levels:Array = []

func load_all_levles() -> void:
	assert(levels_path,"invalid path")
	var folder = DirAccess.open(levels_path)
	folder.list_dir_begin()
	
	var filename = folder.get_next()
	while filename != "":
		if not folder.current_is_dir() and filename.find(".gd"):
			all_levels.push_back(load(levels_path.path_join(filename)))
		filename = folder.get_next()
	folder.list_dir_end()
	print(all_levels)

func load_stage(stage: Level) -> void:
	if $Goal == null:
		return

	#unlode
	var clear = $Pieces.get_children()
	clear.append($Goal)
	for i in clear:
		for j in i.get_children():
			j.queue_free()

	#load
	$Goal.add_child(stage.Goal.instantiate())
	var index: int = 0
	var positions = $Pieces.get_children()
	for i in stage.Pices:
		positions[index].add_child(i.instantiate())
		index += 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	load_stage(all_levels[stage])

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
