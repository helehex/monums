import benchmark
from random import random_si64
from monums.sequences import fibonacci, factorial, factorial_gamma, factorial_stirling, factorial_slow



fn main():


    alias lfac: Int = 20

    var fib: Int = random_si64(50,50).value
    var fac: Int = random_si64(lfac,lfac).value

    @parameter
    fn fib_gen():
        var o = fibonacci(fib)
        benchmark.keep(o)

    @parameter
    fn fib_hard():
        var o = fibonacci_hard(fib)
        benchmark.keep(o)

    @parameter
    fn fib_rewo():
        var o = fibonacci_rewo(fib)
        benchmark.keep(o)

    @parameter
    fn fib_wovo():
        var o = fibonacci_wovo(fib)
        benchmark.keep(o)

    @parameter
    fn fac_gam():
        var o = factorial_gamma(fac)
        benchmark.keep(o)

    @parameter
    fn fac_stir():
        var o = factorial_stirling(fac)
        benchmark.keep(o)

    @parameter
    fn fac_slow():
        var o = factorial_slow(fac)
        benchmark.keep(o)

    @parameter
    fn fac_int():
        var o = factorial(fac)
        benchmark.keep(o)

    @parameter
    fn fac_lit():
        var o = factorial[lfac]()
        benchmark.keep(o)

    @parameter
    fn fac_lit2():
        var o = factorial(lfac)
        benchmark.keep(o)

    print()
    print("fac_gam  :", benchmark.run[fac_gam](max_runtime_secs = 1.0).mean("ns"))
    print("fac_stir :", benchmark.run[fac_stir](max_runtime_secs = 1.0).mean("ns"))
    print("fac_slow :", benchmark.run[fac_slow](max_runtime_secs = 1.0).mean("ns"))
    print("fac_int  :", benchmark.run[fac_int](max_runtime_secs = 1.0).mean("ns"))
    print("fac_lit  :", benchmark.run[fac_lit](max_runtime_secs = 1.0).mean("ns"))
    print("fac_lit2 :", benchmark.run[fac_lit2](max_runtime_secs = 1.0).mean("ns"))
    print()
    print("fib_hard :", benchmark.run[fib_hard](max_runtime_secs = 1.0).mean("ns"))
    print("fib_gen  :", benchmark.run[fib_gen](max_runtime_secs = 1.0).mean("ns"))
    print("fib_rewo :", benchmark.run[fib_rewo](max_runtime_secs = 1.0).mean("ns"))
    print("fib_wovo :", benchmark.run[fib_wovo](max_runtime_secs = 1.0).mean("ns"))
    print()




fn fibonacci_hard(iterations: Int) -> Int:
    var _n0: Int = 0
    var _n1: Int = 1
    for i in range(iterations):
        var _n2: Int = _n0 + _n1
        _n0 = _n1
        _n1 = _n2
    return _n1


from monums import IntE_rewo, IntE_wovo
from monums.sequences import recurrent

@always_inline("nodebug")
fn wo_add(a: IntE_rewo, b: IntE_rewo) -> IntE_rewo: return b.wo_add(a)
@always_inline("nodebug")
fn wo_add(a: IntE_wovo, b: IntE_wovo) -> IntE_wovo: return b.wo_add(a)

alias fibonacci_rewo = recurrent[IntE_rewo, wo_add, IntE_rewo(0,0,0), IntE_rewo(0,1,0)]
alias fibonacci_wovo = recurrent[IntE_wovo, wo_add, IntE_wovo(0,0,0), IntE_wovo(0,1,0)]
