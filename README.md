# LANServerBroadcast
Nodes for broadcasting and receiving LAN games in the Godot game engine.

These allow you to setup a dead simple LAN only server browser for multiplayer games.

Simply add the `ServerAdvertiser` node to your game lobby scene, this will broadcast the fact that you are hosting on this IP.

You can customize the `serverInfo` being broadcast from the lobby by setting entried in the `serverInfo` dictionary on this node.

For your server browser, Add the ServerListener node to your browser scene, and wire up the two signals: `new_server`, `remove_server`

You should add the server to your server browser UI when you receive `new_server`, and remove it from the UI when you receive `remove_server`
