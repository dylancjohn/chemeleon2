# Implementation Plan: Development Workflow Standards for Team Collaboration

**Branch**: `001-this-repository-was` | **Date**: 2025-10-03 | **Spec**: [spec.md](./spec.md)
**Input**: Feature specification from `/specs/001-this-repository-was/spec.md`

## Execution Flow (/plan command scope)
```
1. Load feature spec from Input path
   → Feature spec loaded successfully
2. Fill Technical Context (scan for NEEDS CLARIFICATION)
   → Project Type: Single Python project (machine learning framework)
   → Structure Decision: Single project with src/ and tests/
3. Fill the Constitution Check section
   → Constitution template is placeholder - no specific gates defined
4. Evaluate Constitution Check section
   → No violations detected
   → ✅ Progress Tracking: Initial Constitution Check PASS
5. Execute Phase 0 → research.md
   → All technical decisions clarified in spec
6. Execute Phase 1 → contracts, data-model.md, quickstart.md, CLAUDE.md
   → Design artifacts generated
7. Re-evaluate Constitution Check section
   → No new violations
   → ✅ Progress Tracking: Post-Design Constitution Check PASS
8. Plan Phase 2 → Task generation approach described
9. STOP - Ready for /tasks command
```

**IMPORTANT**: The /plan command STOPS at step 9. Phases 2-4 are executed by other commands:
- Phase 2: /tasks command creates tasks.md
- Phase 3-4: Implementation execution (manual or via tools)

## Summary

Establish development workflow standards to transition chemeleon2 (a generative ML framework for crystal structure prediction) from solo development to team collaboration. Implement automated code formatting, linting, and quality checks using Ruff (Black-compatible formatter + strict linter) with pre-commit hooks that enforce standards locally and GitHub Actions CI/CD that validates all Pull Requests before merge. Apply standards retroactively to entire existing codebase and provide comprehensive documentation for team onboarding.

**Primary Requirement**: Ensure all code commits meet strict formatting and quality standards through automated validation
**Technical Approach**: Ruff for formatting/linting, pre-commit framework for local hooks, GitHub Actions for CI enforcement, comprehensive documentation for team adoption

## Technical Context

**Language/Version**: Python 3.11+
**Primary Dependencies**: Ruff (formatter + linter), pre-commit framework, GitHub Actions
**Storage**: N/A (configuration files only)
**Testing**: pytest (CI only, not in pre-commit hooks)
**Target Platform**: Linux/macOS development environments, GitHub-hosted runners for CI
**Project Type**: Single Python project (ML framework)
**Performance Goals**: Pre-commit validation < 15 seconds for developer workflow
**Constraints**: 88-character line length (Black default), strict linting rules (docstrings, type hints, complexity limits, security patterns)
**Scale/Scope**: Existing codebase with Python, YAML, TOML, JSON files; team of multiple developers; retroactive application to all existing code

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

**Status**: ✅ PASS

The constitution template is a placeholder with no specific project principles defined. This feature introduces foundational development standards and does not violate any architectural constraints. The approach is simple and follows industry best practices:
- Ruff: Single tool for formatting + linting (simpler than separate Black + flake8/pylint)
- pre-commit: Standard framework for git hooks
- GitHub Actions: Standard CI/CD platform already in use
- Documentation-first for team adoption

No complexity justifications needed.

## Project Structure

### Documentation (this feature)
```
specs/001-this-repository-was/
├── plan.md              # This file (/plan command output)
├── research.md          # Phase 0 output (/plan command)
├── data-model.md        # Phase 1 output (/plan command)
├── quickstart.md        # Phase 1 output (/plan command)
├── contracts/           # Phase 1 output (/plan command)
└── tasks.md             # Phase 2 output (/tasks command - NOT created by /plan)
```

### Source Code (repository root)
```
# Single project structure (existing)
src/
├── models/              # ML models (existing)
├── services/            # Services (existing)
├── utils/               # Utilities (existing)
└── lib/                 # Library code (existing)

tests/
├── contract/            # Contract tests (new for this feature)
├── integration/         # Integration tests (existing)
└── unit/                # Unit tests (existing)

# New configuration files at repository root
.pre-commit-config.yaml  # Pre-commit hook configuration
pyproject.toml           # Ruff configuration (extend existing)
.github/
└── workflows/
    └── ci.yml           # GitHub Actions workflow (new)

# New documentation at repository root
CONTRIBUTING.md          # Developer onboarding guide (new)
```

**Structure Decision**: Single Python project structure. Configuration files added to repository root. GitHub Actions workflow added to `.github/workflows/`. Documentation added as top-level CONTRIBUTING.md. No new src/ structure needed - this feature adds development tooling only.

## Phase 0: Outline & Research

**Status**: ✅ COMPLETE

All technical decisions were resolved during the `/clarify` workflow. No unknowns remain. See `research.md` for consolidated findings.

**Key Decisions from Clarifications**:
1. **Formatter**: Ruff Format (Black-compatible, 88 chars, Python 3.11+)
2. **Linter**: Ruff with strict rules (docstrings, type hints, complexity, security)
3. **File Types**: .py, .yaml, .toml, .json
4. **Enforcement**: Block commits on violations (manual or AI-agent fixes)
5. **Hook Installation**: One-command setup script
6. **Performance**: < 15 seconds validation time
7. **Testing**: pytest in CI only (not pre-commit)
8. **CI/CD**: GitHub Actions with required status checks
9. **Documentation**: Full CONTRIBUTING.md with AI agent examples
10. **Retroactive**: Apply to all existing code with conflict mitigation
11. **AI Integration**: Support Claude, Codex, Gemini, etc. for auto-fixing
12. **Line Length**: 88 characters (Black default)

**Output**: research.md created

## Phase 1: Design & Contracts

**Status**: ✅ COMPLETE

### Entities Extracted from Spec

See `data-model.md` for complete entity definitions. Key entities:

1. **Formatting Rules**: Ruff configuration with Black-compatible settings
2. **Linting Rules**: Strict Ruff rule sets
3. **Pre-commit Configuration**: Hook definitions and execution order
4. **CI/CD Pipeline**: GitHub Actions workflow definition
5. **Developer Documentation**: CONTRIBUTING.md structure
6. **Developer Environment Setup**: Installation and setup procedures

### Contracts Generated

See `contracts/` directory for:
- Ruff configuration schema (pyproject.toml structure)
- Pre-commit config schema (.pre-commit-config.yaml structure)
- GitHub Actions workflow schema (ci.yml structure)
- Setup script interface (single-command installation)

### Contract Tests

Contract tests created in `tests/contract/`:
- `test_ruff_config.py`: Validates Ruff configuration exists and is valid
- `test_precommit_config.py`: Validates pre-commit configuration structure
- `test_github_actions.py`: Validates CI workflow configuration
- `test_setup_script.py`: Validates setup script functionality

**Note**: These tests currently FAIL (no implementation yet) - this is expected in TDD workflow.

### Quickstart Created

See `quickstart.md` for developer onboarding flow:
1. Clone repository
2. Run setup command
3. Make code change
4. Commit (pre-commit runs automatically)
5. Open PR (CI validates)
6. Use AI agent to fix issues if needed

### Agent Context Updated

CLAUDE.md updated with:
- Ruff configuration patterns
- Pre-commit hook best practices
- GitHub Actions workflow structure
- Recent changes: Development workflow standards implementation

**Output**: data-model.md, contracts/*, failing tests, quickstart.md, CLAUDE.md

## Phase 2: Task Planning Approach

*This section describes what the /tasks command will do - DO NOT execute during /plan*

**Task Generation Strategy**:
1. Load `.specify/templates/tasks-template.md` as base
2. Generate tasks from Phase 1 design docs in dependency order
3. Group tasks by component:
   - Ruff configuration
   - Pre-commit hooks
   - GitHub Actions CI
   - Setup automation
   - Documentation
   - Retroactive formatting

**Ordering Strategy** (TDD + dependency order):
1. **Tests First**: All contract tests (parallel [P])
2. **Configuration**: Ruff config → Pre-commit config → CI workflow
3. **Automation**: Setup script
4. **Documentation**: CONTRIBUTING.md, inline config comments
5. **Retroactive**: Format existing codebase
6. **Validation**: Verify all tests pass, CI works end-to-end

**Estimated Task Breakdown**:
- 4 contract test tasks [P]
- 3 configuration tasks (sequential - Ruff → pre-commit → CI)
- 1 setup script task
- 2 documentation tasks [P]
- 1 retroactive formatting task (depends on all config)
- 1 end-to-end validation task

**Total Estimated**: 12-15 numbered, ordered tasks in tasks.md

**IMPORTANT**: This phase is executed by the /tasks command, NOT by /plan

## Phase 3+: Future Implementation

*These phases are beyond the scope of the /plan command*

**Phase 3**: Task execution (/tasks command creates tasks.md)
**Phase 4**: Implementation (execute tasks.md following TDD principles)
**Phase 5**: Validation (all tests pass, CI validates PRs, documentation complete)

## Complexity Tracking

*No complexity deviations from constitution - section left empty*

## Progress Tracking

**Phase Status**:
- [x] Phase 0: Research complete (/plan command)
- [x] Phase 1: Design complete (/plan command)
- [x] Phase 2: Task planning complete (/plan command - describe approach only)
- [ ] Phase 3: Tasks generated (/tasks command)
- [ ] Phase 4: Implementation complete
- [ ] Phase 5: Validation passed

**Gate Status**:
- [x] Initial Constitution Check: PASS
- [x] Post-Design Constitution Check: PASS
- [x] All NEEDS CLARIFICATION resolved
- [x] Complexity deviations documented (none)

---
*Based on Constitution template - See `/memory/constitution.md`*
