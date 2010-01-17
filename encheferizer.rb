# Usage:
# Cheferize can be included into any class which responds to to_s.  
# It adds a method to_chef.
# class String
#   include Cheferize
# end
# 
# >> "This is a test!".to_chef
# => "Tees is e test!"
#
# These are applied sequentially to each character in the source string until 1 matches.
module Cheferize
  
  def to_chef
    # split string into words
    # TODO : punctuation will break rules which assert :last position.
    output = to_s.split( ' ' ).map do |word|
      cheferize_word( word )
    end
    output.join( ' ' )
  end
  
  def cheferize_word( input )
    
    i=0
    output = ''
    # see rule "interior ir becomes ur, or first-occurring interior i becomes ee"
    @chef_saw_an_i = nil
    
    while i < input.size do
      # a single character will be :first but not :last.
      position = nil
      if i == 0
        position = :first
      elsif i == ( input.size - 1 )
        position = :last
      end
      
      # apply rules to each character, breaking on the first one which returns output
      # for the word 'testify', the rules will see 'testify', 'estify', 'stify', 'tify', etc...
      subject = input[ i..(input.size-1) ]
      
      Cheferize.rules.each do |rule|
        out = self.send( rule, subject, position )
        # uncomment to see to_chef in action.
        #puts "#{subject} #{' ('+position.to_s+') ' if position}: '#{rule.to_s}' returns '#{out.inspect}'"
        if out
          output += out[ 0 ]
          i += out[ 1 ]
          break
        end
      end
    end
    
    output
  end
  
  # General rules
  # after a replacement occurs, skip to the next source character.  (only 1 transformation per letter)
  # if a multi-char test matches, skip over to the next chars. 'few' matches 'ew->oo'.  Then we're done.
  
  # for first char
    # ^e->i
    # ^o->oo
  # for non-first chars
    # ew->oo
    # e$->e-a
    # f->ff
    # ir->ur, or i->ee if no i has occurred.
    # ow->oo or o->u
    # tion -> shun
    # u->oo

  # An->Un
  # Au->Oo
  # A.->E (A not at the end becomes E)
  # en$->ee
  # e not at the beginning, do nothing. Pointless?
  # th->tt
  # the->zee
  # v->f
  # w->v
  # pass
  
  # Define a transformation rule.
  # Block must accept subject & position parameters.
  def self.rule( name, &block )
    @rules ||= []
    sym = name.to_sym
    @rules << sym
    define_method( sym, block )
  end

  # Shows the transliteration rules.
  def self.rules
    @rules
  end
  
  # no recursive cheferizing yet.
  rule "pass the bork" do |subject, position|
    [ subject, 4 ] if position == :first && subject[ 0,4 ].downcase == 'bork'
  end
  
  rule "randomly borkify after . or !" do |subject, position|
    if position == :last && ( subject[ 0,1 ] == '.' || subject[ 0,1 ] == '!' ) && rand( 3 ) == 0
      [ ', bork bork bork!', 1 ]
    end
  end
  
  # ^e->i
  rule "initial e becomes i" do |subject, position|
    if position == :first && subject[ 0,1 ].downcase == 'e'
      [ ChefString.new( 'i' ).in_same_case_as( subject[ 0,1 ] ), 1 ]
    end
  end
  
  # ^o->oo
  rule "initial o becomes oo" do |subject, position|
    if position == :first && subject[ 0,1 ].downcase == 'o'
      [ ChefString.new( 'o' ).in_same_case_as( subject[ 0,1 ] ) + 'o', 1 ]
    end
  end
  
  # ew->oo, if not at the beginning
  rule "interior ew becomes oo" do |subject, position|
    [ 'oo', 2 ] if position != :first && subject[ 0,2 ] == 'ew'
  end
  
  # e$->e-a, if at the end
  rule "final e becomes e-a" do |subject, position|
    [ 'e-a', 1 ] if position == :last && subject[ 0,1 ] == 'e'
  end
  
  # f->ff if not at the beginning
  rule "interior f becomes ff" do |subject, position|
    [ 'ff', 1 ] if position != :first && subject[ 0,1 ] == 'f'
  end
  
  # ir->ur, or i->ee if no i has occurred.
  rule "interior ir becomes ur, or first-occurring interior i becomes ee" do |subject, position|
    if position != :first
      if subject[ 0,2 ] == 'ir'
        [ 'ur', 2 ]
      elsif subject[ 0,1 ] == 'i' && ! @chef_saw_an_i
        @chef_saw_an_i = true
        [ 'ee', 1 ]
      end
    end
  end
  
  # ow->oo or o->u
  rule "ow becomes oo, or o becomes u" do |subject, position|
    if position != :first
      if subject[ 0,2 ] == 'ow'
        [ 'oo', 2 ]
      elsif subject[ 0,1 ] == 'o'
        [ 'u', 1 ]
      end
    end
  end
  
  # tion -> shun
  rule "tion becomes shun" do |subject, position|
    if position != :first && subject[ 0,4 ] == 'tion'
      [ 'shun', 4 ]
    end
  end
  
  # u->oo
  rule "interior u becomes oo" do |subject, position|
    if position != :first && subject[ 0,1 ] == 'u'
      [ 'oo', 1 ]
    end
  end
  
  # An->Un, an->un
  rule "an becomes un" do |subject, position|
    if subject[ 0,2 ].downcase == 'an'
      [ ChefString.new( 'u' ).in_same_case_as( subject[ 0,1 ] ) + 'n', 2 ]
    end
  end
  
  # Au->Oo, au->oo
  rule "au becomes oo" do |subject, position|
    if subject[ 0,2 ].downcase == 'au'
      [ ChefString.new( 'o' ).in_same_case_as( subject[ 0,1 ] ) + 'o', 2 ]
    end
  end
  
  # A.->E (A not at the end becomes E)
  rule "non-final a becomes e" do |subject, position|
    if position != :last && subject[ 0,1 ].downcase == 'a'
      [ ChefString.new( 'e' ).in_same_case_as( subject[ 0,1 ] ), 1 ]
    end
  end
  
  # en$->ee
  rule "final en becomes ee" do |subject, position|
    if position != :first && subject == 'en'
      [ 'ee', 2 ]
    end
  end
  
  # e not at the beginning, do nothing. Pointless?
  
  # the->zee
  rule "the becomes zee" do |subject, position|
    if subject[ 0,3 ].downcase == 'the'
      [ ChefString.new( 'z' ).in_same_case_as( subject[ 0,1 ] ) + 'ee', 3 ]
    end
  end
  
  # th->t
  rule "th becomes t" do |subject, position|
    if subject[ 0,2 ].downcase == 'th'
      [ ChefString.new( 't' ).in_same_case_as( subject[ 0,1 ] ), 2 ]
    end
  end
  
  # v->f
  rule "v becomes f" do |subject, position|
    if subject[ 0,1 ].downcase == 'v'
      [ ChefString.new( 'f' ).in_same_case_as( subject[ 0,1 ] ), 1 ]
    end
  end
  
  # w->v
  rule "w becomes v" do |subject, position|
    if subject[ 0,1 ].downcase == 'w'
      [ ChefString.new( 'v' ).in_same_case_as( subject[ 0,1 ] ), 1 ]
    end
  end
  
  rule "pass on anything else" do |subject, position|
    [ subject[ 0,1 ], 1 ]
  end
  
  # A ChefString provides an additional public method for String.  in_same_case_as.
  class ChefString
    instance_methods.each { |m| undef_method m unless m =~ /(^__|^send$|^object_id$)/ }

    def initialize( str )
      @target = str
    end

    # return target string, transformed into the same case as the first character of target.
    def in_same_case_as( target )
      to_case( @target, get_case( target ) )
    end

    def get_case( letter )
      code = letter[ 0 ]
      if code > 96 && code < 123
        :lower
      elsif code > 64 && code < 91
        :upper
      else
        :non_alpha
      end
    end

    def to_case( letter, sym )
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