class_name StateValkyrieWalk extends StateValkyrie

@export var move_speed: float = 180

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
	if valkyrie.direction_mov == Vector2.ZERO:
		return idle
	valkyrie.velocity = valkyrie.direction_mov * move_speed
	valkyrie.cal_new_anim_direction()
	if valkyrie.is_anim_direction_changed():
		valkyrie.update_anim_direction()
		sprite_2d_walk.scale.x = valkyrie.anim_scale_x
		valkyrie.update_animation("walk")
	return null

func unhandle_input(_event: InputEvent) -> StateValkyrie:
	if _event.is_action_pressed("attack"):
		return slash
	return null
