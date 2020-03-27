Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:48630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726002AbgC0JYF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 05:24:05 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH v2] s390/gmap: return proper error code on ksm unsharing
Date: Fri, 27 Mar 2020 05:23:56 -0400
Message-Id: <20200327092356.25171-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

If a signal is pending we might return -ENOMEM instead of -EINTR.
We should propagate the proper error during KSM unsharing.

Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 27926a06df32..1ef864c252e6 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2552,12 +2552,13 @@ int gmap_mark_unmergeable(void)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	int ret;
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				MADV_UNMERGEABLE, &vma->vm_flags)) {
-			return -ENOMEM;
-		}
+		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
+				  MADV_UNMERGEABLE, &vma->vm_flags);
+		if (ret)
+			return ret;
 	}
 	mm->def_flags &= ~VM_MERGEABLE;
 	return 0;
-- 
2.25.1
