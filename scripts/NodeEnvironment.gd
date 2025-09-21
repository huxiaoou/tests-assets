class_name NodeEnvironment extends Node2D

@export var invincible: bool = true
@export var hp: float = 1.0
@export var sound_destruction: AudioStream

@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hit_box: HitBox = $HitBox
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _ready() -> void:
	hit_box.initialize(animated_sprite_2d)
	hit_box.Damaged.connect(take_damage)

func take_damage(damage: float) -> void:
	if not invincible:
		hp -= damage
		print("take damage: " + str(damage) + ", remaining hp: " + str(hp))
	
		if hp <= 1e-4:
			audio.stream = sound_destruction
			audio.play(0.4)
			audio.finished.connect(queue_free)
			animated_sprite_2d.visible = false
