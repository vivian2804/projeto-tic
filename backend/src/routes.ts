import {FastifyInstance} from 'fastify'
import {z} from 'zod'
import {prisma} from './lib/prisma'

export async function AppRoutes(server:FastifyInstance){

    // CRUD Fornecedor

    server.get('/fornecedor', async () => {        
        const fornecedor = await prisma.tbFornecedores.findMany()
    
        return fornecedor
    })
    
    server.post('/fornecedor/add', async (request) => {
        const postBody = z.object({
            nomefor: z.string(),
            email: z.string(),
            cnpjcpf: z.string(),
            telefone: z.string(),
            fisjur: z.string(),
            cep: z.string(),
            rua: z.string(),
            cidade: z.string(),
            bairro: z.string(),
            numero: z.number(),
            complemento: z.string(),
        })
    
        const {
            nomefor,
            email,
            cnpjcpf,
            telefone,
            fisjur,
            cep,
            rua,
            cidade,
            bairro,
            numero,
            complemento,
        } = postBody.parse(request.body)
    
        const newForncedor = await prisma.tbFornecedores.create({
            data: {
                nomefor,
                email,
                cnpjcpf,
                telefone,
                fisjur,
                cep,
                rua,
                cidade,
                bairro,
                numero,
                complemento,
            },
        })
    
        return newForncedor
    })        
    
    server.put('/fornecedor/update', async (request) => {
        const putBody = z.object({
            idfor: z.number(),
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
            idfor,
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
        } = putBody.parse(request.body)

        const fornecedorUpdated = await prisma.tbFornecedores.updateMany({
            where: {
                idfor: idfor,
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
        return (fornecedorUpdated.count >= 1) ?  'Atualização com sucesso' :  'Nada foi atualizado'
    })

    server.delete('/fornecedor/delete/:idfor', async (request) => {
        const idParam = z.object({
            idfor: z.string(),
        })
    
        const { idfor } = idParam.parse(request.params)
        const fornecedorId = Number(idfor)
    
        const fornecedorDeleted = await prisma.tbFornecedores.delete({
            where: {
                idfor: fornecedorId,
            },
        })
    
        return fornecedorDeleted
    })   



    // CRUD Unidades de medidas

    server.get('/unidadeMedida', async () => {        
        const unidadeMedida = await prisma.tbUnidadeMedida.findMany()
    
        return unidadeMedida
    })
    
    server.post('/unidadeMedida/add', async (request) => {
        const postBody = z.object({
            siglaun: z.string(),
            nomeunidade: z.string(),
        })
    
        const {
            siglaun,
            nomeunidade,
        } = postBody.parse(request.body)
    
        const newUnidadeMedida = await prisma.tbUnidadeMedida.create({
            data: {
                siglaun,
                nomeunidade,
            },
        })
    
        return newUnidadeMedida
    })        
    
    server.put('/unidadeMedida/update', async (request) => {
        const putBody = z.object({
            idunidade: z.number(),
            siglaun: z.string(),
            nomeunidade: z.string()
        })
    
        const {
            idunidade,
            siglaun,
            nomeunidade
        } = putBody.parse(request.body)

        const unidadeMedidaUpdate = await prisma.tbUnidadeMedida.updateMany({
            where: {
                idunidade: idunidade,
            },
            data: {
                siglaun,
                nomeunidade
            },
        })
        return (unidadeMedidaUpdate.count >= 1) ?  'Atualização com sucesso' :  'Nada foi atualizado'
    })

    server.delete('/unidadeMedida/delete/:idunidade', async (request) => {
        const idParam = z.object({
            idunidade: z.string(),
        })
    
        const { idunidade } = idParam.parse(request.params)
        const UnidadeMedidaID = Number(idunidade)
    
        const unidadeMedidaDeleted = await prisma.tbUnidadeMedida.delete({
            where: {
                idunidade: UnidadeMedidaID,
            },
        })
    
        return unidadeMedidaDeleted
    }) 
    
    

    // CRUD TIPOS DE PRODUTOS

    server.get('/tiposProdutos', async () => {        
        const tiposProdutos = await prisma.tbTiposProdutos.findMany()
    
        return tiposProdutos
    })
    
    server.post('/tiposProdutos/add', async (request) => {
        const bodyData = z.object({
            nometipprod: z.string()
        })
    
        const {nometipprod} = bodyData.parse(request.body)
    
        const newTipProd = await prisma.tbTiposProdutos.create({
            data: {
                nometipprod,
            },
        })
    
        return newTipProd
    })        
    
    server.put('/tiposProdutos/update', async (request) => {
        const putBody = z.object({
            idtipprod: z.number(),
            nometipprod: z.string()
        })
    
        const {idtipprod,nometipprod} = putBody.parse(request.body)

        const tipoProdutoUpdate = await prisma.tbTiposProdutos.updateMany({
            where: {
                idtipprod: idtipprod,
            },
            data: {
                nometipprod
            },
        })
        return (tipoProdutoUpdate.count >= 1) ?  'Atualização com sucesso' :  'Nada foi atualizado'
    })

    server.delete('/tiposProdutos/delete/:idtipprod', async (request) => {
        const idParam = z.object({
            idtipprod: z.string(),
        })
    
        const { idtipprod } = idParam.parse(request.params)
        const tipProdId = Number(idtipprod)
    
        const tipProdDeleted = await prisma.tbTiposProdutos.delete({
            where: {
                idtipprod: tipProdId,
            },
        })
    
        return tipProdDeleted
    })
    
    // Login

    server.post('/usuario/add', async (request) => {
        const postBody = z.object({
            usu_login: z.string(),
            nome: z.string(),
            senha: z.string(),
        })

        const dtcriacao = new Date();
    
        const {
            usu_login,
            nome,
            senha,
        } = postBody.parse(request.body)
    
        const newUsuario = await prisma.tbUsuarios.create({
            data: {
                usu_login,
                nome,
                senha,
                dtcriacao
            },
        })
    
        return newUsuario
    })

    server.post('/cadastro/verifica', async (request) => {
        const verificaBody = z.object({
            usu_login: z.string(),
        })

        const {usu_login} = verificaBody.parse(request.body)
        const result = await prisma.tbUsuarios.findFirst({
            where: {
                usu_login
            }
        })
        return result // retorna null se não encontrar e o objeto se encontra
    })

    server.post('/usuario/verifica', async (request) => {
        const verificaBody = z.object({
            usu_login: z.string(),
            senha: z.string()
        })
        const {usu_login, senha} = verificaBody.parse(request.body)
        const result = await prisma.tbUsuarios.findFirst({
            where: {
                usu_login,
                senha
            }
        })
        return result // retorna null se não encontrar e o objeto se encontra
    })


    //CRUD - Produtos (Conectada a outras entidades)

    server.get('/produtos', async () => {
        const produtos = await prisma.tbProdutos.findMany()

        return produtos
    })

    server.post('/produtos/add', async (request) => {
        const putBody = z.object({
            nomeprod: z.string(),
            idtipprod: z.number(),
            idunidade: z.number(),
            quantminima: z.number()
        })

        const {
            nomeprod,
            idtipprod,
            idunidade,
            quantminima,
        } = putBody.parse(request.body)

        //Verifica se existe id de unidade
        const confereIdUnidade = await prisma.tbUnidadeMedida.findUnique({
            where: { idunidade: idunidade },
          });

         if (!confereIdUnidade) {
            return ('Unidade não existe');
        }

        //Verifica se existe id de tipo do produto
        const confereIdTipoProd = await prisma.tbTiposProdutos.findUnique({
            where: { idtipprod: idtipprod },
          });

        if (!confereIdTipoProd) {
            return ('Tipo do produto não existe');
        }

        const newProduto = await prisma.tbProdutos.create({
            data: {
                nomeprod,
                idtipprod,
                idunidade,
                quantminima
            },
        })

        return newProduto
    })

    server.put('/produtos/update', async (request) => {
        const putBody = z.object({
            idproduto: z.number(),
            nomeprod: z.string(),
            idtipprod: z.number(),
            idunidade: z.number(),
            quantminima: z.number()
        })
    
        const { idproduto,
                nomeprod,
                idtipprod,
                idunidade,
                quantminima} = putBody.parse(request.body)

        //Verifica se existe id de unidade
        const confereIdUnidade = await prisma.tbUnidadeMedida.findUnique({
            where: { idunidade: idunidade },
          });

         if (!confereIdUnidade) {
            return ('Unidade não existe');
        }

        //Verifica se existe id de tipo do produto
        const confereIdTipoProd = await prisma.tbTiposProdutos.findUnique({
            where: { idtipprod: idtipprod },
          });

        if (!confereIdTipoProd) {
            return ('Tipo do produto não existe');
        }        

        const produtoUpdate = await prisma.tbProdutos.updateMany({
            where: {
                idproduto: idproduto,
            },
            data: {
                nomeprod,
                idtipprod,
                idunidade,
                quantminima
            },
        })
        return (produtoUpdate.count >= 1) ?  'Atualização com sucesso' :  'Nada foi atualizado'
    })

    server.delete('/produtos/delete/:produtoId', async (request) => {
        const idParam = z.object({
            produtoId: z.string(),
        })

        const { produtoId } = idParam.parse(request.params)

        const idproduto = Number(produtoId)

        const produtosDeleted = await prisma.tbProdutos.delete({
            where: {
                idproduto: idproduto,
            },
        })

        return produtosDeleted
    })

    // CRUD Locais de estoque

    server.get('/locaisEstoque', async () => {
        const locaisEstoque = await prisma.tbLocais.findMany()

        return locaisEstoque
    })

    server.post('/locaisEstoque/add', async (request) => {
        const bodyData = z.object({
            nomelocal : z.string()
        })

        const {nomelocal} = bodyData.parse(request.body)

        const newLocalEstoque = await prisma.tbLocais.create({
            data: {
                nomelocal
            },
        })

        return newLocalEstoque
    })

    server.put('/locaisEstoque/update', async (request) => {
        const putBody = z.object({
            idlocal : z.number(),
            nomelocal : z.string()
        })

        const {idlocal,
              nomelocal} = putBody.parse(request.body)

        const locaisUpdate = await prisma.tbLocais.updateMany({
            where: {
                idlocal : idlocal,
            },
            data: {
                nomelocal
            },
        })
        return (locaisUpdate.count >= 1) ?  'Atualização realizada com sucesso!' :  'Nada foi atualizado!'
    })

    server.delete('/locaisEstoque/delete/:LocalId', async (request) => {
        const idParam = z.object({
            LocalId: z.string(),
        })

        const { LocalId } = idParam.parse(request.params)
        const idlocal = Number(LocalId)

        const locaisDeleted = await prisma.tbLocais.delete({
            where: {
                idlocal: idlocal,
            },
        })

        return locaisDeleted
    })

        //CRUD - ESTOQUE (Conectada a outras entidades)

        server.get('/estoque', async () => {
            const estoque = await prisma.tbEstoque.findMany()
    
            return estoque
        })
    
        server.post('/estoque/add', async (request) => {
            const putBody = z.object({
                idmovimento: z.number(),
                seqitem: z.number(),
                idlocal: z.number(),
                idproduto: z.number(),
                quantidade: z.number(),
                dtinc: z.date()
            })
    
            const {
                idmovimento,
                seqitem,
                idlocal,
                idproduto,
                quantidade,
                dtinc
            } = putBody.parse(request.body)
    
            //Verifica se existe id do local
            const confereLocal = await prisma.tbLocais.findUnique({
                where: { idlocal: idlocal },
              });
    
             if (!confereLocal) {
                return ('Local de estoque não existe');
            }
    
            //Verifica se existe id do produto
            const confereProduto = await prisma.tbProdutos.findUnique({
                where: { idproduto: idproduto },
              });
    
            if (!confereProduto) {
                return ('Produto não existe');
            }
    
            const newEntry = await prisma.tbEstoque.create({
                data: {
                    idmovimento,
                    seqitem,
                    idlocal,
                    idproduto,
                    quantidade,
                    dtinc
                },
            })
    
            return newEntry
        })
    
        server.put('/estoque/update', async (request) => {
            const putBody = z.object({
                idestoque: z.number(),
                idmovimento: z.number(),
                seqitem: z.number(),
                idlocal: z.number(),
                idproduto: z.number(),
                quantidade: z.number(),
                dtinc: z.date()
            })
        
            const { idestoque,
                    idmovimento,
                    seqitem,
                    idlocal,
                    idproduto,
                    quantidade,
                    dtinc} = putBody.parse(request.body)
    
            //Verifica se existe id de local
            const confereLocal = await prisma.tbLocais.findUnique({
                where: { idlocal: idlocal },
              });
    
             if (!confereLocal) {
                return ('Local não existe');
            }
    
            //Verifica se existe id de tipo do produto
            const confereProduto = await prisma.tbProdutos.findUnique({
                where: { idproduto: idproduto },
              });
    
            if (!confereProduto) {
                return ('Produto não existe');
            }        
    
            const estoqueUpdate = await prisma.tbEstoque.updateMany({
                where: {
                    idestoque: idestoque,
                },
                data: {
                    idmovimento,
                    seqitem,
                    idlocal,
                    idproduto,
                    quantidade,
                    dtinc
                },
            })
            return (estoqueUpdate.count >= 1) ?  'Atualização com sucesso' :  'Nada foi atualizado'
        })
    
        server.delete('/estoque/delete/:estoqueId', async (request) => {
            const idParam = z.object({
                estoqueId: z.string(),
            })
    
            const { estoqueId } = idParam.parse(request.params)
    
            const idestoque = Number(estoqueId)
    
            const estoqueApagado = await prisma.tbEstoque.delete({
                where: {
                    idestoque: idestoque,
                },
            })
    
            return estoqueApagado
        })
}