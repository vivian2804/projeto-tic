/*
  Warnings:

  - You are about to drop the `tbestoque` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tblocais` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbmovimentos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbmovitens` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbnf` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbnfitens` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbprodcomposicao` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbprodutos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbtiposprodutos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbunidademedida` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbusuarios` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "tbestoque" DROP CONSTRAINT "fk_tbestoque_idlocal";

-- DropForeignKey
ALTER TABLE "tbestoque" DROP CONSTRAINT "fk_tbestoque_idmovimento";

-- DropForeignKey
ALTER TABLE "tbestoque" DROP CONSTRAINT "fk_tbestoque_idproduto";

-- DropForeignKey
ALTER TABLE "tbestoque" DROP CONSTRAINT "fk_tbestoque_seqitem_idmovimento";

-- DropForeignKey
ALTER TABLE "tbmovimentos" DROP CONSTRAINT "fk_tbmovimentos_idfor";

-- DropForeignKey
ALTER TABLE "tbmovimentos" DROP CONSTRAINT "fk_tbmovimentos_idusuario";

-- DropForeignKey
ALTER TABLE "tbmovitens" DROP CONSTRAINT "fk_tbmovitens_idlocal";

-- DropForeignKey
ALTER TABLE "tbmovitens" DROP CONSTRAINT "fk_tbmovitens_idmovimento";

-- DropForeignKey
ALTER TABLE "tbmovitens" DROP CONSTRAINT "fk_tbmovitens_idproduto";

-- DropForeignKey
ALTER TABLE "tbnf" DROP CONSTRAINT "fk_tbmovimentos_idmovimento";

-- DropForeignKey
ALTER TABLE "tbnf" DROP CONSTRAINT "fk_tbnf_idfor";

-- DropForeignKey
ALTER TABLE "tbnf" DROP CONSTRAINT "fk_tbnf_idusuario";

-- DropForeignKey
ALTER TABLE "tbnfitens" DROP CONSTRAINT "fk_tbnfitens_idmovimento_seqitem_idproduto";

-- DropForeignKey
ALTER TABLE "tbnfitens" DROP CONSTRAINT "fk_tbnfitens_idnf";

-- DropForeignKey
ALTER TABLE "tbprodcomposicao" DROP CONSTRAINT "fk_tbcomposicao_idproduto";

-- DropForeignKey
ALTER TABLE "tbprodcomposicao" DROP CONSTRAINT "fk_tbcomposicao_idprodutocomp";

-- DropForeignKey
ALTER TABLE "tbprodutos" DROP CONSTRAINT "fk_tbprodutos_idtipprod";

-- DropForeignKey
ALTER TABLE "tbprodutos" DROP CONSTRAINT "fk_tbprodutos_idunidade";

-- DropTable
DROP TABLE "tbestoque";

-- DropTable
DROP TABLE "tblocais";

-- DropTable
DROP TABLE "tbmovimentos";

-- DropTable
DROP TABLE "tbmovitens";

-- DropTable
DROP TABLE "tbnf";

-- DropTable
DROP TABLE "tbnfitens";

-- DropTable
DROP TABLE "tbprodcomposicao";

-- DropTable
DROP TABLE "tbprodutos";

-- DropTable
DROP TABLE "tbtiposprodutos";

-- DropTable
DROP TABLE "tbunidademedida";

-- DropTable
DROP TABLE "tbusuarios";

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
CREATE TABLE "tbMovimentos" (
    "idmovimento" SERIAL NOT NULL,
    "tipmov" VARCHAR(2),
    "idfor" INTEGER,
    "idusuario_alteracao" INTEGER,
    "dtinc" DATE,

    CONSTRAINT "pk_tbmovimentos_idmovimento" PRIMARY KEY ("idmovimento")
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
CREATE TABLE "tbNf" (
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
CREATE TABLE "tbNfItens" (
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
CREATE TABLE "tbProdutos" (
    "idproduto" SERIAL NOT NULL,
    "idtipprod" INTEGER,
    "idunidade" INTEGER,
    "nomeprod" VARCHAR(60),
    "quantminima" INTEGER,

    CONSTRAINT "pk_tbprodutos_idproduto" PRIMARY KEY ("idproduto")
);

-- CreateTable
CREATE TABLE "tbTiposProdutos" (
    "idtipprod" SERIAL NOT NULL,
    "nometipprod" VARCHAR(40),

    CONSTRAINT "pk_tbtiposprodutos" PRIMARY KEY ("idtipprod")
);

-- CreateTable
CREATE TABLE "tbUnidadeMedida" (
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
CREATE UNIQUE INDEX "uk_tbnf_numnf" ON "tbNf"("numnf");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbunidademedida_siglaun" ON "tbUnidadeMedida"("siglaun");

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
ALTER TABLE "tbMovimentos" ADD CONSTRAINT "fk_tbmovimentos_idfor" FOREIGN KEY ("idfor") REFERENCES "tbForncedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovimentos" ADD CONSTRAINT "fk_tbmovimentos_idusuario" FOREIGN KEY ("idusuario_alteracao") REFERENCES "tbUsuarios"("idusuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovItens" ADD CONSTRAINT "fk_tbmovitens_idlocal" FOREIGN KEY ("idlocal") REFERENCES "tbLocais"("idlocal") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovItens" ADD CONSTRAINT "fk_tbmovitens_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbMovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbMovItens" ADD CONSTRAINT "fk_tbmovitens_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNf" ADD CONSTRAINT "fk_tbmovimentos_idmovimento" FOREIGN KEY ("idmovimento") REFERENCES "tbMovimentos"("idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNf" ADD CONSTRAINT "fk_tbnf_idfor" FOREIGN KEY ("idfor") REFERENCES "tbForncedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNf" ADD CONSTRAINT "fk_tbnf_idusuario" FOREIGN KEY ("idusuario_inclusao") REFERENCES "tbUsuarios"("idusuario") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNfItens" ADD CONSTRAINT "fk_tbnfitens_idmovimento_seqitem_idproduto" FOREIGN KEY ("idmovimento", "seqitem", "idproduto") REFERENCES "tbMovItens"("idmovimento", "seqitem", "idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNfItens" ADD CONSTRAINT "fk_tbnfitens_idnf" FOREIGN KEY ("idnf", "idmovimento") REFERENCES "tbNf"("idnf", "idmovimento") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdComposicao" ADD CONSTRAINT "fk_tbcomposicao_idproduto" FOREIGN KEY ("idproduto") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdComposicao" ADD CONSTRAINT "fk_tbcomposicao_idprodutocomp" FOREIGN KEY ("idprodutocomp") REFERENCES "tbProdutos"("idproduto") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdutos" ADD CONSTRAINT "fk_tbprodutos_idtipprod" FOREIGN KEY ("idtipprod") REFERENCES "tbTiposProdutos"("idtipprod") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbProdutos" ADD CONSTRAINT "fk_tbprodutos_idunidade" FOREIGN KEY ("idunidade") REFERENCES "tbUnidadeMedida"("idunidade") ON DELETE NO ACTION ON UPDATE NO ACTION;
