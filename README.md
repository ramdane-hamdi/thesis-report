# Thesis — Compile & Usage

This repository contains the LaTeX source for the master thesis. The included `compile.sh` script handles building the document.

**Prerequisites**

- A TeX distribution with `pdflatex` and `bibtex` (TeX Live recommended).
- Standard LaTeX packages (the class attempts to load them; install `texlive-full` if in doubt).
- A POSIX shell to run `./compile.sh`.

**Quick start**

From the repository root:

```bash
# default: compiles main.tex
./compile.sh

# compile a specific file (e.g. for fast local checks)
./compile.sh chapters/004_general_introduction.tex
```

After a successful run the final PDF will be at:

```
./main.pdf
```

**Troubleshooting**

- If `bibtex` is not found, install the appropriate TeX packages (e.g., `texlive-bibtex-extra` or `texlive-full`).
- If compilation fails, inspect `build/compile.log` and `build/main.log` for details.
- Missing images or files: ensure paths referenced in the source exist (`assets/` is used for logos and figures).
