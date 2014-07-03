require "spec_helper"

feature "Authentication" do
  scenario "A user logs in successfully" do
    create(:user, username: "steve", password: "secret")

    visit(login_path)

    login_form = DOM::LoginForm.first
    login_form.username = "steve"
    login_form.password = "secret"
    login_form.submit

    expect(current_path).to eq(messages_path)
  end

  scenario "A user unsuccessfully attempts to log in" do
    create(:user, username: "steve", password: "secret")

    visit(login_path)

    login_form = DOM::LoginForm.first
    login_form.username = "steve"
    login_form.password = "password"
    login_form.submit

    expect(current_path).to eq(login_path)
    login_form = DOM::LoginForm.first
    expect(login_form.error).to be_present
    expect(login_form.message).not_to be_present
  end

  scenario "A user logs out" do
    user = create(:user, username: "steve", password: "secret")

    log_in(user)
    visit(messages_path)

    click_link("Log Out")

    expect(current_path).to eq(login_path)
    login_form = DOM::LoginForm.first
    expect(login_form.error).not_to be_present
    expect(login_form.message).to be_present
  end
end
