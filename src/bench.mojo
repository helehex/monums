import benchmark

alias fib_loops = 10000
alias fib_n = 50

alias fac_loops = 1000
alias fac_n = 20



fn main():
    from monums.sequences import fibonacci, factorial_gamma, factorial_stirling, factorial_slow
    var ns: Int
    
    fn fib_gen():
        for i in range(fib_loops):
            benchmark.keep(fibonacci(fib_n))

    fn fib_hard():
        for i in range(fib_loops):
            benchmark.keep(hard_fibonacci(fib_n))

    fn fib_rewo():
        for i in range(fib_loops):
            benchmark.keep(fibonacci_rewo(fib_n).re)

    fn fib_wovo():
        for i in range(fib_loops):
            benchmark.keep(fibonacci_rewo(fib_n).wo)

    fn fac_gam():
        for i in range(fac_loops):
            benchmark.keep(factorial_gamma(fac_n))

    fn fac_stir():
        for i in range(fac_loops):
            benchmark.keep(factorial_stirling(fac_n))

    fn fac_slow():
        for i in range(fac_loops):
            benchmark.keep(factorial_slow(fac_n))
    
    print("fib_gen")
    benchmark.run[fib_gen]().print()
    print("\n\n")

    print("fib_hard")
    benchmark.run[fib_hard]().print()
    print("\n\n")

    print("fib_rewo")
    benchmark.run[fib_rewo]().print()
    print("\n\n")

    print("fib_wovo")
    benchmark.run[fib_wovo]().print()
    print("\n\n")

    print("fac_gam")
    benchmark.run[fac_gam]().print()
    print("\n\n")
    
    print("fac_stir")
    benchmark.run[fac_stir]().print()
    print("\n\n")

    print("fac_slow")
    benchmark.run[fac_slow]().print()
    print("\n\n")




fn hard_fibonacci(iterations: Int) -> Int:
    var _n0: Int = 0
    var _n1: Int = 1
    for i in range(iterations):
        let _n2: Int = _n0 + _n1
        _n0 = _n1
        _n1 = _n2
    return _n1


from monums import IntE_rewo, IntE_wovo
from monums.sequences import recurrent

fn wo_add(a: IntE_rewo, b: IntE_rewo) -> IntE_rewo: return b.wo_add(a)
fn wo_add(a: IntE_wovo, b: IntE_wovo) -> IntE_wovo: return b.wo_add(a)

alias fibonacci_rewo = recurrent[IntE_rewo, wo_add, IntE_rewo(0,0,0), IntE_rewo(0,1,0)]
alias fibonacci_wovo = recurrent[IntE_wovo, wo_add, IntE_wovo(0,0,0), IntE_wovo(0,1,0)]
