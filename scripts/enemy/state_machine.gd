extends Node
#class_name StateMachine

var states: Dictionary = {}
@export var initial_state: EnemyState
var curr_state: EnemyState

func _ready():
	for i in get_children():
		if i is EnemyState:
			states[i.name.to_lower()] = i
			i.change_state.connect(on_child_transitioned)
	
	print(states)
	if initial_state:
		initial_state.enter()
	curr_state = initial_state

func force_change_state(new_name: String):
	var neww := states.get(new_name.to_lower()) as EnemyState
	
	if !neww:
		return
	
	if curr_state == neww:
		return
	
	if curr_state:
		Callable(curr_state, "exit").call_deferred()
	
	neww.enter()
	curr_state = neww

func _process(delta):
	if curr_state:
		curr_state.process(delta)
		
func _physics_process(delta):
	if curr_state:
		curr_state.physics_process(delta)


func on_child_transitioned(state: EnemyState, new_state: String):
	if curr_state != state:
		return
	
	var n: EnemyState = states.get(new_state)
	if !n:
		return
	
	if state:
		state.exit()
	
	n.enter()
	curr_state = n
