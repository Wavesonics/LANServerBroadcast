extends VBoxContainer

func _on_HostButton_pressed():
	get_tree().change_scene("res://example/HostGame.tscn")

func _on_BrowseButton_pressed():
	get_tree().change_scene("res://example/ServerBrowser.tscn")
