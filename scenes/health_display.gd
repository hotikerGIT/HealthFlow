extends Node2D

var HealthController : HealthDataClass

@onready var heartbeat_bar = $HeartbeatBar
@onready var health_bar = $HealthBar
@onready var overflow_bar = $OverflowBar


func _ready():
	HealthController = HealthDataClass.new(10, 5)
	update_display()


func _on_heartbeat_bar_heartbeat_gain() -> void:
	HealthController.increase_hbp()
	update_display()


func _on_heartbeat_bar_heartbeat_cooldown() -> void:
	HealthController.deplete_hbp()
	overflow_bar_change()


func health_bar_change():
	health_bar.set_ratio(HealthController.health_ratio)
	health_bar.update_display(HealthController.current_health, HealthController.max_health)
	
	
func overflow_bar_change():
	overflow_bar.set_ratio(HealthController.hbp_ratio)
	overflow_bar.update_display(HealthController.current_hbp, HealthController.max_hbp)
	
	
func update_display():
	health_bar_change()
	overflow_bar_change()
