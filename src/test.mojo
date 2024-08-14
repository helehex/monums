from monums.sequences import factorial, multifactorial, factorial_gamma, factorial_stirling, factorial_slow, simplicial, pascal, generate_lookup
from monums.sequences import fibonacci, recurrent
from monums.solver import newtons_method
from monums.discrete import Discrete
from sys import argv


# full test:       "mojo src/test.mojo"
# sequences test:  "mojo src/test.mojo seq"


fn main():
    var args: VariadicList[StringRef] = argv()

    if len(args) > 1 and args[1] == "temp": temp()
    if len(args) > 1 and args[1] == "newt": test_newtons_method()

    if len(args) < 2 or args[1] == "seq":
        test_seq()
        test_lookup()


fn temp():
    print("temp code")


#------ newtons method ------#
#
@always_inline
fn f(x: SIMD) -> __type_of(x):
    return x**5

@always_inline
fn df(x: SIMD) -> __type_of(x):
    return 5*x**4

fn test_newtons_method():
    print("finding quintic roots using newtons method:\n")
    alias type = DType.float64
    var inputs = SIMD[type,4](100, 200, 300, 400)
    var result = newtons_method[type, 4, f, df, 16, 0.001](inputs*0.01, inputs)
    print("[100,200,300,400]**(1/5)")
    print("= [2.51188643151,      2.88539981181,      3.12913464453,      3.31445401734]")
    print("=", str(result))


#------ sequences ------#
#

fn test_seq():
    print()
    print("#--- factorial(10) = 3628800 ---#")
    print("literal  =", factorial(10))
    print("int      =", factorial(Int(10)))
    print("gamma    =", factorial_gamma(10))
    print("stirling =", factorial_stirling(10))
    print("slow     =", factorial_slow(10))
    print()
    print()
    print("#--- double_factorial(10) = 3840 ---#")
    print("literal  =", multifactorial[2](10))
    print("int      =", multifactorial[2](Int(10)))
    print()
    print()
    print("#--- triangle numbers ---#")
    for i in range(10): print(simplicial[2](i), end = " ")
    print()
    for i in range(10): print(simplicial(2, i), end = " ")
    print()
    print(simplicial(2,0), simplicial(2,1), simplicial(2,2), simplicial(2,3), simplicial(2,4), simplicial(2,5))
    print()
    print()
    print("#--- tetrahedral numbers ---#")
    for i in range(10): print(simplicial[3](i), end = " ")
    print()
    for i in range(10): print(simplicial(3, i), end = " ")
    print()
    print(simplicial(3,0), simplicial(3,1), simplicial(3,2), simplicial(3,3), simplicial(3,4), simplicial(3,5))
    print()
    print()
    print("#--- simplicial ---#")
    for x in range(10):
        for y in range(10):
            print(str(simplicial(x, y)), end = " ")
        print()
    print()
    print()
    print("#--- pascal ---#")
    for x in range(10):
        for y in range(10):
            print(pascal(x, y), end = " ")
        print()
    print()
    print()
    print("#--- fibonacci from recurrent ---#")
    for i in range(10): print(fibonacci(i), end = ", ")
    print()
    print()
    print()

fn test_lookup():
    alias fibonacci_lookup = generate_lookup[Int,fibonacci,50]()
    alias factorial_lookup = generate_lookup[Int,factorial,20]()

    print(fibonacci(5))
    print()
    print(fibonacci[3,3](0))
    print(fibonacci[3,3](1))
    print(fibonacci[3,3](2))
    print(fibonacci[3,3](3))

    print("\n#--- lookup generation ---#")
    print(fibonacci_lookup[7])
    print(fibonacci_lookup[8])
    print(fibonacci_lookup[9])
    print(fibonacci_lookup[10])
    print()
    print(factorial_lookup[15])
    print(factorial_lookup[16])
    print(factorial_lookup[17])
    print(factorial_lookup[18])
    print()