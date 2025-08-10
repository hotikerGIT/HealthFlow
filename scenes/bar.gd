extends CanvasLayer

class_name Bar

# ratio of filling
@export var fill_ratio : float = 1

@onready var content_sprite : Sprite2D = $FillContainer/Content

var starting_position : Vector2
var content_size : Vector2


func _ready():
	starting_position = content_sprite.position
	content_size = content_sprite.get_rect().size * content_sprite.scale
	update_content()
	
	
func set_ratio(new_ratio : float):
	fill_ratio = clamp(new_ratio, 0, 1)
	update_content()
	

func get_ratio():
	return fill_ratio
	
	
func update_content():
	# Changes the content sprite depending on fill ratio
	var offset : float = -content_size.x * (1 - fill_ratio)
	var new_position : Vector2 = starting_position + Vector2(offset, 0)

	content_sprite.position = new_position
