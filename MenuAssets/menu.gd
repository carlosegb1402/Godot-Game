extends Control

var config_file_path = "user://settings.cfg"


func _ready() -> void:
	load_sound_settings()

func _process(delta: float) -> void:
	pass


func _on_btn_sound_pressed() -> void:
	$btn_pressed_sound.play()

	if $menu_background_sound.volume_db == 0:
		$menu_background_sound.volume_db = -80
		$VBoxContainer2/btn_sound.texture_normal = preload("res://MenuAssets/Sound_BTN_active.png")
		save_sound_settings(false)
	else:
		$menu_background_sound.volume_db = 0
		$VBoxContainer2/btn_sound.texture_normal = preload("res://MenuAssets/Sound_BTN.png")
		save_sound_settings(true)


func save_sound_settings(is_sound_on: bool) -> void:
	var config = ConfigFile.new()
	config.set_value("audio", "sound_enabled", is_sound_on)
	config.save(config_file_path)

func load_sound_settings() -> void:
	var config = ConfigFile.new()
	if config.load(config_file_path) == OK:
		var is_sound_on = config.get_value("audio", "sound_enabled", true) # true por defecto
		if is_sound_on:
			$menu_background_sound.volume_db = 0
			$VBoxContainer2/btn_sound.texture_normal = preload("res://MenuAssets/Sound_BTN.png")
		else:
			$menu_background_sound.volume_db = -80
			$VBoxContainer2/btn_sound.texture_normal = preload("res://MenuAssets/Sound_BTN_active.png")
		


func _on_exit_btn_pressed() -> void:
	get_tree().quit()


func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://Arena.tscn")
