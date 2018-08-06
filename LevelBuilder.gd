extends Node

var map = load("res://scripts/Map.gd").new()
var rand = load("res://scripts/Rand.gd").new()
const room_preload = preload("res://Room.tscn")
var area = preload("res://scripts/Area.gd")
var width = 50
var step = 0
var current_step = 0
var time = 0
var steps = {
        1 : funcref(self, "gauss_rooms"),
        2 : funcref(self, "gauss_rooms2"),
        3 : funcref(self, "small_rooms"),
        4 : funcref(self, "surround_rooms"),
        5 : funcref(self, "update_map")
        }

func small_normal_rooms():
    return area.new().get_random(5, 10, width)
func medium_normal_rooms():
    return area.new().get_random(10, 30, width)
func medium_gauss_rooms():
    return area.new().get_random(7, 20, width)
func big_gauss_rooms():
    return area.new().get_random(4, 50, width)
func huge_gauss_rooms():
    return area.new().get_random(4, 80, width)

func _ready():
    map.set_width(width)
    pass

func _process(delta):
    #print("map step %s" % step)
    time += delta
    if time > step * 4:
        step += 1
    if steps.has(step):
        steps[step].call_func()

func gauss_rooms():
    place_rooms(funcref(self, "huge_gauss_rooms"), 1)
    current_step += 1
    if current_step >= 20:
        next_step()
func gauss_rooms2():
    place_rooms(funcref(self, "big_gauss_rooms"), 1)
    if current_step >= 50:
        next_step()
func small_rooms():
    place_rooms(funcref(self, "small_normal_rooms"), 20)
    if current_step >= 10:
        next_step()
func surround_rooms():
    surround(map.room, map.wall)
    next_step()
func update_map():
    var levelDisplay = get_parent().get_node("./LevelDisplay")
    levelDisplay.set_map(map) 
    for i in get_children():
        i.queue_free()

func next_step():
    step += 1
    current_step = 0

func place_rooms(fun, attempts):
    for i in range(attempts):
        var candidate_area = fun.call_func()
        if !map.contains_area(candidate_area, map.room) && candidate_area.x > 0 && candidate_area.y > 0:
            var room = room_preload.instance()
            room.init(candidate_area)
            add_child(room)
            map.mark_area(candidate_area, map.room)

func surround(me, with):
    for x in range(width):
        for y in range(width):
            if map.contains_xy(x, y, me):
                if !map.contains_xy(x - 1, y, with) && !map.contains_xy(x - 1, y, me):
                    map.addVal(x, y, with)
                if !map.contains_xy(x + 1, y, with) && !map.contains_xy(x + 1, y, me):
                    map.addVal(x, y, with)
                if !map.contains_xy(x, y - 1, with) && !map.contains_xy(x, y - 1, me):
                    map.addVal(x, y, with)
                if !map.contains_xy(x, y + 1, with) && !map.contains_xy(x, y + 1, me):
                    map.addVal(x, y, with)

