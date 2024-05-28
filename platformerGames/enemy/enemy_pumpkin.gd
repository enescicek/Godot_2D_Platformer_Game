extends CharacterBody2D

var speed = 40
var player_chase = false
var player_in_danger = false
var Oyuncu = null
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	velocity.y += gravity * delta
	if player_chase:
		position += (Oyuncu.position - position)/speed
		
		if (Oyuncu.position.x - position.x) < 0:
			$AnimatedSprite2D.flip_h = true

		else:
			$AnimatedSprite2D.flip_h = false
	move_and_slide()

func _on_tespit_body_entered(body): # Düzeltilmiş hali
	if body.name == "oyuncu":
		
		Oyuncu = body
		player_chase = true

func _on_tespit_body_exited(body): # Düzeltilmiş hali
	if body.name == "oyuncu":
		
		Oyuncu = null
		player_chase = false



func _on_danger_zone_body_entered(body):
	if body.name == "oyuncu":		
		player_in_danger = true
		DangerDamege()

func EnemyHasar():
	print("düşman öldü")
	self.queue_free()


func _on_danger_zone_body_exited(body):
	player_in_danger = false
	
func DangerDamege():
	if player_in_danger :
		GlobalVeri.hp -= 25
		Oyuncu.CanKontrol()
		$Timer.start()
	else:
		$Timer.stop()
		pass	
		


func _on_timer_timeout():
	DangerDamege()
