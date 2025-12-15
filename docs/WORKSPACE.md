# Docs Workspace Reference

Quick reference for docs/ structure and file purposes.

## Directory Structure

```
docs/
├── myst.yml                 # MyST v2 config with inline TOC
├── index.md                 # Landing page
├── custom.css               # Custom styles (unused currently)
│
├── getting-started/
│   ├── installation.md      # Installation guide
│   └── quickstart.md        # Quick start tutorial
│
├── user-guide/
│   ├── evaluation.md        # Evaluation guide
│   ├── training/
│   │   ├── index.md         # Training overview (Hydra, checkpoints, WandB)
│   │   ├── vae.md           # VAE training
│   │   ├── ldm.md           # LDM training
│   │   ├── rl.md            # RL training
│   │   └── predictor.md     # Predictor training
│   └── rewards/
│       ├── index.md         # Rewards overview + built-in components
│       ├── atomic-density.md    # Tutorial: Simple custom reward
│       ├── dng-reward.md        # Tutorial: DNG (paper implementation)
│       └── predictor-reward.md  # Tutorial: Predictor-based RL
│
├── architecture/
│   ├── index.md             # Architecture overview + diagrams
│   ├── vae-module.md        # VAE module
│   ├── ldm-module.md        # LDM module
│   ├── rl-module.md         # RL module
│   └── data-pipeline.md     # Data loading and utilities
│
├── api/
│   └── index.md             # API reference
│
├── contributing.md          # Development guide
├── PLAN_DOC.md              # Original documentation plan
└── WORKSPACE.md             # This file (workspace reference)
```

## TOC Structure (myst.yml)

| Section | Files |
|---------|-------|
| Getting Started | installation.md, quickstart.md |
| User Guide > Training | index, vae, ldm, rl, predictor |
| User Guide > Custom Rewards | index, atomic-density, dng-reward, predictor-reward |
| User Guide | evaluation.md |
| Architecture Guide | index, vae-module, ldm-module, rl-module, data-pipeline |
| API Reference | index.md |
| Development | contributing.md |

## Build Commands

```bash
# Build docs
cd docs && jupyter-book build --html

# Serve locally
python -m http.server 8000 --directory docs/_build/html

# Build and serve
(cd docs && jupyter-book build --html) && python -m http.server 8000 --directory docs/_build/html
```

## Key Points

- **Config**: `myst.yml` (MyST v2 format with inline TOC)
- **Theme**: book-theme
- **Assets**: `../assets/` (logo.png, toc.png)
- **Build output**: `_build/` (gitignored)
