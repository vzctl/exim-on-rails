module Utils
  def run(*args)
    run0(nil, *args)
  end

  def runt(timeout, *args)
    t = Thread.new{Thread.current[:out] = run(*args)}
    unless t.join(timeout)
      Process.kill('KILL', -t[:pid])
    end
    t[:out]
  end

  def run0(stdin, *args)
    pid=nil
    file_in  = Tempfile.new('wai')
    file_out = Tempfile.new('wao')

    pid=Process.fork do
      Thread.critical=true

      Thread.list.each do |th|
        th.kill unless [Thread.main, Thread.current].include?(th)
      end

      STDOUT.reopen file_out
      STDERR.reopen file_out
      STDIN.reopen file_in

      ObjectSpace.each_object(IO) do |io|
        unless [STDIN, STDOUT, STDERR].include?(io)
          (io.close unless io.closed?) rescue nil
        end
      end

      Process.setpgid(0, Process.pid)

      exec *args.flatten rescue exec "true"
    end
    Thread.current[:pid] = pid

    file_in.write stdin if stdin
    file_in.close

    Process.wait pid

    str=IO.read(file_out.path)
    file_out.close! rescue nil
    file_in.unlink rescue nil

    str
  end

  def try_n_times(n, wait_time = 1)
    counter = 0
    while counter < n
      begin
        counter += 1
        Timeout.timeout wait_time do
          return yield
        end
      rescue Timeout::Error
        Kernel.sleep(1)
      end
    end
  end

end
