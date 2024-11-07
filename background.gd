extends TextureRect

func _ready() -> void:
	$TextureProgressBar.value = Global.ammor 



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$TextureProgressBar.value = Global.ammor
	if Global.vida_player==2:
		$live3.hide()
	if Global.vida_player==1:
		$live2.hide()
	if Global.vida_player<=0:
		$live1.hide()
