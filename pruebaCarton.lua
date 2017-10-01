require "cartonBingo"
--carton = {{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0}}
carton2 = {{02,11,16,09,14},{25,28,30,18,20},{32,44,0,38,36},{50,46,58,59,49},{70,75,62,68,64}}
--carton2 = {{02,25,32,50,70},{11,28,44,46,75},{16,30,0,58,62},{09,18,38,59,68},{14,20,36,49,64}}
numerosMarcados = {}
--llenarCarton(carton)
imprimirCarton(carton2)

actualizarCarton(carton2, "44")
actualizarCarton(carton2, "32")
actualizarCarton(carton2, "36")
actualizarCarton(carton2, "38")

imprimirCarton(carton2)