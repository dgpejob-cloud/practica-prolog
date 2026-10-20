const express = require('express');
const { exec } = require('child_process');
const path = require('path');

const app = express();
app.use(express.json());
app.use(express.static(path.join(__dirname, 'public')));

app.post('/api/consultar', async (req, res) => {
    // Aquí el servidor ya está listo para recibir el arreglo "sintomas"
    const { sintomas, material } = req.body;
    
    if (!sintomas || sintomas.length === 0) {
        return res.json({ recomendacion: "Por favor, selecciona al menos un síntoma." });
    }

    const promesas = sintomas.map(sintoma => {
        return new Promise((resolve) => {
            const query = `diagnosticar('${sintoma}', '${material}', Conclusion), writeln(Conclusion).`;
            const command = `swipl -s conocimientos.pl -g "${query}" -t halt.`;

            exec(command, (error, stdout) => {
                let textoSintoma = sintoma.replace(/_/g, ' '); 
                if (error || !stdout.trim()) {
                    resolve(`<li><b>Falla por ${textoSintoma}:</b> Sin solución en la base de conocimientos.</li>`);
                } else {
                    resolve(`<li><b>Falla por ${textoSintoma}:</b> ${stdout.trim()}</li>`);
                }
            });
        });
    });

    try {
        const resultados = await Promise.all(promesas);
        res.json({ recomendacion: `<ul>${resultados.join('')}</ul>` });
    } catch(e) {
        res.status(500).json({ recomendacion: "Error interno del servidor." });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => console.log(`Servidor activo en el puerto ${PORT}`));