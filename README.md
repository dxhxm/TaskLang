# TaskLang++

**TaskLang++** is a Domain-Specific Language (DSL) designed for defining and managing task scheduling workflows in a simple, structured, and human-readable format.

It allows users to:

* Define tasks
* Schedule executions
* Specify dependencies between tasks
* Add conditional execution rules

This project demonstrates the implementation of a DSL using **Flex (Lex)** for lexical analysis and **Bison (Yacc)** for syntax parsing.

---

## 📌 Features

* Structured task definitions using `{ }`
* Daily and weekly scheduling support
* Task dependencies (`AFTER`)
* Conditional execution (`IF success`)
* Semantic validation:

  * Duplicate task detection
  * Undefined dependency detection
* Syntax error handling with line tracking

---

## 🗂️ Project Structure

```
TaskLang/
├── lexer.l              # Flex lexer definition
├── parser.y             # Bison parser definition
├── Makefile             # Build configuration
├── parser               # Compiled executable (generated)
├── test/
│   ├── valid.txt
│   ├── duplicate.txt
│   ├── bad_dependency.txt
│   ├── full_valid.txt
│   └── syntax_error.txt
└── README.md
```

---

## 🧠 Language Syntax

A TaskLang++ program consists of multiple task blocks:

```
TASK <task_name> {
    RUN "<command>"
    EVERY DAY AT HH:MM
    AFTER <task_name>
    IF SUCCESS
}
```

---

## 🧾 Example

```
TASK backup {
    RUN "backup.sh"
    EVERY DAY AT 10:00
}

TASK email {
    RUN "send_email.sh"
    AFTER backup
    IF SUCCESS
}
```

---

## 🔑 Supported Keywords

| Keyword | Description                 |
| ------- | --------------------------- |
| TASK    | Defines a new task          |
| RUN     | Specifies command execution |
| EVERY   | Defines recurring schedule  |
| DAY     | Daily scheduling            |
| WEEK    | Weekly scheduling           |
| AT      | Specifies execution time    |
| AFTER   | Defines task dependency     |
| IF      | Conditional execution       |
| SUCCESS | Condition keyword           |

---

## ⚙️ Prerequisites

Make sure the following tools are installed:

* Flex (Lex)
* Bison (Yacc)
* GCC Compiler
* Make

### Install on macOS (using Homebrew):

```
brew install flex bison
```

---

## 🛠️ Build Instructions

To compile the project:

```
make
```

---

## ▶️ How to Run

Run the parser with an input file:

```
./parser < test/valid.txt
```

Or using Makefile:

```
make run
```

---

## 🧪 Test Cases

The `test/` directory includes:

* `valid.txt` → Correct TaskLang++ program
* `duplicate.txt` → Duplicate task error
* `bad_dependency.txt` → Undefined dependency
* `full_valid.txt` → Complex valid scenario
* `syntax_error.txt` → Syntax error example

---

## ⚠️ Error Handling

The system detects:

* Lexical errors (invalid characters)
* Syntax errors (invalid structure)
* Semantic errors:

  * Duplicate task names
  * Invalid dependencies

---

## 🚧 Limitations

* Circular dependency detection is not implemented
* Only basic scheduling (daily/weekly) is supported
* Execution is simulated (no real task execution)

---

## 📚 Technologies Used

* C Programming Language
* Flex (Lexical Analyzer)
* Bison (Parser Generator)

---
