#!/bin/bash
# Install all remaining packages

# Remove fish config that conflicts with tldr
paru -Rns --noconfirm cachyos-fish-config tealdeer 2>/dev/null || true

paru -S --needed \
  tldr gum neovim cliphist brightnessctl pamixer \
  ttf-jetbrains-mono-nerd otf-font-awesome gnome-themes-extra \
  github-cli google-chrome \
  python-pip python-virtualenv python-poetry uv ruff \
  python-numpy python-pandas python-scipy python-matplotlib python-scikit-learn \
  python-pytorch-opt-cuda python-torchvision-cuda \
  jupyter-notebook jupyterlab ipython \
  cuda cudnn \
  nodejs npm pnpm yarn \
  typescript ts-node \
  docker docker-buildx docker-compose \
  kubectl helm
