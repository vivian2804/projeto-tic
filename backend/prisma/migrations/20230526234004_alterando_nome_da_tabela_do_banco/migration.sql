/*
  Warnings:

  - You are about to drop the `curso` table. If the table is not empty, all the data it contains will be lost.

*/
-- DropTable
DROP TABLE "curso";

-- CreateTable
CREATE TABLE "tb_curso" (
    "cod_curso" INTEGER NOT NULL,
    "nm_curso" VARCHAR(40),
    "nm_aluno" INTEGER NOT NULL,

    CONSTRAINT "pk_tb_curso_cod_curso" PRIMARY KEY ("cod_curso")
);
