package com.example.bateria_application

import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import android.os.BatteryManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.bateria_application/battery"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "getBatteryTemperature" -> {
                    val temperature = getBatteryTemperature()
                    if (temperature != null) {
                        result.success(temperature)
                    } else {
                        result.error("UNAVAILABLE", "Temperatura no disponible", null)
                    }
                }
                "getBatteryVoltage" -> {
                    val voltage = getBatteryVoltage()
                    if (voltage != null) {
                        result.success(voltage)
                    } else {
                        result.error("UNAVAILABLE", "Voltaje no disponible", null)
                    }
                }
                "getBatteryHealth" -> {
                    val health = getBatteryHealth()
                    result.success(health)
                }
                "getBatteryCapacity" -> {
                    val capacity = getBatteryCapacity()
                    if (capacity != null) {
                        result.success(capacity)
                    } else {
                        result.error("UNAVAILABLE", "Capacidad no disponible", null)
                    }
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    /**
     * Obtiene la temperatura REAL del hardware en grados Celsius
     * Lee el termistor integrado en la batería
     */
    private fun getBatteryTemperature(): Double? {
        val batteryStatus: Intent? = registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        return batteryStatus?.let {
            val temp = it.getIntExtra(BatteryManager.EXTRA_TEMPERATURE, -1)
            if (temp != -1) {
                // La temperatura viene en décimas de grado (280 = 28.0°C)
                temp / 10.0
            } else {
                null
            }
        }
    }

    /**
     * Obtiene el voltaje REAL del hardware en voltios
     * Lee el sensor de voltaje del circuito de carga
     */
    private fun getBatteryVoltage(): Double? {
        val batteryStatus: Intent? = registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        return batteryStatus?.let {
            val voltage = it.getIntExtra(BatteryManager.EXTRA_VOLTAGE, -1)
            if (voltage != -1) {
                // El voltaje viene en milivolts (4200 = 4.2V)
                voltage / 1000.0
            } else {
                null
            }
        }
    }

    /**
     * Obtiene el estado de salud de la batería
     * Valores: Unknown, Good, Overheat, Dead, Over Voltage, Cold
     */
    private fun getBatteryHealth(): String {
        val batteryStatus: Intent? = registerReceiver(null, IntentFilter(Intent.ACTION_BATTERY_CHANGED))
        return batteryStatus?.let {
            when (it.getIntExtra(BatteryManager.EXTRA_HEALTH, -1)) {
                BatteryManager.BATTERY_HEALTH_GOOD -> "Buena"
                BatteryManager.BATTERY_HEALTH_OVERHEAT -> "Sobrecalentada"
                BatteryManager.BATTERY_HEALTH_DEAD -> "Muerta"
                BatteryManager.BATTERY_HEALTH_OVER_VOLTAGE -> "Sobre Voltaje"
                BatteryManager.BATTERY_HEALTH_COLD -> "Fría"
                BatteryManager.BATTERY_HEALTH_UNSPECIFIED_FAILURE -> "Fallo"
                else -> "Desconocida"
            }
        } ?: "Desconocida"
    }

    /**
     * Obtiene la capacidad actual de la batería en mAh
     * Nota: No todos los dispositivos exponen esta información
     */
    private fun getBatteryCapacity(): Int? {
        val batteryManager = getSystemService(Context.BATTERY_SERVICE) as BatteryManager
        return try {
            // Capacidad restante en microamperios-hora (μAh)
            val chargeCounter = batteryManager.getLongProperty(BatteryManager.BATTERY_PROPERTY_CHARGE_COUNTER)
            // Convertir de μAh a mAh
            (chargeCounter / 1000).toInt()
        } catch (e: Exception) {
            // Intentar leer la capacidad de diseño
            try {
                val capacity = batteryManager.getIntProperty(BatteryManager.BATTERY_PROPERTY_CAPACITY)
                // Este valor es un porcentaje, no mAh
                null
            } catch (e: Exception) {
                null
            }
        }
    }
}