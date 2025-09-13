class_name CharacterValkyrie extends CharacterBody2D

var direction_mov: Vector2 = Vector2.ZERO
var direction_anim_new: Vector2 = Vector2.ZERO
var direction_anim: Vector2 = Vector2.ZERO
var anim_scale_x: float = 1

@onready var sprite_2d_idle: Sprite2D = $Sprite2DIdle
@onready var sprite_2d_slash: Sprite2D = $Sprite2DSlash
@onready var sprite_2d_walk: Sprite2D = $Sprite2DWalk
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachineValkyrie = $StateMachine
@onready var direction_arrow: DirectionArrow = $Sprite2DDirectionArrow

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d_idle.visible = true
	sprite_2d_slash.visible = false
	sprite_2d_walk.visible = false
	state_machine.initialize(self)
	direction_arrow.initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction_mov = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	).normalized()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func update_animation(state: String) -> void:
	animation_player.play(state)

func cal_new_anim_direction() -> void:
	direction_anim_new = direction_arrow.direction * 0.99 + direction_anim * 0.01
	direction_anim_new = Vector2.LEFT if direction_anim_new.x < 0 else Vector2.RIGHT

func is_anim_direction_changed() -> bool:
	return direction_anim_new != direction_anim

func update_anim_direction():
	direction_anim = direction_anim_new
	anim_scale_x = sign(direction_anim.x)

func change_anim_direction(state: String) -> void:
	cal_new_anim_direction()
	if is_anim_direction_changed():
		update_anim_direction()
		match state:
			"walk":
				sprite_2d_walk.scale.x = anim_scale_x
			"idle":
				sprite_2d_idle.scale.x = anim_scale_x
			_:
				return # print("other case")
		update_animation(state)
