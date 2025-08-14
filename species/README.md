# Especies de Mariposas (Gestión Modular)

Para agregar una nueva mariposa:

1. Crea una carpeta dentro de `species/` con el nombre de la especie (ejemplo: `monarca`).
2. Dentro de esa carpeta, agrega un archivo `metadata.json` con la siguiente estructura:

```json
{
  "name": "Mariposa Monarca",
  "scientificName": "Danaus plexippus",
  "imageAsset": "assets/images/monarca.png",
  "modelAsset": "assets/models/mariposa.glb"
}
```

3. Coloca los archivos de imagen y modelo 3D en los directorios correspondientes (`assets/images/`, `assets/models/`).
4. ¡Listo! La app puede leer automáticamente todas las especies leyendo los metadatos de cada subcarpeta.

## Ejemplo de estructura:

```
species/
├── monarca/
│   └── metadata.json
├── morpho/
│   └── metadata.json
...
```

Puedes automatizar la carga de especies leyendo todos los `metadata.json` desde código (ver siguiente paso de integración en Flutter).
