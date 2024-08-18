@tool
class_name Piece extends TileMapLayer

const hight = 670*0.25
const rad = (hight/2) * sin(PI/3)**-1 
const offset = Vector2(sqrt(rad**2 - (hight/2)**2)-6.5,0)
const ms = [-sqrt(3),0,sqrt(3),-sqrt(3),0,sqrt(3)]
#var cs = []

var pos: Vector2

func is_mouse_intercecting(hex:Vector2i) -> bool:
	#cs = []
	var angle = PI
	var mouse: Vector2 = get_global_mouse_position()+offset-cord_offset_calc(hex)+pos
	for i in 3:
		if  mouse.y < ms[i]*mouse.x + (rad*sin(angle)-(ms[i]*(rad*cos(angle)))):
			return false
		angle += PI/3
	
	for i in 3:
		if  mouse.y > ms[i]*mouse.x + (rad*sin(angle)-(ms[i]*(rad*cos(angle)))):
			return false
		angle += PI/3

	print("INSIDE", hex,mouse)
	return true

func cord_offset_calc(hex:Vector2i) -> Vector2:
	var out = Vector2.ZERO
	out.x = (2*rad + 2*offset.x)*((hex.x-(hex.x%2))/2) + (hex.x%2)*(rad+offset.x)
	out.y = (hex.y*hight) + (hight/2)*(hex.x%2) #+ (hight/2)*((hex.x)%2)/2
	#print(out)
	return out

func _enter_tree() -> void:
	tile_set = load("res://Resource/tile_set.tres")
	position = Vector2(-154,-85)
	scale = Vector2(0.25,0.25)
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print(name,str(get_used_cells()),global_position)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#print(rad, offset)
	#if ((global_position-offset) - get_global_mouse_position()).length() < rad :
	#return
	
	if "position" not in get_parent():
		pos = Vector2.ZERO
	else:
		pos = get_parent().position
	#print(pos)
	for i in get_used_cells():
		is_mouse_intercecting(i)
		#print(get_global_mouse_position())
