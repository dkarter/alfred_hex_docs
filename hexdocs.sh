#!/bin/bash

export PATH="/opt/homebrew/bin:/usr/local/bin:${PATH}"
if [[ -f ~/.asdf/asdf.sh ]]; then
	source ~/.asdf/asdf.sh
elif [[ "$(command -v brew)" != "" && -f "$(brew --prefix asdf)/libexec/asdf.sh" ]]; then
	source "$(brew --prefix asdf)/libexec/asdf.sh"
elif [[ "$(command -v elixir)" == "" ]]; then
	echo '{"items":[{"title": "Error","subtitle":"Could not find existing Elixir installation"}]}'
	exit 1
fi

elixir hexdocs.exs "$1"
