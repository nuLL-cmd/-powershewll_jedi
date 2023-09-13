#Prompt
oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH/blueish.omp.json" | Invoke-Expression

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

#Retorna o tamanho da pasta passada como parâmetro
function size {
    [CmdletBinding()]
    Param ([Parameter(Mandatory=$true,ValueFromPipeline=$true)]$Path)
    if ( (Test-Path $Path) -and (Get-Item $Path).PSIsContainer ) {
       $Measure = Get-ChildItem $Path -Recurse -Force -ErrorAction SilentlyContinue | Measure-Object -Property Length -Sum
       $Sum = '{0:N2}' -f ($Measure.Sum / 1Gb)
       [PSCustomObject]@{
          "Path" = $Path
          "Size($Gb)" = $Sum
       }
   }
}

# Function para enviar codigo para analise usando sonar maven (Estou usando z jump directory)
function sonar { 
    param(
    [Parameter()]
    [string]$projeto	
    )
    z java
    cd $projeto
    mvn clean verify sonar:sonar `
    "-Dsonar.host.url=http://surprise_motherfucker.io:66666"`
    "-Dsonar.token=oi_eu_sou_uma_chave_token"`
    "-Dsonar.scm.provider=svn"`
    "-Dmaven.test.skip=true"
}

#Maven clean install (Estou usando z jump directoroy)
function maven { 
    param(
    [Parameter()]
    [string]$projeto	

    )
    z work
    cd $projeto
    mvn clean install -X "-Dmaven.test.skip=true"

}

#Function para debugar sem precisar de ide (da pra usar até notepad), estou usando z jump directory
function debug {
    param(
    [Parameter()]
    [string]$projeto	

    )
    z java
    cd $projeto
    mvn clean install -X
    java -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=8000 -jar ./target/$projeto.war

}

#Function jedi para converter arquivos para utf8 sem o BOOOMMMM
function AlterarEncodingParaUTF8SemBOM {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [string]$CaminhoDaPasta
    )

    # Obtém todos os arquivos da pasta especificada
    $arquivos = Get-ChildItem -Path $CaminhoDaPasta -File

    # Para cada arquivo, altera o encoding para UTF-8 sem BOM
    foreach ($arquivo in $arquivos) {
        $conteudo = Get-Content $arquivo.FullName
        $novoConteudo = [System.Text.Encoding]::UTF8.GetBytes($conteudo)
        Set-Content -Path $arquivo.FullName -Encoding UTF8 -Value ([System.Text.Encoding]::UTF8.GetString($novoConteudo))
    }
}

#Iniciar BR modelo 
function brmodelo {

    java -jar C:\brmodelo\brModelo.jar
}

#Mostra informações sobre o drive como um todo
function infoDrive {
   Get-PSDrive
}

#Mostra o espaço dos volumes
function space {
   Get-Volume
}

#Mostra informações sobre o disco
function diskInfo {
   Get-Disk
}

#SSH usando PLINK (é muito ruim :(  )
function pcorp567 {
    plink 12.3.4.567 -l jenkins -pw 'senha_super_secreta'
}

#SSH usando open-ssh 
function scorp224 {
     ssh usuario@12.3.4.567
}

function scorp132 {
    ssh -p 5400 usuario-dev@12.3.4.132
}

#Inciando aplicaçáo docker por flag
function kafka {
    docker-compose -f C:\Users\null\Desktop\dev_docks_versioned\kafka\kafka_one_broker\docker-compose.yml up -d --force-recreate
}
