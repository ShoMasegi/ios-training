#!/bin/sh

echo "Install ruby by rbenv"

rubyVersionBinaryPath="$(rbenv root)""/versions/""$(< .ruby-version)""/bin/ruby"

if [ -e "$rubyVersionBinaryPath" ]; then
  echo "Already installed ruby($(< .ruby-version))"
else
  brew update && brew upgrade ruby-build || true
  rbenv install "$(< .ruby-version)"
  echo "Installed ruby($(< .ruby-version))"
fi
