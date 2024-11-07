extends Node


var creation = null
var player = null
var score=0
var vida_player=3
var ammor=31


func instance_node(packed_scene, location, parent):
	var node_instance = packed_scene.instantiate()
	parent.add_child(node_instance)
	node_instance.global_position=location
	return node_instance
	
