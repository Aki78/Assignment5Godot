extends CharacterBody2D


const SPEED = 300.0

var tick = 0
var vibrate = false
@onready var shoot = $Shoot

@onready var raycast = $RayCast2D

var health = 3

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")


func _enter_tree():
	set_multiplayer_authority(str(name).to_int())

#	print("settomg up", name)

	

#	set_multiplayer_authority(str(name).to_int())
#	print(is_multiplayer_authority())
	pass

func _ready():
	randomize()
	print("REDADY!", get_multiplayer_authority())
	print("miname",str(name).to_int())
	print("unique", get_index())

	$Lavel.text = name
#	if name != str(get_multiplayer_authority()): return


	if not is_multiplayer_authority(): return
	position.x = randi_range(0,1000)
	position.y = randi_range(0,500)
	$Icon.modulate = Color(randi_range(0,10),randi_range(0,10),randi_range(0,10))
	


#$MultiplayerSynchronizer.set_multiplayer_authority(str(name).to_int())
#	if not is_multiplayer_authority(): return



#	position.x = randi_range(0,1000)
#	position.y = randi_range(0,500)

#	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func _physics_process(_delta):

#	if tick == 0:
#		tick = 1
#		set_multiplayer_authority(str(name).to_int())
#	if name == str(get_multiplayer_authority()): 

	if not is_multiplayer_authority(): return

	shoot_animate()
	move()
	
	if vibrate:
		position.x += 5*sin(50*Time.get_unix_time_from_system())
		print("vibrating!")
	
	look_at(get_global_mouse_position())
#	if self.name == str(get_multiplayer_authority()):
	#print("Going")


@rpc("any_peer")
func receive_damage():
	health -= 1
	if health <= 0:
		health = 3
		position.x = randi_range(0,1000)
		position.x = randi_range(0,1000)

func shoot_animate():
	if Input.is_action_just_pressed("left_click"):
		shoot.animate_me()

func _on_shoot_shot():
	print("shot")
	if raycast.is_colliding():
		var hit_player = raycast.get_collider()
		print("shooting: ", hit_player.get_multiplayer_authority())
		var hit_id = hit_player.get_multiplayer_authority()
		hit_player.receive_damage.rpc_id(hit_id)
		hit_player.vibrate_me.rpc_id(hit_id)
		print("shooooooot")

func move():
	var directionX = Input.get_axis("ui_left", "ui_right")
	var directionY = Input.get_axis("ui_up", "ui_down")
	if directionX:
		velocity.x = directionX * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		
	if directionY:
		velocity.y = directionY * SPEED
	else:
		velocity.y = move_toward(velocity.y, 0, SPEED)

	move_and_slide()

@rpc("any_peer")
func vibrate_me():
	$Life.text = str(health)
	$Timer.start()
	vibrate = true
	await $Timer.timeout
	vibrate = false
	
