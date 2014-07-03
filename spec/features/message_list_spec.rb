require "spec_helper"

feature "Message List" do
  scenario "A user lists his or her received messages, newest first" do
    john = create(:user, name: "John")
    jane = create(:user, name: "Jane")
    jack = create(:user, name: "Jack")
    create(:message, :read, sender: john, recipient: jane,
      subject: "Hello.", created_at: 3.days.ago)
    create(:message, sender: jane, recipient: john,
      subject: "Re: Hello.", created_at: 2.days.ago)
    create(:message, :unread, sender: jack, recipient: jane,
      subject: "Hi!", created_at: 1.day.ago)

    log_in(jane)
    visit(messages_path)

    dom_messages = DOM::Message.all
    expect(dom_messages.count).to eq(2)
    expect(dom_messages[0].from).to eq("Jack")
    expect(dom_messages[0].to).to eq("Jane")
    expect(dom_messages[0].subject).to eq("Hi!")
    expect(dom_messages[0]).not_to be_read
    expect(dom_messages[1].from).to eq("John")
    expect(dom_messages[1].to).to eq("Jane")
    expect(dom_messages[1].subject).to eq("Hello.")
    expect(dom_messages[1]).to be_read
  end

  scenario "A user marks multiple messages as having been read" do
    user = create(:user)

    create(:message, :read, recipient: user, created_at: 4.days.ago)
    create(:message, :unread, recipient: user, created_at: 3.days.ago)
    create(:message, :unread, recipient: user, created_at: 2.days.ago)
    create(:message, :unread, recipient: user, created_at: 1.day.ago)

    log_in(user)
    visit(messages_path)

    dom_messages = DOM::Message.all
    expect(dom_messages[0]).not_to be_read
    expect(dom_messages[0]).not_to be_selected
    expect(dom_messages[1]).not_to be_read
    expect(dom_messages[1]).not_to be_selected
    expect(dom_messages[2]).not_to be_read
    expect(dom_messages[2]).not_to be_selected
    expect(dom_messages[3]).to be_read
    expect(dom_messages[3]).not_to be_selected

    dom_messages[0].select
    dom_messages[2].select
    click_button("Mark as Read")

    dom_messages = DOM::Message.all
    expect(dom_messages[0]).to be_read
    expect(dom_messages[0]).not_to be_selected
    expect(dom_messages[1]).not_to be_read
    expect(dom_messages[1]).not_to be_selected
    expect(dom_messages[2]).to be_read
    expect(dom_messages[2]).not_to be_selected
    expect(dom_messages[3]).to be_read
    expect(dom_messages[3]).not_to be_selected
  end

  scenario "A user must log in before viewing messages" do
    visit(messages_path)

    expect(DOM::Message.count).to be_zero
    expect(current_path).to eq(login_path)
  end
end
