extends CanvasLayer

@onready var label: Label = $Control/Label
@onready var start_button: Button = $Control/CenterContainer/HBoxContainer/StartButton
@onready var quit_button: Button = $Control/CenterContainer/HBoxContainer/QuitButton
@onready var timer: Timer = $Timer


func _ready() -> void:
	timer.timeout.connect(on_timer_timeout)
	start_button.pressed.connect(func() -> void:
		get_tree().change_scene_to_file("res://Scenes/game.tscn"))
	quit_button.pressed.connect(func() -> void:
		get_tree().quit())


func on_timer_timeout() -> void:
	var tween := create_tween().set_trans(Tween.TRANS_SPRING).set_ease(Tween.EASE_OUT)
	tween.tween_property(label, "position", Vector2(40, 88), 1.0)
	
	tween.tween_property(start_button, "self_modulate:a", 1, 0.8)
	tween.parallel().tween_property(quit_button, "self_modulate:a", 1, 0.8)
	
	tween.finished.connect(func() -> void:
		start_button.disabled = false
		quit_button.disabled = false)
