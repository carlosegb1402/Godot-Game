extends RigidBody2D

var velocidad = 30
var mov = Vector2.ZERO
var stunned = false
var recuo = 6
var hp = 2
var hit_sound = preload("res://snd_enemy_hit.wav")
var DeathSnd = preload("res://snd_explosion.wav")
var isdead = false
var bullet = preload("res://Enemigos/Bullet_en.tscn")
var tiempo_disparo = 0.0 
var intervalo_disparo = 4.0 
signal eliminado


func _process(delta: float) -> void:
	
	tiempo_disparo += delta
	if hp > 0 and Global.player != null and tiempo_disparo >= intervalo_disparo and Global.ready_to_shoot:
		var nueva_bala = bullet.instantiate()
		nueva_bala.position = global_position  
		get_parent().add_child(nueva_bala) 
		print("Posición de la bala:", nueva_bala.global_position)
		tiempo_disparo = 0.0 
			
			
	if hp > 0:
		if Global.player != null and stunned == false:
			mov = global_position.direction_to(Global.player.global_position)
			look_at(Global.player.global_position)
			$".".rotate(1.57)
		elif stunned:
			mov = lerp(mov, Vector2.ZERO, 0.3)
		
		self.move_and_collide(mov*velocidad*delta)
	else:
		var sprite_enemigo = $enemigo
		sprite_enemigo.texture = preload("res://sprite_enemy_destroy.png")
		mov = Vector2.ZERO

	if hp <= 0 and isdead == false:
		isdead = true
		Global.score+=10
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
		var sprite_enemigo = $enemigo
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
		$enemigo/Timer.start()


func _on_timer_timeout() -> void:
	var sprite_enemigo = $enemigo
	sprite_enemigo.texture = preload("res://sprite_enemy.png")
	stunned=false
	
