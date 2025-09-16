class_name FenceA extends Node2D

@export var hp: float = 8
@export var destructin_sound: AudioStream
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hit_box: HitBox = $HitBox
@onready var effect_shake: EffectShake = $EffectShake
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	hit_box.Damaged.connect(take_damage)

func take_damage(damage: float) -> void:
	hp -= damage
	print("fence A take damage: " + str(damage) + ", remaining hp: " + str(hp))
	effect_shake.start()
	if hp <= 1e-4:
		audio.stream = destructin_sound
		audio.play(0.9)
		audio.finished.connect(queue_free)
		sprite_2d.visible = false
