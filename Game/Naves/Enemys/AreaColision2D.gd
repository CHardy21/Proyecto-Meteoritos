# AreaColision2D.gd
extends Area2D

func recibir_danio(danio:float):
	owner.recibir_danio(danio)
	print("Se paso el daño a ", owner.name)
