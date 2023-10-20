from monums import EisInt_rewo, EisInt_wovo, EisIntSIMD_rewo, EisIntSIMD_wovo

fn main():
    test_EisInt_rewo()
    test_EisInt_wovo()
    test_EisIntSIMD_rewo()
    test_EisIntSIMD_wovo()

fn test_EisInt_rewo():
    let a: EisInt_rewo = EisInt_rewo(4,0,20)
    let b: EisInt_rewo = EisInt_rewo(2,0,4)

    print("a = " + a.str_po())
    print("b = " + b.str_po())
    print()
    print("a+b = " + (a+b).str_po())
    print("a-b = " + (a-b).str_po())
    print("a*b = " + (a*b).str_po())
    print("a//b = " + (a//b).str_po())
    print((a*a).str_po(), "=", (a*a*b // b).str_po())
    print()

fn test_EisInt_wovo():
    let a: EisInt_wovo = EisInt_wovo(4,0,20)
    let b: EisInt_wovo = EisInt_wovo(2,0,4)

    print("a = " + a.str_po())
    print("b = " + b.str_po())
    print()
    print("a+b = " + (a+b).str_po())
    print("a-b = " + (a-b).str_po())
    print("a*b = " + (a*b).str_po())
    print("a//b = " + (a//b).str_po())
    print((a*a).str_po(), "=", (a*a*b // b).str_po())
    print()

fn test_EisIntSIMD_rewo():
    let a: EisIntSIMD_rewo[DType.index,2] = EisIntSIMD_rewo[DType.index,2](4,0,20)
    let b: EisIntSIMD_rewo[DType.index,2] = EisIntSIMD_rewo[DType.index,2](2,0,4)

    print("a = " + a.str_po[" "]())
    print("b = " + b.str_po[" "]())
    print()
    print("a+b = " + (a+b).str_po[" "]())
    print("a-b = " + (a-b).str_po[" "]())
    print("a*b = " + (a*b).str_po[" "]())
    print("a//b = " + (a//b).str_po[" "]())
    print((a*a).str_po[" "](), "=", (a*a*b // b).str_po[" "]())
    print()


fn test_EisIntSIMD_wovo():
    let a: EisIntSIMD_wovo[DType.index,2] = EisIntSIMD_wovo[DType.index,2](4,0,20)
    let b: EisIntSIMD_wovo[DType.index,2] = EisIntSIMD_wovo[DType.index,2](2,0,4)

    print("a = " + a.str_po[" "]())
    print("b = " + b.str_po[" "]())
    print()
    print("a+b = " + (a+b).str_po[" "]())
    print("a-b = " + (a-b).str_po[" "]())
    print("a*b = " + (a*b).str_po[" "]())
    print("a//b = " + (a//b).str_po[" "]())
    print((a*a).str_po[" "](), "=", (a*a*b // b).str_po[" "]())
    print()
