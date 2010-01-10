module Cheferize
  
  def to_chef
    # split string into words
    
    # randomly borkify after . or !
    
    # encheferize each word
    
    # return result
  end
  
  def cheferize( word )
    # return bork if word == bork
    
    # General rules
    # after a replacement occurs, skip to the next source character.  (only 1 transformation per letter)
    # if a multi-char test matches, skip over to the next chars. 'few' matches 'ew->oo'.  Then we're done.
    
    # foreach char in word
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
      
      # longest target string is 4 chars. never need to look further ahead than that.
      i=0
      subject="testify"
      while i<subject.size do
        puts subject[ (i..i+3) ]
        i += 1
      end
      #
      # test
      # esti
      # stif
      # tify
      # ify
      # fy
      # y
      
      # build index of target strings, and transformations to perform on them when found. lambdas?
      
      # write one of these to implement every rule.
      # main loop calls each in turn.
      # first to return content wins.
      def rule( subject, first, last, seen_i )
        
      end
      
  end
  
end