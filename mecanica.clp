(defrule main
	(initial-fact)
	=>
	(printout t "####################################" crlf)
	(printout t "Sistema Especialista - Mecanica v1.0" crlf)
	(printout t "####################################" crlf crlf)
	(printout t "?- O veículo funciona ao acionar a ignição?" crlf)
	(printout t "1- Sim" crlf)
	(printout t "2- Não" crlf)
	(assert (menu (read)))
)

(defrule naoliga
	(menu 2)
	=>
	(printout t "-> Verificar luzes no painel." crlf)
	(printout t "?- Qual luz está acendendo?" crlf)
	(printout t "1- Luz da temperatura" crlf)
	(printout t "2- Luz do óleo" crlf)
	(printout t "3- Luz do combustível" crlf)
	(printout t "4- Nenhuma luz acende" crlf)
	(assert (carro(luz (read))))
)

(defrule luzTemperatura
        (carro(luz 1))
        =>
       	(printout t "-> É necessário verificar a origem do superaquecimento." crlf)
       	(printout t "-> Verificar água no reservatório." crlf)
       	(printout t "?- Nível de água no reservatório está normal?" crlf)
       	(printout t "1- Sim" crlf)
       	(printout t "2- Não" crlf)
       	(assert (carro(agua-reservatorio (read))))
	
)

(defrule luzOleo
        (carro(luz 2))
        =>
        (printout t "-> Verificar o estado do óleo." crlf)
        (printout t "?- Como está o óleo? (baixo, normal)" crlf)
        (assert (carro(oleo (read))))
)

(defrule luzCombustivel
        (carro(luz 3))
        =>
        (printout t ">> Colocar combustível no tanque." crlf)
)

(defrule nenhumaLuz
        (carro(luz 4))
        =>
        (printout t "-> Verificar Parte Elétrica." crlf)
	(printout t "-> Verificar se a bateria está com carga e regulada, utilizando um múltimetro." crlf)
        (printout t "?- A bateria apresenta problemas?" crlf)
        (printout t "1- Sim" crlf)
        (printout t "2- Não" crlf)
	(assert (carro(bateria (read))))
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


(defrule aguaReservatorio
        (carro(agua-reservatorio ?agua))
        =>
        (if (eq ?agua 1) then
                (printout t "-> Verificar vazamento nas mangueiras." crlf)
                (printout t "?- Há vazamento na mangueira de água?" crlf)
              	(printout t "1- Sim" crlf)
                (printout t "2- Não" crlf) 
                (assert (carro(mangueira-agua (read))))
         else
                (if (eq ?agua 2) then
                        (printout t "-> Completar água no reservatório. " crlf)
                )
	)
)

(defrule mangueiraAgua
        (carro(mangueira-agua ?agua))
        =>
        (if (eq ?agua 1) then
        	(printout t "-> Trocar as mangueiras danificadas. " crlf)
         else
                (if (eq ?agua 2) then
                	(printout t "-> Verificar termostato." crlf)
	                (printout t "?- Ventoinha está ligando?" crlf)
	              	(printout t "1- Sim" crlf)
	                (printout t "2- Não" crlf) 
        	        (assert (carro(ventoinha (read))))
                )
	)
)

(defrule ventoinha
        (carro(ventoinha ?vento))
        =>
        (if (eq ?vento 1) then
                (printout t "-> Verificar bomba de água." crlf)
                (printout t "?- Bomba de água está funcionando?" crlf)
              	(printout t "1- Sim" crlf)
                (printout t "2- Não" crlf) 
                (assert (carro(bomba-agua (read))))
         else
                (if (eq ?vento 2) then
                        (printout t "-> Trocar termostato. " crlf)
                )
	)
)

(defrule verificaBomba-agua
        (carro(bomba-agua ?bomba))
        =>
        (if (eq ?bomba 1) then
                (printout t "-> Verificar se está entrando água no motor." crlf)
                (printout t "?- Textura do óleo está clara e fina?" crlf)
              	(printout t "1- Sim" crlf)
                (printout t "2- Não" crlf) 
                (assert (carro(textura-oleo (read))))
         else
                (if (eq ?bomba 2) then
                        (printout t ">> Trocar bomba de água. " crlf)
                )
	)
)

(defrule verificaTextura-oleo
        (carro(textura-oleo ?txtOleo))
        =>
        (if (eq ?txtOleo 1) then
        	(printout t "-- Verificar juntas do motor. " crlf)
         else
                (if (eq ?txtOleo 2) then
                	(printout t "-> Verificar bomba de óleo." crlf)
	                (printout t "?- Bomba de óleo está funcionando?" crlf)
	              	(printout t "1- Sim" crlf)
	                (printout t "2- Não" crlf) 
        	        (assert (carro(bomba-oleo (read))))
                )
	)
)

(defrule verificaBomba-oleo
        (carro(bomba-oleo ?Oleo))
        =>
        (if (eq ?Oleo 1) then
        	(printout t "-- Abrir parte de baixo do motor. " crlf)
         else
                (if (eq ?Oleo 2) then
                	(printout t ">> Trocar Bomba de óleo." crlf)
                )
	)
)

(defrule oleoBaixo
        (carro(oleo baixo))
        =>
       	(printout t ">> Completar o óleo. " crlf)
)

(defrule oleoVelho
        (carro(oleo velho))
        =>
       	(printout t ">> Trocar o óleo. " crlf)
)

(defrule oleoNormal
        (carro(oleo normal))
        =>
        (printout t "-> Verificar se está entrando água no motor." crlf)
        (printout t "?- Textura do óleo está clara e fina?" crlf)
        (printout t "1- Sim" crlf)
        (printout t "2- Não" crlf) 
        (assert (carro(textura-oleo (read))))
)

(defrule Liga
        (menu 1)
        =>
        (printout t "-> Verificar o tipo do problema.  " crlf)
        (printout t "?- Qual o tipo do problema?" crlf)
        (printout t "1- Veículo Falhando" crlf)
        (printout t "2- Veículo Morrendo" crlf)
        (printout t "3- Problema nos freios" crlf)
        (assert (carro(naoliga (read))))
)

(defrule vFalhando
        (carro(naoliga 1))
        =>
       	(printout t "-> Verificar se tem combustível. " crlf)
        (printout t "?- Tem combustível?" crlf)
        (printout t "1- Sim" crlf)
        (printout t "2- Não" crlf)
        (assert (carro(combustivel (read))))
)

(defrule verificaCombustivel
        (carro(combustivel ?comb))
        =>
        (if (eq ?comb 1) then
                (printout t "-> Verificar se o combustível é o adequado." crlf)
                (printout t "?- É o combustível adequado?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(combustivel-certo (read))))
         else
                (if (eq ?comb 2) then
                        (printout t ">> Colocar Combustível." crlf)
                )
        )
)

(defrule verificaCombustivelCorreto
        (carro(combustivel-certo ?comb))
        =>
        (if (eq ?comb 1) then
                (printout t "-> Verificar velas e cabos da vela." crlf)
                (printout t "?- Está normal?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(velas-cabos (read))))
         else
                (if (eq ?comb 2) then
                        (printout t ">> Esvaziar o tanque, limpar e colocar o combustível correto." crlf)
                )
        )
)

(defrule verificaVelasCabos
        (carro(velas-cabos ?velaCabo))
        =>
        (if (eq ?velaCabo 1) then
                (printout t "-> Verificar bobina." crlf)
                (printout t "?- Está normal?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(bobina (read))))
         else
                (if (eq ?velaCabo 2) then
                        (printout t ">> Trocar velas e/ou cabos de velas." crlf)
                )
        )
)

(defrule verificaBobina
        (carro(bobina ?bob))
        =>
        (if (eq ?bob 1) then
                (printout t "-> Verificar tipo de motor." crlf)
                (printout t "?- Qual o tipo de motor?" crlf)
                (printout t "1- Carburado" crlf)
                (printout t "2- Injetado" crlf)
                (assert (carro(falhandoTipoMotor (read))))
         else
                (if (eq ?bob 2) then
                        (printout t ">> Trocar bobina." crlf)
                )
        )
)

(defrule verificaFTipoMotor
        (carro(falhandoTipoMotor ?fTipoM))
        =>
        (if (eq ?fTipoM 1) then
                (printout t "-> Verificar platinado." crlf)
                (printout t "?- Está normal?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(platinado (read))))
         else
                (if (eq ?fTipoM 2) then
                	(printout t "-> Efetua o reset no módulo de injeção." crlf)
	                (printout t "?- O módulo funcionou após o reset?" crlf)
        	        (printout t "1- Sim" crlf)
                	(printout t "2- Não" crlf)
	                (assert (carro(modulo (read))))
                )
        )
)

(defrule verificaPlatinado
        (carro(platinado ?plat))
        =>
        (if (eq ?plat 1) then
                (printout t "-> Verificar carburador." crlf)
                (printout t "?- Está sujo?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(fCarburador (read))))
         else
                (if (eq ?plat 2) then
                        (printout t ">> Trocar platinado." crlf)
                )
        )
)

(defrule verificaFCarburador
        (carro(fCarburador ?fcarb))
        =>
        (if (eq ?fcarb 1) then
                        (printout t ">> Limpar o carburador." crlf)
         else
                (if (eq ?fcarb 2) then
                	(printout t "-> Verifica excesso de combustível." crlf)
	                (printout t "?- Está normal?" crlf)
        	        (printout t "1- Sim" crlf)
	               	(printout t "2- Não" crlf)
        	        (assert (carro(excessoCombustivel (read))))
                )
        )
)

(defrule verificaExcessoCombustivel
        (carro(excessoCombustivel ?excComb))
        =>
        (if (eq ?excComb 1) then
                        (printout t ">> É necessário abrir o motor para maiores detalhes." crlf)
         else
                (if (eq ?excComb 2) then
                	(printout t ">> Regula o carburador." crlf)
                )
        )
)

(defrule fluido
        (carro(naoliga 3))
        =>
       	(printout t "-> Verificar o fluido de freio. " crlf)
        (printout t "?- O nível de fluido está normal?" crlf)
        (printout t "1- Sim" crlf)
        (printout t "2- Não" crlf)
        (assert (carro(fluido (read))))
)

(defrule verificaPastilha
        (carro(fluido ?flu))
        =>
        (if (eq ?flu 1) then
                (printout t "-> Verificar pastilhas de freio." crlf)
                (printout t "?- As pastilhas estão gastas?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(pastilha (read))))
         else
                (if (eq ?flu 2) then
                        (printout t "-> Completa o nível de fluido do freio. " crlf)
                )
        )
)

(defrule pastilha
        (carro(pastilha ?pas))
        =>
        (if (eq ?pas 1) then
        	(printout t "-> Trocar as pastilhas de freio. " crlf) 
	else
                (if (eq ?pas 2) then
   	                (printout t "-> Verificar lonas de freio." crlf)
        	        (printout t "?- As lonas estão gastas?" crlf)
               		(printout t "1- Sim" crlf)
               		(printout t "2- Não" crlf)
                	(assert (carro(lona (read))))
                )
        )
)

(defrule lona
        (carro(lona ?lon))
        =>
        (if (eq ?lon 1) then
                (printout t "-> Trocar as lonas de freio. " crlf)       
        else
                (if (eq ?lon 2) then
                        (printout t "-> Verificar discos de freio." crlf)
                        (printout t "?- Os discos estão gastos?" crlf)
                        (printout t "1- Sim" crlf)
                        (printout t "2- Não" crlf)
                        (assert (carro(disco (read))))
                )
        )
)

(defrule disco
        (carro(disco ?disc))
        =>
        (if (eq ?disc 1) then
                (printout t "-> Trocar os discos de freio. " crlf)    
        else
                (if (eq ?disc 2) then
                        (printout t "-> Verificar cilindro de roda e cilindro mestre." crlf)
                        (printout t "?- Os cilindros estão normais?" crlf)
                        (printout t "1- Sim" crlf)
                        (printout t "2- Não" crlf)
                        (assert (carro(cilindro (read))))
                )
        )
)

(defrule cilindro
        (carro(cilindro ?cil))
        =>
        (if (eq ?cil 1) then
                (printout t "-> Verificar hidrovácuo." crlf)
                (printout t "?- O hidrovácuo está funcionando?" crlf)
                (printout t "1- Sim" crlf)
                (printout t "2- Não" crlf)
                (assert (carro(hidrovacuo (read))))
         else
                (if (eq ?cil 2) then
                        (printout t "-> Troca os cilindros de roda e cilindro mestre. " crlf)
                )
        )
)

(defrule hidrovacuo
        (carro(hidrovacuo ?hid))
        =>
        (if (eq ?hid 1) then
                (printout t "-> Verificar mais a fundo o problema." crlf)
         else
                (if (eq ?hid 2) then
                        (printout t "-> Conserta o hidrovácuo. " crlf)
                )
        )
)

(defrule tmotor
        (carro(naoliga 2))
        =>
        (printout t "-> Verificar o tipo do motor. " crlf)
	(printout t "?- Qual é o tipo de injeção de comubustível?" crlf)
        (printout t "1- Injeção Eletrônica" crlf)
        (printout t "2- Carburador" crlf)
        (assert (carro(tmotor (read))))
)

(defrule ajusteMotor
        (carro(tmotor ?mott))
        =>
        (if (eq ?mott 1) then
                (printout t "-> Ajustar o regulador de marcha lenta (usando o computador)." crlf)
         else
                (if (eq ?mott 2) then
                        (printout t "-> Regular o carburador. " crlf)
                )
        )
)
