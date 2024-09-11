#!/usr/bin/env bats

@test "check git" {
    run which git
    [ "$status" -eq 0 ]
}
