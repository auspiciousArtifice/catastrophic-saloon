extends Node
class_name FSM

@export var state: State

func _ready():
	change_state(state)

func change_state(new_state: State):
	if state is State:
		state._exit_state()
	new_state._enter_state()
	state = new_state
	print("State changed to %s" % str(new_state))
