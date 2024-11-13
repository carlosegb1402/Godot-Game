extends Node


var creation = null
var player : Node2D = null
var score=0
var vida_player=3
var ammor=31
var ready_to_shoot = false

func instance_node(packed_scene, location, parent):
	var node_instance = packed_scene.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position=location
	return node_instance
	
func set_player(new_player: Node2D) -> void:
	player = new_player

func clear_player() -> void:
	if player != null:
		player = null
