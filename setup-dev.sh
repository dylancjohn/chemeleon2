#!/bin/bash
# Development environment setup script
# Exit on first error
set -e

echo "========================================="
echo "Development Environment Setup"
echo "========================================="
echo ""

# 1. Check that .venv exists with Python
echo -n "Checking virtual environment... "
if [ ! -f ".venv/bin/python" ]; then
    echo "✗ Not found"
    echo "ERROR: .venv/bin/python not found."
    echo ""
    echo "This project requires a virtual environment managed by uv."
    echo "Please create it first:"
    echo "  uv venv"
    echo ""
    exit 1
fi
PYTHON_CMD=".venv/bin/python"
echo "✓ Found"

# 2. Check Python version >= 3.11
echo -n "Checking Python version... "

PYTHON_VERSION=$($PYTHON_CMD --version 2>&1 | awk '{print $2}')
PYTHON_MAJOR=$(echo $PYTHON_VERSION | cut -d. -f1)
PYTHON_MINOR=$(echo $PYTHON_VERSION | cut -d. -f2)

if [ "$PYTHON_MAJOR" -lt 3 ] || { [ "$PYTHON_MAJOR" -eq 3 ] && [ "$PYTHON_MINOR" -lt 11 ]; }; then
    echo "✗ Found Python $PYTHON_VERSION"
    echo "ERROR: Python 3.11+ required. Please upgrade Python."
    echo ""
    echo "Installation aborted."
    exit 1
fi
echo "✓ Python $PYTHON_VERSION"

# 3. Check if uv is installed
echo -n "Checking uv package manager... "
if ! command -v uv &> /dev/null; then
    echo "✗ Not found"
    echo "ERROR: uv package manager is required."
    echo "Install uv: curl -LsSf https://astral.sh/uv/install.sh | sh"
    exit 2
fi
echo "✓ Found"

# 4. Install pre-commit framework
echo -n "Installing pre-commit... "
if uv pip install pre-commit > /dev/null 2>&1; then
    echo "✓ Done"
else
    echo "✗ Failed"
    echo "ERROR: Failed to install pre-commit framework."
    exit 2
fi

# 5. Install Ruff
echo -n "Installing Ruff... "
if uv pip install ruff > /dev/null 2>&1; then
    echo "✓ Done"
else
    echo "✗ Failed"
    echo "ERROR: Failed to install Ruff."
    exit 2
fi

# 6. Install pyright
echo -n "Installing pyright... "
if uv pip install pyright > /dev/null 2>&1; then
    echo "✓ Done"
else
    echo "✗ Failed"
    echo "ERROR: Failed to install pyright."
    exit 2
fi

# 7. Install pre-commit hooks
echo -n "Installing pre-commit hooks... "
if .venv/bin/pre-commit install > /dev/null 2>&1; then
    echo "✓ Done"
else
    echo "✗ Failed"
    echo "ERROR: Failed to install pre-commit hooks."
    exit 3
fi

echo ""
echo "✓ Development environment setup complete!"
echo ""

# 8. Optional: Run pre-commit on all files (warn but don't fail)
echo "Running pre-commit validation on all files..."
echo "(This may take a moment and may show warnings)"
echo ""
if .venv/bin/pre-commit run --all-files; then
    echo ""
    echo "✓ All pre-commit checks passed!"
else
    echo ""
    echo "⚠ Warning: Some pre-commit checks failed."
    echo "This is normal for initial setup. You can fix these issues later."
    echo "Setup was successful - hooks are installed and will run on commit."
fi

echo ""
echo "Next steps:"
echo "  1. Make your changes"
echo "  2. Commit (pre-commit will run automatically)"
echo "  3. Push and open a PR"
echo ""
