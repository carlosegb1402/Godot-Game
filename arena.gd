extends Node2D

var enemie_1 = preload("res://Enemigos/enemy.tscn")
var enemie_2 = preload("res://Enemigos/enemy2.tscn")
var nuevo_puntero = preload("res://crosshair.png")
var total_enemigos = 0
var enemigos_eliminados = 0
var current_wave = 0
var enemies_per_wave = 3
var enemie_on_scene=""
var enemies_positions: Array = []


func _ready() -> void:

	Global.creation = self
	Input.set_custom_mouse_cursor(nuevo_puntero)
	$UI/Control/Label.text = "3"  
	$UI/Control/Label.show()
	await get_tree().create_timer(1).timeout
	$UI/Control/Label.text = "2" 
	$UI/Control/Label.show()
	await get_tree().create_timer(1).timeout
	$UI/Control/Label.text = "1"
	$UI/Control/Label.show()
	await get_tree().create_timer(1).timeout
	$UI/Control/Label.text = "Empecemos"  
	$UI/Control/Label.show()
	await get_tree().create_timer(1).timeout
	$UI/Control/Label.hide()
	start_wave()

func _exit_tree() -> void:
	Global.creation = null

func _process(delta: float) -> void:
	if current_wave > 0 and enemigos_eliminados == total_enemigos:
		show_wave_cleared_message()
		start_wave()
		

func start_wave() -> void:
	if current_wave == 0:
		enemie_on_scene=enemie_1
		await get_tree().create_timer(5).timeout 
		$UI/Control/Label.text = "¡Oleada 1! 
		Prepárate!" 
		$UI/Control/Label.show()
		await get_tree().create_timer(2).timeout 
		$UI/Control/Label.hide()
		current_wave += 1
		total_enemigos = enemies_per_wave
		spawn_enemies(total_enemigos)
		Global.ready_to_shoot = true
		
	elif current_wave == 1:
		enemie_on_scene=enemie_2
		Global.score+=20
		enemigos_eliminados = 0 
		await get_tree().create_timer(5).timeout 
		$UI/Control/Label.text = "¡Oleada 2! 
		Prepárate!"  
		$UI/Control/Label.show()	
		await get_tree().create_timer(2).timeout 
		$UI/Control/Label.hide()
		current_wave += 1
		total_enemigos = enemies_per_wave + 2
		spawn_enemies(total_enemigos)
		Global.ready_to_shoot = true

func spawn_enemies(count: int) -> void:
	for i in range(count):
		var posicion_enemie: Vector2
		var valid_position: bool = false

		while not valid_position:
			var side = randi() % 4

			match side:
				0: # Izquierda
					posicion_enemie = Vector2(-100, randf_range(0, 1080))  # Fuera de la izquierda
				1: # Derecha
					posicion_enemie = Vector2(2020, randf_range(0, 1080))  # Fuera de la derecha
				2: # Arriba
					posicion_enemie = Vector2(randf_range(0, 1920), -100)  # Fuera de arriba
				3: # Abajo
					posicion_enemie = Vector2(randf_range(0, 1920), 1180)  # Fuera de abajo

			valid_position = true
			for enemy_pos in enemies_positions:
				if posicion_enemie.distance_to(enemy_pos) < 100:  
					valid_position = false
					break

		enemies_positions.append(posicion_enemie)

		var enemigo = Global.instance_node(enemie_on_scene, posicion_enemie, self)
		enemigo.connect("eliminado", Callable(self, "_on_enemy_eliminado"))
		


func _on_enemy_eliminado() -> void:
	enemigos_eliminados += 1

func show_wave_cleared_message() -> void:
	$UI/Control/Label.text = "¡Oleada limpiada!"
	$UI/Control/Label.show()
	await get_tree().create_timer(2).timeout  
	$UI/Control/Label.hide()
	
	
