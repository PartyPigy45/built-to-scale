@tool
class_name Piece extends TileMapLayer

@export var result:bool = false

const hight = 670*0.25
const rad = (hight/2) * sin(PI/3)**-1 
#const offset = Vector2(sqrt(rad**2 - (hight/2)**2)-6.5,0)
const ms = [-sqrt(3),0,sqrt(3),-sqrt(3),0,sqrt(3)]
#var cs = []

var pos: Vector2 = global_position
var offset : Vector2 = Vector2.ZERO
var hovered:bool = false
var pressed:bool = false

#func is_mouse_intercecting(hex:Vector2i) -> bool:
	# #cs = []
	#var angle = PI
	#var mouse: Vector2 = get_global_mouse_position()+offset-cord_offset_calc(hex)-pos
	#for i in 3:
	#	if  mouse.y < ms[i]*mouse.x + (rad*sin(angle)-(ms[i]*(rad*cos(angle)))):
	#		return false
	#	angle += PI/3
	#
	#for i in 3:
	#	if  mouse.y > ms[i]*mouse.x + (rad*sin(angle)-(ms[i]*(rad*cos(angle)))):
	#		return false
	#	angle += PI/3

	#print("INSIDE", hex,mouse)
	#return true


func cord_offset_calc(hex:Vector2i) -> Vector2:
	var out = Vector2.ZERO
	out.x = (2*rad + 2*offset.x)*((hex.x-(hex.x%2))/2) + (hex.x%2)*(rad+offset.x)
	out.y = (hex.y*hight) + (hight/2)*(hex.x%2) #+ (hight/2)*((hex.x)%2)/2
	#print(out)
	return out

func relesed():
	var collision = get_children()[0] as Area2D
	for entity in collision.get_overlapping_bodies(): 
		if entity.get_parent() is Piece:
			print("Overlap")
		
func _enter_tree() -> void:
	tile_set = load("res://Resource/tile_set.tres")
	position = Vector2(-154,-85)
	scale = Vector2(0.25,0.25)
	
	
func _ready() -> void:
	for i in get_children():
		i.connect("input_event",_on_area_2d_input_event)
		i.connect("mouse_entered",_on_area_2d_mouse_entered)
		i.connect("mouse_exited",_on_area_2d_mouse_exited)
	modulate = Color(0.4,0.4,0.4,1) if result else Color(1,1,1,1) 

func _process(_delta: float) -> void:
	modulate = Color(0.7,0.7,0.7,1) if hovered else Color(1,1,1,1)
	
	if pressed:
		global_position = get_global_mouse_position() + offset
		print(offset)
	else:
		global_position = pos

func _on_area_2d_mouse_entered() -> void:
	hovered = true

func _on_area_2d_mouse_exited() -> void:
	hovered = false

func _on_area_2d_input_event(_viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if pressed and event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and not event.pressed:
		relesed()
	
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		pressed = event.pressed
		offset = global_position - get_global_mouse_position()
