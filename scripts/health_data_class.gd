class_name HealthDataClass


var current_health : int
var current_hbp : int = 0
var total_health : int
var max_health : int
var max_hbp : int
var max_total_health : int

var hbp_flow : int

var health_ratio : float = 1
var hbp_ratio : float = 0

signal death


func _init(new_max_health : int, new_max_hbp : int, new_hbp_flow : int = -1) -> void:
	max_health = new_max_health
	current_health = max_health
	max_hbp = new_max_hbp
	hbp_flow = new_hbp_flow
	
	if new_hbp_flow == -1:
		hbp_flow = max_hbp
	
	max_total_health = max_health + max_hbp
	calculate_total_health()
	
	
func calculate_total_health():
	total_health = current_health + current_hbp
	
	if total_health == 0:
		death.emit()
	
	
func set_current_hbp(new_value : int):
	current_hbp = clamp(new_value, 0, max_hbp)
	calculate_total_health()
	calculate_hbp_ratio()
	

func calculate_hbp_ratio():
	var hbp_income = total_health - max_health
	hbp_ratio = clamp(hbp_income / max_hbp, 0, 1)
	
	
func set_current_health(new_value : int):
	current_health = clamp(new_value, 0, max_health)
	calculate_total_health()
	calculate_health_ratio()
	
	
func calculate_health_ratio():
	var health_income = clamp(total_health, 0, max_health)
	health_ratio = health_income / max_health
	
	
func take_damage(damage):
	if damage >= total_health:
		set_current_hbp(0)
		set_current_health(0)
		return
		
	var tmp = current_hbp
	set_current_hbp(current_hbp - damage)
	
	damage -= tmp
	set_current_health(current_health - damage)
	
	
func heal(healing : int):
	var overflowing_healing : int = healing - (max_health - current_health)
	set_current_health(current_health + healing)
	set_current_hbp(current_hbp + overflowing_healing)


func deplete_hbp():
	set_current_hbp(current_hbp - hbp_flow)


func increase_hbp():
	set_current_hbp(hbp_flow)
