-- CreateTable
CREATE TABLE "curso" (
    "cod_curso" INTEGER NOT NULL,
    "nm_curso" VARCHAR(40),
    "nm_aluno" INTEGER NOT NULL,

    CONSTRAINT "pk_tb_curso_cod_curso" PRIMARY KEY ("cod_curso")
);
