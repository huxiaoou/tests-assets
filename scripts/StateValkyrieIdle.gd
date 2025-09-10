class_name StateValkyrieIdle extends StateValkyrie

@onready var sprite_2d_idle: Sprite2D = $"../../Sprite2DIdle"
@onready var walk: StateValkyrie = $"../Walk"
@onready var slash: StateValkyrie = $"../Slash"

func enter() -> void:
	sprite_2d_idle.visible = true
	valkyrie.update_animation("idle")

func exit() -> void:
	sprite_2d_idle.visible = false

func process(_delta: float) -> StateValkyrie:
	if valkyrie.direction != Vector2.ZERO:
		return walk
	valkyrie.velocity = Vector2.ZERO
	return null

func unhandle_input(_event: InputEvent) -> StateValkyrie:
	if _event.is_action_pressed("attack"):
		return slash
	return null
