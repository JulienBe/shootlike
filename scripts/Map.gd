const room = 1
var arr = {}
var width = 0

func convert_xy(x, y):
    return x % width + y * width
func unconvert(i):
    return [i % width, i / width]

func contains_area(area, value):
    return contains_xywh(area.x, area.y, area.width, area.height, value) 
func contains_xywh(x, y, width, height, value):
    var i = x
    while i <= x + width:
        var j = y
        while j <= y + height:
            if contains_xy(i, j, value):
                return true
            j += 1
        i += 1
    return false
func contains_xy(x, y, value):
    return contains(convert_xy(x, y), value)
func contains(coord, value):
    return arr.has(coord) && arr[coord] == value

func get_width():
    return width
func set_width(w):
    width = w
    return self
func mark_area(area, value):
    var i = area.x
    while i <= area.x + area.width:
        var j = area.y
        while j <= area.y + area.height:
            addVal(i, j, value)
            j += 1
        i += 1

func addVal(x, y, value):
#    var current
#    if arr.has(convert_xy(x, y)):
#        current = arr[convert_xy(x, y)]
#    else:
#        current = 0
    arr[convert_xy(x, y)] = value
