extends TextureRect

var blink_timer: float = 0.0
var is_blinking: bool = false

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()  # Ocultar el TextureRect al inicio

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Global.ammor < 6:
		# Mostrar y parpadear cuando ammo es menor a 5
		if not is_blinking:
			show()  # Asegúrate de que esté visible
			is_blinking = true
			blink_timer = 0.0  # Reiniciar el temporizador

		blink_timer += delta
		if blink_timer >= 0.5:  # Cambia el tiempo de parpadeo aquí
			self.visible = not self.visible  # Alternar visibilidad
			blink_timer = 0.0  # Reiniciar el temporizador
	else:
		hide()  # Ocultar si ammo es 5 o más

	# Detectar la tecla 'R'
