class_name StateMachineValkyrie extends Node

var states: Array[StateValkyrie]
var prev_state: StateValkyrie
var curr_state: StateValkyrie

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check_state(curr_state.process(delta))
	
func _physics_process(delta: float) -> void:
	check_state(curr_state.physics(delta))
	
func _unhandled_input(event: InputEvent) -> void:
	check_state(curr_state.unhandle_input(event))
	
	
func initialize(_CharacterValkyrie: CharacterValkyrie) -> void:
	states = []
	for c in get_children():
		if c is StateValkyrie:
			states.append(c)
			
	if not states.is_empty():
		StateValkyrie.valkyrie = _CharacterValkyrie
		check_state(states[0])
		process_mode = Node.PROCESS_MODE_INHERIT
		print(states[0].valkyrie)
	else:
		print("No state available")

func check_state(new_state: StateValkyrie) ->void:
	if new_state == null || new_state == curr_state:
		return
	if curr_state:
		curr_state.exit()
	
	prev_state = curr_state
	curr_state = new_state
	curr_state.enter()
