from monums import LitIntE_rewo, LitIntE_wovo, IntE_rewo, IntE_wovo, ESIMD_rewo, ESIMD_wovo
from sys import argv


# full test:       "mojo src/test.mojo"
# IntE test:       "mojo src/test.mojo eis"
# sequences test:  "mojo src/test.mojo seq"


fn main():
    let args: VariadicList[StringRef] = argv()

    if len(args) > 1 and args[1] == "temp":
        pass

    if len(args) == 1 or args[1] == "eis":
        test_LitIntE_rewo()
        test_ESIMD_rewo()
        test_LitIntE_wovo()
        test_ESIMD_wovo()

    if len(args) == 1 or args[1] == "seq":
        test_seq()
        test_lookup()




fn test_LitIntE_rewo():
    alias a: LitIntE_rewo = LitIntE_rewo(4,0,20)
    alias b: LitIntE_rewo = LitIntE_rewo(2,0,4)
    alias c: LitIntE_rewo = LitIntE_rewo(0,0, (1<<50) + 3)

    print()
    print("#------ rewo Literal Test ------#")
    print()
    print("a =", a.str_())
    print("b =", b.str_())
    print()
    print("a+b =", (a+b).str_())
    print("a-b =", (a-b).str_())
    print("a*b =", (a*b).str_())
    print("a//b =", (a//b).str_())
    print((a*a).str_po(), "=", ((a*a*b) // b).str_())
    print("c*c // c =", ((c*c) // c).str_(), "=", c.str_())
    print()


fn test_ESIMD_rewo():
    let a: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](4,0,20)
    let b: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](2,0,4)
    let c: ESIMD_rewo[DType.index,2] = ESIMD_rewo[DType.index,2](0,0, (1<<50) + 3)

    print()
    print("#------ rewo SIMD Test ------#")
    print()
    print("a =", a.str_())
    print("b =", b.str_())
    print()
    print("a+b =", (a+b).str_())
    print("a-b =", (a-b).str_())
    print("a*b =", (a*b).str_())
    print("a//b =", (a//b).str_())
    print((a*a).str_(), "=", ((a*a*b) // b).str_())
    print("c*c // c =", ((c*c) // c).str_(), "!=", c.str_()) # optimized away my entire existence
    print()


fn test_LitIntE_wovo():
    alias a: LitIntE_wovo = LitIntE_wovo(4,0,20)
    alias b: LitIntE_wovo = LitIntE_wovo(2,0,4)
    
    print()
    print("#------ wovo Literal Test ------#")
    print()
    print("a =", a.str_())
    print("b =", b.str_())
    print()
    print("a+b =", (a+b).str_())
    print("a-b =", (a-b).str_())
    print("a*b =", (a*b).str_())
    print("a//b =", (a//b).str_())
    print((a*a).str_(), "=", ((a*a*b) // b).str_())
    print()


fn test_ESIMD_wovo():
    let a: ESIMD_wovo[DType.index,2] = ESIMD_wovo[DType.index,2](4,0,20)
    let b: ESIMD_wovo[DType.index,2] = ESIMD_wovo[DType.index,2](2,0,4)

    print()
    print("#------ wovo SIMD Test ------#")
    print()
    print("a =", a.str_())
    print("b =", b.str_())
    print()
    print("a+b =", (a+b).str_())
    print("a-b =", (a-b).str_())
    print("a*b =", (a*b).str_())
    print("a//b =", (a//b).str_()) # im not entirely sure
    print("\nshould be equal, bug? literal wovo works with very similar code and the same math")
    print((a*a).str_(), "=", ((a*a*b) // b).str_()) # still not entirely sure
    print()




fn wo_add(a: IntE_wovo, b: IntE_wovo) -> IntE_wovo: return b.wo_add(a)

fn test_seq():
    from monums.sequences import factorial, factorial_gamma, factorial_stirling, factorial_slow, fibonacci, recurrent

    alias n_fac = 10
    print("\n#--- factorial(" + String(n_fac) + ") ---#")
    print("lit      =", factorial(n_fac))
    print("gamma    =", factorial_gamma(10))
    print("stirling =", factorial_stirling(10))
    print("slow     =", factorial_slow(10))

    print("\n\n#--- fibonacci from recurrent ---#")
    for i in range(10):
        print_no_newline(String(fibonacci(i)) + ", ")
    print()

    print("\n\n#--- eisenstein fibonacci from recurrent ---#")
    alias fibonacci_eisenstein = recurrent[IntE_wovo, wo_add, IntE_wovo(0,0,0), IntE_wovo(0,1,0)]
    for i in range(20):
        fibonacci_eisenstein(i).print_()
    print()


fn test_lookup():
    from monums.sequences import generate_lookup, fibonacci_, factorial

    alias fibonacci_lookup = generate_lookup[Int,fibonacci_,50]()
    alias factorial_lookup = generate_lookup[Int,factorial,20]()

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