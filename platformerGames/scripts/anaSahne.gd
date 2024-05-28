extends Node2D





func _on_area_2d_body_entered(body):
	if body == $oyuncu :		
		get_tree().change_scene_to_file("res://sahneler/ikinci_sahne.tscn")
