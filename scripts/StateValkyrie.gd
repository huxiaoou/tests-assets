class_name StateValkyrie extends Node

static var valkyrie: CharacterValkyrie

func _ready() -> void:
	pass # Replace with function body.

func enter() -> void:
	pass
	
func exit() -> void:
	pass

func process(_delta: float) -> StateValkyrie:
	"""
	function to be called by curr_state in StateMachineValkyrie
	"""
	return null

func physics(_delta: float) -> StateValkyrie:
	"""
	function to be called by curr_state in StateMachineValkyrie
	"""
	return null
	
func unhandle_input(_event: InputEvent) -> StateValkyrie:
	"""
	function to be called by curr_state in StateMachineValkyrie
	"""
	return null
