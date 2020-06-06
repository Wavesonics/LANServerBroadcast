tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("ServerAdvertiser", "Node", load("res://addons/LANServerBroadcast/server_advertiser/ServerAdvertiser.gd"), load("res://addons/LANServerBroadcast/server_advertiser/server_advertiser.png"))
	add_custom_type("ServerListener", "Node", load("res://addons/LANServerBroadcast/server_listener/ServerListener.gd"), load("res://addons/LANServerBroadcast/server_listener/server_listener.png"))


func _exit_tree():
	remove_custom_type("ServerAdvertiser")
	remove_custom_type("ServerListener")
