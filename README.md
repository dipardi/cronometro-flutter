Cronômetro de Voltas em Flutter (MVVM)
📖 Sobre o Projeto
Este é um aplicativo de cronômetro de voltas desenvolvido em Flutter como parte de um projeto acadêmico. O principal objetivo foi aplicar o design pattern MVVM (Model-View-ViewModel) para criar uma arquitetura de software limpa, separando a lógica de negócio da interface do usuário.

O aplicativo também inclui recursos de acessibilidade e notificações, garantindo uma experiência de usuário mais completa e inclusiva.

✨ Funcionalidades
Cronômetro Principal: Iniciar, pausar e zerar a contagem de tempo.

Registro de Voltas: Marcar tempos de volta individuais, que são exibidos em uma lista.

Lista de Voltas Detalhada: Cada item na lista mostra o número da volta, o tempo daquela volta e o tempo total acumulado no momento do registro.

Notificações:

Uma notificação persistente é exibida enquanto o cronômetro está ativo.

Uma nova notificação é disparada a cada volta registrada.

Acessibilidade: Widgets como Semantics foram utilizados para garantir que leitores de tela possam interpretar corretamente as informações e os botões.

🛠️ Pacotes Utilizados
provider: Utilizado para a implementação do padrão MVVM, gerenciando o estado e a comunicação entre a View e o ViewModel.

flutter_local_notifications: Utilizado para criar e gerenciar as notificações locais do sistema Android.

🚀 Como Baixar e Usar
Para rodar este projeto localmente, siga os passos abaixo:

# 1. Clone o repositório
git clone [https://github.com/](https://github.com/)[SEU_USUARIO_GITHUB]/cronometro-flutter.git

# 2. Navegue até a pasta do projeto
cd cronometro-flutter

# 3. Instale as dependências
flutter pub get

# 4. Execute o aplicativo
flutter run

📸 Imagem do App
![Imagem de Cronômetro em execução]
(Instrução: Tire um print da tela do seu app funcionando e substitua esta linha pela imagem. No GitHub, você pode simplesmente arrastar e soltar a imagem aqui enquanto edita o arquivo).

🎬 Vídeo de Demonstração
(Opcional: Grave um pequeno vídeo ou GIF mostrando o app em funcionamento e coloque o link ou o arquivo aqui).
