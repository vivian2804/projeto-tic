import { useState } from "react"
import { useNavigate } from "react-router-dom"
import Swal from 'sweetalert2'

export default function Login() {

    const [username, setUsername] = useState('')
    const [password, setPassword] = useState('')

    const navigate = useNavigate()

    const handleLogin = async (e: React.FormEvent<HTMLFormElement>) => {
        e.preventDefault()

        const resp = await fetch(`http://localhost:3000/users?username=${username}`, {
            method: 'GET',
        })        

        .then (resposta => {
            return resposta.json()
        })

        if (resp.length === 0) {
            Swal.fire({
                title: 'Erro',
                text: 'Usuário ou senha estão incorretos',
                icon: 'error',
                confirmButtonText: 'OK'
            })
        } else {
            if (resp[0].password !== password) {
                Swal.fire({
                    title: 'Erro',
                    text: 'Usuário ou senha estão incorretos',
                    icon: 'error',
                    confirmButtonText: 'OK'
                })
            } else {
                Swal.fire({
                    title: 'Sucesso',
                    icon: 'success',
                    confirmButtonText: 'OK'
                }).then((result) => {
                    if (result.isConfirmed) {
                        navigate('/produto', { state: { username: username } });
                    }
                });
            }
        }
    }

    return (
        <div className="bg-slate-700 flex items-center justify-center h-screen w-screen">
            <div className="bg-teal-600 p-8 rounded-lg drop-shadow-2x1 w-96 flex flex-col items-center">
                <h2 className="font-bold mb-4"> Login </h2>
                <form onSubmit={handleLogin}>
                    <div className="mb-4">
                        <label className="block mb-2 font-semibold" htmlFor="username">Username:</label>
                        <input type="text" id="username" value={username} onChange={e => setUsername(e.target.value)} className="w-full border rounded p-2"></input>
                    </div>
                    <div className="mb-4">
                        <label className="block mb-2 font-semibold" htmlFor="password">Password:</label>
                        <input type="password" id="password" value={password} onChange={e => setPassword(e.target.value)} className="w-full border rounded p-2"></input>
                    </div>
                    <button type="submit" className="w-full bg-teal-500 text-white font-semibold p-2 rounded">Login</button>
                </form>
            </div>
        </div>
    )
}