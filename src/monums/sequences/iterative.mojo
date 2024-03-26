from utils.variant import Variant
from collections import Optional
from math import nan, isnan, abs, select




#------ Recurrent ------#
#

#alias fibonacci = recurrent[Int,add, df_n0 = 0, df_n1 = 1]

fn fibonacci(iterations: Int) -> Int:
    return recurrent[Int,add,0,1](iterations)

fn fibonacci[n0: Int, n1: Int](iterations: Int) -> Int:
    return recurrent[Int,add,n0,n1](iterations)

@always_inline("nodebug")
fn add(a: Int, b: Int) -> Int: return a+b

@always_inline("nodebug")
fn recurrent[T: AnyRegType, func: fn(T,T)->T, default_n0: T, default_n1: T](iterations: Int, n0: T = default_n0, n1: T = default_n1) -> T:
    var _n0: T = n0
    var _n1: T = n1
    for i in range(iterations):
        var _n2: T = func(_n0, _n1)
        _n0 = _n1
        _n1 = _n2
    return _n1