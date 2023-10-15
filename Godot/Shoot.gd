extends Node2D

@onready var _animated_sprite = $AnimatedSprite2D


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
	_animated_sprite.show()
	_animated_sprite.play("default")
	print("Input pressed")


func _on_timer_timeout():
	pass # Replace with function body.
