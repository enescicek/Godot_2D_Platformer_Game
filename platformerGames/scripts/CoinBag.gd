extends Area2D

func _on_body_entered(body):
	if body.name == "oyuncu" :
		
		GlobalVeri.coin = GlobalVeri.coin + 10
		print(GlobalVeri.coin)
		queue_free()
