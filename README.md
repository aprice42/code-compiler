# Code-Compiler

Code-Compiler is a command-line tool that compiles the structure and contents of a codebase into a single text file. It generates a tree structure of the project and appends the contents of each file, creating a comprehensive view of the entire code ecosystem. This is particularly useful for providing context to AI models, allowing them to understand the structure and logic of a project.

## Features

- Generates a hierarchical tree structure of your project.
- Compiles the contents of files tracked by Git into a single document.
- Supports non-Git projects by including all files and directories.
- Provides a detailed, unified view of codebases, making it ideal for AI-based code reviews, analysis, or refactoring assistance.

## Installation

To use Code-Compiler, clone the repository and ensure you have Bash installed on your system.

```bash
git clone https://github.com/yourusername/code-compiler.git
cd code-compiler
chmod +x compile_files_for_ai.sh
./compile_files_for_ai.sh [input_directory] [output_file]

- input_directory: The root directory of the project you want to compile.
- output_file: The path to the output text file where the compiled structure and contents will be saved.

### Example Output
```
Project Structure:
|-- project
    |-- src
        |-- main.py
        |-- utils.py
    |-- tests
        |-- test_main.py

========== src/main.py ==========
# Main application code here

import utils

def main():
    print("Hello, World!")

if __name__ == "__main__":
    main()

========== src/utils.py ==========
# Utility functions for the project

def helper():
    return "This is a helper function"

========== tests/test_main.py ==========
# Test cases for main.py

import unittest
from src.main import main

class TestMain(unittest.TestCase):
    def test_main(self):
        self.assertEqual(main(), "Hello, World!")
```

