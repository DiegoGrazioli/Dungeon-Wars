extends Node2D

@export var id = 0

@export var maxhp : int
@export var atk : int
# True=Main, False=Support
@export var type : bool
# Da 1 a 5 in ordine
@export var rarity : int
@export var lvl : int
@export var exp : int
@export var element : String
@export var origins: Array
# Abilità 1: 2x exp, Abilità 2: notturno
#@export var ability: 0

# Retro: False, Davanti: True
@export var toggle_front : bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	toggle_front = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	check()


func check() -> void:
	if toggle_front:
		$Container.visible = true
		$Bordo.frame = 0
	else:
		$Container.visible = false
		$Bordo.frame = 1
	


#func _on_area_2d_mouse_entered() -> void:
#	if !$AnimationPlayer.is_playing():
#		$AnimationPlayer.play("hover")


#func _on_area_2d_mouse_exited() -> void:
#	if !$AnimationPlayer.is_playing():
#		$AnimationPlayer.play("remove_hover")


func _on_area_2d_mouse_shape_entered(shape_idx: int) -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("hover")


func _on_area_2d_mouse_shape_exited(shape_idx: int) -> void:
	if !$AnimationPlayer.is_playing():
		$AnimationPlayer.play("remove_hover")
