class_name CharacterValkyrie extends CharacterBody2D

var direction: Vector2 = Vector2.ZERO
var cardinal_direction: Vector2 = Vector2.ZERO
var anim_scale_x: float = 1

@onready var sprite_2d_idle: Sprite2D = $Sprite2DIdle
@onready var sprite_2d_slash: Sprite2D = $Sprite2DSlash
@onready var sprite_2d_walk: Sprite2D = $Sprite2DWalk
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var state_machine: StateMachineValkyrie = $StateMachine

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	sprite_2d_slash.visible = false
	sprite_2d_walk.visible = false
	state_machine.initialize(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction = Vector2(
		Input.get_axis("left", "right"),
		Input.get_axis("up", "down"),
	).normalized()

func _physics_process(_delta: float) -> void:
	move_and_slide()

func update_animation(state: String) -> void:
	animation_player.play(state)

func set_direction() -> bool:
	var new_direction: Vector2 = direction * 0.99 + cardinal_direction * 0.01
	new_direction = Vector2.LEFT if new_direction.x < 0 else Vector2.RIGHT
	if new_direction == cardinal_direction:
		return false
	cardinal_direction = new_direction
	anim_scale_x  = sign(cardinal_direction.x)
	sprite_2d_walk.scale.x = anim_scale_x
	return true
