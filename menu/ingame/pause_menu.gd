extends Control

@onready var tree = get_tree()

#@onready var crosshair = $Crosshair
@onready var pause = $Pause
#@onready var options = $Options
#@onready var voxel_world = %VoxelWorld

var _is_paused = false

func _onready():
	pause.visible = false
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(_delta):
	if Input.is_action_just_pressed(&"pause"):
		_is_paused = not _is_paused
		pause.visible = _is_paused
		get_tree().paused = _is_paused 
		#crosshair.visible = not crosshair.visible
		#options.visible = false
		if not _is_paused:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func _on_Resume_pressed():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	#crosshair.visible = true
	get_tree().paused = false 
	pause.visible = false
	_is_paused = false


#func _on_Options_pressed():
	#options.prev_menu = pause
	#options.visible = true
	#pause.visible = false


func _on_MainMenu_pressed():
	#voxel_world.clean_up()
	#tree.change_scene_to_packed(load("res://menu/main/main_menu.tscn"))
	get_tree().paused = false 
	get_tree().reload_current_scene()


func _on_Exit_pressed():
	#voxel_world.clean_up()
	tree.quit()
