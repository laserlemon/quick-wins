module DOM
  class Message < Domino
    selector ".message"

    attribute :from
    attribute :to
    attribute :subject

    def read?
      node["class"].split.include?("read")
    end

    def selected?
      checkbox ? checkbox.checked? : false
    end

    def select
      checkbox.set(true)
    end

    private

    def checkbox
      @checkbox ||= node.first("input[type=checkbox]")
    end
  end

  class LoginForm < Domino
    selector "#login-form"

    attribute :error, ".alert-danger"
    attribute :message, ".alert-success"

    def username
      find_field("username").value
    end

    def username=(value)
      find_field("username").set(value)
    end

    def password
      find_field("password").value
    end

    def password=(value)
      find_field("password").set(value)
    end

    def submit
      click_button("Log In")
    end
  end
end
