async function cadastrar(){
    const usu_login = document.getElementById("usu_login").value
    const nome      = document.getElementById("nome").value
    const senha     = document.getElementById("senha").value

    const corpo_usuario = {usu_login}

    let resposta = await fetch(`http://localhost:3333/cadastro/verifica`, {
        method: 'POST',
        body: JSON.stringify(corpo_usuario),
        headers: {
            'Content-Type': 'application/json;charset=UTF-8'
        }
    })

    .then(resp => {
        return resp.json()
    })
    .catch(error => {
        alert(`Erro na execução ${error}`)
        exit(0) 
    })
    
    if (resposta == null){

        const corpo = {usu_login, nome, senha}
    
        await fetch(`http://localhost:3333/usuario/add`, {
            method: 'POST',
            body: JSON.stringify(corpo),
            headers: {
                'Content-Type': 'application/json;charset=UTF-8'
            }
        })

        .then(resp => {
            alert('Usuario cadastrado com sucesso')
            window.location.href = 'login.html';
        })
        .catch(error => {
            alert('Operação falhou')
        })

    } else {
        alert('Nome de Usuarios já Cadastrado')
    }
}