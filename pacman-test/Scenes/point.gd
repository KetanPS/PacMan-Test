extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(func(body: Node2D) -> void:
		if body is Player:
			queue_free()
			body.add_point())
