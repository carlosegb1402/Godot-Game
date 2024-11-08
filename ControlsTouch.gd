extends Node2D


func _on_touch_screen_button_w_pressed():
	Input.action_press("Forward")


func _on_touch_screen_button_a_pressed():
	Input.action_press("Left")


func _on_touch_screen_button_s_pressed():
	Input.action_press("Back")


func _on_touch_screen_button_d_pressed():
	Input.action_press("Right")


func _on_touch_screen_button_f_pressed():
	Input.action_press("Fire")


func _on_touch_screen_button_r_pressed():
	Input.action_press("Reload")


func _on_touch_screen_button_e_pressed():
	Input.action_press("Menu")
