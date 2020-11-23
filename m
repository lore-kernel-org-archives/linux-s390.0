Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC 3/3] s390/mm: Define arch_get_addressable_range()
Date: Mon, 23 Nov 2020 07:58:49 +0530
Message-Id: <1606098529-7907-4-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
References: <1606098529-7907-1-git-send-email-anshuman.khandual@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc: Anshuman Khandual <anshuman.khandual@arm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org

This overrides arch_get_addressable_range() on s390 platform and drops
now redudant similar check in vmem_add_mapping().

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/include/asm/mmu.h |  2 ++
 arch/s390/mm/vmem.c         | 16 ++++++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index e12ff0f29d1a..f92d3926b188 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -55,4 +55,6 @@ static inline int tprot(unsigned long addr)
 	return rc;
 }
 
+#define arch_get_addressable_range arch_get_addressable_range
+struct range arch_get_addressable_range(bool need_mapping);
 #endif
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b0..e03ad0ed13a7 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -532,14 +532,22 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
 	mutex_unlock(&vmem_mutex);
 }
 
+struct range arch_get_addressable_range(bool need_mapping)
+{
+	struct range memhp_range;
+
+	memhp_range.start = 0;
+	if (need_mapping)
+		memhp_range.end =  VMEM_MAX_PHYS;
+	else
+		memhp_range.end = (1ULL << (MAX_PHYSMEM_BITS + 1)) - 1;
+	return memhp_range;
+}
+
 int vmem_add_mapping(unsigned long start, unsigned long size)
 {
 	int ret;
 
-	if (start + size > VMEM_MAX_PHYS ||
-	    start + size < start)
-		return -ERANGE;
-
 	mutex_lock(&vmem_mutex);
 	ret = vmem_add_range(start, size);
 	if (ret)
-- 
2.20.1
