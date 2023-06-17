async function getFornecedor(){    
    const fornecedores = await fetch(`http://localhost:3333/fornecedor`)
                        .then(resposta => {
                            return resposta.json()
                        })

    let conteudoTabela = ''
    // percorre cada post presente em posts e montar o conteúdo da tabela
    fornecedores.forEach(fornecedor => {            
        // acumula na variável conteudoTabela os dados de cada post
        conteudoTabela += `<tr> <td> ${fornecedor.id} </td> <td> ${fornecedor.nomefor} </td> <td> ${fornecedor.email} </td> <td> ${fornecedor.cpfcnpj} </td> <td> ${fornecedor.telefone} </td> <td> ${fornecedor.fisjur} </td> <td> ${fornecedor.cep} </td> <td> ${fornecedor.cidade} </td> <td> ${fornecedor.rua} </td> <td> ${fornecedor.bairro} </td> <td> ${fornecedor.numero} </td> <td> ${fornecedor.complemento} </td></tr>`
    })
    // vamos jogar os dados no HTML
    document.getElementById("corpoTabela").innerHTML = conteudoTabela

}

function editar(id, title, content, likes, published){
    // alimenta o formulário
    document.getElementById("id").value = id
    document.getElementById("title").value = title;
    document.getElementById("content").value = content;
    document.getElementById("likes").value = likes;
    (published) ? document.getElementById("sim").checked = true : 
                  document.getElementById("nao").checked = true
}


async function remover(id){
    const confirmacao = confirm('Confirma a exclusão do Post? ')
    if (!confirmacao){ // clicou em não
        return 
    }
    // clicou em sim
    await fetch(`http://localhost:3333/post/${id}`, {
        method: 'DELETE'
    })
    .then(resposta => {
        alert('Remoção realizada')
    })
    .catch(error => {
        alert('Problema na remoção')
    })
    getFornecedor() // atualiza a tabela
}
// consome que api que cadastra um post no banco de dados
async function confirmar(){
    // recupera os dados do formulário
    const nomefor     = document.getElementById("nomefor").value
    const email       = document.getElementById("email").value
    const cnpjcpf    = document.getElementById("cnpjcpf").value
    const telefone    = document.getElementById("telefone").value
    const fisico      = document.getElementById("fisico").checked
    const juridico    = document.getElementById("juridico").checked
    const cep         = document.getElementById("cep").value
    const rua         = document.getElementById("rua").value
    const cidade      = document.getElementById("cidade").value
    const bairro      = document.getElementById("bairro").value
    const numero      = Number(document.getElementById("numero").value)
    const complemento = document.getElementById("complemento").value

    // o id será vazio se for inserção e terá conteúdo se for atualização
    const id = Number(document.getElementById("id").value)

    if (!fisico) { // atualizar
        fisjur = 'F'
    }
    else { // cadastrar
        fisjur = 'J'
    }
   
    let corpo
    let verbo
    if (id) { // atualizar
        corpo = {id, nomefor, email, cnpjcpf, telefone, cep, rua, cidade, bairro, numero, complemento}
        verbo = 'PUT'
    }
    else { // cadastrar
        corpo = {nomefor, email, cnpjcpf, telefone, fisjur, cep, rua, cidade, bairro, numero, complemento}
        verbo = 'POST'
    }
     
    // chama a api
    const fornecedor = await fetch('http://localhost:3333/fornecedor/add', {
        method: verbo,
        body: JSON.stringify(corpo), // JSON transformado em string
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
    // atualiza a tabela
    getFornecedor()
    // limpa os campos
    document.getElementById("nomefor").value = ''
    document.getElementById("email").value = ''
    document.getElementById("cnpjcpf").value = ''
    document.getElementById("telefone").value = ''
    document.getElementById("fisico").checked = false
    document.getElementById("juridico").checked = false
    document.getElementById("cep").value = ''
    document.getElementById("rua").value = ''
    document.getElementById("cidade").value = ''
    document.getElementById("bairro").value = ''
    document.getElementById("numero").value =''
    document.getElementById("complemento").value = ''
    document.getElementById("id").value = '';
}