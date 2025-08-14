extends Node2D

var HealthController : HealthDataClass

@onready var heartbeat_bar : Bar = $HeartbeatBar
@onready var health_bar : Bar= $HealthBar
@onready var overflow_bar : Bar = $OverflowBar

signal no_health


func _ready():
	HealthController = HealthDataClass.new(10, 5)
	HealthController.death.connect(_on_death)
	update_display()


func _on_heartbeat_bar_heartbeat_gain() -> void:
	HealthController.increase_hbp()
	update_display()


func _on_heartbeat_bar_heartbeat_cooldown() -> void:
	HealthController.deplete_hbp()
	update_display()
	
	
func _on_death():
	no_health.emit()
	heartbeat_bar.change_bpm(0)


func update_overflow_bar():
	overflow_bar.set_ratio(HealthController.hbp_ratio)
	overflow_bar.update_display(HealthController.current_hbp, HealthController.max_hbp)


func update_health_bar():
	health_bar.set_ratio(HealthController.health_ratio)
	health_bar.update_display(HealthController.current_health, HealthController.max_health)


func update_display():
	update_overflow_bar()
	update_health_bar()


func heal(healing : int):
	HealthController.heal(healing)
	update_display()
	
	
func take_damage(damage : int):
	HealthController.take_damage(damage)
	update_display()
