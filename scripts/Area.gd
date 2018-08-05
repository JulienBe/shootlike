var rand = load("res://scripts/Rand.gd").new()
var x
var y
var width
var height

func init(x, y, width, height):
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    
func get_random(minDim, maxDim, mapWidth):
    self.width = rand.bound_int(minDim, maxDim)
    self.height = rand.bound_int(minDim, maxDim)
    self.x = rand.bound_int(0, (mapWidth - width))
    self.y = rand.bound_int(0, (mapWidth - height))
    return self

func get_gauss(mini, mod, mapWidth):
    self.width = mini + abs(rand.gauss(mod))
    while width >= mapWidth:
        width = mini + abs(rand.gauss(mod))
    self.height = mini + abs(rand.gauss(mod))
    while height >= mapWidth:
        height = mini + abs(rand.gauss(mod))
    self.x = rand.bound_int(0, (mapWidth - width))
    self.y = rand.bound_int(0, (mapWidth - height))
    return self
