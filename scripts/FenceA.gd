class_name FenceA extends Node2D

@export var hp: float = 8
@export var destructin_sound: AudioStream
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _ready() -> void:
	$HitBox.Damaged.connect(take_damage)

func take_damage(damage: float) -> void:
	hp -= damage
	print("fence A take damage: " + str(damage) + ", remaining hp: " + str(hp))
	$EffectShake.start()
	if hp <= 1e-4:
		audio.stream = destructin_sound
		audio.play(0.9)
		audio.finished.connect(queue_free)
		$Sprite2D.visible = false
