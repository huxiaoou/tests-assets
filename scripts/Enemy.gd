class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int = 20

var cardinal_direction: Vector2 = Vector2.DOWN
var direction: Vector2 = Vector2.ZERO
var invulnerable: bool = false

@onready var state_machine: StateMachineEnemy = $StateMachineEnemy
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	state_machine.initialize(self)
	#player = PlayerManager.player

func _process(_delta: float) -> void:
	pass

func _physics_process(_delta: float) -> void:
	move_and_slide()

func set_direction(_new_direction: Vector2) -> bool:
	direction = _new_direction
	if direction == Vector2.ZERO:
		return false

	var direction_id: int = int(round((direction * 0.99 + cardinal_direction * 0.01).angle() / TAU * DIR_4.size()))
	var new_direction: Vector2 = DIR_4[direction_id]
	if new_direction == cardinal_direction:
		return false
	cardinal_direction = new_direction
	direction_changed.emit(new_direction)
	return true

func update_animation(state: String) -> void:
	animated_sprite_2d.play(state + "_" + anim_direction())

func anim_direction() -> String:
	if cardinal_direction == Vector2.UP:
		return "up"
	elif cardinal_direction == Vector2.LEFT:
		return "left"
	elif cardinal_direction == Vector2.RIGHT:
		return "right"
	else: # cardinal_direction == Vector2.DOWN:
		return "down"
