from utils.variant import Variant
from collections import Optional
from math import nan, isnan, abs, select

alias NAN: FloatLiteral = __mlir_attr.`0x7ff8000000000000:f64`


#------ Newtons Method ------#
#
fn newtons_method[type: DType, size: Int,
    f: fn(SIMD[type,size])->SIMD[type,size],
    df: fn(SIMD[type,size])->SIMD[type,size],
    iterations: Int = 8,
    tolerance: FloatLiteral = NAN,
    epsilon: FloatLiteral = NAN
    ](x0: SIMD[type,size], y_offset: SIMD[type,size] = 0) -> SIMD[type,size]:
    
    """
    Implements newtons method for solving trancendental equations.\n
    Converges on the roots of the input function `f` using it's derivative `fp`.\n
    If `tolerance` and `epsilon` are left undefined, only iterations will be used, and may return non-convergent results.

    Constraints:
        Parameter `type` must be floating-point.

    Parameters:
        type: The DType of values used in calculation.
        size: The SIMD vector size of the values.
        f: The function to find the solutions to.
        df: The first derivative of f (not calculated automatically).
        iterations: The number of iterations to perform.
        tolerance: If provided, results within the tolerance will be considered solved.
        epsilon: If provided, the calculation will return `nan` for values that explode.

    Args:
        x0: The initial guess of the solution. Determines which solution is found, and how fast it converges.
        y_offset: A vertical offset applied to the input function `f`. Use for solving the inverse of `f`, for values other than 0.

    Returns:
        The converged value, or `nan` if no solution was found.
    """

    constrained[type.is_floating_point(), "`type` parameter must be a floating-point"]()
    alias _nan: SIMD[type,size] = nan[type]()

    var completed: SIMD[DType.bool,size] = False
    var x1: SIMD[type,size] = x0

    for i in range(iterations):
        var yp = df(x1)

        @parameter
        if tolerance == tolerance:
            var exploded = abs(yp) <= epsilon
            completed |= exploded
            x1 = select(exploded, _nan, x1)
        
        var x2 = x1 - (f(x1)-y_offset)/yp

        @parameter
        if tolerance == tolerance:
            completed |= abs(x2 - x1) <= tolerance

        @parameter
        if tolerance == tolerance or epsilon == epsilon:
            if completed.reduce_and(): return x1
            x1 = select(completed, x1, x2)
        else: x1 = x2

    @parameter
    if tolerance == tolerance or epsilon == epsilon: return select(completed, x1, _nan)
    return x1


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