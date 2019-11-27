@test "Verifica si rbenv 1.9.3-p327 existe en PATH" {
  run ls /home/vagrant/.rbenv/versions/1.9.3-p327
  [ "$status" -eq 0 ]
}
@test "Verifica si rbenv 2.1.0 existe en PATH" {
  run ls /home/vagrant/.rbenv/versions/2.1.0
  [ "$status" -eq 0 ]
}
