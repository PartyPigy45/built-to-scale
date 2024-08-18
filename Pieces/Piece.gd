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
	var mouse: Vector2 = get_global_mouse_position()+offset-cord_offset_calc(hex)#+pos
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
	
	
func _ready() -> void:
	print(name,str(get_used_cells()),global_position)


func _process(delta: float) -> void:
	if "position" not in get_parent():
		pos = Vector2.ZERO
	else:
		pos = get_parent().position

	var found = false
	for i in get_used_cells():
		found = true if is_mouse_intercecting(i) else found
	modulate = Color(0,1,1,1) if found else Color(1,1,1,1)
