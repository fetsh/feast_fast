module FeastFast
  class Feast

    attr_reader :text, :status

    def initialize(hsh={:status => 0, :text => "No feast today"})
      @status = hsh[:status]
      @text = hsh[:text]
    end
  end
end