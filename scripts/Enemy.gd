class_name Enemy extends CharacterBody2D

signal direction_changed(new_direction: Vector2)
signal enemy_damaged()

const DIR_4 = [Vector2.RIGHT, Vector2.DOWN, Vector2.LEFT, Vector2.UP]

@export var hp: int = 20

var direction_anim: Vector2 = Vector2.ZERO
var direction_anim_new: Vector2 = Vector2.ZERO
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

func cal_new_anim_direction() -> void:
	direction_anim_new = DIR_4[randi_range(0, 3)]

func is_anim_direction_changed() -> bool:
	return direction_anim_new != direction_anim

func update_anim_direction() -> void:
	direction_anim = direction_anim_new

func generate_and_change_direction() -> void:
	self.cal_new_anim_direction()
	if self.is_anim_direction_changed():
		self.update_anim_direction()
		direction_changed.emit(direction_anim)

func update_velocity(speed: float) -> void:
	self.velocity = direction_anim * speed

func update_animation(state: String) -> void:
	animated_sprite_2d.play(state + "_" + choose_anim_direction())

func choose_anim_direction() -> String:
	if direction_anim == Vector2.UP:
		return "up"
	elif direction_anim == Vector2.LEFT:
		return "left"
	elif direction_anim == Vector2.RIGHT:
		return "right"
	else: # direction_anim == Vector2.DOWN:
		return "down"
