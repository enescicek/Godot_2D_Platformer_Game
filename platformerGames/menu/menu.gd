extends Control





func _on_yeni_oyun_pressed():
	get_tree().change_scene_to_file("res://sahneler/oyun_sahnemiz.tscn")


func _on_ayarlar_pressed():
	pass # Replace with function body.


func _on_cikis_pressed():
	get_tree().quit()
