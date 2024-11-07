extends Control


func _ready() -> void:
	pass 

func _process(delta: float) -> void:
	pass


func _on_start_btn_pressed() -> void:
	$btn_pressed_sound.play()
	get_tree().change_scene_to_file("res://how_to_play.tscn")
	
func _on_exit_btn_pressed() -> void:
	$btn_pressed_sound.play()
	get_tree().quit()
	

func _on_btn_sound_pressed() -> void:
	$btn_pressed_sound.play()
	if $menu_background_sound.volume_db == 0:
		$menu_background_sound.volume_db = -80
	else:
		$menu_background_sound.volume_db = 0
