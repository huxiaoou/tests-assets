class_name EffectShake extends Node


@export var shake_strength: Vector2 = Vector2(4.0, 1.0)
@export var shake_rotation: float = 5.0 / 180.0 * PI
@export var shake_duration: float = 0.4
@export var shake_frequency: int = 4 # Number of back-and-forth movements
@onready var half_duration = shake_duration / (shake_frequency * 2)
var host: Node2D

signal shake_finished()

func initialize(hitbox_host: Node2D) -> void:
	host = hitbox_host
	
func start(_damage: float) -> void:
	var init_pos: Vector2 = host.position
	var init_rot: float = host.rotation
	var tween: Tween = get_tree().create_tween()
	for i in range(shake_frequency):
		var random_offset: Vector2 = Vector2(
			randf_range(-shake_strength.x, shake_strength.x),
			randf_range(-shake_strength.y, shake_strength.y)
		)
		var random_rotation: float = randf_range(-shake_rotation, shake_rotation)
		# start shake
		tween.tween_property(
			host, "position", init_pos + random_offset, half_duration
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		tween.parallel().tween_property(
			host, "rotation", init_rot + random_rotation, half_duration
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		# recover
		tween.tween_property(
			host, "position", init_pos, half_duration
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
		tween.parallel().tween_property(
			host, "rotation", init_rot, half_duration
		).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_IN)
	#tween.tween_property(host, "position", init_pos, 0.05)
	await tween.finished
	shake_finished.emit()
