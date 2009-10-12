(defrule main
	(initial-fact)
	=>
	(printout t "####################################" crlf)
	(printout t "Sistema Especialista - Mecanica v1.0" crlf)
	(printout t "####################################" crlf crlf)
	(printout t crlf "-> Verificando a natureza do problema envolvido" crlf)
	(printout t "?- Qual o tipo de problema está tendo com o veículo?" crlf)
	(printout t "1- Não Liga" crlf)
	(printout t "2- Superaquecimento" crlf)
	(printout t "3- Luz do óleo acendendo" crlf)
	(printout t "4- Carro Falhando" crlf)
	(printout t "5- Carro Morrendo" crlf)
	(printout t "6- Problema no freio" crlf)
	;(printout t crlf "?- O carro está ligando?" crlf)
	;(bind ?tmp (read))
	(assert (menu (read)))
)

(defrule naoLiga
	(menu 1)
	=>
	(printout t "-> Qual o estado da bateria? " crlf)
	(assert (carro(bateria (read))))
)

(defrule eletrica "Iniciando Verificacao Eletrica"
	(carro(bateria ?bat))
	=>
	(printout t "A bateria esta atualmente -> " ?bat crlf)
)

(defrule checkBateria
	(carro(bateria ?bat))
	=>
	(if (eq ?bat yes) then
		(printout t "-> Verificar a Vela e Bobina" crlf)
		(printout t "A Vela e Bobina estão boas? " crlf)
		(assert (carro(vela-bobina (read))))
	else
		(if (eq ?bat no) then
			(printout t "-> A Bateria descarregou nas ultimas semanas?" crlf)
		)
		;(assert (carro(bateria (read))))
	)
)
