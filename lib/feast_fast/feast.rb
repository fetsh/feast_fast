# coding: utf-8
module FeastFast
  class Feast

    module STATUS
      EASTER = 1
      TWELVE = 2
      GREAT  = 3
      COMMON = 4
    end

    attr_reader :status, :text

    def initialize(hsh={:status => 0, :text => "No feast today"})
      @status = hsh[:status]
      @text = hsh[:text]
    end

    def to_s
      @text + case @status
        when STATUS::GREAT
          ". (великий)"
        when STATUS::TWELVE
          ". (двунадесятый)"
        else
          ""
      end
    end
  end
end