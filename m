Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Li Wang <liwang@redhat.com>
Subject: [PATCH] s390/mm: return -ENOMEM in arch_get_unmapped_area[_topdown]
Date: Thu, 26 Oct 2017 15:36:10 +0800
Message-Id: <20171026073610.9139-1-liwang@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, mingo@kernel.org, hughd@google.com, paul.gortmaker@windriver.com, mhocko@suse.com, shuwang@redhat.com, liwang@redhat.com
List-ID: <linux-s390.vger.kernel.org>

That would be very hard to get -ENOMEM returned in crst_table_upgrade()
because the condition(addr + len <= TASK_SIZE) makes all 'end' value
is smaller/equal than 'TASK_SIZE_TASK'. So let's move it to the upper
layer.

Fixes: 8ab867cb0806 (s390/mm: fix BUG_ON in crst_table_upgrade)
Signed-off-by: Li Wang <liwang@redhat.com>
---
 arch/s390/mm/mmap.c    | 6 ++++++
 arch/s390/mm/pgalloc.c | 3 +--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 5bea139..8ddb13a 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -119,6 +119,9 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 		return addr;
 
 check_asce_limit:
+	if (addr + len >= TASK_SIZE_MAX)
+		return -ENOMEM;
+
 	if (addr + len > current->mm->context.asce_limit &&
 	    addr + len <= TASK_SIZE) {
 		rc = crst_table_upgrade(mm, addr + len);
@@ -184,6 +187,9 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	}
 
 check_asce_limit:
+	if (addr + len >= TASK_SIZE_MAX)
+		return -ENOMEM;
+
 	if (addr + len > current->mm->context.asce_limit &&
 	    addr + len <= TASK_SIZE) {
 		rc = crst_table_upgrade(mm, addr + len);
diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index 05f1f27..5e4b887 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -84,8 +84,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 
 	/* upgrade should only happen from 3 to 4, 3 to 5, or 4 to 5 levels */
 	VM_BUG_ON(mm->context.asce_limit < _REGION2_SIZE);
-	if (end >= TASK_SIZE_MAX)
-		return -ENOMEM;
+
 	rc = 0;
 	notify = 0;
 	while (mm->context.asce_limit < end) {
-- 
2.9.3
