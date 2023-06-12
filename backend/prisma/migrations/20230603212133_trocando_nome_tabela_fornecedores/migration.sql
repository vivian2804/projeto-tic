-- CreateTable
CREATE TABLE "tbestoque" (
    "idestoque" SERIAL NOT NULL,
    "idmovimento" INTEGER NOT NULL,
    "seqitem" INTEGER NOT NULL,
    "idlocal" INTEGER,
    "idproduto" INTEGER,
    "quantidade" DOUBLE PRECISION,
    "dtinc" DATE,

    CONSTRAINT "pk_tbestoque_idestoque_idmovimento_seqitem" PRIMARY KEY ("idestoque","idmovimento","seqitem")
);

-- CreateTable
CREATE TABLE "tbForncedores" (
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
CREATE TABLE "tblocais" (
    "idlocal" SERIAL NOT NULL,
    "nomelocal" VARCHAR(40),

    CONSTRAINT "pk_tblocais_idlocal" PRIMARY KEY ("idlocal")
);

-- CreateTable
CREATE TABLE "tbmovimentos" (
    "idmovimento" SERIAL NOT NULL,
    "tipmov" VARCHAR(2),
    "idfor" INTEGER,
    "idusuario_alteracao" INTEGER,
    "dtinc" DATE,

    CONSTRAINT "pk_tbmovimentos_idmovimento" PRIMARY KEY ("idmovimento")
);

-- CreateTable
CREATE TABLE "tbmovitens" (
    "idmovimento" INTEGER NOT NULL,
    "seqitem" SERIAL NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "idlocal" INTEGER,
    "dtinc" DATE,
    "quantidade" DOUBLE PRECISION,

    CONSTRAINT "pk_tbmovitens_idmovimento_seqitem_idproduto" PRIMARY KEY ("idmovimento","seqitem","idproduto")
);

-- CreateTable
CREATE TABLE "tbnf" (
    "idnf" SERIAL NOT NULL,
    "numnf" INTEGER,
    "idmovimento" INTEGER NOT NULL,
    "serienf" INTEGER,
    "idfor" INTEGER,
    "idusuario_inclusao" INTEGER,
    "dtemissao" DATE,
    "vlrtotal" DOUBLE PRECISION,

    CONSTRAINT "pk_tbnf_idnf_idmovimento" PRIMARY KEY ("idnf","idmovimento")
);

-- CreateTable
CREATE TABLE "tbnfitens" (
    "idnf" INTEGER NOT NULL,
    "idmovimento" INTEGER NOT NULL,
    "seqitem" INTEGER NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "vlrunitario" DOUBLE PRECISION,
    "quantidade" DOUBLE PRECISION,
    "vlrtotitem" DOUBLE PRECISION,

    CONSTRAINT "pk_tbnfitens_idnf_seqitem_idproduto_idmovimento" PRIMARY KEY ("idnf","seqitem","idproduto","idmovimento")
);

-- CreateTable
CREATE TABLE "tbprodcomposicao" (
    "idcomp" SERIAL NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "idprodutocomp" INTEGER NOT NULL,
    "quantidade" DOUBLE PRECISION,

    CONSTRAINT "pk_tbcomp_idcomp_idprod_idprodcomp" PRIMARY KEY ("idcomp","idproduto","idprodutocomp")
);

-- CreateTable
CREATE TABLE "tbprodutos" (
    "idproduto" SERIAL NOT NULL,
    "idtipprod" INTEGER,
    "idunidade" INTEGER,
    "nomeprod" VARCHAR(60),
    "quantminima" INTEGER,

    CONSTRAINT "pk_tbprodutos_idproduto" PRIMARY KEY ("idproduto")
);

-- CreateTable
CREATE TABLE "tbtiposprodutos" (
    "idtipprod" SERIAL NOT NULL,
    "nometipprod" VARCHAR(40),

    CONSTRAINT "pk_tbtiposprodutos" PRIMARY KEY ("idtipprod")
);

-- CreateTable
CREATE TABLE "tbunidademedida" (
    "idunidade" SERIAL NOT NULL,
    "siglaun" VARCHAR(5),
    "nomeunidade" VARCHAR(30),

    CONSTRAINT "pk_tbunidademedida_idunidade" PRIMARY KEY ("idunidade")
);

-- CreateTable
CREATE TABLE "tbusuarios" (
    "idusuario" SERIAL NOT NULL,
    "usu_login" VARCHAR(15),
    "nome" VARCHAR(15),
    "senha" VARCHAR(20),
    "dtcriacao" DATE,
    "usu_admin" BOOLEAN,

    CONSTRAINT "pk_tbusuarios_idusuario" PRIMARY KEY ("idusuario")
);

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbfornecedores_cnpjcpf" ON "tbForncedores"("cnpjcpf");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbfornecedores_email" ON "tbForncedores"("email");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbnf_numnf" ON "tbnf"("numnf");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbunidademedida_siglaun" ON "tbunidademedida"("siglaun");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbusuarios_login" ON "tbusuarios"("usu_login");

-- AddForeignKey
ALTER TABLE "tbestoque" ADD CONSTRAINT "fk_tbestoque_idlocal" FOREIGN KEY ("idlocal") REFERENCES "tblocais"("idlocal") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbestoque" ADD CONSTRAINT "fk_tbestoque_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbmovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbestoque" ADD CONSTRAINT "fk_tbestoque_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbprodutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbestoque" ADD CONSTRAINT "fk_tbestoque_seqitem_idmovimento" FOREIGN KEY ("seqitem", "idmovimento", "idproduto") REFERENCES "tbmovitens"("seqitem", "idmovimento", "idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbmovimentos" ADD CONSTRAINT "fk_tbmovimentos_idfor" FOREIGN KEY ("idfor") REFERENCES "tbForncedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbmovimentos" ADD CONSTRAINT "fk_tbmovimentos_idusuario" FOREIGN KEY ("idusuario_alteracao") REFERENCES "tbusuarios"("idusuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbmovitens" ADD CONSTRAINT "fk_tbmovitens_idlocal" FOREIGN KEY ("idlocal") REFERENCES "tblocais"("idlocal") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbmovitens" ADD CONSTRAINT "fk_tbmovitens_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbmovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbmovitens" ADD CONSTRAINT "fk_tbmovitens_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbprodutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbnf" ADD CONSTRAINT "fk_tbmovimentos_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbmovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbnf" ADD CONSTRAINT "fk_tbnf_idfor" FOREIGN KEY ("idfor") REFERENCES "tbForncedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbnf" ADD CONSTRAINT "fk_tbnf_idusuario" FOREIGN KEY ("idusuario_inclusao") REFERENCES "tbusuarios"("idusuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbnfitens" ADD CONSTRAINT "fk_tbnfitens_idmovimento_seqitem_idproduto" FOREIGN KEY ("idmovimento", "seqitem", "idproduto") REFERENCES "tbmovitens"("idmovimento", "seqitem", "idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbnfitens" ADD CONSTRAINT "fk_tbnfitens_idnf" FOREIGN KEY ("idnf", "idmovimento") REFERENCES "tbnf"("idnf", "idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbprodcomposicao" ADD CONSTRAINT "fk_tbcomposicao_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbprodutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbprodcomposicao" ADD CONSTRAINT "fk_tbcomposicao_idprodutocomp" FOREIGN KEY ("idprodutocomp") REFERENCES "tbprodutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbprodutos" ADD CONSTRAINT "fk_tbprodutos_idtipprod" FOREIGN KEY ("idtipprod") REFERENCES "tbtiposprodutos"("idtipprod") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbprodutos" ADD CONSTRAINT "fk_tbprodutos_idunidade" FOREIGN KEY ("idunidade") REFERENCES "tbunidademedida"("idunidade") ON DELETE NO ACTION ON UPDATE NO ACTION;
