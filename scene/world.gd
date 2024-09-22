extends Node2D

var carte = []
var carte_tot = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Camera2D/HBoxContainer.visible = false
	instantiate_cards()
	$Deck/AnimationPlayer.play("deck_appear")
	for i in GameManager.Players.size():
		var card_id
		for k in 5:
			var numb = randi_range(0, Globals.starter_deck.size())
			card_id = Globals.starter_deck[numb]
			Globals.starter_deck.remove_at(numb)
			get_card(card_id)

#func instantiate_tot_cards():
#	for i in 52:
#		if i == 0:
#			carte_tot.append(load("res://scene/carte/Arpia.tscn").instantiate()) 
##			carte_tot.append(load("res://scene/carte/Arpia.tscn").instantiate()) 
###			carte_tot.append(load("res://scene/carte/Arpia.tscn").instantiate()) 
##			carte_tot.append(load("res://scene/carte/Arpia.tscn").instantiate()) 
#		elif i == 1:
#			carte_tot.append(load("res://scene/carte/ArpiaFT.tscn").instantiate())
#		elif i == 2:
#			carte_tot.append(load("res://scene/carte/Centauro.tscn").instantiate()) 
#		elif i == 3:
#			carte_tot.append(load("res://scene/carte/Dragonborn.tscn").instantiate()) 
#		elif i == 4:
#			carte_tot.append(load("res://scene/carte/ElfoN.tscn").instantiate()) 
#		elif i == 5:
#			carte_tot.append(load("res://scene/carte/ElfoO.tscn").instantiate()) 
#		elif i == 6:
##		elif i == 6:
#			carte_tot.append(load("res://scene/carte/Eroe.tscn").instantiate()) 
#		elif i == 7:
#			carte_tot.append(load("res://scene/carte/Fata.tscn").instantiate()) 
#		elif i == 8:
#			carte_tot.append(load("res://scene/carte/Halfling.tscn").instantiate()) 
##			carte_tot.append(load("res://scene/carte/Halfling.tscn").instantiate()) 
#		elif i == 9:
##		elif i == 9:
#			carte_tot.append(load("res://scene/carte/NanoC.tscn").instantiate()) 
#		elif i == 10:
#			carte_tot.append(load("res://scene/carte/NanoM.tscn").instantiate()) 
#		elif i == 11:
#			carte_tot.append(load("res://scene/carte/NanoP.tscn").instantiate()) 
#		elif i == 12:
#			carte_tot.append(load("res://scene/carte/OrcoC.tscn").instantiate()) 
#		elif i == 13:
#			carte_tot.append(load("res://scene/carte/OrcoP.tscn").instantiate()) 
##			carte_tot.append(load("res://scene/carte/OrcoP.tscn").instantiate()) 
###			carte_tot.append(load("res://scene/carte/OrcoP.tscn").instantiate()) 
	#	elif i == 14:
	#		carte_tot.append(load("res://scene/carte/ReTritone.tscn").instantiate()) 
	#	elif i == 15:
	#		carte_tot.append(load("res://scene/carte/SUmanoCane.tscn").instantiate()) 
	#	elif i == 16:
	#		carte_tot.append(load("res://scene/carte/SUmanoDrago.tscn").instantiate()) 
	#	elif i == 17:
	#		carte_tot.append(load("res://scene/carte/SUmanoGatto.tscn").instantiate()) 
	#	elif i == 18:
	#		carte_tot.append(load("res://scene/carte/SUmanoUccello.tscn").instantiate()) 
	#	elif i == 19:
	#		carte_tot.append(load("res://scene/carte/Tiefling.tscn").instantiate()) 
	#	elif i == 20:
	#		carte_tot.append(load("res://scene/carte/Tritone.tscn").instantiate()) 
	#	elif i == 21:
	#		carte_tot.append(load("res://scene/carte/Umano.tscn").instantiate()) 

func instantiate_cards():
	carte.append("res://scene/carte/Arpia.tscn")  
	carte.append("res://scene/carte/ArpiaFT.tscn")
	carte.append("res://scene/carte/Centauro.tscn")  
	carte.append("res://scene/carte/Dragonborn.tscn")  
	carte.append("res://scene/carte/ElfoN.tscn")  
	carte.append("res://scene/carte/ElfoO.tscn")  
	carte.append("res://scene/carte/Eroe.tscn")  
	carte.append("res://scene/carte/Fata.tscn")  
	carte.append("res://scene/carte/Halfling.tscn")  
	carte.append("res://scene/carte/NanoC.tscn")  
	carte.append("res://scene/carte/NanoM.tscn")  
	carte.append("res://scene/carte/NanoP.tscn")  
	carte.append("res://scene/carte/OrcoC.tscn")  
	carte.append("res://scene/carte/OrcoP.tscn")  
	carte.append("res://scene/carte/ReTritone.tscn")  
	carte.append("res://scene/carte/SUmanoCane.tscn")  
	carte.append("res://scene/carte/SUmanoDrago.tscn")  
	carte.append("res://scene/carte/SUmanoGatto.tscn")  
	carte.append("res://scene/carte/SUmanoUccello.tscn")  
	carte.append("res://scene/carte/Tiefling.tscn")  
	carte.append("res://scene/carte/Tritone.tscn")  
	carte.append("res://scene/carte/Umano.tscn")  

func get_card(card_id):
	# Carica il file .tscn corrispondente e crea una nuova istanza
	var card_scene = load(carte[card_id-1])  # carica il file .tscn
	var new_card_instance = card_scene.instantiate()  # crea una nuova istanza

	# Crea un container per la carta
	var container = Control.new()
	container.size_flags_horizontal = Control.SIZE_EXPAND_FILL
	container.add_child(new_card_instance)

	# Imposta la scala della carta
	for i in container.get_children():
		i.scale.x = 0.07
		i.scale.y = 0.07

	# Aggiungi il container all'HBoxContainer
	$Camera2D/HBoxContainer.add_child(container)
	print(card_id)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "deck_appear":
		$Deck/AnimationPlayer.play("deck_draw_5")
	if anim_name == "deck_draw_5":
			
		$Camera2D/HBoxContainer.visible = true
