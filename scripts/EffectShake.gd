class_name EffectShake extends Node


@export var shake_strength: Vector2 = Vector2(4.0, 1.0)
@export var shake_duration: float = 0.4
@export var shake_frequency: int = 4 # Number of back-and-forth movements
@onready var half_duration = shake_duration / ( shake_frequency * 2)
var host: Sprite2D

func initialize(sprite_host: Sprite2D) -> void:
	host = sprite_host
	
func start() -> void:
	var init_pos: Vector2 = host.position
	var tween: Tween = get_tree().create_tween()
	for i in range(shake_frequency):
		var random_offset: Vector2 = Vector2(
			randf_range(-shake_strength.x, shake_strength.x),
			randf_range(-shake_strength.y, shake_strength.y)
		)
		tween.tween_property(
			host, "position", init_pos + random_offset, half_duration
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.tween_property(
			host, "position", init_pos, half_duration
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	tween.tween_property(self, "position", init_pos, 0.05)
	
