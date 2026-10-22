% === HECHOS (Síntomas y Materiales) ===
sintoma(warping).
sintoma(stringing).
sintoma(atasco).
sintoma(capa_despegada).
sintoma(capa_desplazada).
sintoma(subextrusion).
sintoma(pie_elefante).
sintoma(ghosting).
sintoma(blobs).
sintoma(sobreextrusion).
sintoma(z_banding).
sintoma(curling).
sintoma(espagueti).

material(pla).
material(abs).
material(petg).

% === HECHOS EXTRA (Propiedades de materiales) ===
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

% === REGLAS DE DIAGNÓSTICO (diagnosticar/3) ===
diagnosticar(warping, pla, 'Conclusion: Limpia la cama con alcohol isopropilico y verifica la nivelacion (Z-Offset).').
diagnosticar(warping, abs, 'Conclusion: El ABS sufre choque termico. Usa laca a 100C y encierra la impresora para evitar corrientes de aire.').

diagnosticar(stringing, pla, 'Conclusion: Aumenta la distancia de retraccion en 1mm y baja la temperatura de la boquilla 5C.').
diagnosticar(stringing, petg, 'Conclusion: El PETG absorbe mucha humedad. Seca el filamento y activa la opcion "Z-Hop".').

diagnosticar(atasco, pla, 'Conclusion: Revisa que el tubo de teflon no este degradado y limpia la boquilla con la aguja de mantenimiento.').
diagnosticar(atasco, abs, 'Conclusion: Temperatura muy baja. Aumenta la temperatura a 240C, el ABS no se esta derritiendo correctamente.').

diagnosticar(capa_despegada, _, 'Conclusion: El Z-Offset esta muy alto. Acerca mas la boquilla a la cama de impresion para aplastar la primera capa.').

diagnosticar(capa_desplazada, _, 'Conclusion: Los motores perdieron pasos. Revisa la tension de las correas de los ejes X y Y, y reduce la velocidad de viaje (Travel).').

diagnosticar(subextrusion, _, 'Conclusion: El extrusor esta patinando. Revisa la tension del resorte del extrusor o desenreda el filamento del carrete.').

diagnosticar(pie_elefante, _, 'Conclusion: La boquilla esta demasiado pegada a la cama. Sube el eje Z (aumenta el Z-Offset) un poco.').

diagnosticar(ghosting, _, 'Conclusion: Exceso de vibracion. Reduce la velocidad, ajusta la aceleracion (Jerk) y coloca la impresora en una mesa firme.').

diagnosticar(blobs, petg, 'Conclusion: Burbujas por humedad en el PETG o mala configuracion de la costura (Z-Seam). Seca el material.').
diagnosticar(blobs, pla, 'Conclusion: Ajusta la "Costura Z" (Z-Seam) en tu laminador para ocultar las marcas de inicio de capa.').

diagnosticar(sobreextrusion, _, 'Conclusion: Estas empujando demasiado plastico. Reduce el multiplicador de extrusion (Flujo) en tu laminador al 95%.').

diagnosticar(z_banding, _, 'Conclusion: Oscilacion en el eje Z. Limpia y lubrica la varilla roscada; asegurate de que no este chueca ni sucia.').

diagnosticar(curling, pla, 'Conclusion: El plastico no se enfria a tiempo en los voladizos. Aumenta la velocidad del ventilador de capa al 100%.').

diagnosticar(espagueti, _, 'Conclusion: La pieza se despego a mitad del trabajo. Mejora la adherencia usando borde (Brim) o balsa (Raft).').

% Regla comodín para evitar que el programa truene con combinaciones raras
diagnosticar(_, _, 'Conclusion: Fallo multiple no registrado. Revisa la calibracion general mecanica y termica de la maquina.').