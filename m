From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 4/8] KVM: s390: fix task size check
Date: Fri, 26 Jul 2013 15:04:03 +0200
Message-ID: <1374843847-5046-5-git-send-email-borntraeger@de.ibm.com>
References: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1374843847-5046-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: Cornelia Huck <cornelia.huck@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

The gmap_map_segment function uses PGDIR_SIZE in the check for the
maximum address in the tasks address space. This incorrectly limits
the amount of memory usable for a kvm guest to 4TB. The correct limit
is (1UL << 53). As the TASK_SIZE has different values (4TB vs 8PB)
dependent on the existance of the fourth page table level, create
a new define 'TASK_MAX_SIZE' for (1UL << 53).

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/processor.h | 2 ++
 arch/s390/mm/pgtable.c            | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/processor.h b/arch/s390/include/asm/processor.h
index 6b49987..83c85c2 100644
--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -43,6 +43,7 @@ extern void execve_tail(void);
 #ifndef CONFIG_64BIT
 
 #define TASK_SIZE		(1UL << 31)
+#define TASK_MAX_SIZE		(1UL << 31)
 #define TASK_UNMAPPED_BASE	(1UL << 30)
 
 #else /* CONFIG_64BIT */
@@ -51,6 +52,7 @@ extern void execve_tail(void);
 #define TASK_UNMAPPED_BASE	(test_thread_flag(TIF_31BIT) ? \
 					(1UL << 30) : (1UL << 41))
 #define TASK_SIZE		TASK_SIZE_OF(current)
+#define TASK_MAX_SIZE		(1UL << 53)
 
 #endif /* CONFIG_64BIT */
 
diff --git a/arch/s390/mm/pgtable.c b/arch/s390/mm/pgtable.c
index 6d33248..967d0bf 100644
--- a/arch/s390/mm/pgtable.c
+++ b/arch/s390/mm/pgtable.c
@@ -335,7 +335,7 @@ int gmap_map_segment(struct gmap *gmap, unsigned long from,
 
 	if ((from | to | len) & (PMD_SIZE - 1))
 		return -EINVAL;
-	if (len == 0 || from + len > PGDIR_SIZE ||
+	if (len == 0 || from + len > TASK_MAX_SIZE ||
 	    from + len < from || to + len < to)
 		return -EINVAL;
 
-- 
1.8.3.1
