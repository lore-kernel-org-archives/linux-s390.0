Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39350 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729999AbgC3MTq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 30 Mar 2020 08:19:46 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02UC3wG6134477
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 08:19:45 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3020wcjksc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 30 Mar 2020 08:19:44 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Mon, 30 Mar 2020 13:19:29 +0100
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/1] s390/gmap: return proper error code on ksm unsharing
Date: Mon, 30 Mar 2020 14:19:34 +0200
In-Reply-To: <20200330121934.28143-1-borntraeger@de.ibm.com>
References: <20200330121934.28143-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200330121934.28143-2-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Marc Hartmayer <mhartmay@linux.ibm.com>

If a signal is pending we might return -ENOMEM instead of -EINTR.
We should propagate the proper error during KSM unsharing.
unmerge_ksm_pages returns -ERESTARTSYS on signal_pending. This gets
translated by entry.S to -EINTR. It is important to get this error
code so that userspace can retry.

To make this clearer we also add -EINTR to the documentation of the
PV_ENABLE call, which calls unmerge_ksm_pages.

Fixes: 3ac8e38015d4 ("s390/mm: disable KSM for storage key enabled pages")
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Reported-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Tested-by: Marc Hartmayer <mhartmay@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virt/kvm/api.rst | 6 ++++++
 arch/s390/mm/gmap.c            | 9 +++++----
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index bae90f3cd11d..2edb28bd07a9 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4677,6 +4677,12 @@ KVM_PV_ENABLE
   command has succeeded, any CPU added via hotplug will become
   protected during its creation as well.
 
+  Errors:
+
+  =====      =============================
+  EINTR      an unmasked signal is pending
+  =====      =============================
+
 KVM_PV_DISABLE
 
   Deregister the VM from the Ultravisor and reclaim the memory that
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 03c899849c38..2fbece47ef6f 100644
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
