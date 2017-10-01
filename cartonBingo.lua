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
				m[j][i] = 0
			else
				m[j][i] = generarNumero(a,rangos[j]+1,rangos[j+1])
			end 
		end
	end
end

function seleccionarColumna(b)
	for i = 2, #rangos do
		if b<=rangos[i] then 
			return i-1
		end	
	end
end

function actualizarCarton(c,b)
	bol = tonumber(b)
	columna = seleccionarColumna(bol)
    
    colum_selected = c[columna]

    for i = 1, #colum_selected do
     	if colum_selected[i] == bol then
			colum_selected[i] = -1
			return true
		end	
    end

    return false

end	

function revisarCarton(a)
  return a == 24
end

function imprimirCarton(m)

	print(".------------------------.")
	print("| B    I    N    G    O  |")
	print("|------------------------|")

	--columnas
	for i=1, #m do
		row = "|"
		--filas
		for j=1, #m[1] do
			if m[j][i] < 10 then
				if m[j][i] == 0 then
					row = row .. "    "
				else 
					if m[j][i]== -1 then
                      row = row .. " -- "
                    else 
						row = row .. " 0" .. m[j][i] .. " "
				    end
				end
			else
				row = row .. " " .. m[j][i] .. " "
			end
			row = row .. "|"
		end
		print(row)
	end
	print(".------------------------.")
end
--llenarCarton(carton)
--imprimirCarton(carton)