require"zmq"

local context = zmq.init(1)

local subscriber = context:socket(zmq.SUB)
subscriber:connect("tcp://localhost:5555")
subscriber:setopt(zmq.SUBSCRIBE, "")

local publisher = context:socket(zmq.PUB)
publisher:bind("tcp://*:5556")

local socket = context:socket(zmq.REP)
socket:bind("tcp://*:5557")


local jugar = true

while jugar do

    local bola = subscriber:recv()
    os.execute("cls")
    print("Bola #: "..bola)
    publisher:send(""..bola)

   for i=1, 3 do
	    local request = socket:recv()
	    if request == "1" then
	    	jugar = false
	    	
	    	print("Juego terminado tenemos ganador")
	    end
	    socket:send("ok")
   end

   if jugar == false then
   		publisher:send("0")
   end

end

print("Salii")

socket:close()
publisher:close()
subscriber:close()
context:term()






