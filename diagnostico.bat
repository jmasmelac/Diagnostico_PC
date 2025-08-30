@echo off
chcp 65001 >nul
title Diagnóstico del Sistema

echo =============================
echo   INFORMACIÓN DEL SISTEMA
echo =============================

:: Nombre del sistema operativo
echo.
echo Nombre del sistema operativo:
powershell -command "(Get-CimInstance Win32_OperatingSystem).Caption"

:: Procesador
echo.
echo Informacion del Procesador:
powershell -command "Get-CimInstance Win32_Processor | Format-List Name, Manufacturer, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed"

:: GPU (Nombre)
echo.
echo Información de la GPU (nombre):
echo.
echo GPU(s) detectadas:
powershell -NoProfile -Command "Get-CimInstance Win32_VideoController | ForEach-Object { Write-Output ('Nombre: ' + $_.Name) }"


:: Placa base
echo.
echo Informacion de la Placa Base:
powershell -command "Get-CimInstance Win32_BaseBoard | Format-List Manufacturer, Product, SerialNumber"

:: RAM total
echo.
echo Informacion de la RAM:
powershell -command "$ram = Get-CimInstance Win32_PhysicalMemory; $total = ($ram | Measure-Object -Property Capacity -Sum).Sum / 1GB; Write-Output ('Memoria RAM total: {0:N2} GB' -f $total)"

:: RAM por chip
powershell -command "Get-CimInstance Win32_PhysicalMemory | Select-Object Capacity, Speed, Manufacturer, PartNumber | Format-Table -AutoSize"

:: BATERÍA
echo.
echo Informacion de la BATERIA:
powershell -NoProfile -Command ^
"$cim = Get-CimInstance Win32_Battery; ^
if ($cim) { ^
    $carga = $cim.EstimatedChargeRemaining; ^
    $estado = switch ($cim.BatteryStatus) { ^
        1 {'Desconocido'} 2 {'Cargando'} 3 {'En uso'} 4 {'No cargando'} 5 {'En espera'} 6 {'Cargado'} default {'-'} ^
    }; ^
    Write-Output ('Porcentaje de carga actual: {0}%%' -f $carga); ^
    Write-Output ('Estado: {0}' -f $estado); ^
} else { ^
    Write-Output 'No se detectó batería instalada o accesible.'; ^
} ^
 ^
$batt = Get-WmiObject -Class BatteryFullChargedCapacity -Namespace root\wmi -ErrorAction SilentlyContinue; ^
$design = Get-WmiObject -Class BatteryStaticData -Namespace root\wmi -ErrorAction SilentlyContinue; ^
if ($batt -and $design) { ^
    $full = $batt.FullChargedCapacity; ^
    $orig = $design.DesignedCapacity; ^
    if ($orig -gt 0) { ^
        $vida = [math]::Round(($full / $orig) * 100, 2); ^
        Write-Output ('Porcentaje de vida útil estimada: {0}%%' -f $vida); ^
        Write-Output ('Capacidad de fábrica: {0} mWh' -f $orig); ^
        Write-Output ('Capacidad máxima actual: {0} mWh' -f $full); ^
    } else { ^
        Write-Output 'Capacidad de diseño inválida. No se puede calcular vida útil.' ^
    } ^
} else { ^
    Write-Output 'No se obtuvo información de salud de la batería.' ^
}"

:: Fecha y hora
echo.
echo Fecha y hora:
powershell -command "Get-Date"

echo.
pause


