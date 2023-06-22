async function carregarDados() {
    exibirProduto()
    listaUnidades()
    listaTiposProdutos()
}

async function exibirProduto(){    
    const produtos = await fetch(`http://localhost:3333/produtos`)
                        .then(resposta => {
                            return resposta.json()
                        })

    let conteudoTabela = ''

    produtos.forEach(produto => {            

        conteudoTabela += `
            <tr>
                <td>${produto.idproduto}</td>
                <td>${produto.nomeprod}</td>
                <td>${produto.quantminima}</td>
                <td>${produto.idunidade}</td>
                <td>${produto.idtipprod}</td>
                <td>
                    <button onclick="removerProduto(${produto.idproduto})">
                    <i class="bi bi-trash"></i>
                    </button>
                </td>
                <td>
                    <button onclick="editarProduto(${produto.idproduto}, '${produto.nomeprod}', '${produto.quantminima}', '${produto.idunidade}', '${produto.idtipprod}')">
                    <i class="bi bi-pencil"></i>
                    </button>
                </td>
            </tr>
        `;
    })

    document.getElementById("corpoTabela").innerHTML = conteudoTabela
}

function editarProduto(idproduto, nomeprod, quantminima, idunidade, idtipprod){

    document.getElementById("id").value = idproduto;
    document.getElementById("nomeprod").value = nomeprod;
    document.getElementById("quantminima").value = quantminima;
    document.getElementById("idunidade").value = idunidade;
    document.getElementById("idtipprod").value = idtipprod;
}


async function removerProduto(idproduto){
    const confirmacao = confirm('Confirma a exclusão do Produto? ')
    if (!confirmacao){
        return 
    }
    
    await fetch(`http://localhost:3333/produtos/delete/${idproduto}`, {
        method: 'DELETE'
    })
    .then(resposta => {
        alert('Produto excluido com sucesso')
    })
    .catch(error => {
        alert('Ops! <br> Ocorreu um problema ao excluir o produto')
    })
    exibirProduto()
}

async function salvarProduto(){

    const idproduto   = Number(document.getElementById("id").value);
    const nomeprod    = document.getElementById("nomeprod").value;
    const quantminima = Number(document.getElementById("quantminima").value);
    const idunidade   = Number(document.getElementById("idunidade").value);
    const idtipprod   = Number(document.getElementById("idtipprod").value);

    let corpo
    let verbo
    let url

    if (idproduto) {
        corpo = {idproduto, nomeprod, idtipprod, idunidade, quantminima}
        verbo = 'PUT'
        url = 'http://localhost:3333/produtos/update'
    } else {
        corpo = {nomeprod, idtipprod, idunidade, quantminima}
        verbo = 'POST'
        url = 'http://localhost:3333/produtos/add'
    }
     
    const produto = await fetch(url, {
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

    exibirProduto()

    document.getElementById("id").value = '';
    document.getElementById("nomeprod").value = '';
    document.getElementById("quantminima").value = '';
    document.getElementById("idunidade").value = '';
    document.getElementById("idtipprod").value = '';
}

async function listaUnidades(){

    let conteudoSelect = '<option></option>'

    const unidadesMedida = await fetch('http://localhost:3333/unidadeMedida')

    .then(resp => {
        return resp.json()
    })
    .catch(error => {
        alert(`Erro na execução ${error}`)
        exit(0) 
    })

    unidadesMedida.forEach( unidade => {
        conteudoSelect += `<option value='${unidade.idunidade}'> ${unidade.nomeunidade} </option>`
     })

     document.getElementById("idunidade").innerHTML = conteudoSelect
}

async function listaTiposProdutos(){

    let conteudoSelect = '<option></option>'

    const tiposProdutos = await fetch('http://localhost:3333/tiposProdutos')

    .then(resp => {
        return resp.json()
    })
    .catch(error => {
        alert(`Erro na execução ${error}`)
        exit(0) 
    })

    tiposProdutos.forEach( tiposProduto => {
        conteudoSelect += `<option value='${tiposProduto.idtipprod}'> ${tiposProduto.nometipprod} </option>`
     })

     document.getElementById("idtipprod").innerHTML = conteudoSelect
}