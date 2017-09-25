--Imprimir Carton -- Proceso Cliente parte 1
rangos = {0,15,30,45,60,75}

function llenarCarton(m)
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
				m[i][j] = math.random((rangos[j]+1), rangos[j+1])
			end 
		end
	end
end

function imprimirCarton(m)

	print(".------------------------.")
	print("| B    I    N    G    O  |")
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