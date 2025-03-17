extends Node

const MAIN_MENU_BSO_001 = preload("res://Recursos/Musica/MainMenu_BSO_001.ogg")
const GAME_PLAY_BSO_001 = preload("res://Recursos/Musica/GamePlay_BSO_001.ogg")
const MUSICA_PANTALLA_FINAL_001 = preload("res://Recursos/Musica/Musica_Pantalla_Final_001.ogg")

var background_audio_source : AudioStreamPlayer

func play_background_music(music: AudioStreamOggVorbis):
	background_audio_source.stream = music
	background_audio_source.play()
