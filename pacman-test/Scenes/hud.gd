extends Control
class_name PauseScreen

@onready var resume_button: Button = %ResumeButton
@onready var quit_button: Button = %QuitButton
@onready var label: Label = $PanelContainer/VBoxContainer/Label

var victory := false
var defeat := false

func _ready() -> void:
	quit_button.pressed.connect(func() -> void:
		get_tree().quit())
	resume_button.pressed.connect(func() -> void:
		if victory or defeat:
			get_tree().paused = false
			get_tree().reload_current_scene()
		else :
			get_tree().paused = false
			self.visible = false)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		self.visible = !self.visible
		get_tree().paused = !get_tree().paused
