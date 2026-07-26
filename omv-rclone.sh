#!/bin/bash

# --- Configuración ---
SRC="/Volumes/stuff/ELECE/"  # El '/' final es importante en rsync
# Formato: usuario@IP_DEL_OMV::NOMBRE_DEL_MODULO
DST="eze@192.168.2.39:/srv/dev-disk-by-uuid-58b91598-df33-48be-a38b-23a0a67f25fd/backup_macmini"

# --- Verificaciones ---
if [ ! -d "$SRC" ]; then
    echo "🚨 Error: Origen '$SRC' no encontrado."
    exit 1
fi

# Flags recomendados para rsync:
# -a: archive mode (preserva permisos, fechas, etc.)
# -v: verbose
# -z: comprime datos durante la transferencia
# -P: muestra progreso
# --delete: borra en el destino lo que ya no existe en el origen (mirroring)
RSYNC_FLAGS=(
    #--dry-run
    -a
    -v
    -z
    -P
    --delete
    --exclude="*.DS_Store"
    --exclude=".venv/"
    --exclude=".Spotlight-V100/"
)

echo "🔄 Iniciando sincronización rsync incremental hacia OMV..."

start_time=$(date +%s)

# Ejecutamos y capturamos la salida para procesar los bytes
output=$(rsync "${RSYNC_FLAGS[@]}" "$SRC" "$DST" 2>&1)
exit_status=$?

end_time=$(date +%s)
# --- Cálculos de tiempo ---
duration=$((end_time - start_time))
hours=$((duration / 3600))
mins=$(( (duration % 3600) / 60 ))
secs=$((duration % 60))


# --- Procesamiento de bytes (Extrayendo de la salida de rsync) ---
# Buscamos la línea "Total transferred file size"
total_bytes=$(echo "$output" | grep "Total transferred file size" | awk '{print $5}' | tr -d ',')

# Si rsync no devolvió stats por el error, intentamos con "sent"
if [ -z "$total_bytes" ]; then
    total_bytes=$(echo "$output" | grep "sent" | awk '{print $2}' | tr -d ',')
fi

# Conversión a GB y MB (usando bc para decimales)
total_mb=$(echo "scale=2; $total_bytes / 1048576" | bc)
total_gb=$(echo "scale=2; $total_bytes / 1073741824" | bc)

echo "------------------------------------------------------"

if [ $exit_status -eq 0 ] || [ $exit_status -eq 23 ]; then
    echo "✅ Sincronización finalizada (Status: $exit_status)"
    [ $exit_status -eq 23 ] && echo "⚠️ Nota: Algunos archivos menores fueron omitidos (permisos)."
else
    echo "❌ Error en la sincronización. Status: $exit_status"
fi

echo "📊 Datos procesados: ${total_gb} GB (${total_mb} MB)"
printf "⏱️  Tiempo total: %02dh:%02dm:%02ds\n" $hours $mins $secs
echo "------------------------------------------------------"