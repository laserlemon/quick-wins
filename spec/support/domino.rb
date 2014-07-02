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
end
