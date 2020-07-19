extends Node

var player: Hand

signal gameOver
signal score

enum RESULT {
	lost = 0,
	draw,
	win
}

func _enter_tree():
	player = self.owner

func _on_PlayerHand_area_entered(area):
	if typeof(area) == typeof(Hand):
		var result = checkThrow(player, area)
		if result == RESULT.win:
			area.queue_free()
			emit_signal("score")
		elif result == RESULT.draw:
			area.queue_free()
		else:
			print(self.name, ": ", "Game Over!")
			emit_signal("gameOver")

func checkThrow(var hand1: Hand, var hand2: Hand) -> int:
	if hand1.index == (hand2.index + 1) % 3:
		return RESULT.win
	elif hand1.index == hand2.index:
		return RESULT.draw
	else:
		return RESULT.lost
