extends Node3D

const SPACE = Vector3i(60,100,60)
const BOX = preload("res://sky/box.tscn")
const RANDOM_BLOCK_PROBABILITY = 0.025

@onready var boxes: Node3D = $Boxes
@onready var player: CharacterBody3D = $Player

func _ready() -> void:
	player.position = Vector3(SPACE.x/2, SPACE.y, SPACE.z/2)
	generate_boxes()

func generate_boxes():
	var random_data = {}
	for x in range(SPACE.x):
		for y in range(SPACE.y):
			for z in range(SPACE.z):
				var vec = Vector3i(x, y, z)
				if randf() < RANDOM_BLOCK_PROBABILITY:
					var box = BOX.instantiate()
					box.position = vec
					boxes.add_child(box)
					#random_data[vec] = 5
					#randi() % 29 + 1
	#return random_data
