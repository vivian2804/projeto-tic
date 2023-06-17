import {FastifyInstance} from 'fastify'
import {z} from 'zod'
import {prisma} from './lib/prisma'

export async function AppRoutes(server:FastifyInstance){

    server.get('/fornecedor/:fornecedorId', async (request) => {
        const fornecedorIdParam = z.object({
            fornecedorId: z.string(),
        })
    
        const { fornecedorId } = fornecedorIdParam.parse(request.params)
    
        const fornecedor = await prisma.tbForncedores.findUnique({
            where: {
                idfor: Number(fornecedorId),
            },
        })
    
        return fornecedor
    })
    
    server.post('/fornecedor/add', async (request) => {
        const postBody = z.object({
            nomefor: z.string(),
            fisjur: z.string(),
            cnpjcpf: z.string(),
            telefone: z.string(),
            cep: z.string(),
            cidade: z.string(),
            rua: z.string(),
            bairro: z.string(),
            numero: z.number(),
            complemento: z.string(),
            email: z.string(),
        })
    
        const {
            nomefor,
            fisjur,
            cnpjcpf,
            telefone,
            cep,
            cidade,
            rua,
            bairro,
            numero,
            complemento,
            email,
        } = postBody.parse(request.body)
    
        const newForncedor = await prisma.tbForncedores.create({
            data: {
                nomefor,
                fisjur,
                cnpjcpf,
                telefone,
                cep,
                cidade,
                rua,
                bairro,
                numero,
                complemento,
                email,
            },
        })
    
        return newForncedor
    })        

    // rota para atualizar o conteúdo de um post
    server.patch('/post/content', async (request) => {
        // cria um objeto zod para definir um esquema de dad0s
        const contentBody = z.object({
            id: z.number(),
            content: z.string()
        })
        // recupera os dados do frontend
        const {id, content} = contentBody.parse(request.body)
        // atualiza no banco de dados
        const postUpdated = await prisma.post.update({
            where: {
                id: id
            },
            data: {
                content: content
            }
        })
        return postUpdated
    })

    // rota para remover um post do banco de dados
    server.delete('/post/:id', async (request) => {
        // criar objeto zod para esquema de dados
        const idParam = z.object({
            id: z.string()
        })
        // recupera o id do frontend
        const {id} = idParam.parse(request.params)

    const idNumber = Number(id)
        // remove do banco de dados
        const postDeleted = await prisma.post.delete({
            where: {
                id: idNumber
            }
        })
        return postDeleted
    })
}
