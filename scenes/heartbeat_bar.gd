extends Bar


const STATES : Array[String] = ['gain', 'cooldown']

# Timing is measured in seconds of animation playing in animation_player
var timing : Dictionary[String, float] = {'gain': 1, 'cooldown': 1}
# Speed is measured as a coefficient of speed in animation_player for each animation
var speeds : Dictionary[String, float] = {'gain': 1, 'cooldown': 1}

# GAIN - character has the hbp, COOLDOWN - character wait to get hbp
var state : String = 'cooldown'

var animation_player : AnimationPlayer 

signal heartbeat_gain
signal heartbeat_cooldown


func _ready():
	animation_player = $AnimationPlayer
	animation_player.play(state)
	

# Function called after animation player stopped playing
func _on_state_change() -> void:
	# Change the current state
	state = STATES[(STATES.find(state) + 1) % 2]
	animation_player.speed_scale = speeds[state]
	animation_player.play(state)
	
	# Emit new sygnals
	if state == 'gain':
		heartbeat_gain.emit()
		
	else:
		heartbeat_cooldown.emit()


func change_animation_duration(animation_name : String, new_time : float):
	if animation_name not in STATES:
		return false
		
	var original_length : float = speeds[animation_name]
	var desired_speed : float = original_length / new_time
	
	speeds[animation_name] = desired_speed
