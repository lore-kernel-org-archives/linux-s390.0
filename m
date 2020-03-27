Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:47084 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725946AbgC0I4K (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 27 Mar 2020 04:56:10 -0400
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH] s390/gmap: return proper error code on ksm unsharing
Date: Fri, 27 Mar 2020 04:56:02 -0400
Message-Id: <20200327085602.24535-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Heiko Carstens <heiko.carstens@de.ibm.com>

If a signal is pending we might return -ENOMEM instead of -EINTR.
We should propagate the proper error during KSM unsharing.

Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/mm/gmap.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 27926a06df32..2bf63035a295 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2552,15 +2552,16 @@ int gmap_mark_unmergeable(void)
 {
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
+	int ret  = 0;
 
 	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				MADV_UNMERGEABLE, &vma->vm_flags)) {
-			return -ENOMEM;
-		}
+		ret = ksm_madvise(vma, vma->vm_start, vma->vm_end,
+				MADV_UNMERGEABLE, &vma->vm_flags);
+		if (ret)
+			return ret;
 	}
 	mm->def_flags &= ~VM_MERGEABLE;
-	return 0;
+	return ret;
 }
 EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
 
-- 
2.25.1
