import { useEffect, useState } from "react";
import { Produto } from "./Produtos";
import { useLocation } from "react-router-dom";

interface ProdutoProps {
    id: number,
    name: string,
    description: string,
    price: number,
    qty: number
}

export function ProdutoP() {

    const location = useLocation()

    const username = location.state?.username || ''

    const [products, setProducts] = useState<ProdutoProps[]>([])

    useEffect(() => {
        const buscaProdutos = async () => {
            try {
                const resp = await fetch(`http://localhost:3000/products`)
            } catch (error) {
                alert(error)
            }
        }
        buscaProdutos()
    }, [username])

    return (
        <div className='App'>
            <h1> Bem-Vindo {username} </h1>
            <Produto nome='Produto 1' descricao='Descricao 1' quantidade={10} preco={100} />
            <Produto nome='Produto 2' descricao='Descricao 2' quantidade={20} preco={200} />
        </div>
    )
}