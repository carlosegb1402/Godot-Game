extends Sprite2D

var velocidad = 250
var mov = Vector2.ZERO
var bullet = preload("res://Bullet.tscn")
var reload = true
var shoot_sound = preload("res://snd_player_fire.wav")
var no_ammo = preload("res://snd_gun_jam.wav")
var sound_out_of_ammo: AudioStreamPlayer = null
var reload_ref = preload("res://snd_gun_reload.wav")
var sound_reload_ammo: AudioStreamPlayer = null
var death = false  
var max_vida= Global.vida_player
var is_reloading=false


func _ready() -> void:
	sound_out_of_ammo = AudioStreamPlayer.new()
	sound_out_of_ammo.stream = no_ammo
	add_child(sound_out_of_ammo)
	
	sound_reload_ammo = AudioStreamPlayer.new()
	sound_reload_ammo.stream = reload_ref
	add_child(sound_reload_ammo)
		
	Global.player=self

	

	
func _enter_tree() -> void:
	Global.player=null


func _process(delta: float) -> void:
	
	mov.x = int(Input.is_key_pressed(KEY_D))-int(Input.is_key_pressed(KEY_A))
	mov.y = int(Input.is_key_pressed(KEY_S))-int(Input.is_key_pressed(KEY_W ))
	look_at(get_global_mouse_position())
	self.rotation_degrees = self.rotation_degrees +90   

	
	if death == false:
		global_position += velocidad*mov*delta
	
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Global.creation !=null and reload and death==false and Global.ammor>=1:
		Global.instance_node(bullet, global_position, Global.creation)
		reload=false
		var sound_player = AudioStreamPlayer.new() 
		sound_player.stream = shoot_sound 
		add_child(sound_player) 
		sound_player.play()
		Global.ammor-=1  
		$recall.start()
		
	if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT) and Global.ammor<=0:
		if not sound_out_of_ammo.is_playing()  and not sound_reload_ammo.is_playing():
			sound_out_of_ammo.play()
			
	if Input.is_key_pressed(KEY_R) and Global.ammor<=6:
		if not sound_reload_ammo.is_playing():
			sound_reload_ammo.play()
			await sound_reload_ammo.playing
			await get_tree().create_timer(3).timeout
			Global.ammor = 30
			
	if Global.vida_player<=0:
		visible=false
		death=true
		await get_tree().create_timer(1).timeout
		get_tree().change_scene_to_file("res://Menu Assets/menu.tscn")
		Global.score=0
		Global.vida_player=3
		Global.ammor=31

func _on_recall_timeout() -> void:
	reload=true

var hit_cooldown = false
func _on_area_2d_area_entered(area: Area2D) -> void:
	if area.is_in_group("enemigo") and not hit_cooldown:
		Global.vida_player-=1
		hit_cooldown = true
	await get_tree().create_timer(0.5).timeout
	hit_cooldown = false
		

		
