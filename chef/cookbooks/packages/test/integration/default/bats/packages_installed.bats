#!/usr/bin/env bats

@test "Check if git is installed" {
  run which git
  [ "$status" -eq 0 ]
}

@test "Check if zsh is installed" {
  run which zsh
  [ "$status" -eq 0 ]
}
