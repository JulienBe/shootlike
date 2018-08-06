extends Node

func within(low, high):
    return low + (randf() * high)

func withinButNot(low, high, lowNot, highNot): 
    assert((low < lowNot) || (high > highNot))
    for i in Range(60):
        var candidate = within(low, high)
        if (candidate < lowNot || candidate > highNot):
            return candidate
    return within(low, high)

func gauss(f):
    return gaussian(0, f)
    
func gaussian(mean, deviation):
    var x1 = null
    var x2 = null
    var w = null
    while true:
        x1 = rand_range(0, 2) - 1
        x2 = rand_range(0, 2) - 1
        w = x1*x1 + x2*x2
        if 0 < w && w < 1:
            break
    w = sqrt(-2 * log(w)/w)
    return floor(mean + deviation * x1 * w)

func bound_float(mini, maxi):
    return mini + (randf() * (maxi - mini))

func bound_int(mini, maxi):
    return mini + (randi() % maxi)
