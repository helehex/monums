from monums import LitIntE_rewo, LitIntE_wovo, IntE_rewo, IntE_wovo, ESIMD_rewo, ESIMD_wovo
from monums.sequences import factorial, multifactorial, factorial_gamma, factorial_stirling, factorial_slow, simplicial, pascal, generate_lookup
from monums.sequences import fibonacci, recurrent
from monums.solver import newtons_method
from monums.discrete import Discrete
from sys import argv


# full test:       "mojo src/test.mojo"
# IntE test:       "mojo src/test.mojo eis"
# sequences test:  "mojo src/test.mojo seq"


fn main():
    var args: VariadicList[StringRef] = argv()

    if len(args) > 1 and args[1] == "temp": temp()
    if len(args) > 1 and args[1] == "newt": test_newtons_method()

    if len(args) < 2 or args[1] == "eis":
        test_LitIntE_rewo()
        test_ESIMD_rewo()
        test_LitIntE_wovo()
        test_ESIMD_wovo()

    if len(args) < 2 or args[1] == "seq":
        test_seq()
        test_lookup()


fn temp():
    print("temp code")




#------ newtons method ------#
#
@always_inline
fn f(x: SIMD) -> SIMD[x.type,x.size]: return x**5

@always_inline
fn df(x: SIMD) -> SIMD[x.type,x.size]: return 5*x**4

fn test_newtons_method():
    print("finding quintic roots using newtons method:\n")
    alias type = DType.float64
    var inputs = SIMD[type,4](100,200,300,400)
    var result = newtons_method[type, 4, f[type,4], df[type,4], 16, 0.001](inputs*0.01, inputs)
    print("[100,200,300,400]**(1/5)")
    print("= [2.51188643151,      2.88539981181,      3.12913464453,      3.31445401734]")
    print("=", str(result))




#------ eisentein ------#
#
fn test_LitIntE_rewo():
    alias a: LitIntE_rewo = LitIntE_rewo(4,0,20)
    alias b: LitIntE_rewo = LitIntE_rewo(2,0,4)
    alias c: LitIntE_rewo = LitIntE_rewo(0,0, (1<<50) + 3)

    print()
    print("#------ rewo Literal Test ------#")
    print()
    print("a =", a)
    print("b =", b)
    print()
    print("a+b =", a+b)
    print("a-b =", a-b)
    print("a*b =", a*b)
    print("a//b =", a//b)
    print(a*a, "=", (a*a*b) // b)
    print("c*c // c =", (c*c) // c, "=", c)
    print()


fn test_ESIMD_rewo():
    var a: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](4,0,20)
    var b: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](2,0,4)
    var c: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](0,0, (1<<50) + 3)

    print()
    print("#------ rewo SIMD Test ------#")
    print()
    print("a =", a)
    print("b =", b)
    print()
    print("a+b =", a+b)
    print("a-b =", a-b)
    print("a*b =", a*b)
    print("a//b =", a//b)
    print(a*a, "=", (a*a*b) // b)
    print("c*c // c =", (c*c) // c, "!=", c)
    print()


fn test_LitIntE_wovo():
    alias a: LitIntE_wovo = LitIntE_wovo(4,0,20)
    alias b: LitIntE_wovo = LitIntE_wovo(2,0,4)
    
    print()
    print("#------ wovo Literal Test ------#")
    print()
    print("a =", a)
    print("b =", b)
    print()
    print("a+b =", a+b)
    print("a-b =", a-b)
    print("a*b =", a*b)
    print("a//b =", a//b)
    print(a*a, "=", (a*a*b) // b)
    print()


fn test_ESIMD_wovo():
    var a: ESIMD_wovo[DType.index,2] = ESIMD_wovo[DType.index,2](4,0,20)
    var b: ESIMD_wovo[DType.index,2] = ESIMD_wovo[DType.index,2](2,0,4)

    print()
    print("#------ wovo SIMD Test ------#")
    print()
    print("a =", a)
    print("b =", b)
    print()
    print("a+b =", a+b)
    print("a-b =", a-b)
    print("a*b =", a*b)
    print("a//b =", a//b)
    print(a*a, "=", (a*a*b) // b)
    print()




#------ sequences ------#
#
fn wo_add(a: IntE_wovo, b: IntE_wovo) -> IntE_wovo: return b.wo_add(a)

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
    for i in range(10): print_no_newline(String(simplicial[2](i)) + " ")
    print()
    for i in range(10): print_no_newline(String(simplicial(2, i)) + " ")
    print()
    print(simplicial(2,0), simplicial(2,1), simplicial(2,2), simplicial(2,3), simplicial(2,4), simplicial(2,5))
    print()
    print()
    print("#--- tetrahedral numbers ---#")
    for i in range(10): print_no_newline(String(simplicial[3](i)) + " ")
    print()
    for i in range(10): print_no_newline(String(simplicial(3, i)) + " ")
    print()
    print(simplicial(3,0), simplicial(3,1), simplicial(3,2), simplicial(3,3), simplicial(3,4), simplicial(3,5))
    print()
    print()
    print("#--- simplicial ---#")
    for x in range(10):
        for y in range(10):
            print_no_newline(String(simplicial(x, y)) + " ")
        print()
    print()
    print()
    print("#--- pascal ---#")
    for x in range(10):
        for y in range(10):
            print_no_newline(String(pascal(x, y)) + " ")
        print()
    print()
    print()
    print("#--- fibonacci from recurrent ---#")
    for i in range(10): print_no_newline(String(fibonacci(i)) + ", ")
    print()
    print()
    print()
    print("#--- eisenstein fibonacci from recurrent ---#")
    alias fibonacci_eisenstein = recurrent[IntE_wovo, wo_add, IntE_wovo(0,0,0), IntE_wovo(0,1,0)]
    for i in range(20): fibonacci_eisenstein(i).print_()
    print()


fn test_lookup():
    # alias fibonacci_lookup = generate_lookup[Int,fibonacci,50]() # default parameters not used to allow type check
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