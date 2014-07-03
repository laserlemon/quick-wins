require "spec_helper"

describe "Message List Performance", type: :feature do
  let!(:user) { create(:user) }

  before do
    create_list(:message, 1_000, recipient: user)

    log_in(user)
  end

  def measure(&block)
    time = Benchmark.realtime(&block)
    RSpec.current_example.description << " (#{time})"
  end

  it "is fast!" do
    measure do
      # Visit the page
      visit(messages_path)

      10.times do |i|
        # Refresh the page twice
        2.times { visit(current_path) }

        # See the messages
        dom_messages = DOM::Message.all

        # Select the first 10 unread messages
        dom_messages.slice(i * 100, 100).each(&:select)

        # Mark the selected messages as read
        click_button("Mark as Read")
      end # Rinse, repeat
    end
  end
end
