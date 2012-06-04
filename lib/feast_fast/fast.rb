# coding: utf-8
module FeastFast
  class Fast

    STATUS = {
      :STRICT => 3,
      :COMMON => 2,
      :LOOSE  => 1,
      :NO     => 0
    }

    attr_reader :status, :text

    def initialize(hsh={:status => STATUS[:NO], :text => nil})
      @status = hsh[:status]
      @text = get_text(hsh[:text])
    end

    def get_text(hsh_text)
      text = case @status
        when STATUS[:LOOSE]
          "Пища без мяса"
        when STATUS[:COMMON]
          "Постный день"
        when STATUS[:STRICT]
          "Строгий пост"
        when STATUS[:NO]
          "Нет поста"
      end
      text = "#{hsh_text.chomp('.')}. #{text}" if hsh_text
      text
    end

  end
end