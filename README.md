<div align="center">
  <img src="https://github.com/LLouzada/flutter_weather/blob/main/assets/images/app_logo.png?raw=true" width="200" height="200" alt="Flutter Weather Logo">
</div>

# Flutter Weather

**Flutter Weather** é um aplicativo mobile desenvolvido em Flutter com o objetivo de exibir informações meteorológicas de forma simples, clara e objetiva.

O projeto consome dados da API pública da **Open-Meteo**, permitindo consultar informações relacionadas ao clima de acordo com a localização utilizada pela aplicação. A proposta foi construir uma interface intuitiva, com foco em usabilidade, organização visual e boa estruturação do código.

## Sobre o projeto

Este projeto foi desenvolvido como uma aplicação Flutter para consulta de clima, utilizando recursos comuns em aplicações mobile modernas, como consumo de API, organização de camadas, exibição de dados dinâmicos e preparação para funcionamento em diferentes plataformas.

A aplicação busca apresentar as informações meteorológicas de maneira acessível para o usuário, evitando excesso de detalhes técnicos na interface e priorizando uma experiência direta.

Durante o desenvolvimento, foram consideradas boas práticas de organização do projeto, separação de responsabilidades e estruturação do código para facilitar futuras manutenções e evoluções.

## Tecnologias utilizadas

* **Flutter**
* **Dart**
* **Open-Meteo API**
* Android
* Configurações iniciais para iOS

## Executando o projeto

Para executar o projeto localmente, é necessário ter o Flutter instalado e configurado corretamente na máquina.

Após clonar o repositório, abra o projeto em uma IDE de sua preferência, como **VS Code** ou **Android Studio**.

Em seguida, execute o comando:

```bash
flutter run
```

Esse comando irá compilar e executar a aplicação em um emulador ou dispositivo físico conectado.

Também é possível instalar o APK diretamente em um dispositivo Android, caso o arquivo já tenha sido gerado.

> **Observação:** recomenda-se evitar builds em modo `release` neste momento, pois algumas configurações adicionais ainda seriam necessárias para garantir o funcionamento correto da aplicação nesse modo.

## Funcionalidades

* Consulta de informações meteorológicas.
* Exibição de dados climáticos de forma simples e organizada.
* Consumo de dados a partir de uma API externa.
* Interface desenvolvida com Flutter.
* Estrutura preparada para futuras melhorias.

## Pontos de atenção

Durante o desenvolvimento, alguns pontos ficaram como observação ou melhoria futura:

* A API utilizada, **Open-Meteo**, não disponibilizou a informação de umidade relativa no formato necessário para esta implementação.
* A funcionalidade de **offline first** ainda não foi implementada e permanece como um `TODO`.
* Não houve tempo hábil para testar ou publicar o aplicativo para iOS, embora as configurações iniciais pertinentes tenham sido realizadas.
* O foco principal do desenvolvimento foi garantir o funcionamento da aplicação em ambiente Android.

## Melhorias futuras

Algumas melhorias que podem ser implementadas em versões futuras incluem:

* Implementação da estratégia **offline first**.
* Melhor tratamento de estados de erro e carregamento.
* Ajustes para build em modo `release`.
* Testes e validação em dispositivos iOS.
* Melhorias visuais na interface.
* Inclusão de novas informações meteorológicas, caso disponíveis pela API.
* Ajustes de performance e experiência do usuário.

## Status do projeto

O projeto encontra-se funcional para execução em ambiente de desenvolvimento e instalação via APK no Android.

Apesar de ainda existirem melhorias pendentes, a aplicação já cumpre sua proposta principal de consultar e exibir informações meteorológicas utilizando Flutter e integração com API externa.
