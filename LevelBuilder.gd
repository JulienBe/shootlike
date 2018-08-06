extends Node

var map = load("res://scripts/Map.gd").new()
var rand = load("res://scripts/Rand.gd").new()
const room_preload = preload("res://Room.tscn")
var area = "res://scripts/Area.gd"
var width = 400
var step = 0
var time = 0
var step1ref = funcref(self, "step1")
var step2ref = funcref(self, "step2")
var step3ref = funcref(self, "step3i")
var steps = {
        #1 : funcref(self, "testrooms"),
        1 : funcref(self, "step1"),
        2 : funcref(self, "step2"),
        3 : funcref(self, "step3")
        }

func small_normal_rooms():
    return load(area).new().get_random(5, 10, width)
func medium_normal_rooms():
    return load(area).new().get_random(10, 30, width)
func medium_gauss_rooms():
    return load(area).new().get_random(7, 20, width)
func big_gauss_rooms():
    return load(area).new().get_random(4, 50, width)
func huge_gauss_rooms():
    return load(area).new().get_random(4, 80, width)

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

func step1():
    place_rooms(funcref(self, "huge_gauss_rooms"), 1)
func step2():
    place_rooms(funcref(self, "big_gauss_rooms"), 1)#500)
func step3():
    place_rooms(funcref(self, "small_normal_rooms"), 1)#10000)

func place_rooms(fun, attempts):
    for i in range(attempts):
        var candidate_area = fun.call_func()
        if !map.contains_area(candidate_area, map.room) && candidate_area.x > 0 && candidate_area.y > 0:
            var room = room_preload.instance()
            room.init(candidate_area)
            add_child(room)
            map.mark_area(candidate_area, map.room)
            #map.addRoom(candidate_area)
