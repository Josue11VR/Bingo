require"zmq"
require"zhelpers"

local context = zmq.init(1)
local publisher = context:socket(zmq.PUB)
publisher:bind("tcp://*:5555")

local subscriber = context:socket(zmq.SUB)
subscriber:connect("tcp://localhost:5556")
subscriber:setopt(zmq.SUBSCRIBE, "")

cantados = {}

math.randomseed(os.time())

function fueCantada(numero)
	 for i=1 , #cantados do
	 	if cantados[i]==numero then
	 		return true
	 	end	
	 end
	 return false
end	

function insertarCantados(numero)
   cantados[#cantados+1]= numero
end	

function imprimirCantados()
   os.execute("cls")
   row=""
   for i=1 , #cantados do
   	row= row.."[ "..cantados[i].." ]"
   end

   print("Bolas cantadas: "..row)
end	

function generarBola()
	local valor
	band = true
	while band do
		valor  = math.random(1, 75)
		if fueCantada(valor)==false then
			insertarCantados(valor)
			band=false
        end
	end

	return valor	
end

local jugar = true

while jugar do
    s_sleep(2000)
    local bola
    bola     = generarBola()
    publisher:send(""..bola)
    imprimirCantados()

    local mensaje = subscriber:recv()

    if mensaje == "0" then
    	jugar = false
    end

end

subscriber:close()
publisher:close()
context:term()