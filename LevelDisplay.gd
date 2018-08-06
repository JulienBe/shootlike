extends Node

var map
const wall_preload = preload("res://WallBlock.tscn")
const ground_preload = preload("res://GroundBlock.tscn")
var loaded = false

func _ready():
    pass
    
func set_map(map):
    self.map = map

func _process(delta):
    if map != null && !loaded:
        for i in map.arr:
            var room = map.arr[i]
            if room & map.wall > 0:
                var w = wall_preload.instance()
                w.position(map.unconvert(i), i)
                add_child(w)
            #if room & map.room > 0:
            #    var r = ground_preload.instance()
            #    r.position(map.unconvert(i), i)
            #    add_child(r)    
        loaded = true
        print(get_child_count())
        print("map size %s" % map.arr.size())