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
	for s in states:
		s.enemy = _enemy
		s.state_machine = self
		s.init()

	if not states.is_empty():
		change_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT

func change_state(new_state: StateEnemy) -> void:
	if new_state == null || new_state == curr_state:
		return
	if curr_state:
		curr_state.exit()
		
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()
	
func _process(delta: float) -> void:
	change_state(curr_state.process(delta))
	
func _physics_process(delta: float) -> void:
	change_state(curr_state.physics(delta))
