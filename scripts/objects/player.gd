class_name Player
extends CharacterBody2D


@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var dir = Input.get_vector("move left", "move right", "move up", "move down")
	velocity = dir * speed
	move_and_slide()
