from utils.variant import Variant
from collections import Optional
from math import abs


#------ Newtons Method ------#
#
fn newtons_method[
    type: DType,
    size: Int,
    f: fn(SIMD[type,size])->SIMD[type,size],
    df: fn(SIMD[type,size])->SIMD[type,size],
    max_iterations: Int = 16,
    tolerance: Optional[SIMD[type,1]] = None,
    epsilon: Optional[SIMD[type,1]] = None
    ](x0: SIMD[type,size], yo: SIMD[type,size]) -> Optional[SIMD[type,size]]:

    var x1: SIMD[type,size] = x0

    for i in range(max_iterations):
        var yp = df(x1)

        @parameter
        if epsilon:
            if abs(yp).reduce_min() < epsilon.value(): return None
        
        var x2 = x1 - (f(x1)-yo)/yp

        @parameter
        if tolerance:
            if abs(x2 - x1).reduce_max() < tolerance.value(): return x1

        x1 = x2

    @parameter
    if tolerance and epsilon: return None
    else: return x1 


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
        let _n2: T = func(_n0, _n1)
        _n0 = _n1
        _n1 = _n2
    return _n1