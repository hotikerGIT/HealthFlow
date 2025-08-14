extends CharacterBody2D


var speed : float
var acceleration : float

@onready var health_management = $HealthDisplay
@onready var animation_player : AnimationPlayer = $AnimationPlayer


func _on_health_display_no_health() -> void:
	print('dead')
