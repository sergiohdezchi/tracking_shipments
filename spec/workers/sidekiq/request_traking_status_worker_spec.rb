require 'rails_helper'
require 'sidekiq/testing'
Sidekiq::Testing.fake!

RSpec.describe Sidekiq::RequestTrakingStatusWorker, type: :worker do

  let(:test) { {carrier: 'fedex', tracking_number: '2342342342342'} }

  describe 'testing worker' do
    it 'ActionItemWorker jobs are enqueued in the scheduled queue' do
      described_class.perform_async(test[:carrier], test[:tracking_number])
      assert_equal 'default', described_class.queue
    end

    it 'goes into the jobs array for testing environment' do
      expect do
        described_class.perform_async(test[:carrier], test[:tracking_number])
      end.to change(described_class.jobs, :size).by(1)
      described_class.new.perform(test[:carrier], test[:tracking_number])
    end
  end
end