extends Bar


const STATES : Array[String] = ['gain', 'cooldown']

# Speed is measured in bpm, then when the animation needs to change the speed,
# bpm is converted into a speed coefficient
var bpms : Dictionary[String, float] = {'gain': 150, 'cooldown': 100}
var speeds : Dictionary[String, float]

# GAIN - character has the hbp, COOLDOWN - character wait to get hbp
var state : String = 'cooldown'

var animation_player : AnimationPlayer 

signal heartbeat_gain
signal heartbeat_cooldown


func _ready():
	animation_player = $AnimationPlayer
	animation_player.play(state)
	
	for _state in STATES:
		speeds[_state] = _bpm_to_coefficient(bpms[_state])
		
	_set_animation_speed()
	

# Function called after animation player stopped playing
func _on_state_change() -> void:
	# Change the current state
	state = STATES[(STATES.find(state) + 1) % 2]
	_set_animation_speed()
	
	# Emit new sygnals
	if state == 'gain':
		heartbeat_gain.emit()
		
	else:
		heartbeat_cooldown.emit()


func change_bpm(state : String, new_bpm : float):
	if state not in STATES:
		return
		
	bpms[state] = new_bpm
	speeds[state] = _bpm_to_coefficient(new_bpm)


func _bpm_to_coefficient(bpm : float):
	return bpm / 60
	

func _set_animation_speed():
	animation_player.speed_scale = speeds[state]
	animation_player.play(state)
