extends Node

const Packet = preload("res://packet.gd")

signal connected
signal data
signal disconnected
signal error

var socket = WebSocketPeer.new()
var url =""


func _ready():
	socket.connect_to_url("")
	

func send_packet(packet: Packet) -> void:
	socket.send_text(packet.tostring())


func _process(delta):
	socket.poll()
	var state = socket.get_ready_state()
	if state == WebSocketPeer.STATE_OPEN:
		print("Packet: ", socket.get_packet())
	elif state == WebSocketPeer.STATE_CLOSING:
		pass
	elif state == WebSocketPeer.STATE_CLOSED:
		var code = socket.get_close_code()
		var reason = socket.get_close_reason()

		print("WebSocket closed with code: %d, reason %s. Clean: %s" % [code, reason, code != -1])
		set_process(false)
		
