module Cheferize
  # A ChefString provides an additional public method for String.  in_same_case_as.
  class ChefString
    instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }

    def initialize(str)
      @target = str
    end

    # return target string, transformed into the same case as the first character of target.
    def in_same_case_as(target)
      to_case(@target, get_case(target))
    end

    def get_case(letter)
      code = letter.codepoints[0]
      if code > 96 && code < 123
        :lower
      elsif code > 64 && code < 91
        :upper
      else
        :non_alpha
      end
    end

    def to_case(letter, sym)
      case sym
      when :upper
        letter.upcase
      when :lower
        letter.downcase
      else
        letter
      end
    end

    protected

    # proxy any remaining calls to the underlying string.
    def method_missing(name, *args, &block)
      @target.send(name, *args, &block)
    end
  end
end
