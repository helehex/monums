# x----------------------------------------------------------------------------------------------x #
# | MIT License
# | Copyright (c) 2024 Helehex
# x----------------------------------------------------------------------------------------------x #
"""Lookup Table Generation."""

from pathlib import Path


# +----------------------------------------------------------------------------------------------+ #
# | Fibonacci
# +----------------------------------------------------------------------------------------------+ #
#
fn fibonacci[n0: Int = 0, n1: Int = 1](n: Int) -> Int:
    return recurrent[next_fibonacci](n, (n0, n1))

fn next_fibonacci[lif: MutableOrigin, //](ref [lif]n0n1: (Int, Int)) -> ref [lif]Int:
    var n2 = n0n1[0] + n0n1[1]
    n0n1[0] = n0n1[1]
    n0n1[1] = n2
    return n0n1[1]

fn tribonacci[n0: Int = 0, n1: Int = 0, n2: Int = 1](n: Int) -> Int:
    return recurrent[next_tribonacci](n, (n0, n1, n2))

fn next_tribonacci[lif: MutableOrigin, //](ref [lif]n0n1n2: (Int, Int, Int)) -> ref [lif]Int:
    var n3 = n0n1n2[0] + n0n1n2[1] + n0n1n2[2]
    n0n1n2[0] = n0n1n2[1]
    n0n1n2[1] = n0n1n2[2]
    n0n1n2[2] = n3
    return n0n1n2[2]


# +----------------------------------------------------------------------------------------------+ #
# | Factorial
# +----------------------------------------------------------------------------------------------+ #
#
fn factorial(n: Int) -> Int:
    return recurrent[next_factorial](n, (0, 1))

fn next_factorial[lif: MutableOrigin, //](ref [lif]n_fac: (Int, Int)) -> ref [lif]Int:
    n_fac[0] += 1
    n_fac[1] *= n_fac[0]
    return n_fac[1]


# +----------------------------------------------------------------------------------------------+ #
# | Recurrent
# +----------------------------------------------------------------------------------------------+ #
#
fn recurrent[state_type: AnyType, result_type: Copyable, //, func: fn [lif: MutableOrigin, //](ref [lif]state: state_type) -> ref [lif]result_type](iterations: Int, owned seed: state_type) -> result_type:
    for _ in range(iterations - 1):
        _ = func(seed)
    return func(seed)


# +----------------------------------------------------------------------------------------------+ #
# | Generate
# +----------------------------------------------------------------------------------------------+ #
#
trait GenType(Copyable, Writable):
    pass

fn generate_lookup[state_type: AnyType, result_type: GenType, //, func: fn [lif: MutableOrigin, //](ref [lif]state: state_type) -> ref [lif]result_type](path: Path, name: String, start: Int, stop: Int, owned state: state_type, owned seed: result_type) raises:
    var output: String = ""
    output.write("alias ", name, " = \n    [\n    ")
    if start == 0:
        output.write(seed, ", \n    ")
    for _ in range(1, start):
        _ = func(state)
    for _ in range(start + 1, stop):
        output.write(func(state), ", \n    ")
    output.write("]")
    (path.joinpath(name + ".mojo")).write_text(output)
