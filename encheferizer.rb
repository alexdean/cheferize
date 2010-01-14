class String
  def in_same_case_as( target )
    to_case( self, get_case( target ) )
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
end

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
    
    rules = [ :pass_the_bork, :beginning_e, :beginning_o, :interior_ew_to_oo, :final_e_to_ea, :interior_f_to_ff, :interior_i, 
      :interior_o, :tion_to_shun, :interior_u, :an_to_un, :au_to_oo, :non_final_a_to_e, :final_en_to_ee, :the_to_zee,
      :th_to_t, :v_to_f, :w_to_v, :pass ]
    
    
    
    i=0
    output = ''
    @chef_saw_an_i = nil
    
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
        #puts "#{i} #{subject} #{rule} returns #{out.inspect}"
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
  
  def pass_the_bork( subject, position )
    return subject if position == :first && subject[ 0,4 ].downcase == 'bork'
  end
  
  # ^e->i
  def beginning_e( subject, position )
    if position == :first
      return [ 'i', 1 ] if subject[ 0,1 ] == 'e'
      return [ 'I', 1 ] if subject[ 0,1 ] == 'E'
    end
  end
  
  # ^o->oo
  def beginning_o( subject, position )
    if position == :first
      return [ 'oo', 1 ] if subject[ 0,1 ] == 'o'
      return [ 'Oo', 1 ] if subject[ 0,1 ] == 'O'
    end
  end
  
  # ew->oo, if not at the beginning
  def interior_ew_to_oo( subject, position )
    [ 'oo', 2 ] if position != :first && subject[ 0,2 ] == 'ew'
  end
  
  # e$->e-a, if at the end
  def final_e_to_ea( subject, position )
    [ 'e-a', 1 ] if position == :last && subject[ 0,1 ] == 'e'
  end
  
  # f->ff if not at the beginning
  def interior_f_to_ff( subject, position )
    [ 'ff', 1 ] if position != :first && subject[ 0,1 ] == 'f'
  end
  
  # ir->ur, or i->ee if no i has occurred.
  def interior_i( subject, position )
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
  def interior_o( subject, position )
    if position != :first
      if subject[ 0,2 ] == 'ow'
        [ 'oo', 2 ]
      elsif subject[ 0,1 ] == 'o'
        [ 'u', 1 ]
      end
    end
  end
  
  # tion -> shun
  def tion_to_shun( subject, position )
    if position != :first && subject[ 0,4 ] == 'tion'
      [ 'shun', 4 ]
    end
  end
  
  # u->oo
  def interior_u( subject, position )
    if position != :first && subject[ 0,1 ] == 'u'
      [ 'oo', 1 ]
    end
  end
  
  # An->Un, an->un
  def an_to_un( subject, position )
    if subject[ 0,2 ].downcase == 'an'
      [ 'u'.in_same_case_as( subject[ 0,1] ) + 'n', 2 ]
    end
  end
  
  # Au->Oo, au->oo
  def au_to_oo( subject, position )
    if subject[ 0,2 ].downcase == 'au'
      [ 'o'.in_same_case_as( subject[ 0,1] ) + 'o', 2 ]
    end
  end
  
  # A.->E (A not at the end becomes E)
  def non_final_a_to_e( subject, position )
    if position != :last && subject[ 0,1 ].downcase == 'a'
      [ 'e'.in_same_case_as( subject[ 0,1] ), 1 ]
    end
  end
  
  # en$->ee
  def final_en_to_ee( subject, position )
    if position != :first && subject == 'en'
      [ 'ee', 2 ]
    end
  end
  
  # e not at the beginning, do nothing. Pointless?
  
  # the->zee
  def the_to_zee( subject, position )
    if subject[ 0,3 ].downcase == 'the'
      [ 'z'.in_same_case_as( subject[ 0,1] ) + 'ee', 3 ]
    end
  end
  
  # th->t
  def th_to_t( subject, position )
    if subject[ 0,2 ].downcase == 'th'
      [ 't'.in_same_case_as( subject[ 0,1] ), 2 ]
    end
  end
  
  # v->f
  def v_to_f( subject, position )
    if subject[ 0,1 ].downcase == 'v'
      [ 'f'.in_same_case_as( subject[ 0,1] ), 1 ]
    end
  end
  
  # w->v
  def w_to_v( subject, position )
    if subject[ 0,1 ].downcase == 'w'
      [ 'v'.in_same_case_as( subject[ 0,1] ), 1 ]
    end
  end
  
  def pass( subject, position )
    [ subject[ 0,1 ], 1 ]
  end
  
end