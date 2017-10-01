require"zmq"
require "cartonBingo"

carton = {{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0}}
array = {}
acertadas = 0


llenarCarton(carton,array)
imprimirCarton(carton)

local context = zmq.init(1)

local subscriber = context:socket(zmq.SUB)
subscriber:connect("tcp://localhost:5556")
subscriber:setopt(zmq.SUBSCRIBE, "")

local socket = context:socket(zmq.REQ)
socket:connect("tcp://localhost:5557")


socket:send("play")
socket:recv()

local jugar = true

while jugar do

    
    local bola = subscriber:recv()
    --os.execute("cls")

    if bola ~= "0" then
	    print("Bola #: "..bola)

	 
	    if actualizarCarton(carton,bola)==true then
	    	acertadas = acertadas +1
	    end	

	    imprimirCarton(carton)

	    if revisarCarton(acertadas) == true then
	    	print("   ---------------")
	    	print("   | BINGOOOOOOO |")
	    	print("   ---------------")
			socket:send("1")
	    else	
	    	socket:send("0")
	    end


	    

	    socket:recv()

	else
	print("juego terminado") 
	jugar = false   
	end  


end


socket:close()
subscriber:close()
context:term()
