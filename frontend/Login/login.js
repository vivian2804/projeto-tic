async function entrar(){
    const usu_login = document.getElementById("usu_login").value
    const senha = document.getElementById("senha").value

    const corpo = {usu_login, senha}
    let resposta = await fetch(`http://localhost:3333/usuario/verifica`, {
        method: 'POST',
        body: JSON.stringify(corpo),
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
        alert('Usuário/Senha incorretos')
    }
    else {
        window.location.href = '../index.html';
    }
}