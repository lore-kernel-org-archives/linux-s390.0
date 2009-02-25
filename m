Return-Path: <linux-kernel-owner+w=401wt.eu-S1761892AbZBYPTE@vger.kernel.org>
Message-Id: <20090225150839.018436534@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:07:05 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 43/46] module function call optimization
Content-Disposition: inline; filename=142-module-branches.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Avoid the detour over the PLT if the branch target of a function call
in a module is in the range of the bras (16-bit) or brasl (32-bit)
instruction. The PLT is still generated but it is unused.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/module.c |   19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

Index: quilt-2.6/arch/s390/kernel/module.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/module.c
+++ quilt-2.6/arch/s390/kernel/module.c
@@ -310,15 +310,20 @@ apply_rela(Elf_Rela *rela, Elf_Addr base
 			info->plt_initialized = 1;
 		}
 		if (r_type == R_390_PLTOFF16 ||
-		    r_type == R_390_PLTOFF32
-		    || r_type == R_390_PLTOFF64
-			)
+		    r_type == R_390_PLTOFF32 ||
+		    r_type == R_390_PLTOFF64)
 			val = me->arch.plt_offset - me->arch.got_offset +
 				info->plt_offset + rela->r_addend;
-		else
-			val =  (Elf_Addr) me->module_core +
-				me->arch.plt_offset + info->plt_offset + 
-				rela->r_addend - loc;
+		else {
+			if (!((r_type == R_390_PLT16DBL &&
+			       val - loc + 0xffffUL < 0x1ffffeUL) ||
+			      (r_type == R_390_PLT32DBL &&
+			       val - loc + 0xffffffffULL < 0x1fffffffeULL)))
+				val = (Elf_Addr) me->module_core +
+					me->arch.plt_offset +
+					info->plt_offset;
+			val += rela->r_addend - loc;
+		}
 		if (r_type == R_390_PLT16DBL)
 			*(unsigned short *) loc = val >> 1;
 		else if (r_type == R_390_PLTOFF16)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
