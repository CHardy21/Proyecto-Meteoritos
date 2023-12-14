# ContenedorInformacionEnergia
class_name ContenedorInformacionEnergia
extends ContenedorInformacion

## ATRIBUTOS
#Variables Onready
onready var medidor:ProgressBar = $ProgressBar


# Métodos Customs
func actualizar_energia(energia_max:float, energia_actual:float) -> void:
# warning-ignore:narrowing_conversion
	var energia_porcentual:int = (energia_actual * 100) / energia_max
	medidor.value = energia_porcentual
