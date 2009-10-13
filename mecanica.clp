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
			(printout t "1- Sim" crlf)
			(printout t "2- Não" crlf)
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

(defrule alternadorFunciona
        (carro(alternador ?alt))
        =>
        (if (eq ?alt 1) then
                (printout t "-> Verificar se há algum componente elétrico roubando carga da bateria." crlf)
                (printout t "?- Há algum equipamento roubando carga?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(componente (read))))
         else
                (if (eq ?alt 2) then
                        (printout t "-> Verificar a correia do alternador. " crlf)
			(printout t "?- A correia está danificada?" crlf)
               		(printout t "1- Sim" crlf)
                	(printout t "2- Não" crlf)
                	(assert (carro(correia (read))))         
		)
        )
)

(defrule correiaDanificada
        (carro(correia ?cor))
        =>
        (if (eq ?cor 1) then
                (printout t "-> Trocar a correia" crlf)
         else
                (if (eq ?cor 2) then
                        (printout t "-> Verificar estado do alternador. " crlf)
                        (printout t "?- É possível consertar o alternador?" crlf)
                        (printout t "1- Sim" crlf)
                        (printout t "2- Não" crlf)
                        (assert (carro(consertaalternador (read))))    
                )
        )
)

(defrule consertaAlternador
        (carro(consertaalternador ?conalt))
        =>
        (if (eq ?conalt 1) then
                (printout t "-> Conserta o alternador" crlf)
         else
                (if (eq ?conalt 2) then
                        (printout t "-> Troca o alternador. " crlf)
                )
        )
)

(defrule equipEnergia
        (carro(componente ?eqp))
        =>
        (if (eq ?eqp 1) then
                (printout t "-> Adaptar fiação ou retirar o equipamento." crlf)
         else
                (if (eq ?eqp 2) then
                        (printout t "-> Verificar vela e bobina. " crlf)
                        (printout t "?- A vela e a bobina estão em bom estado?" crlf)
                        (printout t "1- Sim" crlf)
                        (printout t "2- Não" crlf)
                        (assert (carro(vela-bobina (read))))
                )
        )
)

(defrule velaBobina
        (carro(vela-bobina ?vel))
        =>
        (if (eq ?vel 1) then
		(printout t "-> Verificar motor de arranque. " crlf)
                (printout t "?- O motor de arranque está funcionando?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(motorarranque (read))))
         else
                (if (eq ?vel 2) then
                        (printout t "-> Troca a vela ou bobina" crlf)
                )
        )
)

(defrule motorArranque
        (carro(motorarranque ?mta))
        => 
        (if (eq ?mta 1) then
                (printout t "-> Verificar o tipo de motor. " crlf)
                (printout t "?- Qual é o tipo de injeção de comubustível?" crlf)
                (printout t "1- Injeção Eletrônica" crlf)
                (printout t "2- Carburador" crlf)
                (assert (carro(tipomotor (read))))
         else
                (if (eq ?mta 2) then
                        (printout t "-> Verifica se esta travado ou troca o motor de arranque" crlf)
                )       
        )       
)

(defrule tipoMotor
        (carro(tipomotor ?tmot))
        =>
        (if (eq ?tmot 1) then
                (printout t "-> Verifica bomba de combustível elétrica." crlf)
                (printout t "?- A bomba está funcionando corretamente?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(bomba (read))))
         else
                (if (eq ?tmot 2) then
                        (printout t "-> Verifica sujeira ou malfuncionamento do carburador. " crlf)
                )
        )
)

(defrule verificaBomba
        (carro(bomba ?bomb))
        =>
        (if (eq ?bomb 1) then
                (printout t "-> Efetua o reset no módulo de injeção." crlf)
                (printout t "?- O módulo funcionou após o reset?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(modulo (read))))
         else
                (if (eq ?bomb 2) then
                        (printout t "-> Arruma a bomba com o manômetro de pressão, ou troca a bomba. " crlf)
                )
        )
)

(defrule verificaModulo
        (carro(modulo ?mod))
        =>
        (if (eq ?mod 1) then
                (printout t "-> Problema resolvido." crlf)
         else
                (if (eq ?mod 2) then
                        (printout t "-> Regula o módulo pelo computador. " crlf)
                )
        )
)


(defrule naoLiga
        (menu 2)
        =>
        (printout t "-> Qual o estado da bateria? " crlf)
        ;(assert (carro(bateria (read))))
)



