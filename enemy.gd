extends Sprite2D

var velocidad = 100
var mov = Vector2.ZERO
var stunned = false
var recuo = 6
var hp = 3
var hit_sound = preload("res://snd_enemy_hit.wav")
var DeathSnd = preload("res://snd_explosion.wav")
var isdead = false
signal eliminado

func _process(delta: float) -> void:
	if hp > 0:
		if Global.player != null and stunned == false:
			mov = global_position.direction_to(Global.player.global_position)
			look_at(Global.player.global_position)
			self.rotation_degrees = self.rotation_degrees - 90
		elif stunned:
			mov = lerp(mov, Vector2.ZERO, 0.3)
		
		global_position += mov * velocidad * delta
	else:
		var sprite_enemigo = self
		sprite_enemigo.texture = preload("res://sprite_enemy_destroy.png")
		mov = Vector2.ZERO

	if hp <= 0 and isdead == false:
		Global.score+=10
		isdead = true
		var death = AudioStreamPlayer.new()
		death.stream = DeathSnd
		death.volume_db = -10 
		add_child(death)
		death.play()
		await get_tree().create_timer(1.66).timeout
		emit_signal("eliminado")
		queue_free()


		

func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("damage") and hp>0:
		var sprite_enemigo = self
		if sprite_enemigo:
			sprite_enemigo.texture = preload("res://sprite_enemy_damage.png")
		area.get_parent().queue_free()
		mov = -mov * recuo
		stunned=true
		hp -= 1
		var hit = AudioStreamPlayer.new() 
		hit.stream = hit_sound 
		add_child(hit) 
		hit.play()  
		$Timer.start()


func _on_timer_timeout() -> void:
	var sprite_enemigo = self
	sprite_enemigo.texture = preload("res://sprite_enemy.png")
	stunned=false
	
