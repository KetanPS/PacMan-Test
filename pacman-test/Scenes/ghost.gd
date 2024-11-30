extends CharacterBody2D

@export var speed := 2.0
@export var player: CharacterBody2D
@export var navigation_points: Node2D
@export var alternative_texture: Texture = null

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D

var destination = null

func _ready() -> void:
	if alternative_texture != null:
		sprite_2d.texture = alternative_texture
	destination = navigation_points.get_children().pick_random()
	navigation_agent.target_reached.connect(func() -> void:
		destination = navigation_points.get_children().pick_random())


func _physics_process(delta: float) -> void:
	navigation_agent.target_position = destination.global_position
	var direction = navigation_agent.get_next_path_position() - global_position
	velocity = direction * speed
	move_and_slide()
