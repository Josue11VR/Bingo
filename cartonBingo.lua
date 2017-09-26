--Imprimir Carton -- Proceso Cliente parte 1
rangos = {0,15,30,45,60,75}



function revisarRepetidos(array,num)
	for i=1,#array do
         if tonumber(array[i])==tonumber(num) then
         	return true
         end
	end

	return false
end

function generarNumero(array,menor,mayor)
	local valor
    band = true
	while band do
        valor  = math.random(menor, mayor)
		if revisarRepetidos(array,valor) == false then
			array[#array+1] = valor
			band=false
		end	

	end

	return valor
end

function llenarCarton(m,a)
	--cambie el random, pero lo hace cada segundo
	math.randomseed(os.time())
	mitad = math.modf(#m/2) +1
	-- Mueve filas
	for i=1, #m do
		--Mueve Columnas (rangos)
		for j=1, #m[1] do
			if (i == mitad and j == mitad) then
				m[i][j] = 0
			else
				--m[i][j] = math.random((rangos[j]+1), rangos[j+1])
				m[i][j] = generarNumero(a,rangos[j]+1,rangos[j+1])
			end 
		end
	end
end


function actualizarCarton(c,b)
	for i=1, #c do

		for j=1, #c[1] do
			if tonumber(c[i][j]) == tonumber(b) then
				c[i][j] = tonumber(0)
			end	
		end
	end
end	

function revisarCarton(c)
	for i=1, #c do

		for j=1, #c[1] do
			if tonumber(c[i][j]) ~= tonumber(0) then
				return false
			end	
		end
	end

	return true
end

function imprimirCarton(m)

	print(".------------------------.")
	print("| B    I    N    G    O  |")
	print("|------------------------|")
	for i=1, #m do
		row = "|"
		for j=1, #m[1] do
			if m[i][j] < 10 then
				if m[i][j] == 0 then
					row = row .. "    "
				else 
					row = row .. " 0" .. m[i][j] .. " "
				end
			else
				row = row .. " " .. m[i][j] .. " "
			end
			row = row .. "|"
		end
		print(row)
	end
	print(".------------------------.")
end
--llenarCarton(carton)
--imprimirCarton(carton)