# Quickstart: Development Workflow Standards

**Feature**: 001-this-repository-was
**Purpose**: Validate that development workflow standards are working end-to-end
**Time**: ~5 minutes

## Prerequisites

- Python 3.11+ installed
- Git installed
- GitHub account with repository access

## Steps

### 1. Clone Repository (if not already)

```bash
git clone https://github.com/YOUR_ORG/chemeleon2.git
cd chemeleon2
```

### 2. Run Setup Command

```bash
# Option 1: Shell script
./setup-dev.sh

# Option 2: Makefile
make setup
```

**Expected output**:
```
Setting up development environment...
✓ Python 3.11 detected
✓ Installing pre-commit...
✓ Installing Ruff...
✓ Installing pre-commit hooks...
Setup complete! Pre-commit hooks are active.
```

### 3. Verify Pre-commit Installation

```bash
pre-commit run --all-files
```

**Expected output**:
```
Ruff Format Check...................................Passed
Ruff Lint Check.....................................Passed
Check YAML..........................................Passed
Check TOML..........................................Passed
Check JSON..........................................Passed
```

### 4. Make a Test Code Change

Create a test file with intentional violations:

```bash
cat > test_formatting.py << 'PYEOF'
def hello(  ):
    x=1+2
    print('hello')
PYEOF
```

### 5. Attempt to Commit

```bash
git add test_formatting.py
git commit -m "test: formatting violation"
```

**Expected outcome**: Commit BLOCKED with Ruff errors

**Expected output**:
```
Ruff Format Check...................................Failed
- hook id: ruff-format
- files were modified by this hook

test_formatting.py

Ruff Lint Check.....................................Failed
- hook id: ruff
test_formatting.py:1:11: E201 whitespace after '('
test_formatting.py:2:6: E225 missing whitespace around operator
test_formatting.py:3:11: Q000 Single quotes found but double quotes preferred
```

### 6. Fix Violations (Manual or AI Agent)

**Option A: Manual Fix**
```python
def hello():
    x = 1 + 2
    print("hello")
```

**Option B: AI Agent Fix**
Ask Claude/Codex/Gemini:
> "Fix these Ruff violations in test_formatting.py: [paste errors]"

### 7. Re-commit Successfully

```bash
git add test_formatting.py
git commit -m "test: properly formatted code"
```

**Expected outcome**: Commit SUCCEEDS

**Expected output**:
```
Ruff Format Check...................................Passed
Ruff Lint Check.....................................Passed
[001-this-repository-was abc1234] test: properly formatted code
 1 file changed, 3 insertions(+)
```

### 8. Push and Open PR

```bash
git push origin 001-this-repository-was
```

Open Pull Request on GitHub.

### 9. Verify CI Runs

Check GitHub Actions tab on your PR.

**Expected**: CI workflow runs automatically

**Expected checks**:
- ✓ Ruff format check
- ✓ Ruff lint check
- ✓ pytest

### 10. Clean Up Test File

```bash
git rm test_formatting.py
git commit -m "test: remove test file"
git push
```

## Success Criteria

- [x] Setup script completed without errors
- [x] Pre-commit hooks installed
- [x] Intentional violation was blocked
- [x] Fixed code committed successfully
- [x] CI ran on PR
- [x] All CI checks passed

## Troubleshooting

### "Python version too old"
**Solution**: Install Python 3.11 or higher
```bash
python --version  # Check version
```

### "pre-commit: command not found"
**Solution**: Re-run setup script or install manually
```bash
pip install pre-commit
```

### "Ruff not found"
**Solution**: Install Ruff
```bash
pip install ruff
```

### Hooks not running on commit
**Solution**: Reinstall hooks
```bash
pre-commit install
```

### CI failing but local pre-commit passes
**Solution**: Ruff version mismatch
```bash
pre-commit autoupdate  # Update hook versions
```

## AI Agent Examples

### Claude Prompt
```
I got these Ruff errors when committing:
test.py:1:11: E201 whitespace after '('
test.py:2:6: E225 missing whitespace around operator

Please fix the code.
```

### Codex/Copilot Prompt
```
Fix Ruff linting errors in this code:
[paste code]
```

### Gemini Prompt
```
Add docstrings to pass Ruff pydocstyle checks:
[paste code]
```

## Next Steps

After quickstart validation:
1. Read full CONTRIBUTING.md for detailed guidelines
2. Review Ruff configuration in pyproject.toml
3. Join team development workflow

## References

- Full documentation: `CONTRIBUTING.md`
- Ruff rules: https://docs.astral.sh/ruff/rules/
- Pre-commit: https://pre-commit.com/

---

**Quickstart Complete** ✅
Development workflow standards are active and working.
