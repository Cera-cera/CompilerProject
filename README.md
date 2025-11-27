# SMALL COMPILER – Flex & Bison

## Description
This project implements a small compiler for a simplified programming language using **Flex** (lexical analysis) and **Bison** (syntax analysis).  
It demonstrates the core concepts of lexical analysis, parsing, and symbol table management in C, using dynamic linked lists for symbol tables.

The compiler can:

- Detect identifiers, constants, keywords, operators, and separators.
- Parse declarations, instructions, expressions, and control structures (`if`, `for`, `while`, `write`, assignments).
- Maintain dynamic symbol tables for:
  - **TS**: identifiers and constants.
  - **TM**: keywords.
  - **TSep**: separators.
- Display all symbol tables after parsing.

This project is intended for learning **software engineering concepts, compiler design, and data structure usage in C**.

---

## Features

### Lexical Analysis using Flex
- Tokens for IDFs, constants, keywords, operators, and separators.
- Automatic insertion into symbol tables.

### Syntax Analysis using Bison
- Grammar rules for declarations, assignments, arithmetic expressions, loops, and conditional statements.
- Error reporting with line and column numbers.

### Symbol Table Management
- Dynamic lists using pointers.
- Functions to insert, search, and display symbols.

### Display
- After compilation, the compiler prints all symbol tables in a readable format.

---

## Project Structure
.
├── ts.h # Symbol table structures and prototypes
├── tp.l # Flex lexical rules
├── tp.y # Bison syntax rules
├── test.txt # Example input program
└── README.md # Project description

---

## Requirements
- GCC compiler  
- Flex  
- Bison  
- Linux or Windows environment  

---

## Compilation
```bash
flex tp.l
bison -d tp.y
gcc lex.yy.c tp.tab.c ts.c -o parser -lfl
```
## Usage
```bash
./parser < test.txt
```
## Example Input (`test.txt`)
```text
MainProgram ACAD_A ;
Declaration
L,S,K : Entier ;
F,W : Reel ;
T[15] : Entier ;
Body
begin
S := a + b ;
Write("Hello") ;
end
```
## Expected Output
```text
--- Analyse syntaxique terminee avec succes ---
Table des symboles :
/-------------Table des  IDF---------------/
____________________________________________________________________
        | Nom_Entite | Code_Entite | Type_Entite | Val_Entite
____________________________________________________________________
        |            |              |        CONST |           15
        |          T |          IDF |          IDF |
        |          W |          IDF |          IDF |
        |          F |          IDF |          IDF |
        |          K |          IDF |          IDF |
        |          S |          IDF |          IDF |
        |          L |          IDF |          IDF |
        |     ACAD_A |          IDF |          IDF |

/--------------Table des  keywords-------------/
_____________________________________
        | NomEntite | CodeEntite
_____________________________________
        |       Reel |           KW
        |     Entier |           KW

/---------------Table des SEP -------------------/
_____________________________________
        | NomEntite | CodeEntite
_____________________________________
        |          ] |          SEP
        |          [ |          SEP
        |          , |          SEP
        |          ; |          SEP

```
## Notes
- Constants (like array sizes) are added to TS with their values. 
- Keywords and separators are automatically inserted into TM and TSep .
- The project can be extended with type checking, semantic analysis, or code generation.

---

## License
- This project is free to use for learning purposes.
