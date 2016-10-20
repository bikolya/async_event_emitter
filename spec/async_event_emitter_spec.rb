require "spec_helper"

describe AsyncEventEmitter do
  before do
    described_class.reset
  end

  describe '#observe' do
    subject { described_class.observe(event, subscriber, options) }
    let(:event) { :some_event }
    let(:subscriber) { double(:subscriber) }

    context 'when there are no custom options' do
      let(:options) { Hash.new }

      it 'adds new subscriber for events collection' do
        subject
        expect(described_class.events).to eq({
          some_event: [{
            subscriber: subscriber,
            method: event
          }]
        })
      end
    end

    context 'when subscriber specifies another message to receive' do
      let(:options) do
        { method: :another_method }
      end

      it 'adds new subscriber for events collection' do
        subject
        expect(described_class.events).to eq({
          some_event: [{
            subscriber: subscriber,
            method: :another_method
          }]
        })
      end
    end
  end

  describe '#notify' do
    subject { described_class.notify(event, data) }
    let(:event) { :some_event }
    let(:data) do
      { order_id: 1 }
    end
    let(:subscriber) { double(:subscriber) }
    let(:subscriber_custom_method) { double(:subscriber_custom_method) }

    before do
      described_class.observe(event, subscriber)
      described_class.observe(event, subscriber_custom_method, method: :another_method)
    end

    it 'notifies subscribers' do
      expect(subscriber).to receive(:some_event).with(data)
      expect(subscriber_custom_method).to receive(:another_method).with(data)
      subject
    end
  end

  describe '#reset' do
    subject { described_class.reset }
    let(:event) { :some_event }
    let(:subscriber) { double(:subscriber) }

    before do
      described_class.observe(event, subscriber)
    end

    it 'resets events collection' do
      expect(described_class.events).not_to eq({})
      subject
      expect(described_class.events).to eq({})
    end
  end
end
