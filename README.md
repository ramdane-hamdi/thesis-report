# Thesis — Compile & Usage

This repository contains the LaTeX source for the master thesis. The included `compile.sh` script handles building the document.

**Prerequisites**

- A TeX distribution with `latexmk` and `lualatex` (TeX Live recommended).
- `latexmk` command must be installed (`sudo apt install latexmk`).
- Standard LaTeX packages (the class attempts to load them; install `texlive-full` if in doubt).
- A POSIX shell to run `./compile.sh`.

**Quick start**

From the repository root:

```bash
# incremental build (fast)
./compile.sh

# full clean rebuild
./compile.sh --clean

# force all passes (no incremental)
./compile.sh --full

# compile a specific file
./compile.sh chapters/004_general_introduction.tex
```

After a successful run the final PDF will be at:

```
./main.pdf
```

**Troubleshooting**

- If `latexmk` or `lualatex` is not found, ensure your TeX distribution is correctly installed and in your PATH.
- If compilation fails, inspect `build/compile.log` and `build/main.log` for details.
- Missing images or files: ensure paths referenced in the source exist (`assets/` is used for logos and figures).
