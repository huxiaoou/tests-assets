class_name EffectShake extends Node

var host: Node2D
var init_pos: Vector2
var init_rot: float

@export var x_max = 4
@export var r_max = 3.0 / 180.0 * PI
@export var pivot_below = true

const STOP_THRESHOLD = 0.1
const TEWEEN_DURATION = 0.05
const RECOVERY_FACTOR = 2.0 / 3
const TRANSITION_TYPE = Tween.TRANS_SINE

signal shake_finished()

func initialize(hitbox_host: Node2D) -> void:
	host = hitbox_host
	
func start(_damage: float) -> void:
	init_pos = host.position
	init_rot = host.rotation
	var tween: Tween = get_tree().create_tween()
	var x: float = x_max
	var r: float = r_max
	while x > STOP_THRESHOLD:
		tilt_left(x, r, tween)
		recenter(tween)
		x *= RECOVERY_FACTOR
		r *= RECOVERY_FACTOR
		tilt_right(x, r, tween)
		recenter(tween)
		x *= RECOVERY_FACTOR
		r *= RECOVERY_FACTOR
	recenter(tween)
	await tween.finished
	shake_finished.emit()
	return

func tilt_left(x: float, r: float, tween: Tween) -> void:
	var offset_pos: Vector2 = Vector2(-x, 0)
	var offset_rot: float = -r if pivot_below else r
	tween.tween_property(
		host, "position", init_pos + offset_pos, TEWEEN_DURATION
	).set_trans(TRANSITION_TYPE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(
		host, "rotation", init_rot + offset_rot, TEWEEN_DURATION
	).set_trans(TRANSITION_TYPE).set_ease(Tween.EASE_OUT)
	return

func tilt_right(x: float, r: float, tween: Tween) -> void:
	var offset_pos: Vector2 = Vector2(x, 0)
	var offset_rot: float = r if pivot_below else -r
	tween.tween_property(
		host, "position", init_pos + offset_pos, TEWEEN_DURATION
	).set_trans(TRANSITION_TYPE).set_ease(Tween.EASE_OUT)
	tween.parallel().tween_property(
		host, "rotation", init_rot + offset_rot, TEWEEN_DURATION
	).set_trans(TRANSITION_TYPE).set_ease(Tween.EASE_OUT)
	return

func recenter(tween: Tween) -> void:
	tween.tween_property(
		host, "position", init_pos, TEWEEN_DURATION
	).set_trans(TRANSITION_TYPE).set_ease(Tween.EASE_IN)
	tween.parallel().tween_property(
		host, "rotation", init_rot, TEWEEN_DURATION
	).set_trans(TRANSITION_TYPE).set_ease(Tween.EASE_IN)
	return
