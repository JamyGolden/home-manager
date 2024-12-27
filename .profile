# This file is specifically for Linux intellij which doesn't load zsh
# when executing tests

if [ -f "$SECRETS_REPO_PATH/exports" ]; then
  . "$SECRETS_REPO_PATH/secrets/exports"
fi
