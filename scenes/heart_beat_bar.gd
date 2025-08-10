extends Bar


const STATES : Array[String] = ['gain', 'cooldown']
const FPS : int = 6

var timing : Dictionary[String, float] = {'gain': 2 * FPS, 'cooldown': 2 * FPS}
var speeds : Dictionary[String, float] = {'gain': 0, 'cooldown': 0}

# GAIN - character has the hbp, COOLDOWN - character wait to get hbp
var state : String = 'gain'
# Progress of the bar
var progress : float = timing[state]

signal state_change(new_state : String)
signal heartbeat_gain
signal heartbeat_cooldown


func _ready():
	super._ready()
	# Speed at which the timer sprite moves
	for key in timing:
		speeds[key] = content_size.x / timing[key]
	
	
func _physics_process(delta: float) -> void:
	update_progress(delta)
	update_content()
			
			
func update_progress(delta):
	progress -= speeds[state] * delta
	
	
func set_ratio(new_ratio : float):
	fill_ratio = clamp(new_ratio, 0, 1)
	super.update_content()
			
			
func update_content():
	set_ratio(progress / timing[state])
	
	if fill_ratio == 0:
		var new_state = STATES[(STATES.find(state) + 1) % 2]
		state_change.emit(new_state)


func _on_state_change(new_state: String) -> void:
	if new_state == 'gain':
		heartbeat_gain.emit()
		
	else:
		heartbeat_cooldown.emit()
		
	state = new_state
	content_sprite.frame = 0 if state == 'gain' else 1
	progress = timing[state]
	update_content()
