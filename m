Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Guenter Roeck <linux@roeck-us.net>
Subject: [RFC PATCH] s390: Fix runtime warning about negative pgtables_bytes
Date: Thu,  1 Mar 2018 14:40:52 -0800
Message-Id: <1519944052-19992-1-git-send-email-linux@roeck-us.net>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When running s390 images with 'compat' processes, the following
BUG is seen repeatedly.

BUG: non-zero pgtables_bytes on freeing mm: -16384

Bisect points to commit b4e98d9ac775 ("mm: account pud page tables").
Analysis shows that init_new_context() is called with
mm->context.asce_limit set to _REGION3_SIZE. In this situation,
pgtables_bytes remains set to 0 and is not increased. The message is
displayed when the affected process dies and mm_dec_nr_puds() is called.

Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Fixes: b4e98d9ac775 ("mm: account pud page tables")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
RFC since I have no idea if this is correct (or complete, for that matter).
All I can say is that the message is no longer seen after the patch is
applied.

 arch/s390/include/asm/mmu_context.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index 65154eaa3714..6c8ce15cde7b 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -63,6 +63,7 @@ static inline int init_new_context(struct task_struct *tsk,
 				   _ASCE_USER_BITS | _ASCE_TYPE_SEGMENT;
 		/* pgd_alloc() did not account this pmd */
 		mm_inc_nr_pmds(mm);
+		mm_inc_nr_puds(mm);
 	}
 	crst_table_init((unsigned long *) mm->pgd, pgd_entry_type(mm));
 	return 0;
-- 
2.7.4
