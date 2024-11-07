extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta) -> void:
	if Input.is_key_pressed(KEY_P):
		self.show()
		get_tree().paused=true



func _on_resume_btn_pressed() -> void:
	$btn_pressed_sound.play()
	self.hide()
	get_tree().paused=false
	



func _on_exit_btn_pressed() -> void:
	Global.ammor=31
	Global.vida_player=3
	Global.score=0
	get_tree().paused=false
	$btn_pressed_sound.play()
	get_tree().change_scene_to_file("res://Menu Assets/menu.tscn")
