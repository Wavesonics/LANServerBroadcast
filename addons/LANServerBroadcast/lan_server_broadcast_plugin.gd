tool
extends EditorPlugin

func _enter_tree():
	add_custom_type("ServerAdvertiser", "Node", preload("server_advertiser/ServerAdvertiser.gd"), preload("server_advertiser/ServerAdvertiser.png"))
	add_custom_type("ServerListener", "Node", preload("server_listener/ServerListener.gd"), preload("server_listener/ServerListener.png"))


func _exit_tree():
	remove_custom_type("ServerAdvertiser")
	remove_custom_type("ServerListener")
