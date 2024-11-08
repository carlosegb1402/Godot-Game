extends Node2D


func _on_touch_screen_button_w_pressed():
	Input.action_press("Forward")


func _on_touch_screen_button_a_pressed():
	Input.action_press("Left")


func _on_touch_screen_button_s_pressed():
	Input.action_press("Back")


func _on_touch_screen_button_d_pressed():
	Input.action_press("Right")


func _on_touch_screen_button_r_pressed():
	Input.action_press("Reload")


func _on_touch_screen_button_e_pressed():
	Input.action_press("Menu")


func _on_touch_screen_button_r_released() -> void:
	Input.action_release("Reload")


func _on_touch_screen_button_w_released() -> void:
	Input.action_release("Forward")


func _on_touch_screen_button_a_released() -> void:
	Input.action_release("Left")


func _on_touch_screen_button_s_released() -> void:
	Input.action_release("Back")


func _on_touch_screen_button_d_released() -> void:
	Input.action_release("Right")


func _on_touch_screen_button_e_released() -> void:
	Input.action_release("Menu")
