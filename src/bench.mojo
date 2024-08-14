import benchmark
from random import random_si64
from monums.sequences import fibonacci, factorial, factorial_gamma, factorial_stirling, factorial_slow



fn main():
    alias lfac: Int = 20

    var fac: Int = random_si64(lfac,lfac).value

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