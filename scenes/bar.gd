extends CanvasLayer

@export var fill_ratio : float = 1
@export var starting_position : Vector2

@onready var content_sprite : Sprite2D = $FillContainer/Container


func _ready():
	update_content()
	
	
func set_ratio(new_ratio : float):
	fill_ratio = clamp(new_ratio, 0, 1)
	update_content()
	

func get_ratio():
	return fill_ratio
	
	
func update_content():
	var content_size = content_sprite.texture.get_size()
	var new_x_position : float = -content_size.x * (1 - fill_ratio)
	var new_position : Vector2 = Vector2(starting_position.x + new_x_position, starting_position.y)

	content_sprite.position = new_position
