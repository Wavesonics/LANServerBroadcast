extends VBoxContainer

func _on_HostButton_pressed():
	get_tree().change_scene("res://example/TestLobby.tscn")

func _on_BrowseButton_pressed():
	get_tree().change_scene("res://example/TestServerBrowser.tscn")
