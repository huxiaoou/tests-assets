class_name StateEnemyWander extends StateEnemy

@export var wander_speed: float = 100.0
@export_category("AI")
@export var state_animation_duration: float = 1.0
@export var state_cycles_min: int = 1
@export var state_cycles_max: int = 3
@export var next_state: StateEnemy

var anim_name: String = "wander"
var _timer: float = 0.0

func enter() -> void:
	_timer = randi_range(state_cycles_min, state_cycles_max) * state_animation_duration
	enemy.generate_and_change_direction()
	enemy.update_velocity(wander_speed)
	enemy.update_animation(anim_name)
	
func process(_delta: float) -> StateEnemy:
	_timer -= _delta
	if _timer <= 0:
		return next_state
	return null
