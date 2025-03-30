extends Node

@onready var player_polyphonic: AudioStreamPlayer = $Player_Polyphonic


#const SOUND_BUTTON = preload("res://assets/sounds/sfx/button/BOX_Click_02.wav")
#const SOUND_DRAG = preload("res://assets/sounds/sfx/d&d/Wooden_Click_01.wav")
#const SOUND_DROP = preload("res://assets/sounds/sfx/d&d/Wooden_Click_02.wav")
#const SOUND_LOCK = preload("res://assets/sounds/sfx/lock/Locked_ONE_TURN_02.ogg")
#const SOUND_PROJECT_DONE = preload("res://assets/sounds/sfx/project/Project_finished_01.ogg")
#
#const SOUND_VICTORY = preload("res://assets/sounds/sfx/ending/Orchestral_Victory_sound_03_200BPM.mp3")
#const SOUND_DEFEAT = preload("res://assets/sounds/sfx/ending/end_defeat_orchestral_05_120BPM.ogg")

const SFX_JETPACK = preload("res://sound/sfx/movement-sounds/sfx_jetpack.ogg")
const SFX_JUMP = preload("res://sound/sfx/movement-sounds/sfx_jump.wav")

const SFX_REWARD_RED = [
	preload("res://sound/sfx/reward-sounds/red-succes-c#-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/red-succes-d-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/red-succes-f#-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/red-succes-a-tone_01.ogg")
]

const SFX_REWARD_GREEN = [
	preload("res://sound/sfx/reward-sounds/green-succes-e-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/green-succes-f#-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/green-succes-h-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/green-succes-d-tone_01.ogg")
]

const SFX_REWARD_BLUE = [
	preload("res://sound/sfx/reward-sounds/blue-succes-f#-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/blue-succes-g-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/blue-succes-h-tone_01.ogg"),
	preload("res://sound/sfx/reward-sounds/blue-succes-d-tone_01.ogg")
]

func play(sound : AudioStream, volume : float = 0.0):
	if !player_polyphonic.playing : player_polyphonic.play()
	var playback : AudioStreamPlaybackPolyphonic = player_polyphonic.get_stream_playback()
	var id = playback.play_stream(sound,0,volume)
	if id == playback.INVALID_ID:
		printerr("playback didn't play stream: ", str(sound))

func stop():
	player_polyphonic.stop()
