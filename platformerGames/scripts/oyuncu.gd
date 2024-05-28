extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

#Saldırı Değişkenleri
var canMove = true
var canAttack = true
var yonDeger = 0
var isAlive = true

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var animator = get_node("AnimationPlayer")


func _physics_process(delta):
	
	if canAttack == true && Input.is_action_just_pressed("attack") && is_on_floor() :
		Attack()
		
	
	if canMove == true:
		if not is_on_floor():
			velocity.y += gravity * delta
			

		# Handle jump.
		if Input.is_action_just_pressed("zipla") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			animator.play("jump")

		# Get the input direction and handle the movement/deceleration.
		# As good practice, you should replace UI actions with custom gameplay actions.
		var direction = Input.get_axis("solaGit", "sagaGit")
		
		#animasyonun yöne göre dönüşünü ayarlayalım
		if direction == -1 :
			yonDeger=-1
			get_node("AnimatedSprite2D").flip_h=true 
		elif direction == 1 :
			yonDeger=1
			get_node("AnimatedSprite2D").flip_h=false 
				
				
		if direction:
			velocity.x = direction * SPEED
			#zıplamıyorsak ve x ekseninde gidiyorsak koşma animasyonu devreye girsin.
			if velocity.y == 0 :
				animator.play("run")
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)
			animator.play("Idle")
		
		if velocity.y>0 :
			animator.play("fall")	
				

		move_and_slide()
	else:
		pass
			
		
	
func DeathState():
	isAlive=false
	canMove=false
	canAttack=false
	animator.play("Death")
	
func Attack():
	canMove=false
	canAttack=false
	animator.play("Attack")
	print("attack test")	
	
	if yonDeger == -1:
		$Hitbox/hitboxColRight.disabled = true
		$Hitbox/hitboxColLeft.disabled = false
	else:
		$Hitbox/hitboxColRight.disabled = false
		$Hitbox/hitboxColLeft.disabled = true
		
func CanKontrol():
	
	if GlobalVeri.hp <= 0 :
		DeathState()		


func _on_animation_player_animation_finished(anim_name):
	if isAlive==true:
		$Hitbox/hitboxColRight.disabled = true
		$Hitbox/hitboxColLeft.disabled = true
		canMove=true
		canAttack=true
	else:
		GlobalVeri.hp = 100
		GlobalVeri.coin = 0
		get_tree().reload_current_scene()	#Karekterimiz ölünce sahnemizin baştan başlaması için.
	pass
		
			
		


func _on_hitbox_body_entered(enemy):
	if enemy.is_in_group("Enemy"):
		print("düşman vuruldu")
		enemy.EnemyHasar()
