async function exibirTiposProdutos(){    
    const tiposProdutos = await fetch(`http://localhost:3333/tiposProdutos`)
                        .then(resposta => {
                            return resposta.json()
                        })

    let conteudoTabela = ''

    tiposProdutos.forEach(tipoProduto => {            

        conteudoTabela += `
            <tr>
                <td>${tipoProduto.idtipprod}</td>
                <td>${tipoProduto.nometipprod}</td>
                <td>
                    <button onclick="removerFornecedor(${tipoProduto.idtipprod})">
                    <i class="bi bi-trash"></i>
                    </button>
                </td>
                <td>
                    <button onclick="editarFornecedor(${tipoProduto.idtipprod}, '${tipoProduto.nometipprod}')">
                    <i class="bi bi-pencil"></i>
                    </button>
                </td>
            </tr>
        `;
    })

    document.getElementById("corpoTabela").innerHTML = conteudoTabela
}

function editarFornecedor(idtipprod, nometipprod){

    document.getElementById("idtipprod").value = idtipprod;
    document.getElementById("nometipprod").value = nometipprod;
}


async function removerTipoProduto(idtipprod){
    const confirmacao = confirm('Confirma a exclusão do Tipo de Produto? ')
    if (!confirmacao){
        return 
    }
    
    await fetch(`http://localhost:3333/tiposProdutos/delete/${idtipprod}`, {
        method: 'DELETE'
    })
    .then(resposta => {
        alert('Tipo de Produto excluido com sucesso')
    })
    .catch(error => {
        alert('Ops! <br> Ocorreu um problema ao excluir o Tipo de Produto')
    })
    exibirTiposProdutos()
}

async function salvarTipoProduto(){
    const nometipprod     = document.getElementById("nometipprod").value;
    const idtipprod       = Number(document.getElementById("idtipprod").value);

    let corpo
    let verbo
    let url

    if (idtipprod) {
        corpo = {idtipprod, nometipprod}
        verbo = 'PUT'
        url = 'http://localhost:3333/tiposProdutos/update'
    }
    else {
        corpo = {nometipprod}
        verbo = 'POST'
        url = 'http://localhost:3333/tiposProdutos/add'
    }
     
    const tipoProduto = await fetch(url, {
        method: verbo,
        body: JSON.stringify(corpo),
        headers: {
            "Content-Type": "application/json;charset=UTF-8"
        }
    })
    .then( resposta => {
       alert('Operação realizada com sucesso')
    })
    .catch(error => {
        alert('Operação falhou')
    })

    exibirTiposProdutos()

    document.getElementById("nometipprod").value = '';
    document.getElementById("idtipprod").value = '';
}