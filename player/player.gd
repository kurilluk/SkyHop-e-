extends CharacterBody3D

#const EYE_HEIGHT_STAND = 1.6
#const EYE_HEIGHT_CROUCH = 1.4

const MOVEMENT_SPEED_GROUND = 0.6
const MOVEMENT_SPEED_AIR = 0.11 #0.11
const MOVEMENT_SPEED_CROUCH_MODIFIER = 0.5
const MOVEMENT_FRICTION_GROUND = 0.9
const MOVEMENT_FRICTION_AIR = 0.98
const MOVEMENT_JETPACK_STRENGTH = 15.0
const MAX_JETPACK_STRENTCH = 10

var _mouse_motion = Vector2()
var _selected_block = 6
var current_interaction_type
var is_ready_to_interact = false

var last_visited_box

@onready var next_color: ColorRect = $NextColor
@onready var score: Label = %Score
@onready var energy: Label = %Energy

@onready var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

@onready var head = $Head
#@onready var raycast = $Head/RayCast3D
@onready var camera_attributes = $Head/Camera3D.attributes
@onready var selected_block_texture = $SelectedBlock
#@onready var voxel_world = $"../VoxelWorld"
#@onready var crosshair = $"../PauseMenu/Crosshair"

var _next_type
var _score = 0
var _energy = 50

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	SignalManager.on_box_entered.connect(_on_box_interact)
	set_next_color()

func set_next_color():
	var id = randi() % 7
	_next_type = BoxManager.BOX_TYPES.keys()[id]
	BoxManager.actual_type = _next_type
	next_color.color = BoxManager.COLORS.values()[id]

func score_count(type):
	print(_next_type + " vs " + type)
	if _next_type == type:
		_score += 10
		print("+10")
	else:
		_score -= 5
		print("-5")

func _on_box_interact(type, box):
	current_interaction_type = type
	is_ready_to_interact = true
	last_visited_box = box
	
	##print(type)
	#score_count(type)
	#print(_score)
	#score.text = str(_score)
	#set_next_color()
	##BgmManager.play_box(type)
	##pass
	
func _process(_delta):
	# Mouse movement.
	#_mouse_motion.y = clamp(_mouse_motion.y, -1560, 1560)
	transform.basis = Basis.from_euler(Vector3(0, _mouse_motion.x * -0.001, 0))
	head.transform.basis = Basis.from_euler(Vector3(_mouse_motion.y * -0.001, 0, 0))
	#print(head.transform.basis)

	# Block selection.
	#var ray_position = raycast.get_collision_point()
	#var ray_normal = raycast.get_collision_normal()
	#if Input.is_action_just_pressed(&"pick_block"):
		## Block picking.
		#var block_global_position = Vector3i((ray_position - ray_normal / 2).floor())
		#_selected_block = voxel_world.get_block_global_position(block_global_position)
	#else:
		## Block prev/next keys.
		#if Input.is_action_just_pressed(&"prev_block"):
			#_selected_block -= 1
		#if Input.is_action_just_pressed(&"next_block"):
			#_selected_block += 1
		#_selected_block = wrapi(_selected_block, 1, 30)
	## Set the appropriate texture.
	#var uv = Chunk.calculate_block_uvs(_selected_block)
	#selected_block_texture.texture.region = Rect2(uv[0] * 512, Vector2.ONE * 64)

	# Block breaking/placing.
	#if crosshair.visible and raycast.is_colliding():
		#var breaking = Input.is_action_just_pressed(&"break")
		#var placing = Input.is_action_just_pressed(&"place")
		## Either both buttons were pressed or neither are, so stop.
		#if breaking == placing:
			#return
#
		#if breaking:
			#var block_global_position = Vector3i((ray_position - ray_normal / 2).floor())
			#voxel_world.set_block_global_position(block_global_position, 0)
		#elif placing:
			#var block_global_position = Vector3i((ray_position + ray_normal / 2).floor())
			#voxel_world.set_block_global_position(block_global_position, _selected_block)


func _physics_process(delta):
	#camera_attributes.dof_blur_far_enabled = Settings.fog_enabled
	#camera_attributes.dof_blur_far_distance = Settings.fog_distance * 1.5
	#camera_attributes.dof_blur_far_transition = Settings.fog_distance * 0.125
	# Crouching.
	#var crouching = Input.is_action_pressed(&"crouch")
	#head.transform.origin.y = lerpf(head.transform.origin.y, EYE_HEIGHT_CROUCH if crouching else EYE_HEIGHT_STAND, 16 * delta)

	# Keyboard movement.
	var movement_vec2 = Input.get_vector("move_left", "move_right", "move_forward", "move_back")
	var movement = transform.basis * (Vector3(movement_vec2.x, 0, movement_vec2.y))

	if is_on_floor():
		movement *= MOVEMENT_SPEED_GROUND
	else:
		movement *= MOVEMENT_SPEED_AIR

	#if crouching:
		#movement *= MOVEMENT_SPEED_CROUCH_MODIFIER

	# Gravity.
	velocity.y -= gravity/4 * delta
	if velocity.y < -6:
		velocity.y = -6

	velocity += Vector3(movement.x, 0, movement.z)
	# Apply horizontal friction.
	velocity.x *= MOVEMENT_FRICTION_GROUND if is_on_floor() else MOVEMENT_FRICTION_AIR
	velocity.z *= MOVEMENT_FRICTION_GROUND if is_on_floor() else MOVEMENT_FRICTION_AIR
	move_and_slide()
	
	#var collision = get_last_slide_collision()
	#if collision:
		#print("Collided with: ", collision.get_collider().name)

	# Jumping, applied next frame.
	#if is_on_floor() and Input.is_action_pressed(&"jump"):
		#velocity.y = 5 # 7.5
	
	if Input.is_action_pressed(&"crouch"):
		if _energy <= 0 and energy:
			energy.text = "THE END"
			BgmManager.play_out_of_fuel()
			return
		_energy -= delta*2
		if velocity.y < 0:
			velocity.y = 0
		velocity.y += MOVEMENT_JETPACK_STRENGTH * delta
		if velocity.y > MAX_JETPACK_STRENTCH:
			velocity.y = MAX_JETPACK_STRENTCH
		if energy:
			energy.text = str(round(_energy * 100) / 100)
			#_energy.snapped(0.01))
			BgmManager.play_jetpack()
	if Input.is_action_just_released(&"crouch"):
		BgmManager.stop_jetpack()
		pass
			


func _input(event):
	if event is InputEventMouseMotion:
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			_mouse_motion += event.relative
			
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT and event.pressed:
		if is_ready_to_interact:
			print(is_ready_to_interact)
			score_count(current_interaction_type)
			
			#if current_interaction_type == BoxManager.actual_type:
				#BgmManager.play_box(current_interaction_type,last_visited_box)
			#else:
				#BgmManager.play_box_false(last_visited_box)
			#print(BoxManager.actual_type + " ----> " + current_interaction_type)
			
			print(_score)
			score.text = str(_score)
			set_next_color()
			is_ready_to_interact = false  # reset po kliknutí


#func chunk_pos():
	#return Vector3i((transform.origin / Chunk.CHUNK_SIZE).floor())
