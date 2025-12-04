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

### Semantic Analysis
The compiler now includes semantic analysis to detect logical and contextual errors after syntax validation.
This module performs:
### Variable Declaration Checking
- Detects using a variable before declaration.
- Prevents double declarations.
- Assigns a valid type to each declared variable.
### Array (Tableau) Semantic Checks
- Ensures an array is declared before use.
- Validates array size:
- Must be greater than 0
- Detects negative or zero sizes
- Prevents redeclaration of the same array with a different type or size
### Type Assignment After Parsing
- Flex inserts identifiers first without type.
- Bison assigns the correct type later using semantic rules.
- Types appear correctly in the final symbol table.
### Semantic Error Messages
- The compiler prints semantic diagnostic messages such as:
- Erreur semantique : 'X' not declared
- Erreur semantique tableau 'T' deja declarer
- Erreur semantique: taille invalide pour tableau 'U' (0)
- Erreur semantique: type incompatible

### Final Semantic Report
- After parsing, the compiler displays:
- The updated symbol tables (TS, TM, TSep)
- With all types, codes, and array sizes resolved
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
bison -d bisonFile.y
flex flexFile.l
gcc bisonFile.tab.c lex.yy.c  -o parser -lfl

```
## Usage
```bash
parser.exe < test.txt
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

## Expected Output (including semantic work now )
   ```
Erreur semantique  ligne 7: 'T' not declared
Tableau 'T' declare avec succes: type='Entier', taille=15
Erreur semantique  ligne 8: 'U' not declared
Erreur semantique ligne 8: taille invalide pour tableau 'U' (0)
Erreur semantique  tableau 'T' deja declarer
Erreur semantique  ligne 10: 'TAB2' not declared
Erreur semantique ligne 10: taille invalide pour tableau 'TAB2' (-4)
Erreur semantique  ligne 17: 'M' not declared


--- Analyse syntaxique terminee avec succes ---

 ---Analyse sementique ---
Table des symboles :
/-------------Table des  IDF---------------/
____________________________________________________________________
        | Nom_Entite | Code_Entite | Type_Entite | Val_Entite
____________________________________________________________________
        |          M |          IDF |              |
        |       TAB2 |          IDF |              |
        |          U |          IDF |              |
        |          T |      TABLEAU |       Entier |           15
        |          F |          VAR |         Reel |
        |          L |          VAR |       Entier |
        |     ACAD_A |          IDF |              |

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
        |          } |          SEP
        |          { |          SEP
        |          ] |          SEP
        |          [ |          SEP
        |          ; |          SEP
```
## Notes
- Constants (like array sizes) are added to TS with their values. 
- Keywords and separators are automatically inserted into TM and TSep .
- The project can be extended with type checking, semantic analysis, or code generation.

---

## License
- This project is free to use for learning purposes.
