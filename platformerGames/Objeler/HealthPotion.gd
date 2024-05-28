extends Area2D




func _on_body_entered(body):
	if body.name == "oyuncu" :
		if GlobalVeri.hp <100 :			
			GlobalVeri.hp += 25
			queue_free()
