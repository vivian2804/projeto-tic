/*
  Warnings:

  - You are about to drop the `tbForncedores` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropForeignKey
ALTER TABLE "tbMovimentos" DROP CONSTRAINT "fk_tbmovimentos_idfor";

-- DropForeignKey
ALTER TABLE "tbNf" DROP CONSTRAINT "fk_tbnf_idfor";

-- DropTable
DROP TABLE "tbForncedores";

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

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbfornecedores_cnpjcpf" ON "tbFornecedores"("cnpjcpf");

-- CreateIndex
CREATE UNIQUE INDEX "uk_tbfornecedores_email" ON "tbFornecedores"("email");

-- AddForeignKey
ALTER TABLE "tbMovimentos" ADD CONSTRAINT "fk_tbmovimentos_idfor" FOREIGN KEY ("idfor") REFERENCES "tbFornecedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;

-- AddForeignKey
ALTER TABLE "tbNf" ADD CONSTRAINT "fk_tbnf_idfor" FOREIGN KEY ("idfor") REFERENCES "tbFornecedores"("idfor") ON DELETE NO ACTION ON UPDATE NO ACTION;
