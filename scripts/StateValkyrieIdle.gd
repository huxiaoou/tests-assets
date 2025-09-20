class_name StateValkyrieIdle extends StateValkyrie

@onready var walk: StateValkyrie = $"../Walk"
@onready var slash: StateValkyrie = $"../Slash"

func enter() -> void:
	valkyrie.update_animation("idle")

func process(_delta: float) -> StateValkyrie:
	if valkyrie.direction_mov != Vector2.ZERO:
		return walk
	valkyrie.velocity = Vector2.ZERO
	valkyrie.change_anim_direction("idle")
	return null

func unhandle_input(_event: InputEvent) -> StateValkyrie:
	if _event.is_action_pressed("attack"):
		return slash
	return null
