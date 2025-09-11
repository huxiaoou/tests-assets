class_name StateValkyrieWalk extends StateValkyrie

@export var move_speed: float = 100

@onready var sprite_2d_walk: Sprite2D = $"../../Sprite2DWalk"
@onready var idle: StateValkyrieIdle = $"../Idle"
@onready var slash: StateValkyrieSlash = $"../Slash"

func enter() -> void:
	sprite_2d_walk.visible = true
	sprite_2d_walk.scale.x = valkyrie.anim_scale_x
	valkyrie.update_animation("walk")

func exit() -> void:
	sprite_2d_walk.visible = false

func process(_delta: float) -> StateValkyrie:
	if valkyrie.direction == Vector2.ZERO:
		return idle
	valkyrie.velocity = valkyrie.direction * move_speed
	if valkyrie.set_direction():
		valkyrie.update_animation("walk")
	return null

func unhandle_input(_event: InputEvent) -> StateValkyrie:
	if _event.is_action_pressed("attack"):
		return slash
	return null
