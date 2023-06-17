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

    server.patch('/fornecedor/update', async (request) => {
        const contentBody = z.object({
            id: z.number(),
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
            id,
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
        } = contentBody.parse(request.body)
    
        const fornecedorUpdated = await prisma.tbForncedores.update({
            where: {
                idfor: id,
            },
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
    
        return fornecedorUpdated
    })    

    server.delete('/fornecedor/delete/:id', async (request) => {
        const idParam = z.object({
            id: z.string(),
        })
    
        const { id } = idParam.parse(request.params)
        const fornecedorId = Number(id)
    
        const fornecedorDeleted = await prisma.tbForncedores.delete({
            where: {
                idfor: fornecedorId,
            },
        })
    
        return fornecedorDeleted
    })   
}
