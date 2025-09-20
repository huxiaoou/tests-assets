class_name CharacterValkyrie extends CharacterBody2D

var direction_mov: Vector2 = Vector2.ZERO
var direction_anim_new: Vector2 = Vector2.ZERO
var direction_anim: Vector2 = Vector2.ZERO
var anim_scale_x: float = 1

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
@onready var state_machine: StateMachineValkyrie = $StateMachine
@onready var direction_arrow: DirectionArrow = $AnimatedSprite2D/Sprite2DDirectionArrow


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	state_machine.initialize(self)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction_mov = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	).normalized()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func cal_new_anim_direction() -> void:
	var directon_id: int = int(round((direction_arrow.direction * 0.99 + direction_anim * 0.01).angle() / TAU * DIR_4.size()))
	direction_anim_new = DIR_4[directon_id]

func is_anim_direction_changed() -> bool:
	return direction_anim_new != direction_anim

func update_anim_direction():
	direction_anim = direction_anim_new

func get_anim_direction() -> String:
	if direction_anim == Vector2.LEFT:
		return "left"
	elif direction_anim == Vector2.RIGHT:
		return "right"
	elif direction_anim == Vector2.UP:
		return "up"
	else: # direction_anim == Vector2.DOWN:
		return "down"

func update_animation(state: String) -> void:
	animated_sprite_2d.play(state + "_" + get_anim_direction())

func change_anim_direction(state: String) -> void:
	cal_new_anim_direction()
	if is_anim_direction_changed():
		update_anim_direction()
		update_animation(state)
