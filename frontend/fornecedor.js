async function exibirFornecedor(){    
    const fornecedores = await fetch(`http://localhost:3333/fornecedor`)
                        .then(resposta => {
                            return resposta.json()
                        })

    let conteudoTabela = ''

    fornecedores.forEach(fornecedor => {            

        conteudoTabela += `
            <tr>
                <td>${fornecedor.idfor}</td>
                <td>${fornecedor.nomefor}</td>
                <td>${fornecedor.email}</td>
                <td>${fornecedor.cnpjcpf}</td>
                <td>${fornecedor.telefone}</td>
                <td>${fornecedor.fisjur}</td>
                <td>${fornecedor.cep}</td>
                <td>${fornecedor.cidade}</td>
                <td>${fornecedor.rua}</td>
                <td>${fornecedor.bairro}</td>
                <td>${fornecedor.numero}</td>
                <td>${fornecedor.complemento}</td>
                <td>
                    <button onclick="removerFornecedor(${fornecedor.idfor})">
                    <i class="bi bi-trash"></i>
                    </button>
                </td>
                <td>
                    <button onclick="editarFornecedor(${fornecedor.idfor}, '${fornecedor.nomefor}', '${fornecedor.email}', '${fornecedor.cnpjcpf}', '${fornecedor.telefone}', '${fornecedor.fisjur}', '${fornecedor.cep}', '${fornecedor.cidade}', '${fornecedor.rua}', '${fornecedor.bairro}', ${fornecedor.numero}, '${fornecedor.complemento}')">
                    <i class="bi bi-pencil"></i>
                    </button>
                </td>
            </tr>
        `;
    })

    document.getElementById("corpoTabela").innerHTML = conteudoTabela
}

function editarFornecedor(idfor, nomefor, email, cnpjcpf, fisjur, telefone, cep, cidade, rua, bairro, numero, complemento){

    document.getElementById("id").value = idfor
    document.getElementById("nomefor").value = nomefor;
    document.getElementById("email").value = email;
    document.getElementById("cnpjcpf").value = cnpjcpf;
    (fisjur) ? document.getElementById("fisico").checked = true : document.getElementById("juridico").checked = true;
    document.getElementById("telefone").value = telefone;
    document.getElementById("cep").value = cep;
    document.getElementById("cidade").value = cidade;
    document.getElementById("rua").value = rua;
    document.getElementById("bairro").value = bairro;
    document.getElementById("numero").value = numero;
    document.getElementById("complemento").value = complemento;
}


async function removerFornecedor(idfor){
    const confirmacao = confirm('Confirma a exclusão do Fornecedor? ')
    if (!confirmacao){
        return 
    }
    
    await fetch(`http://localhost:3333/fornecedor/delete/${idfor}`, {
        method: 'DELETE'
    })
    .then(resposta => {
        alert('Fornecedor excluido com sucesso')
    })
    .catch(error => {
        alert('Ops! <br> Ocorreu um problema ao excluir o fornecedor')
    })
    exibirFornecedor()
}

async function salvarFornecedor(){
    const nomefor     = document.getElementById("nomefor").value
    const email       = document.getElementById("email").value
    const cnpjcpf     = document.getElementById("cnpjcpf").value
    const telefone    = document.getElementById("telefone").value
    const jurfis      = document.getElementById("fisico").checked
    const cep         = document.getElementById("cep").value
    const rua         = document.getElementById("rua").value
    const cidade      = document.getElementById("cidade").value
    const bairro      = document.getElementById("bairro").value
    const numero      = Number(document.getElementById("numero").value)
    const complemento = document.getElementById("complemento").value
    const idfor       = Number(document.getElementById("id").value)

    fisjur = jurfis ? 'F' : 'J';

    let corpo
    let verbo
    let url

    if (idfor) {
        corpo = {idfor, nomefor, email, cnpjcpf, telefone, fisjur, cep, rua, cidade, bairro, numero, complemento}
        verbo = 'PUT'
        url = 'http://localhost:3333/fornecedor/update'
    }
    else {
        corpo = {nomefor, email, cnpjcpf, telefone, fisjur, cep, rua, cidade, bairro, numero, complemento}
        verbo = 'POST'
        url = 'http://localhost:3333/fornecedor/add'
    }
     
    const fornecedor = await fetch(url, {
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

    exibirFornecedor()

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
    document.getElementById("numero").value = ''
    document.getElementById("complemento").value = ''
    document.getElementById("id").value = ''
}