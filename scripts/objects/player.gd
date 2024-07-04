class_name Player
extends CharacterBody2D

var dir: Vector2 = Vector2.ZERO
var last_dir: Vector2 = Vector2.ZERO
@export var speed = 100
@onready var animated_sprite: AnimatedSprite2D = %AnimatedSprite2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	dir = Input.get_vector("move left", "move right", "move up", "move down")
	move_and_slide()


