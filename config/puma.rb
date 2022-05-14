# frozen_string_literal: true

max_threads_count = 5
min_threads_count = 5
threads min_threads_count, max_threads_count
port 9292
environment :production
pidfile 'tmp/pids/server.pid'

# Allow puma to be restarted by `bin/rails restart` command.
plugin :tmp_restart
