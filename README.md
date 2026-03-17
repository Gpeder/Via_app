🤝 VIA - Volunteers in Action
O VIA é um aplicativo mobile desenvolvido em Flutter que conecta pessoas dispostas a ajudar com organizações que precisam de voluntários. O foco é facilitar a descoberta de causas sociais próximas e o gerenciamento de ações solidárias.

✨ Funcionalidades Principais
📍 Mapa de Oportunidades: Localize vagas de voluntariado em tempo real baseadas na sua localização.

🔍 Filtros Inteligentes: Busque por categorias (Animais, Educação, Saúde, etc.), distância ou disponibilidade.

📅 Agendamento Simples: Escolha o melhor horário para você e confirme sua participação com poucos cliques.

👤 Perfil de Impacto: Acompanhe suas horas de serviço, atividades concluídas e pontos de impacto gerados.

🌓 Suporte a Temas: Interface adaptável com modos claro (Light) e escuro (Dark).

🛠️ Tecnologias e Bibliotecas
Este projeto utiliza tecnologias modernas do ecossistema Flutter:

Core UI: Biblioteca de componentes customizados desenvolvida especificamente para manter a consistência visual.

Google Maps & Flutter Map: Integração de mapas para visualização geográfica das vagas.

Shimmer: Animações suaves de carregamento para uma melhor experiência do usuário.

Lucide Icons: Conjunto de ícones modernos e minimalistas.

Google Fonts: Tipografia personalizada (Google Sans).

📁 Estrutura do Projeto
A organização segue padrões de escalabilidade:

lib/view: Telas principais e lógica de navegação.

lib/widgets: Componentes reutilizáveis de interface.

lib/model: Definição de dados e regras de negócio.

lib/utils: Configurações de cores, temas e estilos globais.

lib/data: Dados fictícios (mock) para demonstração do protótipo.

🚀 Como rodar o projeto
Certifique-se de ter o Flutter instalado na sua máquina.

Clone o repositório:

Bash
git clone https://github.com/Gpeder/via_app.git
Instale as dependências:

Bash
flutter pub get
Execute o aplicativo:

Bash
flutter run
Nota: Para o funcionamento completo do mapa, é necessário configurar uma chave de API do Google Maps no arquivo AndroidManifest.xml e AppDelegate.swift.