class_name StateMachineEnemy extends Node

var states: Array[StateEnemy]
var prev_state: StateEnemy
var curr_state: StateEnemy

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED

func initialize(_enemy: Enemy) -> void:
	states = []
	for c in get_children():
		if c is StateEnemy:
			states.append(c)
			c.enemy = _enemy
			c.init()

	if not states.is_empty():
		check_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
	else:
		print("No state available")

func check_state(new_state: StateEnemy) -> void:
	if new_state == null || new_state == curr_state:
		return
	if curr_state:
		curr_state.exit()
		
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()
	
func _process(delta: float) -> void:
	check_state(curr_state.process(delta))
	
func _physics_process(delta: float) -> void:
	check_state(curr_state.physics(delta))
