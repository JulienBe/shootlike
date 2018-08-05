extends Node

var map = load("res://scripts/Map.gd").new()
var rand = load("res://scripts/Rand.gd").new()
const room_preload = preload("res://Room.tscn")
var area = "res://scripts/Area.gd"
var width = 200
var step = 0
var time = 0
var step1ref = funcref(self, "step1")
var step2ref = funcref(self, "step2")
var step3ref = funcref(self, "step3i")
var steps = {
        #1 : funcref(self, "testrooms"),
        1 : funcref(self, "step3")
        #2 : funcref(self, "step2"),
        #3 : funcref(self, "step3")
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

func testrooms():
    var candidate1 = load(area).new()
    candidate1.x = 0
    candidate1.y = 0
    candidate1.width = 10
    candidate1.height = 10
    var c2 = load(area).new()
    c2.x = randi() % 10
    c2.y = randi() % 10
    c2.width = 1
    c2.height = 1
    map.mark_area(candidate1, map.room)
    print("c2.x %s" % c2.x)
    print("c2.y %s" % c2.y)
    print("contains 2 %s" % map.contains_area(c2, map.room))

func step1():
    place_rooms(funcref(self, "huge_gauss_rooms"), 2)
func step2():
    place_rooms(funcref(self, "big_gauss_rooms"), 1)#500)
func step3():
    place_rooms(funcref(self, "small_normal_rooms"), 100)#10000)

func place_rooms(fun, attempts):
    for i in range(attempts):
        var candidate_area = fun.call_func()
        if !map.contains_area(candidate_area, map.room):# && candidate_area.x > 0 && candidate_area.y > 0:
            var room = room_preload.instance()
            room.init(candidate_area)
            add_child(room)
            print("add %s" % candidate_area)
            map.mark_area(candidate_area, map.room)
            #map.addRoom(candidate_area)
