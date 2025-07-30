extends Control

@export var advertiserPath: NodePath
@onready var advertiser := get_node(advertiserPath)

const PORT := 3333


func _enter_tree():
	var peer = ENetMultiplayerPeer.new()
	var result = peer.create_server(PORT)
	if result == OK:
		multiplayer.multiplayer_peer = peer
		print("Game hosted")
	else:
		print("Failed to host game")


func _ready():
	# Set this lobby's info to be advertised
	advertiser.serverInfo["name"] = "A great lobby"
	advertiser.serverInfo["port"] = PORT
