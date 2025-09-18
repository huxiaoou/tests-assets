class_name StateEnemyIdle extends StateEnemy

@export_category("AI")
@export var state_duration_min: float = 0.5
@export var state_duration_max: float = 1.5
@export var next_state: StateEnemy

var anim_name: String = "idle"
var _timer: float = 0.0


func enter() -> void:
	enemy.velocity = Vector2.ZERO
	_timer = randf_range(state_duration_min, state_duration_max)
	enemy.update_animation(anim_name)

func process(_delta: float) -> StateEnemy:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
