Return-Path: <linux-kernel-owner+w=401wt.eu-S1753711AbXGQMUu@vger.kernel.org>
Message-Id: <20070717122231.050011517@de.ibm.com>
References: <20070717121747.591687140@de.ibm.com>
Date: Tue, 17 Jul 2007 14:17:49 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 2/8] Fix disassembly of RX_URRD, SI_URD & PC-relative instructions.
Content-Disposition: inline; filename=001-disassembler.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Christian Borntraeger <borntraeger@de.ibm.com>

The instructions with format RX_URRD and SI_URD and instructions
with a PC relative operand are not disassembled correctly.
For RX_URRD and SI_URD instructions find_insn sets opfrag to code[0].
The mask byte of these two formats is 0x00. table->opfrag will never
be identical to (opfrag & opmask) and no matching instruction will
be found. Set the mask byte to 0xff to actually check byte 0 against
the table.
For PC relative instructions the (unsigned) offset value needs to be
casted to an signed integer so that negative branch offsets are
handled correctly.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/dis.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

Index: quilt-2.6/arch/s390/kernel/dis.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/dis.c
+++ quilt-2.6/arch/s390/kernel/dis.c
@@ -240,8 +240,8 @@ static const unsigned char formats[][7] 
 	[INSTR_RXY_FRRD]  = { 0xff, F_8,D20_20,X_12,B_16,0,0 },/* e.g. ley   */
 	[INSTR_RX_FRRD]	  = { 0xff, F_8,D_20,X_12,B_16,0,0 },  /* e.g. ae    */
 	[INSTR_RX_RRRD]	  = { 0xff, R_8,D_20,X_12,B_16,0,0 },  /* e.g. l     */
-	[INSTR_RX_URRD]	  = { 0x00, U4_8,D_20,X_12,B_16,0,0 }, /* e.g. bc    */
-	[INSTR_SI_URD]	  = { 0x00, D_20,B_16,U8_8,0,0,0 },    /* e.g. cli   */
+	[INSTR_RX_URRD]	  = { 0xff, U4_8,D_20,X_12,B_16,0,0 }, /* e.g. bc    */
+	[INSTR_SI_URD]	  = { 0xff, D_20,B_16,U8_8,0,0,0 },    /* e.g. cli   */
 	[INSTR_SIY_URD]	  = { 0xff, D20_20,B_16,U8_8,0,0,0 },  /* e.g. tmy   */
 	[INSTR_SSE_RDRD]  = { 0xff, D_20,B_16,D_36,B_32,0,0 }, /* e.g. mvsdk */
 	[INSTR_SS_L0RDRD] = { 0xff, D_20,L8_8,B_16,D_36,B_32,0 },
@@ -1190,7 +1190,8 @@ static int print_insn(char *buffer, unsi
 			else if (operand->flags & OPERAND_CR)
 				ptr += sprintf(ptr, "%%c%i", value);
 			else if (operand->flags & OPERAND_PCREL)
-				ptr += sprintf(ptr, "%lx", value + addr);
+				ptr += sprintf(ptr, "%lx", (signed int) value
+								      + addr);
 			else if (operand->flags & OPERAND_SIGNED)
 				ptr += sprintf(ptr, "%i", value);
 			else

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
