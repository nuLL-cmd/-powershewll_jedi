# Windows Terminal Customizado

Tutorial de como realizar algumas customizações no windows terminal e PowerShell.
> ℹ*Testado no Windows em suas versões 10 e 11*
# Ingredientes

Para a customização usarei alguns ingredientes.
   
- [Windows Terminal Customizado](#windows-terminal-customizado)
- [Ingredientes](#ingredientes)
  - [PowerShell](#powershell)
  - [Nerd Fonts](#nerd-fonts)
      - [Outras configurações de aparência (Personalizável):](#outras-configurações-de-aparência-personalizável)
  - [Scoop (instalador em linha de comando)](#scoop-instalador-em-linha-de-comando)
  - [Git](#git)
  - [Criando perfil de usuário PowerShell e configurando alias](#criando-perfil-de-usuário-powershell-e-configurando-alias)
  - [Instalando e configurando o oh-my-posh](#instalando-e-configurando-o-oh-my-posh)
  - [Terminal Icons](#terminal-icons)
  - [Z Directory Jumper](#z-directory-jumper)
  - [PSReadLine](#psreadline)
  - [FZF - Fuzzy Finder](#fzf---fuzzy-finder)
  - [Considerações finais.](#considerações-finais)

## PowerShell
Vá para a Microsoft Store, baixe e instale o  ***PowerShell for Windows***<br>
[Link para a loja](https://apps.microsoft.com/store/detail/powerShell/9MZ1SNWT0N5D?hl=pt-br&gl=BR)<br><br>
Defina o PowerShell como shell padrão em ***Configurações > Inicialização > Perfil Padrão***.
## Nerd Fonts
Vá para repositório Nerd Fonts e baixe o pacote de fontes ***Hack***<br>
[Link para o site oficial](https://www.nerdfonts.com/font-downloads)<br><br>
Baixe o arquivo zip e instale a fonte ***Hack Bold Italic Nerd Font Complete Mono Windows Compatible*** usando o método normal de instalação de fonte no windows.
Nas configurações do terminal, vá para  ***Perfis > Padrão > Configurações adicionais > Aparência*** e escolha o tipo de fonte como ***Hack NF***.
#### Outras configurações de aparência (Personalizável):
```
Esquema de cores: One Half Dark
Tamanho da fonte: 12
Espessura da fonte: Normal
Formato do cursor: Vintage
Estilo de texto intenso: Cores brilhantes
Material acrílico: on
Opacidade do fundo: 36%
```
ℹOpcional:<br>
Adicione o bloco abaixo dentro de schemes no arquivo settings.json do PowerShell, caso queira ter uma variante com esquema de cores One Hafl Dark personalizada.
```JSON
 {
    "background": "#001B26",
    "black": "#282C34",
    "blue": "#61AFEF",
    "brightBlack": "#5A6374",
    "brightBlue": "#61AFEF",
    "brightCyan": "#56B6C2",
    "brightGreen": "#98C379",
    "brightPurple": "#C678DD",
    "brightRed": "#E06C75",
    "brightWhite": "#DCDFE4",
    "brightYellow": "#E5C07B",
    "cursorColor": "#FFFFFF",
    "cyan": "#56B6C2",
    "foreground": "#DCDFE4",
    "green": "#98C379",
    "name": "One Half Dark (modificado)",
    "purple": "#C678DD",
    "red": "#E06C75",
    "selectionBackground": "#FFFFFF",
    "white": "#DCDFE4",
    "yellow": "#E5C07B"
}

```
## Scoop (instalador em linha de comando)
Scoop é um instalador de linha de comando que permite ao usuário instalar diversos tipos de ferramentas / aplicações
de forma fácil digitando apenas o comando ***scoop install [nome_do_pacote]***.
Instale o Scoop for PowerShell no site oficial do projeto<br>
[Site oficial do projeto](!https://scoop.sh/)<br><br>
Instale usando o PowerShell
 ```bash
> Set-ExecutionPolicy RemoteSigned -Scope CurrentUser # Optional: Needed to run a remote script the first time
> irm get.scoop.sh | iex
 ```
Caso sua conta seja de Administrador 😈 instale usando o modo f****.
```bash
# Instalação do scoop usando parâmetros de instalação
irm get.scoop.sh -outfile 'install.ps1'
.\install.ps1 -RunAsAdmin [-OtherParameters ...]
  
# Eu não me importo com outros parâmetros, só quero meu instalador de linha de comando 😎
iex "& {$(irm get.scoop.sh)} -RunAsAdmin"
```
Valide a instalção
```bash
scoop --version
```
Após a instalação, teste o scoop instalando algumas ferramentas que serão usadas no decorrer do processo.
- ***curl*** 
- ***sudo***  
- ***jq***
- ***neovim***

<br>Exemplo de uso
```bash
scoop install neovim
```
## Git
Caso não tenha o Git instalado, instale usando o PowerShell
```bash
winget install -e --d Git.Git
```
## Criando perfil de usuário PowerShell e configurando alias
Crie um perfil de usuário para o PowerShell conforme a estrutura de diretórios abaixo.
```shell
nvim C:\Users\seu_usuario\.config\powershell\user_profile.ps1
```
Após criar o arquivo, abra-o usando um editor(pode ser o vim instalado via scoop) e crie os aliases de sua preferencia.<br><br>
ℹ***Alias - Assim como acontece no Linux, permite a execução rápida de comandos curtos que por trás<br> podem estar executando comandos maiores, mais complexos e até functions*** 
Alguns alias de exemplo
```bash
# Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias g git
Set-Alias dc docker-compose
Set-Alias ddown docker-compose down --rmi all --remove-orphans
Set-Alias dup docker-compose up --force-recreate
Set-Alias dlogstail docker-compose logs --tail 1000 --follow
Set-Alias d docker
Set-Alias kt kafka-topics
Set-Alias kc kafka-console-consumer
Set-Alias kp kafka-console-producer
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
```
Feito isto, associe o perfil de usuário criado ao PowerShell para ver o resultado das configurações acima.
```bash
# Crie usando vim.
nvim $PROFILE.CurrentUserCurrentHost
...
# No arquivo criado insira a linha abaixo.
. $env:USERPROFILE\.config\powerShell\user_profile.ps1
# Salve o arquivo usando os atalhos do vim ":wq"
```
A partir de agora, o perfil criado inicialmente para o PowerShell será pré carregado toda vez que abrir o Windows Terminal ou uma nova aba for aberta, permitindo assim que novos módulos, funções, e configurações seja pré carregada sem a necessidade de executar o script manualmente.
## Instalando e configurando o oh-my-posh
Siga para o site oficial do projeto.<br>
[Link da documentação](!https://ohmyposh.dev/docs/installation/windows)<br><br>
***Obs: Para facilitar e generalizar a instalação para todos os usuário, utilize o Scoop para esta etapa da customização.***
```bash
scoop install https://github.com/JanDeDobbeleer/oh-my-posh/releases/latest/download/oh-my-posh.json
```
Este comando instalará?
- Engine do oh-my-posh
- Pacote de temas
Reinicie o terminal e edite o script de perfil do PowerShell inserindo o linha abaixo.
```bash
# Prompt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/M365Princess.omp.json" | Invoke-Expression
# Salve e feche o arquivo
```
Este comando no script de perfil, carrega um tema de sua escolha que está localizado no diretório ***themes*** do oh-my=posh, uma vez que o perfil é carregado em toda a inicialização do windows terminal. O diretório de temas esta disponível através da variável ```$POSH_THEMES``` criada durante a instalação do módulo.
> Você pode usar o mesmo comando para carregar um novo tema no PowerShell em tempo de execução caso queria experimentar novos tempos de forma ágil.
>O comando abaixo no powershell visualiza o caminho completo da variável **POSH_THEMES_PATH**.
>```bash 
>$env:POSH_THEMES_PATH
>```
Feito este passo, ainda no diretório do script de perfil, execute-o (```.\user_profile.ps1```) e veja as mudanças acontecerem.
É possível criar seu próprio arquivo de tema e coloca-lo no próprio diretório junto com o script de perfil do PowerShelll, para isso, basta criar uma variável de ambiente, algo como (```$POWERSHEL_CONFIG```) e setar como valor o diretório no qual se encontra o script de perfil de usuário junto com o arquivo de tema (```~\.config\powerShell```) como valor, e no script (```.\user_profile.ps1```) editar a linha referente ao carregamento do tema, apontando para a variável de ambiente criada + o nome do arquivo no diretório.
Exemplo
```bash
# Prompt
oh-my-posh init pwsh --config "$env:POWERSHELL_CONFIG/meuTemaCustomizado.omp.json" | Invoke-Expression
# Salve e feche o arquivo
```
## Terminal Icons
Este modulo instala ícones personalizados para o PowerShell, onde ao listar os diretórios e arquivos, mostra cada pasta e arquivo de acordo com seu tipo e importância.
Abra o PowerShell e digite
```bash
Install-Module Terminal-Icons -Repository PSGallery -Force
```
Abra o script de perfil (```.\user_profile.ps1```) e coloque a linha abaixo, para que o tema de ícones seja carregado a cada inicialização do terminal.
```bash
#Terminal Icons
Import-Module Terminal-Icons
# Salve e feche o arquivo
```
Reinicie o windows terminal e experimente listar os itens de um diretório.
## Z Directory Jumper

[Link do repositório no GitHub](https://github.com/badmotorfinger/z)<br>

Um módulo poderoso do powershell que lhe permite utilizar atalhos dentro da ferramenta de linha de comando da Microsoft, podendo pular de um diretório para outro com apenas o comando ```z <alias_diretorio>```, facilitando muito a vida de quem usa o Powershell no dia a dia.
Para instalar o Z Directory Jumper siga os passos abaixo:
Abra o PowerShell e digite
```bash
Install-Module -Name z -Force
```
Feito isso, já é possível utilizar o ```z``` gravando novos diretórios e utilizando para saltar de um diretório para outro.
No PowerShell navegue até o diretório que deseja salvar no ```z```
```bash
cd c:\diretorio\diretorioDestino
```
Quando estiver no diretório desejado, de o comando conforme exemplo
```bash
z dirDestino
```
A partir de agora, ao digitar no PowerShell ```z dirDestino``` de qualquer diretório no PowerShell, você navegará para o seu ```diretorioDestino```.
## PSReadLine
Será usado em conjunto com Fuzzy Finder -FZF para prover uma experiência aprimorada em histórico e auto-complete de comandos digitados no
PowerShell
Abra o PowerShell e digite
```bash
Install-Module -Name PSReadLine -AllowPrerelease -Scope CurrentUser -Force -SkipPublisherCheck
```
Abra o script de perfil (```.\user_profile.ps1```) e coloque as linha a baixo, para que as configurações sejam carregadas a cada inicialização do terminal.
```bash
#PSReadLine - AutoCompletion
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView
# Salve e feche o arquivo
```
## FZF - Fuzzy Finder
Será usado em conjunto com o PSReadLine para prover uma experiência aprimorada em histórico e auto-complete de comandos digitados no
PowerShell
Abra o PowerShell e digite
```bash
Install-Module -Name PSFzf -Scope CurrentUser -Force
```
Abra o script (```.\user_profile.ps1```) e coloque a linha abaixo, para que a configuração seja carregada a cada inicialização do terminal.
```bash
#FZF - Fuzzy Finder
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'
# Salve e feche o arquivo
```
Reinicie novamente o PowerShell e veja o resultado das customizações.

> Caso receba um erro referente ao FZF mesmo após a reinicialização do terminal, siga os passos abaixo:
>  - Baixe o zip no [repositório oficial do projeto](https://github.com/junegunn/fzf)
>  - Extraia, e caso precise, renomeie o arquivo fzf para fzf.exe
>  - Mova o arquivo para C:\Windows\System32
>  - Reinicie o terminal novamente para aplicar as alterações.

## Considerações finais.
***Ao final deste documento, seu script de usuário do PowerShell deverá se parecer com o modelo abaixo***
```bash
#Prompt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/M365Princess.omp.json" | Invoke-Expression

#Terminal Icons
Import-Module Terminal-Icons

#PSReadLine - AutoCompletion
Set-PSReadLineOption -PredictionSource History

Set-PSReadLineOption -PredictionViewStyle ListView
#FZF - Fuzzy Finder
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+f' -PSReadlineChordReverseHistory 'Ctrl+r'

#Alias
Set-Alias vim nvim
Set-Alias ll ls
Set-Alias grep findstr
Set-Alias g git
Set-Alias dc docker-compose
Set-Alias ddown docker-compose down --rmi all --remove-orphans
Set-Alias dup docker-compose up --force-recreate
Set-Alias dlogstail docker-compose logs --tail 1000 --follow
Set-Alias d docker
Set-Alias kt kafka-topics
Set-Alias kc kafka-console-consumer
Set-Alias kp kafka-console-producer
Set-Alias less 'C:\Program Files\Git\usr\bin\less.exe'
Set-Alias tig 'C:\Program Files\Git\usr\bin\tig.exe'
```
***E sua estrutura de diretório conforme modelo abaixo***
```
C:/
└─ Users/
   └─ seu_usuario/
      └─ .config/
         └─ powerShell/
            ├─ tema_customizado.omp.json
            └─ user_profile.ps1
```
Obrigado 🙂!
