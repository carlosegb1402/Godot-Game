extends Sprite2D

var mov = Vector2(1,0)
var velocidad = 300
var dir_unica= true
var hit_sound = preload("res://snd_player_hit.wav")

func _ready() -> void:
	pass

func _process(delta: float) -> void:
	if dir_unica:
		look_at(Global.player.global_position)
		dir_unica=false
	global_position += mov.rotated(rotation)*velocidad*delta

# Cuando la bala sale de la pantalla, se elimina
func _on_screen_exited() -> void:
	queue_free()


func _on_hitbox_balan_en_area_entered(area: Area2D) -> void:
	if area.is_in_group("jugador"):
		if Global.vida_player <= 0:
			return

		Global.vida_player -= 1
		var hit = AudioStreamPlayer.new() 
		hit.stream = hit_sound 
		add_child(hit) 
		hit.play()  
		self.hide()
		await get_tree().create_timer(3).timeout
		queue_free()  
