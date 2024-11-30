extends CharacterBody2D
class_name Player

signal point_added
signal player_hit

@export var speed := 100.0

@onready var animation_player: AnimationPlayer = %AnimationPlayer
@onready var sprite_2d: AnimatedSprite2D = $Sprite2D
@onready var hitbox: Area2D = %Hitbox
@onready var audio_movement: AudioStreamPlayer = $AudioMovement
@onready var hurt_animation: AnimationPlayer = $HurtAnimation


func _ready() -> void:
	hitbox.body_entered.connect(func(body:Node2D) -> void:
		hurt_animation.play("hurt")
		player_hit.emit())


# Called when the node enters the scene tree for the first time.
func _physics_process(delta: float) -> void:
	var direction := Input.get_vector("move_left", "move_right", "move_up", "move_down")
	if direction.length() > 0.0:
		animation_player.play("movement")
		if audio_movement.playing == false:
			audio_movement.play()
	
	match direction:
		Vector2.UP:
			sprite_2d.flip_h = false
			sprite_2d.rotation_degrees = -90
			velocity = Vector2.UP * speed
		Vector2.DOWN:
			sprite_2d.flip_h = false
			sprite_2d.rotation_degrees = 90
			velocity = Vector2.DOWN * speed
		Vector2.LEFT:
			sprite_2d.flip_h = true
			sprite_2d.rotation_degrees = 0
			velocity = Vector2.LEFT * speed
		Vector2.RIGHT:
			sprite_2d.flip_h = false
			sprite_2d.rotation_degrees = 0
			velocity = Vector2.RIGHT * speed
		Vector2.ZERO:
			animation_player.play("idle")
			audio_movement.stop()
			velocity = Vector2.ZERO
	
	move_and_slide()


func add_point() -> void:
	point_added.emit()
