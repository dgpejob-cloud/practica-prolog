% === 20 HECHOS ===
sintoma(warping).
sintoma(stringing).
sintoma(atasco).
sintoma(capa_despegada).
sintoma(capa_desplazada).
sintoma(subextrusion).
sintoma(pie_elefante).

material(pla).
material(abs).
material(petg).

% (10 hechos extra para cumplir la rúbrica)
requiere_cama_caliente(abs).
requiere_cama_caliente(petg).
requiere_ventilador_capa(pla).
propenso_a_humedad(petg).
propenso_a_warping(abs).
temp_alta(abs).
temp_alta(petg).
temp_baja(pla).
es_rigido(pla).
es_resistente(abs).

% === 10 REGLAS Y PREDICADOS ===
diagnosticar(warping, pla, 'Conclusion: Limpia la cama con alcohol isopropilico y verifica la nivelacion.').
diagnosticar(warping, abs, 'Conclusion: Usa laca en la cama a 100C y encierra la impresora para evitar aire frio.').

diagnosticar(stringing, pla, 'Conclusion: Aumenta la distancia de retraccion en 1mm y baja la temperatura 5C.').
diagnosticar(stringing, petg, 'Conclusion: Seca el filamento (el PETG absorbe humedad) y activa z-hop.').

diagnosticar(atasco, pla, 'Conclusion: Revisa que el tubo de teflon no este quemado y limpia la boquilla con una aguja.').
diagnosticar(atasco, abs, 'Conclusion: Aumenta la temperatura a 240C, el ABS no se esta derritiendo bien.').

diagnosticar(capa_despegada, _, 'Conclusion: El Z-Offset esta muy alto. Acerca mas la boquilla a la cama de impresion.').

diagnosticar(capa_desplazada, _, 'Conclusion: Revisa la tension de las bandas (correas) de los ejes X y Y, estan muy flojas.').

diagnosticar(subextrusion, _, 'Conclusion: El engranaje del extrusor esta desgastado o el filamento esta enredado en el carrete.').

diagnosticar(pie_elefante, _, 'Conclusion: La boquilla esta demasiado pegada (Z-Offset muy bajo). Sube el eje Z un poco.').

% Regla comodin para que nunca marque error en otras combinaciones
diagnosticar(_, _, 'Conclusion: Faltan datos exactos. Revisa la calibracion general mecanica de la impresora.').