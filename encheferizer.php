<?php
#########################################################
#                                                       #
#  PHP Encheferizer 0.9 (20-5-2003)                     #
#  Convert English to Mock Swedish.                     #
#  Ported to PHP by eamelink (Erik Bakker)              #
#  PHP Encheferizer website : http://bork.eamelink.nl   #
#                                                       #     
#  Based on the original chef.x from John Hagerman.     #
#  More info about the original chef.x :                #
#  http://tbrowne.best.vwh.net/chef/                    #
#                                                       #
#  Works like :                                         #
#    $chef = new encheferizer();                        #
#    $swedish = $chef->encheferize($string);            #
#                                                       #
#########################################################
class encheferizer
{
    function encheferizer() {}

    function encheferize($string)
    {
        $delimiters = " \n\t\\,<.>/?;:'\"[{]}|=+-_!@#$%^&*()~`";
        $newline = "";
        $word = "";
        for($i = 0; $i < strlen($string); $i++){
            $s = substr($string, $i, 1);
                                      
            if(($position = strstr($delimiters, $s)) === false){ 

                $word .= $s;
  
             } else {
                if(!empty($word)){
                    $newline .= $this->encheferizeWord($word);
                    $word = "";
                }
                if($s == "." || $s == "!"){
                    if(rand(0,3) == 1){  
                        $newline .= ", Bork Bork Bork!";
                        
                    } else {
                        $newline .= ".";
                    }
                } else {
                    $newline .= $s;
                }
            }
        }
        $newline .= $this->encheferizeWord($word);
        return $newline;    
    }
    
    function encheferizeWord($word)
    {
        if(strtolower($word) == "bork"){
            return $word;
        }
        $newword = "";    

        $i = 0;
        while($i < strlen($word)){
            $char = substr($word, $i, 1);
            $isLast = ($i == strlen($word) - 1) ? true : false;   
            $iSeen = false;
            if($i == 0){ 
                switch($char){
                case "e":
                    $newword = "i";
                    $i++;
                    continue 2;
                    break;
                case "E":
                    $newword = "I";
                    $i++;
                    continue 2;
                    break;
                case "o":
                    $newword = "oo";
                    $i++;
                    continue 2;
                    break;
                case "O":
                    $newword = "Oo";
                    $i++;
                    continue 2;
                    break;
                }
                
            } else {
                if($char == "e"){
                    if(!$isLast && substr($word, $i + 1, 1) == "w"){
                        $newword .= 'oo';
                        
                        $i+=2; 
                        continue;
                    } elseif($isLast){
                        $newword .= 'e-a';
                        $i++;
                        continue;
                    }
                    
                } elseif($char == "f"){
                    $newword .= "ff"; 
                    $i++;
                    continue;
                } elseif($char == "i"){
                    if(!$isLast && substr($word, $i + 1, 1) == "r"){
                        $newword .= "ur";
                        $i+=2;
                        continue;
                    } elseif(!$iSeen){
                        $newword .= "ee";
                        $i++;
                        
                        $iSeen = true;
                        continue;
                    }
                } elseif($char == "o"){
                    if(!$isLast && substr($word, $i + 1, 1) == "w"){
                        $newword .= "oo";
                        $i+=2;
                        continue;
                    } else {
                        $newword .= "u";
                        $i++;
                        continue;
                    }
                } elseif($i <= strlen($word - 4) && $char == "t" && substr($word, $i + 1, 1) == "i" 
                            && substr($word, $i + 2, 1) == "o" && substr($word, $i + 3, 1) == "n"){  // Caption -> Capshun
                    $newword .= "shun";
                    $i += 4;
                    continue;
                } elseif($char == "u"){
                    $newword .= "oo";
                    $i++;
                    continue;
                } elseif($char == "U"){
                    $newword .= "Oo";
                    $i++;
                    continue;
                }
            } // En of In-word rules
            // Things that may be replaced anywhere
            if($char == "A"){
                if(!$isLast && substr($word, $i+1, 1) == "n"){
                    $newword .= "Un";
                    $i+=2;
                    continue;
                } elseif(!$isLast && substr($word, $i+1, 1) == "u"){
                    $newword .= "Oo";
                    $i+=2;
                    continue;
                } elseif(!$isLast){
                    $newword .= "E";
                    $i++;
                    continue;
                } 
            } elseif($char == "a"){
                if(!$isLast && substr($word, $i+1, 1) == "n"){
                    $newword .= "un";
                    $i+=2;
                    continue;
                } elseif(!$isLast && substr($word, $i+1, 1) == "u"){
                    $newword .= "oo";
                    $i+=2;
                    continue;
                } elseif(!$isLast){
                    $newword .= "e";
                    $i++;
                    continue;
                } 
            } elseif($char == "e"){
                if(!$isLast && substr($word, $i+1, 1) == "n" && $i == strlen($word) - 2){
                    $newword .= "ee";
                    $i+=2;
                    continue;
                } elseif ($i > 0){
                    // Do nothing
                    
                }
            } elseif($char == "t"){
                if($i == strlen($word) -2 && substr($word, $i+1, $i) == "h"){
                    $newword .= "t";
                    $i+=2;
                    continue;
                } elseif($i <= strlen($word) - 3 && substr($word, $i+1, 1) == "h" && substr($word, $i+2, 1) == "e"){
                    $newword .= "zee";
                    $i+=3;
                    continue;
                }
            } elseif($char == "T" && $i<= strlen($word)-3 && substr($word, $i+1, 1) == "h"
                        && substr($word, $i+2, 1) == "e"){
                $newword .= "Zee";
                $i +=3;
                continue;
                
            } elseif($char == "v"){
                $newword .= "f";
                $i++;
                continue;
            } elseif($char == "V"){
                $newword .= "F";
                $i++;
                continue;
            } elseif($char == "w"){
                $newword .= "v";
                $i++;
                continue;
            } elseif($char == "W"){
                $newword .= "V";
                $i++;
                continue;
            } 
            
            $newword .= $char;
            $i++;   
                
                
                
        } // End of FOR lus
        
        return $newword;
    }
}
?>   