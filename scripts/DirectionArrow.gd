class_name DirectionArrow extends Sprite2D

@export var shift: float = 120
@export var scale_arrow: float = 0.6

var target: Node2D
var direction: Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	position = Vector2(shift, 0)
	scale = Vector2.ONE * scale_arrow

func initialize(target_node: Node2D) -> void:
	target = target_node

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	direction = (get_global_mouse_position() - target.global_position).normalized()
	position = direction * shift
	rotation = direction.angle()
	pass
