/*
  Warnings:

  - You are about to drop the `tbEstoque` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbLocais` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbMovItens` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbMovimentos` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbNf` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbNfItens` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbProdComposicao` table. If the table is not empty, all the data it contains will be lost.
  - You are about to drop the `tbUsuarios` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "tbEstoque" DROP CONSTRAINT "fk_tbestoque_idlocal";

-- DropForeignKey
ALTER TABLE "tbEstoque" DROP CONSTRAINT "fk_tbestoque_idmovimento";

-- DropForeignKey
ALTER TABLE "tbEstoque" DROP CONSTRAINT "fk_tbestoque_idproduto";

-- DropForeignKey
ALTER TABLE "tbEstoque" DROP CONSTRAINT "fk_tbestoque_seqitem_idmovimento";

-- DropForeignKey
ALTER TABLE "tbMovItens" DROP CONSTRAINT "fk_tbmovitens_idlocal";

-- DropForeignKey
ALTER TABLE "tbMovItens" DROP CONSTRAINT "fk_tbmovitens_idmovimento";

-- DropForeignKey
ALTER TABLE "tbMovItens" DROP CONSTRAINT "fk_tbmovitens_idproduto";

-- DropForeignKey
ALTER TABLE "tbMovimentos" DROP CONSTRAINT "fk_tbmovimentos_idfor";

-- DropForeignKey
ALTER TABLE "tbMovimentos" DROP CONSTRAINT "fk_tbmovimentos_idusuario";

-- DropForeignKey
ALTER TABLE "tbNf" DROP CONSTRAINT "fk_tbmovimentos_idmovimento";

-- DropForeignKey
ALTER TABLE "tbNf" DROP CONSTRAINT "fk_tbnf_idfor";

-- DropForeignKey
ALTER TABLE "tbNf" DROP CONSTRAINT "fk_tbnf_idusuario";

-- DropForeignKey
ALTER TABLE "tbNfItens" DROP CONSTRAINT "fk_tbnfitens_idmovimento_seqitem_idproduto";

-- DropForeignKey
ALTER TABLE "tbNfItens" DROP CONSTRAINT "fk_tbnfitens_idnf";

-- DropForeignKey
ALTER TABLE "tbProdComposicao" DROP CONSTRAINT "fk_tbcomposicao_idproduto";

-- DropForeignKey
ALTER TABLE "tbProdComposicao" DROP CONSTRAINT "fk_tbcomposicao_idprodutocomp";

-- DropTable
DROP TABLE "tbEstoque";

-- DropTable
DROP TABLE "tbLocais";

-- DropTable
DROP TABLE "tbMovItens";

-- DropTable
DROP TABLE "tbMovimentos";

-- DropTable
DROP TABLE "tbNf";

-- DropTable
DROP TABLE "tbNfItens";

-- DropTable
DROP TABLE "tbProdComposicao";

-- DropTable
DROP TABLE "tbUsuarios";
