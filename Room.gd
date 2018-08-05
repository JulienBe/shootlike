extends Node2D

const mult = 16
var area

func init(area):
    self.area = area
    position = Vector2(area.x, area.y)
    scale = Vector2(area.width / mult, area.height / mult)
    position = Vector2(position.x - (area.width / 2), position.x - (area.height / 2))
func _ready():
	pass

