from utils.variant import Variant
from collections import Optional
from math import nan, isnan




#------ Recurrent ------#
#

# alias fibonacci = recurrent[func=add, default_n0 = Int(0), default_n1 = Int(1)]

fn fibonacci(iterations: Int) -> Int:
    return recurrent[add, 0, 1](iterations)

fn fibonacci[n0: Int, n1: Int](iterations: Int) -> Int:
    return recurrent[add, n0, n1](iterations)

trait SumableCollectionElement(CollectionElement):
    fn __add__(self, other: Self) -> Self: ...

@always_inline("nodebug")
fn add[T: SumableCollectionElement](a: T, b: T) -> T: return a+b

@always_inline("nodebug")
fn recurrent[T: SumableCollectionElement, //, func: fn[_T: SumableCollectionElement](_T,_T) -> _T, default_n0: T, default_n1: T](iterations: Int, owned n0: T = default_n0, owned n1: T = default_n1) -> T:
    var _n0: T = n0^
    var _n1: T = n1^
    for i in range(iterations):
        var _n2: T = func(_n0, _n1)
        _n0 = _n1^
        _n1 = _n2^
    return _n1^