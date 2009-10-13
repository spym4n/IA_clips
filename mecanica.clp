(defrule main
	(initial-fact)
	=>
	(printout t "####################################" crlf)
	(printout t "Sistema Especialista - Mecanica v1.0" crlf)
	(printout t "####################################" crlf crlf)
	(printout t "?- O veículo funciona ao acionar a ignição?" crlf)
	(printout t "1- Sim" crlf)
	(printout t "2- Não" crlf)

	;(printout t crlf "-> Verificando a natureza do problema envolvido" crlf)
	;(printout t "?- Qual o tipo de problema está tendo com o veículo?" crlf)
	;(printout t "2- Superaquecimento" crlf)
	;(printout t "3- Luz do óleo acendendo" crlf)
	;(printout t "4- Carro Falhando" crlf)
	;(printout t "5- Carro Morrendo" crlf)
	;(printout t "6- Problema no freio" crlf)
	;(printout t crlf "?- O carro está ligando?" crlf)
	;(bind ?tmp (read))
	(assert (menu (read)))
)

(defrule liga
	(menu 1)
	=>
	(printout t "-> Verificar luzes no painel." crlf)
	(printout t "?- Qual luz está acendendo?" crlf)
	(printout t "1- Luz do painel" crlf)
	(printout t "2- Luz do óleo" crlf)
	(printout t "3- Luz do combustível" crlf)
	(printout t "4- Nenhuma luz acende" crlf)
	(assert (carro(luz (read))))
)

(defrule luzPainel
        (carro(luz ?luz))
        =>
	(if (eq ?luz 1) then
        	(printout t "-> Verificar luzes no painel." crlf)
        	(printout t "?- Qual luz está acendendo?" crlf)
        	(printout t "1- Luz do painel" crlf)
        	(printout t "2- Luz do óleo" crlf)
        	(printout t "3- Luz do combustível" crlf)
        	(printout t "4- Nenhuma luz acente" crlf)
        	(assert (carro(bateria (read)))))
	
)

(defrule luzOleo
        (carro(luz ?luz))
        =>
        (if (eq ?luz 2) then
                (printout t "-> Verificar luzes no painel." crlf)
                (printout t "?- Qual luz está acendendo?" crlf)
                (printout t "1- Luz do painel" crlf)
                (printout t "2- Luz do óleo" crlf)
                (printout t "3- Luz do combustível" crlf)
                (printout t "4- Nenhuma luz acente" crlf)
                (assert (carro(bateria (read)))))

)

(defrule luzCombustivel
        (carro(luz ?luz))
        =>
        (if (eq ?luz 3) then
                (printout t "-> Verificar luzes no painel." crlf)
                (printout t "?- Qual luz está acendendo?" crlf)
                (printout t "1- Luz do painel" crlf)
                (printout t "2- Luz do óleo" crlf)
                (printout t "3- Luz do combustível" crlf)
                (printout t "4- Nenhuma luz acente" crlf)
                (assert (carro(bateria (read)))))

)

(defrule nenhumaLuz
        (carro(luz ?luz))
        =>
        (if (eq ?luz 4) then
                (printout t "-> Verificar Parte Elétrica." crlf)
		(printout t "-> Verificar se a bateria está com carga e regulada, utilizando um múltimetro." crlf)
                (printout t "?- A bateria apresenta problemas?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
		(assert (carro(bateria (read)))))

)

(defrule problemaBateria
        (carro(bateria ?bat))
        =>
        (if (eq ?bat 1) then
                (printout t "-> Verificar Tipo da Bateria." crlf)
                (printout t "?- A bateria é com água?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
		(assert (carro(tipobateria (read))))
	 else
                (if (eq ?bat 2) then
                        (printout t "-> Verificar porque a bateria está descarregando. " crlf)
                	(printout t "?- O alternador está conseguindo carregar a bateria?" crlf)
			(printout t "!- sim ou nao " crlf)
			(assert (carro(alternador (read))))
		)
        )
)

(defrule tipoBateria
        (carro(tipobateria ?tbat))
        =>
        (if (eq ?tbat 1) then
                (printout t "-> Colocar água na bateria." crlf)
                (printout t "?- A bateria continua com problema?" crlf)
              	(printout t "1- Sim" crlf)
                (printout t "2- Não" crlf) 
                (assert (carro(contbateria (read))))
         else
                (if (eq ?tbat 2) then
                        (printout t "-> Trocar a bateria. " crlf)
                )
	)
)

(defrule continuaProblemaBateria
        (carro(contbateria ?cbat))
        =>
        (if (eq ?cbat 1) then
        (printout t "-> Trocar a bateria. " crlf)	 
	 else
                (if (eq ?cbat 2) then
                        (printout t "-> Problema resolvido. " crlf)
                )
	)
)

(defrule naoLiga
        (menu 2)
        =>
        (printout t "-> Qual o estado da bateria? " crlf)
        ;(assert (carro(bateria (read))))
)


