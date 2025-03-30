extends Area3D

var type = "Jozko"


func _ready():
	connect("body_entered", _on_body_entered)

func _on_body_entered(body):
	print(body)
	if body.is_in_group("player"):  # Uisti sa, že Player je v skupine "player"
		print("Hráč vstúpil na: ", type)
		SignalManager.on_box_entered.emit(type)  # Pošleme signál s menom boxu
