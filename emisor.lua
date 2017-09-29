require"zmq"
require"zhelpers"

local context = zmq.init(1)
local publisher = context:socket(zmq.PUB)
publisher:bind("tcp://*:5555")

local subscriber = context:socket(zmq.SUB)
subscriber:connect("tcp://localhost:5556")
subscriber:setopt(zmq.SUBSCRIBE, "")

cantados = {}
bingo = {}
random = 75

math.randomseed(os.time())

function cargarbolas()
 for i =1, 75 do
  bingo[#bingo+1]=i
 end
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
	
		espacio  = math.random(1, random)
    bolita = bingo[espacio]
    insertarCantados(bolita)
    table.remove(bingo, espacio)
    random = random -1


    return bolita
	
end

local jugar = true
cargarbolas()

while jugar do
    s_sleep(1000)
    local bola
    bola  = generarBola()
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