# coding: utf-8
module FeastFast
  class Fast

    module STATUS
      NO     = 0
      LOOSE  = 1
      COMMON = 2
      STRICT = 3
    end

    attr_reader :status, :text

    def initialize(hsh={:status => STATUS::NO, :text => nil})
      @status = hsh[:status]
      @text = get_text(hsh[:text])
    end

    def to_s
      @text
    end

    def == fast
      self.status == fast.status && self.text == fast.text
    end

    private

      def get_text(hsh_text)
        text = case @status
          when STATUS::LOOSE
            "Пища без мяса"
          when STATUS::COMMON
            "Постный день"
          when STATUS::STRICT
            "Строгий пост"
          when STATUS::NO
            "Нет поста"
        end
        text = "#{hsh_text.chomp('.')}. #{text}" if hsh_text
        text
      end

  end
end