#!/bin/bash

# LaTeX compilation script with proper build directory handling
# Usage: ./compile.sh [filename.tex]

if [ $# -eq 0 ]; then
    TEXFILE="main.tex"
else
    TEXFILE="$1"
fi

BASENAME=$(basename "$TEXFILE" .tex)
BUILDDIR="./build"
LOGFILE="$BUILDDIR/compile.log"

AUXFILE="$BUILDDIR/$BASENAME.aux"



# Create build directory if it doesn't exist
mkdir -p "$BUILDDIR"
rm -rf "$BUILDDIR"/* # Clean previous build files

> "$LOGFILE" # Clear previous compilation log

# Compile multiple times to resolve references, TOC, bibliography, etc.
echo "=== First pass ==="
pdflatex -output-directory="$BUILDDIR" -interaction=nonstopmode "$TEXFILE" >> "$LOGFILE" 2>&1 

# Run BibTeX if a bibliography is present
if [ -f "$AUXFILE" ] && grep -q "\\\\bibdata" "$AUXFILE"; then
    echo "=== BibTeX pass ==="
    if ! command -v bibtex >/dev/null 2>&1; then
        echo ""
        echo "✗ bibtex not found in PATH. Install TeX Live BibTeX tools and retry."
        exit 1
    fi
    bibtex "$BUILDDIR/$BASENAME" >> "$LOGFILE" 2>&1 || {
        echo ""
        echo "✗ BibTeX failed. Check the log file: $LOGFILE"
        exit 1
    }
fi

echo "=== Second pass (for TOC and references) ==="
pdflatex -output-directory="$BUILDDIR" -interaction=nonstopmode "$TEXFILE" >> "$LOGFILE" 2>&1 

echo "=== Third pass (final resolve) ==="
pdflatex -output-directory="$BUILDDIR" -interaction=nonstopmode "$TEXFILE" >> "$LOGFILE" 2>&1 

# Check if PDF was created successfully
if [ -f "$BUILDDIR/$BASENAME.pdf" ]; then
    cp "$BUILDDIR/$BASENAME.pdf" "./$BASENAME.pdf"
    rm -f "$BUILDDIR/$BASENAME.pdf"
    echo ""
    echo "✓ Compilation successful!"
    echo "PDF location: ./$BASENAME.pdf"
else
    echo ""
    echo "✗ Compilation failed. Check the log file:"
    echo "  $BUILDDIR/$BASENAME.log"
    exit 1
fi