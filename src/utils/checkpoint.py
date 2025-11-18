"""Checkpoint download utility using Hugging Face Hub."""

import time
from pathlib import Path

import yaml
from huggingface_hub import hf_hub_download

CHECKPOINT_CONFIG = (
    Path(__file__).parent.parent.parent / "checkpoints" / "checkpoints.yaml"
)  # Available checkpoints config file


def load_checkpoint_config() -> dict:
    """Load checkpoint configuration from YAML file."""
    with open(CHECKPOINT_CONFIG) as f:
        return yaml.safe_load(f)


def get_checkpoint(name: str) -> Path:
    """Download checkpoint from Hugging Face Hub if not cached.

    Args:
        name: Checkpoint name from config (e.g., 'mp_20_vae').

    Returns:
        Path to downloaded checkpoint.
    """
    # Load config
    config = load_checkpoint_config()
    ckpt_info = config["checkpoints"][name]
    hf_repo = config["config"]["hf_repo"]
    local_dir = config["config"]["local_dir"]
    retry_attempts = config["config"].get("retry_attempts", 3)
    retry_delay = config["config"].get("retry_delay", 2)

    # Download with retry
    last_error = None
    for attempt in range(retry_attempts):
        try:
            path = hf_hub_download(
                repo_id=hf_repo,
                filename=ckpt_info["hf_path"],
                local_dir=local_dir,
            )

            return Path(path)

        except Exception as e:
            last_error = e
            if attempt < retry_attempts - 1:
                print(
                    f"⚠ Download failed (attempt {attempt + 1}/{retry_attempts}): {e}"
                )
                print(f"  Retrying in {retry_delay}s...")
                time.sleep(retry_delay)

    # All retries failed
    raise RuntimeError(
        f"Failed to download '{name}' after {retry_attempts} attempts"
    ) from last_error


def resolve_checkpoint_path(name_or_path: str) -> Path:
    """Resolve checkpoint path, downloading if necessary.

    Args:
        name_or_path: Either a checkpoint name (e.g., 'mp_20_vae') or a file path.

    Returns:
        Path to the checkpoint file.

    Raises:
        ValueError: If the input is neither a valid file path nor a registered checkpoint name.
    """
    # Check if input is an existing file path
    path = Path(name_or_path)
    if path.exists():
        return path

    config = load_checkpoint_config()
    available = ", ".join(config["checkpoints"].keys())
    if name_or_path in available:
        return get_checkpoint(name_or_path)
    else:
        raise ValueError(
            f"'{name_or_path}' is neither a valid file path nor a registered checkpoint name. "
            f"Available checkpoints: {available}"
        )
