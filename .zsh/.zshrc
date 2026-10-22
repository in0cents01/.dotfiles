if [[ -o interactive && -z "$BASH_VERSION" && -x /bin/bash ]]; then
  exec bash
fi
