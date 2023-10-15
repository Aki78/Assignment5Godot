extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D

var audio_file = "res://Sounds/gunshot_short.mp3"

signal shot

func _ready():
	_animated_sprite.hide()

	

func _process(_delta):
#	if Input.is_action_pressed("ui_right"):
##		_animated_sprite.show()
#		_animated_sprite.play("default")
#	else:
##		_animated_sprite.hide()
#		_animated_sprite.stop()
#		
	
#	if Input.is_action_just_pressed("left_click"):
#		animate_me()

		
		await _animated_sprite.animation_finished
		_animated_sprite.hide()

func animate_me():
	var audio = AudioStreamPlayer2D.new()
	var sfx = load(audio_file)
	_animated_sprite.show()
	_animated_sprite.play("default")
	print("Input pressed")
	add_child(audio)
	audio.stream = sfx
	audio.play()
	emit_signal("shot")
	await audio.finished
	audio.queue_free()
	



func _on_timer_timeout():
	pass # Replace with function body.
