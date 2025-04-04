extends Area3D
class_name Box

#@onready 
#@onready var _material = box_mesh.get_surface_override_material(0)
@onready var player_3d: AudioStreamPlayer3D = $Player3D

var _type = "Jozko"
var _active

func _ready():
	connect("body_entered", _on_body_entered)
	_active = true

	

func set_type(type: int):
	#print(BoxManager.BOX_TYPES.keys())
	_type = BoxManager.BOX_TYPES.keys()[type]
	#print(BoxManager.COLORS.values())
	#_material.albedo_color = Color.BLACK
	#BoxManager.COLORS.values()[type]
	#pass"albedo_color""albedo_color""albedo_color"
	set_color(type)

func set_color(type: int):
	var box_mesh: MeshInstance3D = %BoxMesh
	var new_material = StandardMaterial3D.new()
	new_material.albedo_color = BoxManager.COLORS.values()[type]
	#Color(0, 1, 0) # Nastaví zelenú farbu

	if(box_mesh == null):
		print("NO MESH!")
	else:
		box_mesh.set_surface_override_material(0, new_material) # Aplikuje materiál na mesh

func count_down():
	pass

func play_sound():
	if _type == BoxManager.actual_type:
		BgmManager.play_box(_type,player_3d)
	else:
		BgmManager.play_box_false(player_3d)
		print(BoxManager.actual_type + " ----> " + _type)
	await get_tree().create_timer(3).timeout
	queue_free()
	BgmManager.stop_box()

func _on_body_entered(body):
	#print(body)
	if not _active:
		return
		
	if body.is_in_group("player"):  # Uisti sa, že Player je v skupine "player"
		#var player = body as CharacterBody3D
		#if player and player.is_on_floor_only():
			#print("on the floor")
			#print("Hráč vstúpil na: ", _type)
		_active = false  # uz znovy neaktivujes
		#if _type == BoxManager.actual_type:
			#BgmManager.play_box(_type,player_3d)
		#else:
			#BgmManager.play_box_false(player_3d)
			#print(BoxManager.actual_type + " ----> " + _type)
		SignalManager.on_box_entered.emit(_type, self)
		await get_tree().create_timer(3).timeout
		queue_free()
		BgmManager.stop_box()
