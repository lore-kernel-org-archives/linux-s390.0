Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20100224084452.146162956@de.ibm.com>
Date: Wed, 24 Feb 2010 09:44:54 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 24/32] [PATCH] add z9-ec/z10 instruction to kernel disassembler
References: <20100224084430.193562869@de.ibm.com>
Content-Disposition: inline; filename=123-disasm-z9ec-z10.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Add the instruction of the z9-ec and z10 machines to the kernel disassembler.
Add the missing "ptff" instruction of z9-109 and the missing "sqd" of g5.
Remove useless comments with instruction examples from format table.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/dis.c |  369 +++++++++++++++++++++++++++++++++++++------------
 1 file changed, 285 insertions(+), 84 deletions(-)

Index: quilt-2.6/arch/s390/kernel/dis.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/dis.c	2010-02-24 09:28:13.000000000 +0100
+++ quilt-2.6/arch/s390/kernel/dis.c	2010-02-24 09:44:27.000000000 +0100
@@ -86,10 +86,17 @@
 	U4_12,	/* 4 bit unsigned value starting at 12 */
 	U4_16,	/* 4 bit unsigned value starting at 16 */
 	U4_20,	/* 4 bit unsigned value starting at 20 */
+	U4_32,	/* 4 bit unsigned value starting at 32 */
 	U8_8,	/* 8 bit unsigned value starting at 8 */
 	U8_16,	/* 8 bit unsigned value starting at 16 */
+	U8_24,	/* 8 bit unsigned value starting at 24 */
+	U8_32,	/* 8 bit unsigned value starting at 32 */
+	I8_8,	/* 8 bit signed value starting at 8 */
+	I8_32,	/* 8 bit signed value starting at 32 */
 	I16_16,	/* 16 bit signed value starting at 16 */
+	I16_32,	/* 32 bit signed value starting at 16 */
 	U16_16,	/* 16 bit unsigned value starting at 16 */
+	U16_32,	/* 32 bit unsigned value starting at 16 */
 	J16_16,	/* PC relative jump offset at 16 */
 	J32_16,	/* PC relative long offset at 16 */
 	I32_16,	/* 32 bit signed value starting at 16 */
@@ -104,21 +111,37 @@
  */
 enum {
 	INSTR_INVALID,
-	INSTR_E, INSTR_RIE_RRP, INSTR_RIL_RI, INSTR_RIL_RP, INSTR_RIL_RU,
-	INSTR_RIL_UP, INSTR_RI_RI, INSTR_RI_RP, INSTR_RI_RU, INSTR_RI_UP,
+	INSTR_E,
+	INSTR_RIE_R0IU, INSTR_RIE_R0UU, INSTR_RIE_RRP, INSTR_RIE_RRPU,
+	INSTR_RIE_RRUUU, INSTR_RIE_RUPI, INSTR_RIE_RUPU,
+	INSTR_RIL_RI, INSTR_RIL_RP, INSTR_RIL_RU, INSTR_RIL_UP,
+	INSTR_RIS_R0RDU, INSTR_RIS_R0UU, INSTR_RIS_RURDI, INSTR_RIS_RURDU,
+	INSTR_RI_RI, INSTR_RI_RP, INSTR_RI_RU, INSTR_RI_UP,
 	INSTR_RRE_00, INSTR_RRE_0R, INSTR_RRE_AA, INSTR_RRE_AR, INSTR_RRE_F0,
-	INSTR_RRE_FF, INSTR_RRE_R0, INSTR_RRE_RA, INSTR_RRE_RF, INSTR_RRE_RR,
-	INSTR_RRE_RR_OPT, INSTR_RRF_F0FF, INSTR_RRF_FUFF, INSTR_RRF_M0RR,
-	INSTR_RRF_R0RR, INSTR_RRF_RURR, INSTR_RRF_U0FF, INSTR_RRF_U0RF,
+	INSTR_RRE_FF, INSTR_RRE_FR, INSTR_RRE_R0, INSTR_RRE_RA, INSTR_RRE_RF,
+	INSTR_RRE_RR, INSTR_RRE_RR_OPT,
+	INSTR_RRF_0UFF, INSTR_RRF_F0FF, INSTR_RRF_F0FF2, INSTR_RRF_F0FR,
+	INSTR_RRF_FFRU, INSTR_RRF_FUFF, INSTR_RRF_M0RR, INSTR_RRF_R0RR,
+	INSTR_RRF_RURR, INSTR_RRF_U0FF, INSTR_RRF_U0RF, INSTR_RRF_U0RR,
+	INSTR_RRF_UUFF, INSTR_RRR_F0FF, INSTR_RRS_RRRDU,
 	INSTR_RR_FF, INSTR_RR_R0, INSTR_RR_RR, INSTR_RR_U0, INSTR_RR_UR,
-	INSTR_RSE_CCRD, INSTR_RSE_RRRD, INSTR_RSE_RURD, INSTR_RSI_RRP,
-	INSTR_RSL_R0RD, INSTR_RSY_AARD, INSTR_RSY_CCRD, INSTR_RSY_RRRD,
-	INSTR_RSY_RURD, INSTR_RS_AARD, INSTR_RS_CCRD, INSTR_RS_R0RD,
-	INSTR_RS_RRRD, INSTR_RS_RURD, INSTR_RXE_FRRD, INSTR_RXE_RRRD,
-	INSTR_RXF_FRRDF, INSTR_RXY_FRRD, INSTR_RXY_RRRD, INSTR_RX_FRRD,
-	INSTR_RX_RRRD, INSTR_RX_URRD, INSTR_SIY_URD, INSTR_SI_URD,
-	INSTR_SSE_RDRD, INSTR_SSF_RRDRD, INSTR_SS_L0RDRD, INSTR_SS_LIRDRD,
-	INSTR_SS_LLRDRD, INSTR_SS_RRRDRD, INSTR_SS_RRRDRD2, INSTR_SS_RRRDRD3,
+	INSTR_RSE_CCRD, INSTR_RSE_RRRD, INSTR_RSE_RURD,
+	INSTR_RSI_RRP,
+	INSTR_RSL_R0RD,
+	INSTR_RSY_AARD, INSTR_RSY_CCRD, INSTR_RSY_RRRD, INSTR_RSY_RURD,
+	INSTR_RS_AARD, INSTR_RS_CCRD, INSTR_RS_R0RD, INSTR_RS_RRRD,
+	INSTR_RS_RURD,
+	INSTR_RXE_FRRD, INSTR_RXE_RRRD,
+	INSTR_RXF_FRRDF,
+	INSTR_RXY_FRRD, INSTR_RXY_RRRD, INSTR_RXY_URRD,
+	INSTR_RX_FRRD, INSTR_RX_RRRD, INSTR_RX_URRD,
+	INSTR_SIL_RDI, INSTR_SIL_RDU,
+	INSTR_SIY_IRD, INSTR_SIY_URD,
+	INSTR_SI_URD,
+	INSTR_SSE_RDRD,
+	INSTR_SSF_RRDRD,
+	INSTR_SS_L0RDRD, INSTR_SS_LIRDRD, INSTR_SS_LLRDRD, INSTR_SS_RRRDRD,
+	INSTR_SS_RRRDRD2, INSTR_SS_RRRDRD3,
 	INSTR_S_00, INSTR_S_RD,
 };
 
@@ -129,7 +152,7 @@
 };
 
 struct insn {
-	const char name[5];
+	const char name[6];
 	unsigned char opfrag;
 	unsigned char format;
 };
@@ -170,11 +193,16 @@
 	[U4_12]  = {  4, 12, 0 },
 	[U4_16]  = {  4, 16, 0 },
 	[U4_20]  = {  4, 20, 0 },
+	[U4_32]  = {  4, 32, 0 },
 	[U8_8]	 = {  8,  8, 0 },
 	[U8_16]  = {  8, 16, 0 },
+	[U8_24]  = {  8, 24, 0 },
+	[U8_32]  = {  8, 32, 0 },
 	[I16_16] = { 16, 16, OPERAND_SIGNED },
 	[U16_16] = { 16, 16, 0 },
+	[U16_32] = { 16, 32, 0 },
 	[J16_16] = { 16, 16, OPERAND_PCREL },
+	[I16_32] = { 16, 32, OPERAND_SIGNED },
 	[J32_16] = { 32, 16, OPERAND_PCREL },
 	[I32_16] = { 32, 16, OPERAND_SIGNED },
 	[U32_16] = { 32, 16, 0 },
@@ -183,82 +211,93 @@
 };
 
 static const unsigned char formats[][7] = {
-	[INSTR_E]	  = { 0xff, 0,0,0,0,0,0 },	       /* e.g. pr    */
-	[INSTR_RIE_RRP]	  = { 0xff, R_8,R_12,J16_16,0,0,0 },   /* e.g. brxhg */
-	[INSTR_RIL_RP]	  = { 0x0f, R_8,J32_16,0,0,0,0 },      /* e.g. brasl */
-	[INSTR_RIL_UP]	  = { 0x0f, U4_8,J32_16,0,0,0,0 },     /* e.g. brcl  */
-	[INSTR_RIL_RI]	  = { 0x0f, R_8,I32_16,0,0,0,0 },      /* e.g. afi   */
-	[INSTR_RIL_RU]	  = { 0x0f, R_8,U32_16,0,0,0,0 },      /* e.g. alfi  */
-	[INSTR_RI_RI]	  = { 0x0f, R_8,I16_16,0,0,0,0 },      /* e.g. ahi   */
-	[INSTR_RI_RP]	  = { 0x0f, R_8,J16_16,0,0,0,0 },      /* e.g. brct  */
-	[INSTR_RI_RU]	  = { 0x0f, R_8,U16_16,0,0,0,0 },      /* e.g. tml   */
-	[INSTR_RI_UP]	  = { 0x0f, U4_8,J16_16,0,0,0,0 },     /* e.g. brc   */
-	[INSTR_RRE_00]	  = { 0xff, 0,0,0,0,0,0 },	       /* e.g. palb  */
-	[INSTR_RRE_0R]	  = { 0xff, R_28,0,0,0,0,0 },	       /* e.g. tb    */
-	[INSTR_RRE_AA]	  = { 0xff, A_24,A_28,0,0,0,0 },       /* e.g. cpya  */
-	[INSTR_RRE_AR]	  = { 0xff, A_24,R_28,0,0,0,0 },       /* e.g. sar   */
-	[INSTR_RRE_F0]	  = { 0xff, F_24,0,0,0,0,0 },	       /* e.g. sqer  */
-	[INSTR_RRE_FF]	  = { 0xff, F_24,F_28,0,0,0,0 },       /* e.g. debr  */
-	[INSTR_RRE_R0]	  = { 0xff, R_24,0,0,0,0,0 },	       /* e.g. ipm   */
-	[INSTR_RRE_RA]	  = { 0xff, R_24,A_28,0,0,0,0 },       /* e.g. ear   */
-	[INSTR_RRE_RF]	  = { 0xff, R_24,F_28,0,0,0,0 },       /* e.g. cefbr */
-	[INSTR_RRE_RR]	  = { 0xff, R_24,R_28,0,0,0,0 },       /* e.g. lura  */
-	[INSTR_RRE_RR_OPT]= { 0xff, R_24,RO_28,0,0,0,0 },      /* efpc, sfpc */
-	[INSTR_RRF_F0FF]  = { 0xff, F_16,F_24,F_28,0,0,0 },    /* e.g. madbr */
-	[INSTR_RRF_FUFF]  = { 0xff, F_24,F_16,F_28,U4_20,0,0 },/* e.g. didbr */
-	[INSTR_RRF_RURR]  = { 0xff, R_24,R_28,R_16,U4_20,0,0 },/* e.g. .insn */
-	[INSTR_RRF_R0RR]  = { 0xff, R_24,R_16,R_28,0,0,0 },    /* e.g. idte  */
-	[INSTR_RRF_U0FF]  = { 0xff, F_24,U4_16,F_28,0,0,0 },   /* e.g. fixr  */
-	[INSTR_RRF_U0RF]  = { 0xff, R_24,U4_16,F_28,0,0,0 },   /* e.g. cfebr */
-	[INSTR_RRF_M0RR]  = { 0xff, R_24,R_28,M_16,0,0,0 },    /* e.g. sske  */
-	[INSTR_RR_FF]	  = { 0xff, F_8,F_12,0,0,0,0 },        /* e.g. adr   */
-	[INSTR_RR_R0]	  = { 0xff, R_8, 0,0,0,0,0 },	       /* e.g. spm   */
-	[INSTR_RR_RR]	  = { 0xff, R_8,R_12,0,0,0,0 },        /* e.g. lr    */
-	[INSTR_RR_U0]	  = { 0xff, U8_8, 0,0,0,0,0 },	       /* e.g. svc   */
-	[INSTR_RR_UR]	  = { 0xff, U4_8,R_12,0,0,0,0 },       /* e.g. bcr   */
-	[INSTR_RSE_RRRD]  = { 0xff, R_8,R_12,D_20,B_16,0,0 },  /* e.g. lmh   */
-	[INSTR_RSE_CCRD]  = { 0xff, C_8,C_12,D_20,B_16,0,0 },  /* e.g. lmh   */
-	[INSTR_RSE_RURD]  = { 0xff, R_8,U4_12,D_20,B_16,0,0 }, /* e.g. icmh  */
-	[INSTR_RSL_R0RD]  = { 0xff, R_8,D_20,B_16,0,0,0 },     /* e.g. tp    */
-	[INSTR_RSI_RRP]	  = { 0xff, R_8,R_12,J16_16,0,0,0 },   /* e.g. brxh  */
-	[INSTR_RSY_RRRD]  = { 0xff, R_8,R_12,D20_20,B_16,0,0 },/* e.g. stmy  */
+	[INSTR_E]	  = { 0xff, 0,0,0,0,0,0 },
+	[INSTR_RIE_R0UU]  = { 0xff, R_8,U16_16,U4_32,0,0,0 },
+	[INSTR_RIE_RRPU]  = { 0xff, R_8,R_12,U4_32,J16_16,0,0 },
+	[INSTR_RIE_RRP]	  = { 0xff, R_8,R_12,J16_16,0,0,0 },
+	[INSTR_RIE_RRUUU] = { 0xff, R_8,R_12,U8_16,U8_24,U8_32,0 },
+	[INSTR_RIE_RUPI]  = { 0xff, R_8,I8_32,U4_12,J16_16,0,0 },
+	[INSTR_RIL_RI]	  = { 0x0f, R_8,I32_16,0,0,0,0 },
+	[INSTR_RIL_RP]	  = { 0x0f, R_8,J32_16,0,0,0,0 },
+	[INSTR_RIL_RU]	  = { 0x0f, R_8,U32_16,0,0,0,0 },
+	[INSTR_RIL_UP]	  = { 0x0f, U4_8,J32_16,0,0,0,0 },
+	[INSTR_RIS_R0RDU] = { 0xff, R_8,U8_32,D_20,B_16,0,0 },
+	[INSTR_RIS_RURDI] = { 0xff, R_8,I8_32,U4_12,D_20,B_16,0 },
+	[INSTR_RIS_RURDU] = { 0xff, R_8,U8_32,U4_12,D_20,B_16,0 },
+	[INSTR_RI_RI]	  = { 0x0f, R_8,I16_16,0,0,0,0 },
+	[INSTR_RI_RP]	  = { 0x0f, R_8,J16_16,0,0,0,0 },
+	[INSTR_RI_RU]	  = { 0x0f, R_8,U16_16,0,0,0,0 },
+	[INSTR_RI_UP]	  = { 0x0f, U4_8,J16_16,0,0,0,0 },
+	[INSTR_RRE_00]	  = { 0xff, 0,0,0,0,0,0 },
+	[INSTR_RRE_0R]	  = { 0xff, R_28,0,0,0,0,0 },
+	[INSTR_RRE_AA]	  = { 0xff, A_24,A_28,0,0,0,0 },
+	[INSTR_RRE_AR]	  = { 0xff, A_24,R_28,0,0,0,0 },
+	[INSTR_RRE_F0]	  = { 0xff, F_24,0,0,0,0,0 },
+	[INSTR_RRE_FF]	  = { 0xff, F_24,F_28,0,0,0,0 },
+	[INSTR_RRE_FR]	  = { 0xff, F_24,R_28,0,0,0,0 },
+	[INSTR_RRE_R0]	  = { 0xff, R_24,0,0,0,0,0 },
+	[INSTR_RRE_RA]	  = { 0xff, R_24,A_28,0,0,0,0 },
+	[INSTR_RRE_RF]	  = { 0xff, R_24,F_28,0,0,0,0 },
+	[INSTR_RRE_RR]	  = { 0xff, R_24,R_28,0,0,0,0 },
+	[INSTR_RRE_RR_OPT]= { 0xff, R_24,RO_28,0,0,0,0 },
+	[INSTR_RRF_0UFF]  = { 0xff, F_24,F_28,U4_20,0,0,0 },
+	[INSTR_RRF_F0FF2] = { 0xff, F_24,F_16,F_28,0,0,0 },
+	[INSTR_RRF_F0FF]  = { 0xff, F_16,F_24,F_28,0,0,0 },
+	[INSTR_RRF_F0FR]  = { 0xff, F_24,F_16,R_28,0,0,0 },
+	[INSTR_RRF_FFRU]  = { 0xff, F_24,F_16,R_28,U4_20,0,0 },
+	[INSTR_RRF_FUFF]  = { 0xff, F_24,F_16,F_28,U4_20,0,0 },
+	[INSTR_RRF_M0RR]  = { 0xff, R_24,R_28,M_16,0,0,0 },
+	[INSTR_RRF_R0RR]  = { 0xff, R_24,R_16,R_28,0,0,0 },
+	[INSTR_RRF_RURR]  = { 0xff, R_24,R_28,R_16,U4_20,0,0 },
+	[INSTR_RRF_U0FF]  = { 0xff, F_24,U4_16,F_28,0,0,0 },
+	[INSTR_RRF_U0RF]  = { 0xff, R_24,U4_16,F_28,0,0,0 },
+	[INSTR_RRF_U0RR]  = { 0xff, R_24,R_28,U4_16,0,0,0 },
+	[INSTR_RRF_UUFF]  = { 0xff, F_24,U4_16,F_28,U4_20,0,0 },
+	[INSTR_RRR_F0FF]  = { 0xff, F_24,F_28,F_16,0,0,0 },
+	[INSTR_RRS_RRRDU] = { 0xff, R_8,R_12,U4_32,D_20,B_16,0 },
+	[INSTR_RR_FF]	  = { 0xff, F_8,F_12,0,0,0,0 },
+	[INSTR_RR_R0]	  = { 0xff, R_8, 0,0,0,0,0 },
+	[INSTR_RR_RR]	  = { 0xff, R_8,R_12,0,0,0,0 },
+	[INSTR_RR_U0]	  = { 0xff, U8_8, 0,0,0,0,0 },
+	[INSTR_RR_UR]	  = { 0xff, U4_8,R_12,0,0,0,0 },
+	[INSTR_RSE_CCRD]  = { 0xff, C_8,C_12,D_20,B_16,0,0 },
+	[INSTR_RSE_RRRD]  = { 0xff, R_8,R_12,D_20,B_16,0,0 },
+	[INSTR_RSE_RURD]  = { 0xff, R_8,U4_12,D_20,B_16,0,0 },
+	[INSTR_RSI_RRP]	  = { 0xff, R_8,R_12,J16_16,0,0,0 },
+	[INSTR_RSL_R0RD]  = { 0xff, D_20,L4_8,B_16,0,0,0 },
+	[INSTR_RSY_AARD]  = { 0xff, A_8,A_12,D20_20,B_16,0,0 },
+	[INSTR_RSY_CCRD]  = { 0xff, C_8,C_12,D20_20,B_16,0,0 },
+	[INSTR_RSY_RRRD]  = { 0xff, R_8,R_12,D20_20,B_16,0,0 },
 	[INSTR_RSY_RURD]  = { 0xff, R_8,U4_12,D20_20,B_16,0,0 },
-							       /* e.g. icmh  */
-	[INSTR_RSY_AARD]  = { 0xff, A_8,A_12,D20_20,B_16,0,0 },/* e.g. lamy  */
-	[INSTR_RSY_CCRD]  = { 0xff, C_8,C_12,D20_20,B_16,0,0 },/* e.g. lamy  */
-	[INSTR_RS_AARD]	  = { 0xff, A_8,A_12,D_20,B_16,0,0 },  /* e.g. lam   */
-	[INSTR_RS_CCRD]	  = { 0xff, C_8,C_12,D_20,B_16,0,0 },  /* e.g. lctl  */
-	[INSTR_RS_R0RD]	  = { 0xff, R_8,D_20,B_16,0,0,0 },     /* e.g. sll   */
-	[INSTR_RS_RRRD]	  = { 0xff, R_8,R_12,D_20,B_16,0,0 },  /* e.g. cs    */
-	[INSTR_RS_RURD]	  = { 0xff, R_8,U4_12,D_20,B_16,0,0 }, /* e.g. icm   */
-	[INSTR_RXE_FRRD]  = { 0xff, F_8,D_20,X_12,B_16,0,0 },  /* e.g. axbr  */
-	[INSTR_RXE_RRRD]  = { 0xff, R_8,D_20,X_12,B_16,0,0 },  /* e.g. lg    */
+	[INSTR_RS_AARD]	  = { 0xff, A_8,A_12,D_20,B_16,0,0 },
+	[INSTR_RS_CCRD]	  = { 0xff, C_8,C_12,D_20,B_16,0,0 },
+	[INSTR_RS_R0RD]	  = { 0xff, R_8,D_20,B_16,0,0,0 },
+	[INSTR_RS_RRRD]	  = { 0xff, R_8,R_12,D_20,B_16,0,0 },
+	[INSTR_RS_RURD]	  = { 0xff, R_8,U4_12,D_20,B_16,0,0 },
+	[INSTR_RXE_FRRD]  = { 0xff, F_8,D_20,X_12,B_16,0,0 },
+	[INSTR_RXE_RRRD]  = { 0xff, R_8,D_20,X_12,B_16,0,0 },
 	[INSTR_RXF_FRRDF] = { 0xff, F_32,F_8,D_20,X_12,B_16,0 },
-							       /* e.g. madb  */
-	[INSTR_RXY_RRRD]  = { 0xff, R_8,D20_20,X_12,B_16,0,0 },/* e.g. ly    */
-	[INSTR_RXY_FRRD]  = { 0xff, F_8,D20_20,X_12,B_16,0,0 },/* e.g. ley   */
-	[INSTR_RX_FRRD]	  = { 0xff, F_8,D_20,X_12,B_16,0,0 },  /* e.g. ae    */
-	[INSTR_RX_RRRD]	  = { 0xff, R_8,D_20,X_12,B_16,0,0 },  /* e.g. l     */
-	[INSTR_RX_URRD]	  = { 0xff, U4_8,D_20,X_12,B_16,0,0 }, /* e.g. bc    */
-	[INSTR_SI_URD]	  = { 0xff, D_20,B_16,U8_8,0,0,0 },    /* e.g. cli   */
-	[INSTR_SIY_URD]	  = { 0xff, D20_20,B_16,U8_8,0,0,0 },  /* e.g. tmy   */
-	[INSTR_SSE_RDRD]  = { 0xff, D_20,B_16,D_36,B_32,0,0 }, /* e.g. mvsdk */
+	[INSTR_RXY_FRRD]  = { 0xff, F_8,D20_20,X_12,B_16,0,0 },
+	[INSTR_RXY_RRRD]  = { 0xff, R_8,D20_20,X_12,B_16,0,0 },
+	[INSTR_RXY_URRD]  = { 0xff, U4_8,D20_20,X_12,B_16,0,0 },
+	[INSTR_RX_FRRD]	  = { 0xff, F_8,D_20,X_12,B_16,0,0 },
+	[INSTR_RX_RRRD]	  = { 0xff, R_8,D_20,X_12,B_16,0,0 },
+	[INSTR_RX_URRD]	  = { 0xff, U4_8,D_20,X_12,B_16,0,0 },
+	[INSTR_SIL_RDI]   = { 0xff, D_20,B_16,I16_32,0,0,0 },
+	[INSTR_SIL_RDU]   = { 0xff, D_20,B_16,U16_32,0,0,0 },
+	[INSTR_SIY_IRD]   = { 0xff, D20_20,B_16,I8_8,0,0,0 },
+	[INSTR_SIY_URD]	  = { 0xff, D20_20,B_16,U8_8,0,0,0 },
+	[INSTR_SI_URD]	  = { 0xff, D_20,B_16,U8_8,0,0,0 },
+	[INSTR_SSE_RDRD]  = { 0xff, D_20,B_16,D_36,B_32,0,0 },
+	[INSTR_SSF_RRDRD] = { 0x00, D_20,B_16,D_36,B_32,R_8,0 },
 	[INSTR_SS_L0RDRD] = { 0xff, D_20,L8_8,B_16,D_36,B_32,0 },
-							       /* e.g. mvc   */
 	[INSTR_SS_LIRDRD] = { 0xff, D_20,L4_8,B_16,D_36,B_32,U4_12 },
-							       /* e.g. srp   */
 	[INSTR_SS_LLRDRD] = { 0xff, D_20,L4_8,B_16,D_36,L4_12,B_32 },
-							       /* e.g. pack  */
-	[INSTR_SS_RRRDRD] = { 0xff, D_20,R_8,B_16,D_36,B_32,R_12 },
-							       /* e.g. mvck  */
 	[INSTR_SS_RRRDRD2]= { 0xff, R_8,D_20,B_16,R_12,D_36,B_32 },
-							       /* e.g. plo   */
 	[INSTR_SS_RRRDRD3]= { 0xff, R_8,R_12,D_20,B_16,D_36,B_32 },
-							       /* e.g. lmd   */
-	[INSTR_S_00]	  = { 0xff, 0,0,0,0,0,0 },	       /* e.g. hsch  */
-	[INSTR_S_RD]	  = { 0xff, D_20,B_16,0,0,0,0 },       /* e.g. lpsw  */
-	[INSTR_SSF_RRDRD] = { 0x00, D_20,B_16,D_36,B_32,R_8,0 },
-							       /* e.g. mvcos */
+	[INSTR_SS_RRRDRD] = { 0xff, D_20,R_8,B_16,D_36,B_32,R_12 },
+	[INSTR_S_00]	  = { 0xff, 0,0,0,0,0,0 },
+	[INSTR_S_RD]	  = { 0xff, D_20,B_16,0,0,0,0 },
 };
 
 static struct insn opcode[] = {
@@ -454,6 +493,8 @@
 static struct insn opcode_01[] = {
 #ifdef CONFIG_64BIT
 	{ "sam64", 0x0e, INSTR_E },
+	{ "pfpo", 0x0a, INSTR_E },
+	{ "ptff", 0x04, INSTR_E },
 #endif
 	{ "pr", 0x01, INSTR_E },
 	{ "upt", 0x02, INSTR_E },
@@ -519,6 +560,8 @@
 	{ "cutfu", 0xa7, INSTR_RRF_M0RR },
 	{ "stfle", 0xb0, INSTR_S_RD },
 	{ "lpswe", 0xb2, INSTR_S_RD },
+	{ "srnmt", 0xb9, INSTR_S_RD },
+	{ "lfas", 0xbd, INSTR_S_RD },
 #endif
 	{ "stidp", 0x02, INSTR_S_RD },
 	{ "sck", 0x04, INSTR_S_RD },
@@ -589,7 +632,6 @@
 	{ "clst", 0x5d, INSTR_RRE_RR },
 	{ "srst", 0x5e, INSTR_RRE_RR },
 	{ "cmpsc", 0x63, INSTR_RRE_RR },
-	{ "cmpsc", 0x63, INSTR_RRE_RR },
 	{ "siga", 0x74, INSTR_S_RD },
 	{ "xsch", 0x76, INSTR_S_00 },
 	{ "rp", 0x77, INSTR_S_RD },
@@ -630,6 +672,57 @@
 	{ "cger", 0xc8, INSTR_RRF_U0RF },
 	{ "cgdr", 0xc9, INSTR_RRF_U0RF },
 	{ "cgxr", 0xca, INSTR_RRF_U0RF },
+	{ "lpdfr", 0x70, INSTR_RRE_FF },
+	{ "lndfr", 0x71, INSTR_RRE_FF },
+	{ "cpsdr", 0x72, INSTR_RRF_F0FF2 },
+	{ "lcdfr", 0x73, INSTR_RRE_FF },
+	{ "ldgr", 0xc1, INSTR_RRE_FR },
+	{ "lgdr", 0xcd, INSTR_RRE_RF },
+	{ "adtr", 0xd2, INSTR_RRR_F0FF },
+	{ "axtr", 0xda, INSTR_RRR_F0FF },
+	{ "cdtr", 0xe4, INSTR_RRE_FF },
+	{ "cxtr", 0xec, INSTR_RRE_FF },
+	{ "kdtr", 0xe0, INSTR_RRE_FF },
+	{ "kxtr", 0xe8, INSTR_RRE_FF },
+	{ "cedtr", 0xf4, INSTR_RRE_FF },
+	{ "cextr", 0xfc, INSTR_RRE_FF },
+	{ "cdgtr", 0xf1, INSTR_RRE_FR },
+	{ "cxgtr", 0xf9, INSTR_RRE_FR },
+	{ "cdstr", 0xf3, INSTR_RRE_FR },
+	{ "cxstr", 0xfb, INSTR_RRE_FR },
+	{ "cdutr", 0xf2, INSTR_RRE_FR },
+	{ "cxutr", 0xfa, INSTR_RRE_FR },
+	{ "cgdtr", 0xe1, INSTR_RRF_U0RF },
+	{ "cgxtr", 0xe9, INSTR_RRF_U0RF },
+	{ "csdtr", 0xe3, INSTR_RRE_RF },
+	{ "csxtr", 0xeb, INSTR_RRE_RF },
+	{ "cudtr", 0xe2, INSTR_RRE_RF },
+	{ "cuxtr", 0xea, INSTR_RRE_RF },
+	{ "ddtr", 0xd1, INSTR_RRR_F0FF },
+	{ "dxtr", 0xd9, INSTR_RRR_F0FF },
+	{ "eedtr", 0xe5, INSTR_RRE_RF },
+	{ "eextr", 0xed, INSTR_RRE_RF },
+	{ "esdtr", 0xe7, INSTR_RRE_RF },
+	{ "esxtr", 0xef, INSTR_RRE_RF },
+	{ "iedtr", 0xf6, INSTR_RRF_F0FR },
+	{ "iextr", 0xfe, INSTR_RRF_F0FR },
+	{ "ltdtr", 0xd6, INSTR_RRE_FF },
+	{ "ltxtr", 0xde, INSTR_RRE_FF },
+	{ "fidtr", 0xd7, INSTR_RRF_UUFF },
+	{ "fixtr", 0xdf, INSTR_RRF_UUFF },
+	{ "ldetr", 0xd4, INSTR_RRF_0UFF },
+	{ "lxdtr", 0xdc, INSTR_RRF_0UFF },
+	{ "ledtr", 0xd5, INSTR_RRF_UUFF },
+	{ "ldxtr", 0xdd, INSTR_RRF_UUFF },
+	{ "mdtr", 0xd0, INSTR_RRR_F0FF },
+	{ "mxtr", 0xd8, INSTR_RRR_F0FF },
+	{ "qadtr", 0xf5, INSTR_RRF_FUFF },
+	{ "qaxtr", 0xfd, INSTR_RRF_FUFF },
+	{ "rrdtr", 0xf7, INSTR_RRF_FFRU },
+	{ "rrxtr", 0xff, INSTR_RRF_FFRU },
+	{ "sfasr", 0x85, INSTR_RRE_R0 },
+	{ "sdtr", 0xd3, INSTR_RRR_F0FF },
+	{ "sxtr", 0xdb, INSTR_RRR_F0FF },
 #endif
 	{ "lpebr", 0x00, INSTR_RRE_FF },
 	{ "lnebr", 0x01, INSTR_RRE_FF },
@@ -780,6 +873,14 @@
 	{ "cu24", 0xb1, INSTR_RRF_M0RR },
 	{ "cu41", 0xb2, INSTR_RRF_M0RR },
 	{ "cu42", 0xb3, INSTR_RRF_M0RR },
+	{ "crt", 0x72, INSTR_RRF_U0RR },
+	{ "cgrt", 0x60, INSTR_RRF_U0RR },
+	{ "clrt", 0x73, INSTR_RRF_U0RR },
+	{ "clgrt", 0x61, INSTR_RRF_U0RR },
+	{ "ptf", 0xa2, INSTR_RRE_R0 },
+	{ "pfmf", 0xaf, INSTR_RRE_RR },
+	{ "trte", 0xbf, INSTR_RRF_M0RR },
+	{ "trtre", 0xbd, INSTR_RRF_M0RR },
 #endif
 	{ "kmac", 0x1e, INSTR_RRE_RR },
 	{ "lrvr", 0x1f, INSTR_RRE_RR },
@@ -835,6 +936,43 @@
 	{ "cfi", 0x0d, INSTR_RIL_RI },
 	{ "clgfi", 0x0e, INSTR_RIL_RU },
 	{ "clfi", 0x0f, INSTR_RIL_RU },
+	{ "msfi", 0x01, INSTR_RIL_RI },
+	{ "msgfi", 0x00, INSTR_RIL_RI },
+#endif
+	{ "", 0, INSTR_INVALID }
+};
+
+static struct insn opcode_c4[] = {
+#ifdef CONFIG_64BIT
+	{ "lrl", 0x0d, INSTR_RIL_RP },
+	{ "lgrl", 0x08, INSTR_RIL_RP },
+	{ "lgfrl", 0x0c, INSTR_RIL_RP },
+	{ "lhrl", 0x05, INSTR_RIL_RP },
+	{ "lghrl", 0x04, INSTR_RIL_RP },
+	{ "llgfrl", 0x0e, INSTR_RIL_RP },
+	{ "llhrl", 0x02, INSTR_RIL_RP },
+	{ "llghrl", 0x06, INSTR_RIL_RP },
+	{ "strl", 0x0f, INSTR_RIL_RP },
+	{ "stgrl", 0x0b, INSTR_RIL_RP },
+	{ "sthrl", 0x07, INSTR_RIL_RP },
+#endif
+	{ "", 0, INSTR_INVALID }
+};
+
+static struct insn opcode_c6[] = {
+#ifdef CONFIG_64BIT
+	{ "crl", 0x0d, INSTR_RIL_RP },
+	{ "cgrl", 0x08, INSTR_RIL_RP },
+	{ "cgfrl", 0x0c, INSTR_RIL_RP },
+	{ "chrl", 0x05, INSTR_RIL_RP },
+	{ "cghrl", 0x04, INSTR_RIL_RP },
+	{ "clrl", 0x0f, INSTR_RIL_RP },
+	{ "clgrl", 0x0a, INSTR_RIL_RP },
+	{ "clgfrl", 0x0e, INSTR_RIL_RP },
+	{ "clhrl", 0x07, INSTR_RIL_RP },
+	{ "clghrl", 0x06, INSTR_RIL_RP },
+	{ "pfdrl", 0x02, INSTR_RIL_UP },
+	{ "exrl", 0x00, INSTR_RIL_RP },
 #endif
 	{ "", 0, INSTR_INVALID }
 };
@@ -842,6 +980,8 @@
 static struct insn opcode_c8[] = {
 #ifdef CONFIG_64BIT
 	{ "mvcos", 0x00, INSTR_SSF_RRDRD },
+	{ "ectg", 0x01, INSTR_SSF_RRDRD },
+	{ "csst", 0x02, INSTR_SSF_RRDRD },
 #endif
 	{ "", 0, INSTR_INVALID }
 };
@@ -917,6 +1057,12 @@
 	{ "llgh", 0x91, INSTR_RXY_RRRD },
 	{ "llc", 0x94, INSTR_RXY_RRRD },
 	{ "llh", 0x95, INSTR_RXY_RRRD },
+	{ "cgh", 0x34, INSTR_RXY_RRRD },
+	{ "laey", 0x75, INSTR_RXY_RRRD },
+	{ "ltgf", 0x32, INSTR_RXY_RRRD },
+	{ "mfy", 0x5c, INSTR_RXY_RRRD },
+	{ "mhy", 0x7c, INSTR_RXY_RRRD },
+	{ "pfd", 0x36, INSTR_RXY_URRD },
 #endif
 	{ "lrv", 0x1e, INSTR_RXY_RRRD },
 	{ "lrvh", 0x1f, INSTR_RXY_RRRD },
@@ -931,6 +1077,15 @@
 static struct insn opcode_e5[] = {
 #ifdef CONFIG_64BIT
 	{ "strag", 0x02, INSTR_SSE_RDRD },
+	{ "chhsi", 0x54, INSTR_SIL_RDI },
+	{ "chsi", 0x5c, INSTR_SIL_RDI },
+	{ "cghsi", 0x58, INSTR_SIL_RDI },
+	{ "clhhsi", 0x55, INSTR_SIL_RDU },
+	{ "clfhsi", 0x5d, INSTR_SIL_RDU },
+	{ "clghsi", 0x59, INSTR_SIL_RDU },
+	{ "mvhhi", 0x44, INSTR_SIL_RDI },
+	{ "mvhi", 0x4c, INSTR_SIL_RDI },
+	{ "mvghi", 0x48, INSTR_SIL_RDI },
 #endif
 	{ "lasp", 0x00, INSTR_SSE_RDRD },
 	{ "tprot", 0x01, INSTR_SSE_RDRD },
@@ -977,6 +1132,11 @@
 	{ "lmy", 0x98, INSTR_RSY_RRRD },
 	{ "lamy", 0x9a, INSTR_RSY_AARD },
 	{ "stamy", 0x9b, INSTR_RSY_AARD },
+	{ "asi", 0x6a, INSTR_SIY_IRD },
+	{ "agsi", 0x7a, INSTR_SIY_IRD },
+	{ "alsi", 0x6e, INSTR_SIY_IRD },
+	{ "algsi", 0x7e, INSTR_SIY_IRD },
+	{ "ecag", 0x4c, INSTR_RSY_RRRD },
 #endif
 	{ "rll", 0x1d, INSTR_RSY_RRRD },
 	{ "mvclu", 0x8e, INSTR_RSY_RRRD },
@@ -988,6 +1148,30 @@
 #ifdef CONFIG_64BIT
 	{ "brxhg", 0x44, INSTR_RIE_RRP },
 	{ "brxlg", 0x45, INSTR_RIE_RRP },
+	{ "crb", 0xf6, INSTR_RRS_RRRDU },
+	{ "cgrb", 0xe4, INSTR_RRS_RRRDU },
+	{ "crj", 0x76, INSTR_RIE_RRPU },
+	{ "cgrj", 0x64, INSTR_RIE_RRPU },
+	{ "cib", 0xfe, INSTR_RIS_RURDI },
+	{ "cgib", 0xfc, INSTR_RIS_RURDI },
+	{ "cij", 0x7e, INSTR_RIE_RUPI },
+	{ "cgij", 0x7c, INSTR_RIE_RUPI },
+	{ "cit", 0x72, INSTR_RIE_R0IU },
+	{ "cgit", 0x70, INSTR_RIE_R0IU },
+	{ "clrb", 0xf7, INSTR_RRS_RRRDU },
+	{ "clgrb", 0xe5, INSTR_RRS_RRRDU },
+	{ "clrj", 0x77, INSTR_RIE_RRPU },
+	{ "clgrj", 0x65, INSTR_RIE_RRPU },
+	{ "clib", 0xff, INSTR_RIS_RURDU },
+	{ "clgib", 0xfd, INSTR_RIS_RURDU },
+	{ "clij", 0x7f, INSTR_RIE_RUPU },
+	{ "clgij", 0x7d, INSTR_RIE_RUPU },
+	{ "clfit", 0x73, INSTR_RIE_R0UU },
+	{ "clgit", 0x71, INSTR_RIE_R0UU },
+	{ "rnsbg", 0x54, INSTR_RIE_RRUUU },
+	{ "rxsbg", 0x57, INSTR_RIE_RRUUU },
+	{ "rosbg", 0x56, INSTR_RIE_RRUUU },
+	{ "risbg", 0x55, INSTR_RIE_RRUUU },
 #endif
 	{ "", 0, INSTR_INVALID }
 };
@@ -1004,6 +1188,16 @@
 	{ "ldy", 0x65, INSTR_RXY_FRRD },
 	{ "stey", 0x66, INSTR_RXY_FRRD },
 	{ "stdy", 0x67, INSTR_RXY_FRRD },
+	{ "sldt", 0x40, INSTR_RXF_FRRDF },
+	{ "slxt", 0x48, INSTR_RXF_FRRDF },
+	{ "srdt", 0x41, INSTR_RXF_FRRDF },
+	{ "srxt", 0x49, INSTR_RXF_FRRDF },
+	{ "tdcet", 0x50, INSTR_RXE_FRRD },
+	{ "tdcdt", 0x54, INSTR_RXE_FRRD },
+	{ "tdcxt", 0x58, INSTR_RXE_FRRD },
+	{ "tdget", 0x51, INSTR_RXE_FRRD },
+	{ "tdgdt", 0x55, INSTR_RXE_FRRD },
+	{ "tdgxt", 0x59, INSTR_RXE_FRRD },
 #endif
 	{ "ldeb", 0x04, INSTR_RXE_FRRD },
 	{ "lxdb", 0x05, INSTR_RXE_FRRD },
@@ -1037,6 +1231,7 @@
 	{ "mae", 0x2e, INSTR_RXF_FRRDF },
 	{ "mse", 0x2f, INSTR_RXF_FRRDF },
 	{ "sqe", 0x34, INSTR_RXE_FRRD },
+	{ "sqd", 0x35, INSTR_RXE_FRRD },
 	{ "mee", 0x37, INSTR_RXE_FRRD },
 	{ "mad", 0x3e, INSTR_RXF_FRRDF },
 	{ "msd", 0x3f, INSTR_RXF_FRRDF },
@@ -1117,6 +1312,12 @@
 	case 0xc2:
 		table = opcode_c2;
 		break;
+	case 0xc4:
+		table = opcode_c4;
+		break;
+	case 0xc6:
+		table = opcode_c6;
+		break;
 	case 0xc8:
 		table = opcode_c8;
 		break;
