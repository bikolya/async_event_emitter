require "async_event_emitter/version"
require "forwardable"

class AsyncEventEmitter
  class << self
    extend Forwardable
    def_delegators :instance, :notify, :observe, :events, :reset

    def instance
      @instance ||= new
    end
  end

  attr_reader :events

  def initialize
    @events = default_hash
  end

  def notify(event, data = {})
    events[event.to_sym].each do |subscriber:, **options|
      if options[:async]
        subscriber.delay.public_send(options[:method], data)
      else
        subscriber.public_send(options[:method], data)
      end
    end
  end

  def observe(event, subscriber, **options)
    events[event.to_sym] << {
      subscriber: subscriber,
      method: options.fetch(:method, event),
      async: options.fetch(:async, false)
    }
  end

  def reset
    @events = default_hash
  end

  private

  def default_hash
    Hash.new { |hash, key| hash[key] = [] }
  end
end

EventEmitter = AsyncEventEmitter
