extends CanvasLayer


func _process(delta):
	$Coin_UI.text = "Altın : " + str(GlobalVeri.coin)
	#$hp_UI.text = "Can : " + str(GlobalVeri.hp)
	
	$ProgressBar.value = GlobalVeri.hp
	pass
