module Cheferize
  
  def to_chef
    
    # split string into words
    output = to_s.split( ' ' ).map do |word|
      cheferize( word )
    end
    output = output.join( ' ' )
    
    # randomly borkify after . or !
    
  end
  
  def cheferize( input )
    
    # return bork if word == bork
    

      
    # longest target string is 4 chars. never need to look further ahead than that.
    
    rules = [ :beginning_e, :beginning_o, :pass ]
    
    i=0
    output = ''
    
    while i < input.size do
      position = nil
      if i == 0
        position = :first
      elsif i == input.size
        position = :last
      end
      
      # apply rules to each character, breaking on the first one which returns output
      rules.each do |rule|
        subject = input[ (i..input.size) ]
        out = self.send( rule, subject, position )
        puts "#{i} #{subject} #{rule} returns #{out.inspect}"
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
    # A.->E (A followed by anything becomes E)
    # en$->ee
    # e not at the beginning, do nothing. Pointless?
    # th->tt
    # the->zee
    # v->f
    # w->v
    # passthrough
    
  # write one of these to implement every rule.
  # main loop calls each in turn.
  # first to return true wins.
  #   set @@next_char_idx to the next character to consider.
  #   add some output to @@word_in_progress
  #   return true
  # position :first, nil, :last
  
  # ^e->i
  def beginning_e( subject, position )
    return false if position != :first
    return [ 'i', 1 ] if subject[ 0,1 ] == 'e'
    return [ 'I', 1 ] if subject[ 0,1 ] == 'E'
  end
  
  # ^o->oo
  def beginning_o( subject, position )
    return false if position != :first
    return [ 'oo', 1 ] if subject[ 0,1 ] == 'o'
    return [ 'Oo', 1 ] if subject[ 0,1 ] == 'O'
  end
  
  def pass( subject, position )
    [ subject[ 0,1 ], 1 ]
  end
  
  # ew->oo, if not at the beginning
  def ew_oo( subject, position )
    return false if position == :first
    if subject[ 0,2 ] == 'ew'
      [ 'oo', 2 ]
    end
  end
  
  # e$->e-a, if at the end
  def ending_in_e( subject, position )
    return false if position != :last
    [ 'e-a', 1 ] if subject[ 0,1 ] == 'e'
  end
  
  # f->ff if not at the beginning
  def double_f( subject, position )
    return false if position == :first
    [ 'ff', 1 ] if subject[ 0,1 ] == 'f'
  end
end