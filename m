Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Anshuman Khandual <anshuman.khandual@arm.com>
Subject: [RFC V2 3/3] s390/mm: Define arch_get_mappable_range()
Date: Mon, 30 Nov 2020 08:59:52 +0530
Message-Id: <1606706992-26656-4-git-send-email-anshuman.khandual@arm.com>
In-Reply-To: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
References: <1606706992-26656-1-git-send-email-anshuman.khandual@arm.com>
List-ID: <linux-s390.vger.kernel.org>
To: linux-mm@kvack.org, akpm@linux-foundation.org, david@redhat.com
Cc: linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Anshuman Khandual <anshuman.khandual@arm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>

This overrides arch_get_mappabble_range() on s390 platform and drops now
redundant similar check in vmem_add_mapping(). This compensates by adding
a new check __segment_load() to preserve the existing functionality.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>
Cc: linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/s390/mm/extmem.c |  5 +++++
 arch/s390/mm/vmem.c   | 13 +++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/extmem.c b/arch/s390/mm/extmem.c
index 5060956b8e7d..cc055a78f7b6 100644
--- a/arch/s390/mm/extmem.c
+++ b/arch/s390/mm/extmem.c
@@ -337,6 +337,11 @@ __segment_load (char *name, int do_nonshared, unsigned long *addr, unsigned long
 		goto out_free_resource;
 	}
 
+	if (seg->end + 1 > VMEM_MAX_PHYS || seg->end + 1 < seg->start_addr) {
+		rc = -ERANGE;
+		goto out_resource;
+	}
+
 	rc = vmem_add_mapping(seg->start_addr, seg->end - seg->start_addr + 1);
 	if (rc)
 		goto out_resource;
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index b239f2ba93b0..06dddcc0ce06 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -532,14 +532,19 @@ void vmem_remove_mapping(unsigned long start, unsigned long size)
 	mutex_unlock(&vmem_mutex);
 }
 
+struct range arch_get_mappable_range(void)
+{
+	struct range memhp_range;
+
+	memhp_range.start = 0;
+	memhp_range.end =  VMEM_MAX_PHYS;
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
