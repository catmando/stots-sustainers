class App < HyperComponent
  include Hyperstack::Router

  # Heartbeat.  Detect if device has gone to sleep
  # But load the main data first, otherwise it may take
  # so long on the first request that we will timeout
  # and reload the page

  include Hyperstack::Component::IsomorphicHelpers

  before_first_mount do
    # @last_wakeup = Time.now
    # every(0.25) { check_wakeup }
  end

  class << self
    def pause_heartbeat
      puts "pausing heart beat"
      yield
    ensure
      @last_wakeup = Time.now
      puts "leaving pause heart beat time now = {@last_wakeup}"
    end

    def check_wakeup
      return unless @last_wakeup
      puts "checking wakeup"
      unless Time.now > @last_wakeup + 3.seconds
        puts "*********************** RELOADING AFTER SLEEP ****************************"
        `window.location.reload()`
        @last_wakeup = nil
      end
      @last_wakeup = Time.now
    end
  end

  # error fall back display while we are waiting for page reload.  See rescues block below
  def display_error
    Mui::Paper(id: :tp_display_error, elevation: 3, style: { margin: 30, padding: 10, fontSize: 30, color: :red }) do
      'Something went wrong, we will be back shortly!'
    end
  end

  render do
    return display_error if @display_error

    # dynamically set height so it works on mobile devices like iphone / safari
    # which does not use 100vh properly.

    DIV(class: :box, style: { height: WindowDims.height+1 }) do
      Header()
      Switch() do
        Route('/home',            mounts: PWA.ready_to_update? ? Reloading : Home)
        Route('/give')            { Give(key: 'its-the-same') }
        Route('*')                { mutate Redirect('/home') }
      end
      Footer() unless App.location.pathname == '/'
    end
  end

  rescues do |error, info|
    return if Hyperstack.env.development?

    # send the error to the server log, and then reload the page
    ReportError.run(message: error.message, backtrace: error.backtrace, info: info)
    `window.location.href = '/home'`
    # react needs to see some state change so it knows we won't keep in an endless loop
    mutate @display_error = true
  end

  # check for any pwa updates on boot and every 10 minutes after
  after_mount do
    PWA.check_for_updates!
    every(10.minutes) { PWA.check_for_updates! }
  end
end
