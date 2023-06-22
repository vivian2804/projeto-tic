async function exibirLocais(){    
    const locaisEstoque = await fetch(`http://localhost:3333/locaisEstoque`)
                        .then(resposta => {
                            return resposta.json()
                        })

    let conteudoTabela = ''

    locaisEstoque.forEach(localEstoque => {            

        conteudoTabela += `
            <tr>
                <td>${localEstoque.idlocal}</td>
                <td>${localEstoque.nomelocal}</td>
                <td>
                    <button onclick="removerLocal(${localEstoque.idlocal})">
                    <i class="bi bi-trash"></i>
                    </button>
                </td>
                <td>
                    <button onclick="editarLocal(${localEstoque.idlocal}, '${localEstoque.nomelocal}')">
                    <i class="bi bi-pencil"></i>
                    </button>
                </td>
            </tr>
        `;
    })

    document.getElementById("corpoTabela").innerHTML = conteudoTabela
}

async function editarLocal(idlocal, nomelocal){

    document.getElementById("idlocal").value = idlocal;
    document.getElementById("nomelocal").value = nomelocal;
}


async function removerLocal(idlocal){
    const confirmacao = confirm('Confirma a exclusão do Local de Estoque? ')
    if (!confirmacao){
        return 
    }
    
    await fetch(`http://localhost:3333/locaisEstoque/delete/${idlocal}`, {
        method: 'DELETE'
    })
    
    .then(resposta => {
        alert('Local de Estoque excluido com sucesso')
    })
    .catch(error => {
        alert('Ops! <br> Ocorreu um problema ao excluir o Local de Estoque')
    })

    exibirLocais()
}

async function salvarLocal(){
    const nomelocal     = document.getElementById("nomelocal").value;
    const idlocal       = Number(document.getElementById("idlocal").value);

    let corpo
    let verbo
    let url

    if (idlocal) {
        corpo = {idlocal, nomelocal}
        verbo = 'PUT'
        url = 'http://localhost:3333/locaisEstoque/update'
    }
    else {
        corpo = {nomelocal}
        verbo = 'POST'
        url = 'http://localhost:3333/locaisEstoque/add'
    }
     
    const localEstoque = await fetch(url, {
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

    exibirLocais()

    document.getElementById("nomelocal").value = '';
    document.getElementById("idlocal").value = '';
}