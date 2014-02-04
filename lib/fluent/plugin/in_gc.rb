# encoding: UTF-8
class Fluent::GcInput < Fluent::Input
  Fluent::Plugin.register_input('gc', self)

  # To support log_level option implemented by Fluentd v0.10.43
  unless method_defined?(:log)
    define_method("log") { $log }
  end

  config_param :disable, :bool, :default => false
  config_param :interval, :time, :default => 5
  config_param :debug, :bool, :default => false
  attr_accessor :last_checked

  def configure(conf)
    super

    @interval = @interval.to_i
  end

  def start
    super
    GC.disable if @disable
    @watcher = Thread.new(&method(:watcher))
  end

  def shutdown
    super
    @watcher.terminate
    @watcher.join
  end

  # thread callback
  def watcher
    @last_checked = Fluent::Engine.now
    while true
      sleep 0.5
      begin
        if Fluent::Engine.now - @last_checked >= @interval
          now = Fluent::Engine.now
          start_gc
          @last_checked = now
        end
      rescue => e
        log.warn "#{e.class} #{e.message} #{e.backtrace.first}"
      end
    end
  end

  def start_gc
    log.info "gc: before #{GC.stat}" if @debug # intentionally info level
    disabled = GC.enable
    GC.start
    GC.disable if disabled
    log.info "gc: after  #{GC.stat}" if @debug
  end
end
