#!/bin/sh
#
# init script for a Java application
#

# Check the application status
#
# This function checks if the application is running
RUNAS=pi
JAR_FILE=/vagrant/commandline-1.0.0.jar
PID_FILE=/var/log/commandline.log
PID_FILE=/var/run/commandline.pid

start() {
  if [ -f $PID_FILE ] && kill -0 $(cat $PID_FILE); then
    echo 'Service already running' >&2
    return 1
  fi
  echo 'Starting service…' >&2
  nohup ./script.sh >nohup.script 2>&1&
  local CMD="nohup java -jar $JAR_FILE &> \"$PID_FILE\" & echo \$!"
  su -c "$CMD" $RUNAS > "$PID_FILE"
  echo 'Service started' >&2
}

stop() {
  if [ ! -f "$PID_FILE" ] || ! kill -0 $(cat "$PID_FILE"); then
    echo 'Service not running' >&2
    return 1
  fi
  echo 'Stopping service…' >&2
  kill -15 $(cat "$PID_FILE") && rm -f "$PID_FILE"
  echo 'Service stopped' >&2
}

# Show the application status
status() {
  if [ -f $PID_FILE ] && kill -0 $(cat $PID_FILE); then
    echo 'Service running'
  else
    echo 'Service stopped'
  fi
}

# Main logic, a simple case to call functions
case "$1" in
  start)
    start
    ;;
  stop)
    stop
    ;;
  status)
    status
    ;;
  restart|reload)
    stop
    start
    ;;
  *)
    echo "Usage: $0 {start|stop|restart|reload|status}"
    exit 1
esac

exit 0