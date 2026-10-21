;extends

;; hide \begin{}
(begin command:_ @begin_commmand name:(curly_group_text "{" @b1 "}" @b2)  (#set! conceal "")) 
;; hide \end{}
(end _  @end_command  (#set! conceal "")) 

;; replace \frac{1}{2}
((generic_command command:(command_name) @com_name
                  arg:(curly_group (text word: (word) @fracword1))
                  arg:(curly_group (text word: (word) @fracword2))
 ) @fraccomm 
 (#eq? @com_name "\\frac")( #eq? @fracword1 "1") (#eq? @fracword2 "2")
 ; (#set! @fraccomm conceal "½")
 )

; (inline_formula "$" @b5 _ @math "$" @b5
;  (#set! @b5 conceal ""))
;
; (displayed_equation "$$" @dm _ "$$" @dm
;  (#set! @dm conceal ""))
;
; (displayed_equation "\\[" @dm _ "\\]" @dm
;  (#set! @dm conceal ""))

;; replace \alpha
((generic_command command:(command_name) @com_name) (#eq? @com_name "\\alpha") (#set!   @com_name conceal "α" ))
((generic_command command:(command_name) @com_name) (#eq? @com_name "\\langle") (#set!  @com_name conceal "⟨" ))
((generic_command command:(command_name) @com_name) (#eq? @com_name "\\rangle") (#set!  @com_name conceal "⟩" ))
