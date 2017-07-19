extends RichTextLabel

var count = 0

func _ready():
	self.add_text("")


func _on_Timer_timeout():
	count += 1
	self.clear()
	self.add_text(str("Time (seconds): ", count))
