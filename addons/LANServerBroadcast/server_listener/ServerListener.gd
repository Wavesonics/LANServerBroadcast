extends Node
class_name ServerListener, 'res://addons/LANServerBroadcast/server_listener/server_listener.png'

signal new_server
signal remove_server

var cleanUpTimer := Timer.new()
var socketUDP := PacketPeerUDP.new()
var listenPort := ServerAdvertiser.DEFAULT_PORT
var knownServers = {}

# Number of seconds to wait when a server hasn't been heard from
# before calling remove_server
export (int) var server_cleanup_threshold: int = 3

func _init():
	cleanUpTimer.wait_time = server_cleanup_threshold
	cleanUpTimer.one_shot = false
	cleanUpTimer.autostart = true
	cleanUpTimer.connect("timeout", self, 'clean_up')
	add_child(cleanUpTimer)

func _ready():
	knownServers.clear()
	
	if socketUDP.listen(listenPort) != OK:
		print("GameServer LAN service: Error listening on port: " + str(listenPort))
	else:
		print("GameServer LAN service: Listening on port: " + str(listenPort))

func _process(delta):
	if socketUDP.get_available_packet_count() > 0:
		var serverIp = socketUDP.get_packet_ip()
		var serverPort = socketUDP.get_packet_port()
		var array_bytes = socketUDP.get_packet()
		
		if serverIp != '' and serverPort > 0:
			# We've discovered a new server! Add it to the list and let people know
			if not knownServers.has(serverIp):
				var serverMessage = array_bytes.get_string_from_ascii()
				var gameInfo = parse_json(serverMessage)
				gameInfo.ip = serverIp
				gameInfo.lastSeen = OS.get_unix_time()
				knownServers[serverIp] = gameInfo
				print("New server found: %s - %s:%s" % [gameInfo.name, gameInfo.ip, gameInfo.port])
				emit_signal("new_server", gameInfo)
			# Update the last seen time
			else:
				var gameInfo = knownServers[serverIp]
				gameInfo.lastSeen = OS.get_unix_time()

func clean_up():
	var now = OS.get_unix_time()
	for serverIp in knownServers:
		var serverInfo = knownServers[serverIp]
		if (now - serverInfo.lastSeen) > server_cleanup_threshold:
			knownServers.erase(serverIp)
			print('Remove old server: %s' % serverIp)
			emit_signal("remove_server", serverIp)

func _exit_tree():
	socketUDP.close()
