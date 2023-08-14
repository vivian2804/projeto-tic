-- CreateTable
CREATE TABLE "tbEstoque" (
    "idestoque" SERIAL NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "idlocal" INTEGER,
    "quantidade" DECIMAL,
    "dtinc" DATE,

    CONSTRAINT "pk_tbestoque_idestoque_idmovimento_seqitem" PRIMARY KEY ("idestoque","idproduto")
);

-- CreateTable
CREATE TABLE "tbFornecedores" (
    "idfor" SERIAL NOT NULL,
    "nomefor" VARCHAR(80),
    "fisjur" VARCHAR(1),
    "cnpjcpf" VARCHAR(20),
    "telefone" VARCHAR(20),
    "cep" VARCHAR(10),
    "cidade" VARCHAR(40),
    "rua" VARCHAR(60),
    "bairro" VARCHAR(20),
    "numero" INTEGER,
    "complemento" VARCHAR(20),
    "email" VARCHAR(60),

    CONSTRAINT "pk_tbfornecedores_idfor" PRIMARY KEY ("idfor")
);

-- CreateTable
CREATE TABLE "tbLocais" (
    "idlocal" SERIAL NOT NULL,
    "nomelocal" VARCHAR(40),

    CONSTRAINT "pk_tblocais_idlocal" PRIMARY KEY ("idlocal")
);

-- CreateTable
CREATE TABLE "tbMovimentos" (
    "idmovimento" SERIAL NOT NULL,
    "tipmov" VARCHAR(2),
    "idfor" INTEGER,
    "idusuario_alteracao" INTEGER,
    "dtinc" DATE,

    CONSTRAINT "pk_tbmovimentos_idmovimento" PRIMARY KEY ("idmovimento")
);

-- CreateTable
CREATE TABLE "tbMovitens" (
    "idmovimento" INTEGER NOT NULL,
    "seqitem" SERIAL NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "idlocal" INTEGER,
    "dtinc" DATE,
    "quantidade" DECIMAL,

    CONSTRAINT "pk_tbmovitens_idmovimento_seqitem_idproduto" PRIMARY KEY ("idmovimento","seqitem","idproduto")
);

-- CreateTable
CREATE TABLE "tbNf" (
    "idnf" SERIAL NOT NULL,
    "numnf" INTEGER,
    "idmovimento" INTEGER,
    "serienf" INTEGER,
    "idfor" INTEGER,
    "idusuario_inclusao" INTEGER,
    "dtemissao" DATE,
    "vlrtotal" DECIMAL,

    CONSTRAINT "pk_tbnf_idnf" PRIMARY KEY ("idnf")
);

-- CreateTable
CREATE TABLE "tbNfitens" (
    "idnf" INTEGER NOT NULL,
    "idmovimento" INTEGER,
    "seqitem" INTEGER NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "vlrunitario" DECIMAL,
    "quantidade" DECIMAL,
    "vlrtotitem" DECIMAL,

    CONSTRAINT "pk_tbnfitens_idnf_seqitem_idprodut" PRIMARY KEY ("idnf","seqitem","idproduto")
);

-- CreateTable
CREATE TABLE "tbProdcomposicao" (
    "idcomp" SERIAL NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "idprodutocomp" INTEGER NOT NULL,
    "quantidade" DECIMAL,

    CONSTRAINT "pk_tbcomp_idcomp_idprod_idprodcomp" PRIMARY KEY ("idcomp","idproduto","idprodutocomp")
);

-- CreateTable
CREATE TABLE "tbProdutos" (
    "idproduto" SERIAL NOT NULL,
    "nomeprod" VARCHAR(60),
    "idtipprod" INTEGER,
    "idunidade" INTEGER,
    "quantminima" INTEGER,

    CONSTRAINT "pk_tbprodutos_idproduto" PRIMARY KEY ("idproduto")
);

-- CreateTable
CREATE TABLE "tbTiposprodutos" (
    "idtipprod" SERIAL NOT NULL,
    "nometipprod" VARCHAR(40),

    CONSTRAINT "pk_tbtiposprodutos" PRIMARY KEY ("idtipprod")
);

-- CreateTable
CREATE TABLE "tbUnidademedida" (
    "idunidade" SERIAL NOT NULL,
    "siglaun" VARCHAR(5),
    "nomeunidade" VARCHAR(30),

    CONSTRAINT "pk_tbunidademedida_idunidade" PRIMARY KEY ("idunidade")
);

-- CreateTable
CREATE TABLE "tbUsuarios" (
    "idusuario" SERIAL NOT NULL,
    "usu_login" VARCHAR(15),
    "nome" VARCHAR(15),
    "senha" VARCHAR(20),
    "dtcriacao" DATE,
    "usu_admin" BOOLEAN,

    CONSTRAINT "pk_tbusuarios_idusuario" PRIMARY KEY ("idusuario")
);

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbfornecedores_cnpjcpf" ON "tbFornecedores"("cnpjcpf");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbfornecedores_email" ON "tbFornecedores"("email");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbnf_numnf" ON "tbNf"("numnf");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbnf_idmovimento" ON "tbNf"("idmovimento");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbunidademedida_siglaun" ON "tbUnidademedida"("siglaun");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbusuarios_usu_login" ON "tbUsuarios"("usu_login");

-- AddForeignKey
ALTER TABLE "tbEstoque" ADD CONSTRAINT "fk_tbestoque_idlocal" FOREIGN KEY ("idlocal") REFERENCES "tbLocais"("idlocal") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbEstoque" ADD CONSTRAINT "fk_tbestoque_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovimentos" ADD CONSTRAINT "fk_tbmovimentos_idfor" FOREIGN KEY ("idfor") REFERENCES "tbFornecedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovimentos" ADD CONSTRAINT "fk_tbmovimentos_idusuario" FOREIGN KEY ("idusuario_alteracao") REFERENCES "tbUsuarios"("idusuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovitens" ADD CONSTRAINT "fk_tbmovitens_idlocal" FOREIGN KEY ("idlocal") REFERENCES "tbLocais"("idlocal") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovitens" ADD CONSTRAINT "fk_tbmovitens_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbMovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovitens" ADD CONSTRAINT "fk_tbmovitens_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNf" ADD CONSTRAINT "fk_tbmovimentos_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbMovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNf" ADD CONSTRAINT "fk_tbnf_idfor" FOREIGN KEY ("idfor") REFERENCES "tbFornecedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNf" ADD CONSTRAINT "fk_tbnf_idusuario" FOREIGN KEY ("idusuario_inclusao") REFERENCES "tbUsuarios"("idusuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNfitens" ADD CONSTRAINT "fk_tbnfitens_idmovimento_seqitem_idproduto" FOREIGN KEY ("idmovimento", "seqitem", "idproduto") REFERENCES "tbMovitens"("idmovimento", "seqitem", "idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNfitens" ADD CONSTRAINT "fk_tbnfitens_idnf" FOREIGN KEY ("idnf") REFERENCES "tbNf"("idnf") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdcomposicao" ADD CONSTRAINT "fk_tbcomposicao_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdcomposicao" ADD CONSTRAINT "fk_tbcomposicao_idprodutocomp" FOREIGN KEY ("idprodutocomp") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdutos" ADD CONSTRAINT "fk_tbprodutos_idtipprod" FOREIGN KEY ("idtipprod") REFERENCES "tbTiposprodutos"("idtipprod") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdutos" ADD CONSTRAINT "fk_tbprodutos_idunidade" FOREIGN KEY ("idunidade") REFERENCES "tbUnidademedida"("idunidade") ON DELETE NO ACTION ON UPDATE NO ACTION;
