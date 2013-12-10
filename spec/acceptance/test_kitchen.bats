#!/usr/bin/env bats

load test_helper

@test "Vagrantfile with :test_kitchen enabled does not blow up when bringing the VM up" {
  configure_env "test-kitchen.rb"
  vagrant_up
  [ "$status" -eq 0 ]
  vagrant_destroy
}
