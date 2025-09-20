class_name DirectionArrow extends Sprite2D

@export var shift: float = 120
@export var scale_arrow: float = 0.6
@onready var hurt_box: HurtBox = $HurtBox

var target: Node2D
var direction: Vector2

func _ready() -> void:
	position = Vector2(shift, 0)
	scale = Vector2.ONE * scale_arrow
	target = get_parent()

func _process(_delta: float) -> void:
	direction = (get_global_mouse_position() - target.global_position).normalized()
	position = direction * shift
	rotation = direction.angle()
	pass

func start_monitor() -> void:
	$HurtBox.monitoring = true

func stop_monitor() -> void:
	$HurtBox.monitoring = false
