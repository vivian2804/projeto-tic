interface ProdutoProps {
    nome: string,
    descricao: string,
    quantidade: number,
    preco: number
}

export function Produto(prod:ProdutoProps) {
    return (
        <div className="bg-zinc-900 w-full h-10 text-white rounded m-2 flex items-center justify-center">
            nome: {prod.nome}
            descricao: {prod.descricao}
            quantidade: {prod.quantidade}
            preco: {prod.preco}
        </div>
    )
}

export default Produto;