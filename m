Return-Path: <linux-kernel-owner+w=401wt.eu-S1761927AbZBYPMo@vger.kernel.org>
Message-Id: <20090225150831.512686187@de.ibm.com>
References: <20090225150622.529143164@de.ibm.com>
Date: Wed, 25 Feb 2009 16:06:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch/s390 16/46] check addressing mode in s390_enable_sie
Content-Disposition: inline; filename=115-kvm-amode-check.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Carsten Otte <cotte@de.ibm.com>

The sie instruction requires address spaces to be switched
to run proper. This patch verifies that this is the case
in s390_enable_sie, otherwise the kernel would crash badly
as soon as the process runs into sie.

Signed-off-by: Carsten Otte <cotte@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/mm/pgtable.c |    4 ++++
 1 file changed, 4 insertions(+)

Index: quilt-2.6/arch/s390/mm/pgtable.c
===================================================================
--- quilt-2.6.orig/arch/s390/mm/pgtable.c
+++ quilt-2.6/arch/s390/mm/pgtable.c
@@ -256,6 +256,10 @@ int s390_enable_sie(void)
 	struct task_struct *tsk = current;
 	struct mm_struct *mm, *old_mm;
 
+	/* Do we have switched amode? If no, we cannot do sie */
+	if (!switch_amode)
+		return -EINVAL;
+
 	/* Do we have pgstes? if yes, we are done */
 	if (tsk->mm->context.has_pgste)
 		return 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
