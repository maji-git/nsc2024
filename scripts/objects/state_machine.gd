extends Node

@export var initial_state: State
	
var states: Dictionary = {}
var curr_state: State 

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(on_child_transitioned)
	
	print(states)
	if initial_state:
		initial_state.enter()
		curr_state = initial_state


func _process(delta):
	if curr_state:
		curr_state.process(delta)


func _physics_process(delta):
	if curr_state:
		curr_state.physics_process(delta)


func on_child_transitioned(state: State, new_state: String):
	if state != curr_state:
		return
		
	var new_state_item: State = states.get(new_state.to_lower())
	if !new_state:
		return
		
	if curr_state:
		curr_state.exit()
	
	new_state_item.enter()
	curr_state = new_state_item
