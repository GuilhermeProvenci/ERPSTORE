function GeraSenhaDia {
    param (
        [DateTime]$iData
    )

    $vData = $iData
    $vDiaMes = Get-Date $vData -Format "ddMM"
    $vD1 = [int]($vDiaMes[0].ToString())
    $vD2 = [int]($vDiaMes[1].ToString())
    $vM1 = [int]($vDiaMes[2].ToString())
    $vM2 = [int]($vDiaMes[3].ToString())

    switch ($vD2) {
        0 { $vD2 = 5 }
        1 { $vD2 = 8 }
        2 { $vD2 = 6 }
        3 { $vD2 = 9 }
        4 { $vD2 = 3 }
        5 { $vD2 = 7 }
        6 { $vD2 = 2 }
        7 { $vD2 = 5 }
        8 { $vD2 = 1 }
        9 { $vD2 = 0 }
    }

    $vA = ($vD1 + 5) % 10
    $vB = ($vD2 + 7) % 10
    $vC = ($vM1 + 3) % 10
    $vD = ($vM2 + 8) % 10

    $vX = ($vA + $vC + $vB) % 10
    $vY = ($vA + $vB) % 10
    $vZ = ($vC + $vB) % 10
    $vK = ($vD + $vA + $vB) % 10

    return "$vX$vY$vZ$vK"
}

function PerguntaGerarSenha {
    do {
        $resposta = Read-Host "Qual senha deseja gerar? (Hoje (1) - Escolher Dia (2) - Sair (3)"
        switch ($resposta) {
            1 {
                $data = Get-Date
                $senha = GeraSenhaDia -iData $data
                ExibirSenhas $senha
                PerguntaRenomearArquivo -Data $data
                $continuar = PerguntaGerarNovamente
            }
            2 {
                $data = Read-Host "Informe a data no formato dd/MM/yyyy"
                if ($data -eq "sair") {
                    return
                }
                $data = Get-Date $data
                $senha = GeraSenhaDia -iData $data
                ExibirSenhas $senha
                PerguntaRenomearArquivo -Data $data
                $continuar = PerguntaGerarNovamente
            }
            3 { return }
            default {
                Write-Host "Opção inválida. Por favor, escolha '1', '2' ou '3'."
                $continuar = $true
            }
        }
    } while ($continuar)
}

function PerguntaRenomearArquivo {
    param (
        [DateTime]$Data
    )

    $resposta = Read-Host "Deseja renomear o arquivo parametrizado? (S/N)"
    if ($resposta -eq "s") {
        RenomearArquivo -Data $Data
    }
}

function RenomearArquivo {
    param (
        [DateTime]$Data
    )

    # Padrão para procurar o arquivo
    $padraoArquivo = "SENHA - *"

    # Diretório onde procurar o arquivo
    $diretorio = "C:\Users\junior.duarte\Favorites\Links"

    # Obter o arquivo correspondente ao padrão
    $arquivo = Get-ChildItem -Path $diretorio -Filter $padraoArquivo | Select-Object -First 1

    if ($arquivo -ne $null) {
        Write-Output "Arquivo encontrado: $($arquivo.FullName)"
        # Renomear o arquivo
        $senha = GeraSenhaDia -iData $Data
        $senha2 = [int]$senha + 25
        $novoNomeArquivo = $arquivo.Name -replace "$padraoArquivo.*", "SENHA - $senha - $senha2.lnk"
        $novoCaminhoArquivo = Join-Path -Path $diretorio -ChildPath $novoNomeArquivo
        Rename-Item -Path $arquivo.FullName -NewName $novoNomeArquivo
        Write-Output "Arquivo renomeado para: $novoNomeArquivo"
    } else {
        Write-Output "Arquivo não encontrado."
    }
}

function PerguntaGerarNovamente {
    $resposta = Read-Host "Deseja gerar outra senha? (S/N)"
    return $resposta.ToLower() -eq "s"
}

function ExibirSenhas {
    param (
        [string]$senha
    )
    $senha2 = [int]$senha + 25
    Write-Output "Senha gerada: $senha"
    Write-Output "Senha + 25: $senha2"
}

# Perguntar ao usuário se deseja gerar senha
PerguntaGerarSenha

# Aguardar usuário pressionar Enter
Read-Host "Pressione Enter para sair"
