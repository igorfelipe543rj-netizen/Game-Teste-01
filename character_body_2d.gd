extends CharacterBody2D

var vidas = 3
var velocidade = 200
var pode_levar_dano = true

func _ready():
	print("Personagem criado com ", vidas, " vidas")

func _process(delta):
	# Adicione aqui a lógica de movimento do personagem
	pass

func _on_dano_body_entered(body):
	if pode_levar_dano:
		pode_levar_dano = false
		vidas -= 1
		print("DANO! Vidas restantes: ", vidas)
		
		# Efeito visual de piscar
		modulate.a = 0.5
		await get_tree().create_timer(0.1).timeout
		modulate.a = 1.0
		await get_tree().create_timer(0.1).timeout
		modulate.a = 0.5
		await get_tree().create_timer(0.1).timeout
		modulate.a = 1.0
		
		# Aguarda 1 segundo antes de poder levar dano novamente
		await get_tree().create_timer(1.0).timeout
		pode_levar_dano = true
		
		# Verifica se morreu
		if vidas <= 0:
			morrer()

func morrer():
	print("GAME OVER! Você perdeu!")
	get_tree().reload_current_scene()