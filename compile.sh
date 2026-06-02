#!/bin/bash

# LaTeX compilation script using latexmk + XeLaTeX
# - Incremental builds (only recompiles what changed)
# - Native Unicode/Arabic support via XeLaTeX
# - Automatic BibTeX and multi-pass handling
#
# Usage:
#   ./compile.sh              # incremental build (fast)
#   ./compile.sh --clean      # full clean rebuild
#   ./compile.sh --full       # force all passes (no incremental)
#   ./compile.sh other.tex    # compile a different file

# ── Parse arguments ──────────────────────────────────
CLEAN=0
FULL=0
TEXFILE="main.tex"

for arg in "$@"; do
    case "$arg" in
        --clean)  CLEAN=1 ;;
        --full)   FULL=1 ;;
        *.tex)    TEXFILE="$arg" ;;
    esac
done

BASENAME=$(basename "$TEXFILE" .tex)
BUILDDIR="./build"

# ── Colors ───────────────────────────────────────────
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# ── Pre-flight checks ───────────────────────────────
if ! command -v latexmk &>/dev/null; then
    echo -e "${RED}✗ latexmk not found. Install with: sudo apt install latexmk${NC}"
    exit 1
fi
if ! command -v xelatex &>/dev/null; then
    echo -e "${RED}✗ xelatex not found. Install with: sudo apt install texlive-xetex${NC}"
    exit 1
fi

if [ ! -f "$TEXFILE" ]; then
    echo -e "${RED}✗ File not found: $TEXFILE${NC}"
    exit 1
fi

mkdir -p "$BUILDDIR"

# ── Clean if requested ───────────────────────────────
if [ $CLEAN -eq 1 ]; then
    echo -e "${YELLOW}Cleaning build directory...${NC}"
    latexmk -C -output-directory="$BUILDDIR" "$TEXFILE" 2>/dev/null
    rm -rf "$BUILDDIR"/*
fi

# ── Compile ──────────────────────────────────────────
START=$(date +%s%N)

echo -e "${CYAN}Compiling ${TEXFILE}...${NC}"

LATEXMK_FLAGS=(
    -lualatex                         # use LuaLaTeX engine (Unicode + Arabic)
    -output-directory="$BUILDDIR"     # keep build artifacts out of root
    -interaction=nonstopmode          # don't stop on errors
    -file-line-error                  # better error messages
    -f                                # force through non-fatal errors
    -quiet                            # suppress most output
)

if [ $FULL -eq 1 ]; then
    LATEXMK_FLAGS+=(-gg)              # force full rebuild
fi

latexmk "${LATEXMK_FLAGS[@]}" "$TEXFILE" 2>&1 | tee "$BUILDDIR/compile.log"
RESULT=${PIPESTATUS[0]}

END=$(date +%s%N)
ELAPSED=$(( (END - START) / 1000000 ))  # milliseconds

# ── Post-compile ─────────────────────────────────────
if [ -f "$BUILDDIR/$BASENAME.pdf" ]; then
    cp "$BUILDDIR/$BASENAME.pdf" "./$BASENAME.pdf"
    echo ""
    if [ $RESULT -eq 0 ]; then
        echo -e "${GREEN}✓ Compilation successful!${NC} (${ELAPSED}ms)"
    else
        echo -e "${YELLOW}✓ PDF generated with warnings.${NC} (${ELAPSED}ms)"
        echo -e "  Check: ${BUILDDIR}/${BASENAME}.log"
    fi
    echo -e "  PDF: ./${BASENAME}.pdf"
else
    echo ""
    echo -e "${RED}✗ Compilation failed — no PDF produced.${NC} (${ELAPSED}ms)"
    echo -e "  Log: ${BUILDDIR}/${BASENAME}.log"
    exit 1
fi