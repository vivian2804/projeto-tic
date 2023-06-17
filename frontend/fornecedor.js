async function getFornecedor(){
    // consome a API e guarda o resultado em posts
    // recupera o cookie do id do usuário
    let aux = document.cookie.split('=')
    let fornecedorId = Number(aux[1])
    const posts = await fetch(`http://localhost:3333/fornecedor/${fornecedorId}`)
                        .then(resposta => {
                            return resposta.json()
                        })

    let conteudoTabela = ''
    // percorre cada post presente em posts e montar o conteúdo da tabela
    posts.forEach( post => {            
        // acumula na variável conteudoTabela os dados de cada post
        conteudoTabela += `<tr> <td> ${post.id} </td> <td> ${post.name} </td> <td> ${post.type_person} </td> <td> ${post.likes} </td> <td> ${post.published} </td> <td> <button onclick="remover(${post.id})"> <i class="bi bi-trash"></i> </button> </td> <td> <button onclick="editar(${post.id}, '${post.title}', '${post.content}', ${post.likes}, ${post.published})">  <i class="bi bi-pencil"></i> </button> </td> </tr>`
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
    const name        = document.getElementById("name").value
    const email       = document.getElementById("email").value
    const cpf_cnpj    = document.getElementById("cpf_cnpj").value
    const telefone    = document.getElementById("telefone").value
    const fisico      = document.getElementById("fisico").checked
    const juridico    = document.getElementById("juridico").checked
    const rua         = document.getElementById("rua").value
    const bairro      = document.getElementById("bairro").value
    const numero      = Number(document.getElementById("numero").value)
    const complemento = document.getElementById("complemento").value

    // o id será vazio se for inserção e terá conteúdo se for atualização
    const id = Number(document.getElementById("id").value)
   
    let corpo
    let verbo
    if (id) { // atualizar
        corpo = {id, name, email, cpf_cnpj, telefone, rua, bairro, numero, complemento}
        verbo = 'PUT'
    }
    else { // cadastrar
        // recupera o cookie
        let aux = document.cookie.split('=')
        let userId = Number(aux[1])
        corpo = {name, email, cpf_cnpj, telefone, userId, rua, bairro, numero, complemento}
        verbo = 'POST'
    }
     
    // chama a api
    const post = await fetch('http://localhost:3333/fornecedor/add', {
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
    document.getElementById("name").value = ''
    document.getElementById("email").value = ''
    document.getElementById("cpf_cnpj").value = ''
    document.getElementById("telefone").value = ''
    document.getElementById("fisico").checked = false
    document.getElementById("juridico").checked = false
    document.getElementById("rua").value = ''
    document.getElementById("bairro").value = ''
    document.getElementById("numero").value ='0'
    document.getElementById("complemento").value = ''
}