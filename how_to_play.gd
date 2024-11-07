extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _process(delta: float) -> void:
	pass


func _on_avanzer_btn_pressed() -> void:
	$btn_pressed_sound.play()
	get_tree().change_scene_to_file("res://Arena.tscn")
