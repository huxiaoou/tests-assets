class_name CameraValkyrie extends Camera2D

# Trauma parameters
@onready var direction_arrow: DirectionArrow = $"../AnimatedSprite2D/Sprite2DDirectionArrow"
@export var decay: float = 0.8 # How quickly the shaking stops (0 to 1)
@export var max_offset: Vector2 = Vector2(8, 8) # Maximum horizontal/vertical add_shake
@onready var trauma = 0.0
@onready var timer: Timer = $Timer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	GlobalMgrLevel.TileMapBoundsChanged.connect(update_limits)
	direction_arrow.hurt_box.hurt_something.connect(add_shake)
	timer.timeout.connect(_on_timer_out)
	update_limits(GlobalMgrLevel.current_tilemap_bounds)
	
func update_limits(bounds: Array[Vector2]) -> void:
	if bounds.is_empty():
		return
	
	limit_left = int(bounds[0].x)
	limit_top = int(bounds[0].y)
	limit_right = int(bounds[1].x)
	limit_bottom = int(bounds[1].y)

func _process(delta: float) -> void:
	process_shake(delta)

func process_shake(delta: float) -> void:
	if trauma > 0:
		var shake_offset: Vector2 = Vector2(
			randf_range(-1, 1),
			randf_range(-1, 1)
		) * trauma * trauma
		offset = shake_offset * max_offset
		trauma = lerp(trauma, 0.0, decay * delta * 5)
	else:
		offset = Vector2.ZERO

func add_shake(amount):
	trauma = min(trauma + sign(amount), 1.0)
	timer.start()
	Engine.time_scale = 0.1

func _on_timer_out():
	Engine.time_scale = 1.0
