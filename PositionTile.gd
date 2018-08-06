extends Node2D

const tilesize = 8.0 
var index

func position(xy, index):
    global_position = Vector2(xy[0], xy[1])
    var width = 1
    var height = 1
    scale = Vector2(width / tilesize, height / tilesize)
    var offsetX = tilesize * scale.x
    var offsetY = tilesize * scale.y
    position = Vector2(position.x + (offsetX / 2), position.y + (offsetY / 2))
    
func _ready():
    pass