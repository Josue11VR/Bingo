require"zmq"

local context = zmq.init(1)

local subscriber = context:socket(zmq.SUB)
subscriber:connect("tcp://localhost:5555")
subscriber:setopt(zmq.SUBSCRIBE, "")

local publisher = context:socket(zmq.PUB)
publisher:bind("tcp://*:5556")

local socket = context:socket(zmq.REP)
socket:bind("tcp://*:5557")


local jugar = false
local escuchar = true
local subs = 0

function suscribirJugadores()
  while escuchar do
    local request = socket:recv()
  
    if request == "play" then
      subs = subs + 1
      print("Jugador conectado")
    end

    if request == "init" then
      print("Comienza el juego")
      escuchar = false
      jugar = true
    end
    socket:send("ok")

  end

end

function cantar()
  print("Comienza a cantar a "..subs.." jugadores")
  while jugar do

      local bola = subscriber:recv()
      os.execute("cls")
      print("Bola #: "..bola)
      publisher:send(""..bola)

     for i=1, subs do
  	    local request = socket:recv()
  	    if request == "1" then
  	    	jugar = false
  	    	os.execute("cls")
  	    	print("Juego terminado tenemos ganador")
  	    end
  	    socket:send("ok")
     end

     if jugar == false then
     		publisher:send("0")
     end

  end
end


suscribirJugadores()
cantar()

socket:close()
publisher:close()
subscriber:close()
context:term()






