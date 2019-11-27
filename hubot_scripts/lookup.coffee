exec = require('child_process').exec

execCommand = (msg, cmd) ->
  exec cmd, (error, stdout, stderr) ->
    msg.send error
    msg.send stdout
    msg.send stderr

module.exports = (robot) ->
  robot.respond /host lookup (.*)$/i, (msg) ->
    hostname = msg.match[1]
    command = "host #{hostname}"
    execCommand msg, command

