import benchmark


fn main():
    from random import random_si64
    from monums.sequences import fibonacci, factorial_gamma, factorial_stirling, factorial_slow

    let fib: Int = random_si64(50,50).value
    let fac: Int = random_si64(30,30).value

    @parameter
    fn fib_gen():
        let o = fibonacci(fib)
        benchmark.keep(o)

    @parameter
    fn fib_hard():
        let o = fibonacci_hard(fib)
        benchmark.keep(o)

    @parameter
    fn fib_rewo():
        var o = fibonacci_rewo(fib)
        benchmark.keep(o)

    @parameter
    fn fib_wovo():
        var o = fibonacci_rewo(fib)
        benchmark.keep(o)

    @parameter
    fn fac_gam():
        let o = factorial_gamma(fac)
        benchmark.keep(o)

    @parameter
    fn fac_stir():
        let o = factorial_stirling(fac)
        benchmark.keep(o)

    @parameter
    fn fac_slow():
        let o = factorial_slow(fac)
        benchmark.keep(o)

    print()
    print("fib_gen  :", benchmark.run[fib_gen]().mean["ns"]())
    print("fib_hard :", benchmark.run[fib_hard]().mean["ns"]())
    print("fib_rewo :", benchmark.run[fib_rewo]().mean["ns"]())
    print("fib_wovo :", benchmark.run[fib_wovo]().mean["ns"]())
    print()
    print("fac_gam  :", benchmark.run[fac_gam]().mean["ns"]())
    print("fac_stir :", benchmark.run[fac_stir]().mean["ns"]())
    print("fac_slow :", benchmark.run[fac_slow]().mean["ns"]())
    print()




fn fibonacci_hard(iterations: Int) -> Int:
    var _n0: Int = 0
    var _n1: Int = 1
    for i in range(iterations):
        let _n2: Int = _n0 + _n1
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
