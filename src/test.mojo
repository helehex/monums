from monums.eisint import EisInt

fn main():
    print((EisInt(1,2)).str_po())
    print((EisInt(1,2) * EisInt(1,2)).str_po(), "=", ((EisInt(1,2) * EisInt(1,2) * EisInt(1,2)) // EisInt(1,2)).str_po())
    print(((EisInt(1,2) * EisInt(1,2) * EisInt(1,2))).str_po())