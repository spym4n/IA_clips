(defrule main
	(initial-fact)
	=>
	(printout t "####################################" crlf)
	(printout t "Sistema Especialista - Mecanica v1.0" crlf)
	(printout t "####################################" crlf crlf)
	(assert (rule1))
)

(defrule rule1
	=>
	(printout t crlf "?- O carro está ligando?" crlf)
	(bind ?tmp (read))
	(assert (carro-liga ?tmp))
)

(defrule rule2
	(carro-liga ?tmp)
	=>
	(if (eq ?tmp sim) then
		(printout t crlf "-> Verificando a natureza do problema envolvido" crlf)
		(printout t "?- Qual o tipo de problema está tendo com o veículo?" crlf)
		(printout t "1- carro falhando" crlf)
		(printout t "2- carro morrendo" crlf)
		(printout t "3- freios" crlf)
		(printout t "4- suspensão" crlf)
        	(bind ?tmp (read))
		(assert (tipo-problema ?tmp))
	else
		(printout t "-> Verificar as luzes do painel" crlf)
	)
)

(defrule rule3
	(carro-liga ?tmp)
	(tipo-problema ?tmp)
	=> 
	(if (eq ?tmp 1) then
		(printout  t "-> Carro Falhando" crlf)
	)
)
