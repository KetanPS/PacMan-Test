extends Node

@onready var points: Node2D = %Points
@onready var player: Player = $Player
@onready var hud: PauseScreen = $CanvasLayer/HUD
@onready var lifes: Node2D = %Lifes
@onready var start_label: Label = $StartLabel
@onready var timer: Timer = $Timer

var collectables := 0
var point_counter := 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	get_tree().paused = true
	timer.timeout.connect(func() -> void:
		get_tree().paused = false
		start_label.text = "Go!!!"
		await get_tree().create_timer(1.5).timeout
		start_label.visible = false)
		
	player.point_added.connect(on_point_added)
	player.player_hit.connect(on_player_hit)
	collectables = points.get_child_count()


func on_point_added() -> void:
	point_counter += 1
	if collectables == point_counter:
		hud.visible = true
		get_tree().paused = true
		hud.label.text = "Victory!"
		hud.resume_button.text = "Restart"
		hud.victory = true

func on_player_hit() -> void:
	var life := lifes.get_children()
	if life.is_empty():
		hud.visible = true
		get_tree().paused = true
		hud.label.text = "Defeat!"
		hud.resume_button.text = "Restart"
		hud.defeat = true
	else:
		var life_lost = life.pop_at(0)
		life_lost.queue_free()
