async function exibirUnidadesMedidas(){    
    const unidadeMedida = await fetch(`http://localhost:3333/unidadeMedida`)
                        .then(resposta => {
                            return resposta.json()
                        })

    let conteudoTabela = ''

    unidadeMedida.forEach(unidadeMedida => {            

        conteudoTabela += `
            <tr>
                <td>${unidadeMedida.idunidade}</td>
                <td>${unidadeMedida.siglaun}</td>
                <td>${unidadeMedida.nomeunidade}</td>
                <td>
                    <button onclick="removerUnidadeMedida(${unidadeMedida.idunidade})">
                    <i class="bi bi-trash"></i>
                    </button>
                </td>
                <td>
                    <button onclick="editarUnidadeMedida(${unidadeMedida.idunidade}, '${unidadeMedida.siglaun}', '${unidadeMedida.nomeunidade}')">
                    <i class="bi bi-pencil"></i>
                    </button>
                </td>
            </tr>
        `;
    })

    document.getElementById("corpoTabela").innerHTML = conteudoTabela
}

function editarUnidadeMedida(idunidade, siglaun, nomeunidade){

    document.getElementById("id").value = idunidade;
    document.getElementById("siglaun").value = siglaun;
    document.getElementById("nomeunidade").value = nomeunidade;
}


async function removerFornecedor(idunidade){
    const confirmacao = confirm('Confirma a exclusão da unidade de medida? ')
    if (!confirmacao){
        return 
    }
    
    await fetch(`http://localhost:3333/unidadeMedida/delete/${idunidade}`, {
        method: 'DELETE'
    })
    .then(resposta => {
        alert('Unidade de Medida excluida com sucesso!!')
    })
    .catch(error => {
        alert('Ops! <br> Ocorreu um problema ao excluir a Unidade de Medida')
    })
    exibirUnidadesMedidas()
}

async function salvarFornecedor(){
    const siglaun     = document.getElementById("siglaun").value;
    const nomeunidade       = document.getElementById("nomeunidade").value;

    let corpo
    let verbo
    let url

    if (idunidade) {
        corpo = {idfor, siglaun, nomeunidade}
        verbo = 'PUT'
        url = 'http://localhost:3333/unidadeMedida/update'
    }
    else {
        corpo = {siglaun, nomeunidade}
        verbo = 'POST'
        url = 'http://localhost:3333/unidadeMedida/add'
    }
     
    const unidadeMedida = await fetch(url, {
        method: verbo,
        body: JSON.stringify(corpo),
        headers: {
            "Content-Type": "application/json;charset=UTF-8"
        }
    })
    .then( resposta => {
       alert('Operação realizada com sucesso!')
    })
    .catch(error => {
        alert('Operação falhou!')
    })

    exibirUnidadesMedidas()

    document.getElementById("siglaun").value = '';
    document.getElementById("nomeunidade").value = '';
}