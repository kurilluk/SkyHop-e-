extends Node

@onready var hit_player: AudioStreamPlayer = $HIT_Player
@onready var ambient_player: AudioStreamPlayer = $Ambient_Player

const AMBIENT_LOOP = [
preload("res://sound/music/loops/Ambient_background_no_bass_SEAMLESS_01.ogg"),
preload("res://sound/music/box-music/red-home_03.ogg"),
preload("res://sound/music/box-music/green-relax_03.ogg"),
preload("res://sound/music/box-music/blue-fuel_03.ogg")
]

const BOX_MUSIC = [
	preload("res://sound/music/box-notes-better/RED_04.ogg"),
	preload("res://sound/music/box-notes-better/YELLOW_04.ogg"),
	preload("res://sound/music/box-notes-better/GREEN_04.ogg"),
	preload("res://sound/music/box-notes-better/AQUA_04.ogg"),
 	preload("res://sound/music/box-notes-better/BLUE_04.ogg"),
	preload("res://sound/music/box-notes-better/PURPLE_04.ogg"),
	preload("res://sound/music/box-notes-better/PINK_04.ogg"),
]
const NEGATIVE = preload("res://sound/music/positive-negative-sound/NEGATIVE_01.ogg")
const OUT_OF_FUEL = preload("res://sound/sfx/movement-sounds/OUT_OF_FUEL_01.ogg")
const JETPACK = preload("res://sound/sfx/movement-sounds/sfx_jetpack.ogg")

func play_background():
	ambient_player.stream = AMBIENT_LOOP[0]
	ambient_player.play()
	
func play_jetpack(player = hit_player):
	if not player.playing:
		player.stream = JETPACK
		player.play()
		print("Is playing:", player.playing)
		#player.playing = true
		
func stop_jetpack(player = hit_player):
	player.stop()
	#player.playing = false

func stop_all():
	hit_player.stop()
	ambient_player.stop()
	
func stop_box():
	hit_player.stop()
	
func play_box_false(player = hit_player):
	player.stream = NEGATIVE
	#print(player.stream)
	player.play()
	
func play_out_of_fuel(player = hit_player):
	player.stream = OUT_OF_FUEL
	player.play()
	
func play_box(type, player = hit_player):
	if type == BoxManager.BOX_TYPES.keys()[0]: #RED
		player.stream = BOX_MUSIC[0]
	elif type == BoxManager.BOX_TYPES.keys()[1]: #YELLOW:
		player.stream = BOX_MUSIC[1]
	elif type == BoxManager.BOX_TYPES.keys()[2]: #GREEN:
		player.stream = BOX_MUSIC[2]
	elif type == BoxManager.BOX_TYPES.keys()[3]: #AQUA:
		player.stream = BOX_MUSIC[3]
	elif type == BoxManager.BOX_TYPES.keys()[4]: #BLUE
		player.stream = BOX_MUSIC[4]
	elif type == BoxManager.BOX_TYPES.keys()[5]: #PURPLE:
		player.stream = BOX_MUSIC[5]
	elif type == BoxManager.BOX_TYPES.keys()[6]: #PINK:
		player.stream = BOX_MUSIC[6]
	#print(player.stream)
	player.play()
	

#func play_initial_ambient_loop_only(loop: AudioStreamPlayer):
	#loop.stop()
	#loop.stream = AMBIENT_LOOP[3]
	#loop.play()
#
#func play_ambient_hit(loop: AudioStreamPlayer, hit: AudioStreamPlayer):
	#hit.stop()
	#hit.stream = AMBIENT_HIT[_phase]
	#hit.play()
	#
	#loop.stop()
	#loop.stream = AMBIENT_LOOP[_phase]
	#loop.play()
	##next_ambient_phase()
	
	
#const AMBIENT_LOOP_PLAYLIST : AudioStreamPlaylist = preload("res://assets/sounds/ambient/ambient_loop_playlist.tres")
#func play_next_phase():
	#play(AMBIENT_LOOP_PLAYLIST.get_list_stream(_phase))
