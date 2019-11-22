extends Node
class_name ServerAdvertiser

const PORT := 3111

export (float) var broadcast_interval: float = 1.0
var server_name := 'LAN Server'

var socketUDP: PacketPeerUDP
var broadcastTimer := Timer.new()

func _enter_tree():
	broadcastTimer.wait_time = broadcast_interval
	broadcastTimer.one_shot = false
	broadcastTimer.autostart = true
	
	if get_tree().is_network_server():
		add_child(broadcastTimer)
		broadcastTimer.connect("timeout", self, "broadcast") 
		
		socketUDP = PacketPeerUDP.new()
		socketUDP.set_dest_address('255.255.255.255', PORT)

func broadcast():
	var info = {'name' : server_name,
				'port' : Network.gameData.serverPort,
				'players' : Network.gameData.players.size(),
				'numGames' : Network.gameData.numGames + 1}
	
	#print('Broadcasting game...')
	var packetMessage := to_json(info)
	var packet := packetMessage.to_ascii()
	socketUDP.put_packet(packet)

func _exit_tree():
	broadcastTimer.stop()
	if socketUDP != null:
		socketUDP.close()
