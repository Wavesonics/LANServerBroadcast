# LANServerBroadcast
Nodes for broadcasting and receiving LAN games in the Godot game engine.

These allow you to setup a dead simple LAN only server browser for multiplayer games.

# Setup for the host
Add the `ServerAdvertiser` node to your game **Lobby** scene (*but only for the host if it's peer to peer*), this will broadcast the fact that you are hosting on this IP.

You can customize the `serverInfo` being broadcast from the lobby by setting entries in the `serverInfo` dictionary on this node.
```
    advertiser.serverInfo["name"] = "A great lobby"
    advertiser.serverInfo["port"] = 3333 # This is important so the client knows what port to connect on
    advertiser.serverInfo["max_players"] = 10
    advertiser.serverInfo["cur_players"] = 3
```

You can change this info at will, and the new changes will be broadcast out at the next interval.

The broadcast interval can be changed on the `ServerAdvertiser` node via the exposed property: `broadcast_interval` (*default is 1 second*)

# Setup for the client
For your server browser, Add the `ServerListener` node to your **Server Browser** scene, and wire up the two signals: `new_server`, `remove_server`

You should add the server to your server browser UI when you receive `new_server`.

You can use the info that the server provided in it's `serverInfo` to populate the UI in your server browser.

On the client this is represented as an object who's properties are the fields the server specified.

In adition to what ever you added via `advertiser.serverInfo[]` the `ServerListener` node also adds in the server's IP: `serverInfo.ip`

From the example above, access the fields as such:
```
func _on_ServerListener_new_server(serverInfo):
    serverInfo.ip
    serverInfo.name
    serverInfo.port
    serverInfo.max_players
    serverInfo.cur_players
```

To connect to a game, you just grab the IP and Port (*if it's not hard coded for your game*) from the serverInfo, and then perform a normal connection how ever you like.

Lastly, when a server goes offline, you must remove it from the UI. You do this when you receive a `remove_server` signal, this is emitted when a server has not been seen for a period of time, which the server browser can specify on the `ServerListener` node via the exposed property: `server_cleanup_threshold`
