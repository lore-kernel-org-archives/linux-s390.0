Return-Path: <linux-kernel-owner+w=401wt.eu-S1763214AbXHVMgT@vger.kernel.org>
Message-Id: <20070822123643.989489295@de.ibm.com>
References: <20070822123603.501231302@de.ibm.com>
Date: Wed, 22 Aug 2007 14:36:12 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/10] kprobes: fix instruction length calculation
Content-Disposition: inline; filename=009-kprobe-iln.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: David Wilder <dwilder@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Wilder <dwilder@us.ibm.com>

Placing a kprobe on "bc" instruction (s390/s390x) can cause an oops.
The instruction length is encoded into the first two bits of the s390
instruction. Kprobe is incorrectly computing the instruction length.
The instruction length is used for determining what type of "fix-up" is
needed for conditional branch instruction. The problem can bee seen by
placing a kprobe on a "bc" instruction that will not branch. The
results is that Kprobe incorrectly computes the new instruction
pointer (psw.addr) after single stepping the instruction. The problem
is corrected with this patch.

Signed-off-by: David Wilder <dwilder@us.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---

 arch/s390/kernel/kprobes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/kprobes.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/kprobes.c
+++ quilt-2.6/arch/s390/kernel/kprobes.c
@@ -85,7 +85,7 @@ void __kprobes get_instruction_type(stru
 	ainsn->reg = (*ainsn->insn & 0xf0) >> 4;
 
 	/* save the instruction length (pop 5-5) in bytes */
-	switch (*(__u8 *) (ainsn->insn) >> 4) {
+	switch (*(__u8 *) (ainsn->insn) >> 6) {
 	case 0:
 		ainsn->ilen = 2;
 		break;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
