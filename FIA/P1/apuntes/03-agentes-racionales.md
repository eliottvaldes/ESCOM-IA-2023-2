# AGENTES RACIONALES
Razona piensa

- controles automaticos
- tiene percepcion del entorno
- adaptacion al cambio
- alcanzan metas diferentes
- tiene funcion especifica
- toman accion esperando el mejor resultado


## Razonamiento perfecto > Siempre la mehir accuib
- **Complejidad computacional**: excesivamente costoso

## Razonamiento Limitado > Busca la mejor accion
- **Complejidad computacional**: no es tan costoso
- Actua de manera adecuada
- actua en un timepo limitado


## ENTORNO
Los agentes se encuentran dentro de un entorno en el cual se encuentran los sensores y actuadores.
> Los sensores son los que perciben el entorno
> Los actuadores son los que actuan sobre el entorno

-- La percepcion es usada apra indicar al agente puede recibir entradas en cualquier entorno

-- el comportamiento de agente es dado por la funcion del agenre que convierte una determunada percepcion en una accion


## MEDICIONES DE EFICIENCIA
La eficiencia es necesaria para medir que se este replicando lo correcto y que se este haciendo de la mejor manera
- uso de criterios que determinan la salida
- realiza acciones de acuerdo a las percepciones recibidas
> es mejor diseñar las medidas de eficiencia de acuerdo a li que se desea

## RACIONALIDAD
- medida de desempeño que define el exito del agente
- conocimeinto previo del ambiente
- acciones que el agente puede realizar
- secuencia de percepciones que el agente ha recibido hasta el momento




## ESTRUCTURA DE AGENTES
### ARQUITECURA DE AGENTES
- **Agente reactivo simple**: selecciona acciones en base a la percepcion actual, ignorando el resto de la historia
- **Agente reactivo basado en modelo**: mantiene un estado interno que depende de la historia perceptual hasta el momento
- **Agente basado en objetivos**: selecciona acciones que logren sus objetivos
- **Agente basado en utilidad**: selecciona acciones que maximicen una funcion de utilidad


#### Agente de reflejo simple
- **Funcion del agente**: mapea las percepciones a las acciones, es decir, selecciona una accion en base a la percepcion actual


#### Agente basado en modelos:
- **Funcion del agente**: mapea las percepciones a las acciones, es decir, selecciona una accion en base a la percepcion actual usando un modelo interno del mundo. Ayuda a dar una percepcion mayor del mundo en la actualidad


#### Agente basado en objetivos
- **Funcion del agente**: mapea las percepciones a las acciones, es decir, selecciona una accion en base a la percepcion actual usando un modelo interno del mundo. Ayuda a dar una percepcion mayor del mundo en la actualidad. Ademas de esto, se le agrega un objetivo que se desea alcanzar. Evalua las posibles opciones a realizar para saber cual es la mejor opcion a realizar

#### Agente basado en utilidad
- **Funcion del agente**: mapea las percepciones a las acciones, es decir, selecciona una accion en base a la percepcion actual usando un modelo interno del mundo. Ayuda a dar una percepcion mayor del mundo en la actualidad. Ademas de esto, se le agrega un objetivo que se desea alcanzar. Evalua las posibles opciones a realizar para saber cual es la mejor opcion a realizar. Ademas de esto, se le agrega una funcion de utilidad que ayuda a saber cual es la mejor opcion a realizar. Define que tan bueno seria realizar una accion en base a la funcion de utilidad