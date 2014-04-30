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
      checkbox.checked?
    end

    def select
      checkbox.set(true)
    end

    private

    def checkbox
      @checkbox ||= node.find("input[type=checkbox]")
    end
  end
end
