-- CreateTable
CREATE TABLE "tbEstoque" (
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
CREATE TABLE "tbLocais" (
    "idlocal" SERIAL NOT NULL,
    "nomelocal" VARCHAR(40),

    CONSTRAINT "pk_tblocais_idlocal" PRIMARY KEY ("idlocal")
);

-- CreateTable
CREATE TABLE "tbMovItens" (
    "idmovimento" INTEGER NOT NULL,
    "seqitem" SERIAL NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "idlocal" INTEGER,
    "dtinc" DATE,
    "quantidade" DOUBLE PRECISION,

    CONSTRAINT "pk_tbmovitens_idmovimento_seqitem_idproduto" PRIMARY KEY ("idmovimento","seqitem","idproduto")
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
CREATE TABLE "tbNF" (
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
CREATE TABLE "tbNFItens" (
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
CREATE TABLE "tbProdComposicao" (
    "idcomp" SERIAL NOT NULL,
    "idproduto" INTEGER NOT NULL,
    "idprodutocomp" INTEGER NOT NULL,
    "quantidade" DOUBLE PRECISION,

    CONSTRAINT "pk_tbcomp_idcomp_idprod_idprodcomp" PRIMARY KEY ("idcomp","idproduto","idprodutocomp")
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
CREATE UNIQUE INDEX "uk_tbnf_numnf" ON "tbNF"("numnf");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbusuarios_login" ON "tbUsuarios"("usu_login");

-- AddForeignKey
ALTER TABLE "tbEstoque" ADD CONSTRAINT "fk_tbestoque_idlocal" FOREIGN KEY ("idlocal") REFERENCES "tbLocais"("idlocal") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbEstoque" ADD CONSTRAINT "fk_tbestoque_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbMovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbEstoque" ADD CONSTRAINT "fk_tbestoque_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbEstoque" ADD CONSTRAINT "fk_tbestoque_seqitem_idmovimento" FOREIGN KEY ("seqitem", "idmovimento", "idproduto") REFERENCES "tbMovItens"("seqitem", "idmovimento", "idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovItens" ADD CONSTRAINT "fk_tbmovitens_idlocal" FOREIGN KEY ("idlocal") REFERENCES "tbLocais"("idlocal") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovItens" ADD CONSTRAINT "fk_tbmovitens_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbMovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovItens" ADD CONSTRAINT "fk_tbmovitens_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovimentos" ADD CONSTRAINT "fk_tbmovimentos_idfor" FOREIGN KEY ("idfor") REFERENCES "tbFornecedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovimentos" ADD CONSTRAINT "fk_tbmovimentos_idusuario" FOREIGN KEY ("idusuario_alteracao") REFERENCES "tbUsuarios"("idusuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNF" ADD CONSTRAINT "fk_tbmovimentos_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbMovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNF" ADD CONSTRAINT "fk_tbnf_idfor" FOREIGN KEY ("idfor") REFERENCES "tbFornecedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNF" ADD CONSTRAINT "fk_tbnf_idusuario" FOREIGN KEY ("idusuario_inclusao") REFERENCES "tbUsuarios"("idusuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNFItens" ADD CONSTRAINT "fk_tbnfitens_idmovimento_seqitem_idproduto" FOREIGN KEY ("idmovimento", "seqitem", "idproduto") REFERENCES "tbMovItens"("idmovimento", "seqitem", "idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNFItens" ADD CONSTRAINT "fk_tbnfitens_idnf" FOREIGN KEY ("idnf", "idmovimento") REFERENCES "tbNF"("idnf", "idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdComposicao" ADD CONSTRAINT "fk_tbcomposicao_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdComposicao" ADD CONSTRAINT "fk_tbcomposicao_idprodutocomp" FOREIGN KEY ("idprodutocomp") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;
