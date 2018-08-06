extends Node2D

const mult = 16.0 
var area

func init(area):
    self.area = area
    
    global_position = Vector2(area.x, area.y)
    scale = Vector2(area.width / mult, area.height / mult)
    var offsetX = mult * scale.x
    var offsetY = mult * scale.y
    position = Vector2(position.x + (offsetX / 2),
            position.y + (offsetY / 2))
func _ready():
    pass