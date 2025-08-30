# Diagnóstico de PCs

Repositorio con scripts simples para obtener información básica de un equipo en **Linux** y **Windows**.  
No almacenan resultados, únicamente muestran en pantalla el estado detectado del sistema.

---

## Archivos incluidos

- `diagnostico.sh` → Script para Linux (Bash).
- `diagnostico.bat` → Script para Windows (Batch).
- `README.md` → Este archivo con instrucciones.
- `LICENSE` → Licencia MIT.

---

## Uso en Windows

Ejecutar el archivo `diagnostico.bat` con doble clic.  
Se recomienda abrir como Administrador para obtener la información completa.

---

## Uso en Linux

Dar permisos de ejecución y correr el script:

```bash
chmod +x diagnostico.sh
./diagnostico.sh
```

Asegúrese de estar en la carpeta donde se encuentra el archivo o de indicar la ruta completa.

---

## Qué hacen los archivos

- **diagnostico.sh**: muestra información de fabricante, modelo y número de serie, CPU, memoria RAM, discos, estado SMART (si está disponible), interfaces de red, GPU, batería y fecha/hora.&#x20;

- **diagnostico.bat**: entrega información básica del sistema en Windows, incluyendo versión, procesador, memoria y red.

---

## Licencia

Este proyecto está bajo la licencia **MIT**. Consulte el archivo [LICENSE](LICENSE) para más información.
