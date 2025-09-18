class_name FenceA extends Node2D

@export var hp: float = 4
@onready var audio: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var hit_box: HitBox = $HitBox
@onready var sprite_2d: Sprite2D = $Sprite2D

func _ready() -> void:
	hit_box.initialize(sprite_2d)
	hit_box.Damaged.connect(take_damage)

func take_damage(damage: float) -> void:
	hp -= damage
	print("fence A take damage: " + str(damage) + ", remaining hp: " + str(hp))
	if hp <= 1e-4:
		audio.play(0.4)
		audio.finished.connect(queue_free)
		sprite_2d.visible = false
