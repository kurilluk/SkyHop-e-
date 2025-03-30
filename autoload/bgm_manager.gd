extends Node

@onready var hit_player: AudioStreamPlayer = $HIT_Player
@onready var ambient_player: AudioStreamPlayer = $Ambient_Player

const AMBIENT_LOOP = [
preload("res://sound/music/loops/Ambient_background_no_bass_SEAMLESS_01.ogg")
]
const BOX_MUSIC = [
	preload("res://sound/music/box-notes/RED_01.ogg"),
	preload("res://sound/music/box-notes/YELLOW_01.ogg"),
	preload("res://sound/music/box-notes/GREEN_01.ogg"),
	preload("res://sound/music/box-notes/AQUA_01.ogg"),
 	preload("res://sound/music/box-notes/BLUE_01.ogg"),
	preload("res://sound/music/box-notes/PURPLE_01.ogg"),
	preload("res://sound/music/box-notes/PINK_01.ogg"),
]

var _phase : int = -1

func play_next_phase():
	_phase += 1
	if _phase > BOX_MUSIC.size()-1:
		_phase = 0
	
	hit_player.stream = BOX_MUSIC[_phase]
	hit_player.play()
	ambient_player.stream = AMBIENT_LOOP[_phase]
	ambient_player.play()

func stop_all():
	hit_player.stop()
	ambient_player.stop()
	
func stop_box():
	hit_player.stop()
	
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
	else:
		player.stream = BOX_MUSIC[2]
	print(player.stream)
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
