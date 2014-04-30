module DOM
  class Message < Domino
    selector ".message"

    attribute :from
    attribute :to
    attribute :subject

    def read?
      node["class"].split.include?("read")
    end
  end
end
