Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:28140 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2437952AbfJYIZB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 04:25:01 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9P8AXua110472
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 04:25:00 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vuuh4um3q-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 04:25:00 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 25 Oct 2019 09:24:58 +0100
From: Janosch Frank <frankja@linux.ibm.com>
Subject: [RFC v2] KVM: s390: protvirt: Secure memory is not mergeable
Date: Fri, 25 Oct 2019 04:24:46 -0400
In-Reply-To: <20191024114059.102802-8-frankja@linux.ibm.com>
References: <20191024114059.102802-8-frankja@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20191025082446.754-1-frankja@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com, frankja@linux.ibm.com

KSM will not work on secure pages, because when the kernel reads a
secure page, it will be encrypted and hence no two pages will look the
same.

Let's mark the guest pages as unmergeable when we transition to secure
mode.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/include/asm/gmap.h |  1 +
 arch/s390/kvm/kvm-s390.c     |  6 ++++++
 arch/s390/mm/gmap.c          | 32 +++++++++++++++++++++-----------
 3 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 6efc0b501227..eab6a2ec3599 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -145,4 +145,5 @@ int gmap_mprotect_notify(struct gmap *, unsigned long start,
 
 void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
 			     unsigned long gaddr, unsigned long vmaddr);
+int gmap_mark_unmergeable(void);
 #endif /* _ASM_S390_GMAP_H */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 924132d92782..d1ba12f857e7 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2176,6 +2176,12 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		if (r)
 			break;
 
+		down_write(&current->mm->mmap_sem);
+		r = gmap_mark_unmergeable();
+		up_write(&current->mm->mmap_sem);
+		if (r)
+			break;
+
 		mutex_lock(&kvm->lock);
 		kvm_s390_vcpu_block_all(kvm);
 		/* FMT 4 SIE needs esca */
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index edcdca97e85e..faecdf81abdb 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2548,6 +2548,23 @@ int s390_enable_sie(void)
 }
 EXPORT_SYMBOL_GPL(s390_enable_sie);
 
+int gmap_mark_unmergeable(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
+				MADV_UNMERGEABLE, &vma->vm_flags))
+			return -ENOMEM;
+	}
+	mm->def_flags &= ~VM_MERGEABLE;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
+
 /*
  * Enable storage key handling from now on and initialize the storage
  * keys with the default key.
@@ -2593,24 +2610,17 @@ static const struct mm_walk_ops enable_skey_walk_ops = {
 int s390_enable_skey(void)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	int rc = 0;
 
 	down_write(&mm->mmap_sem);
 	if (mm_uses_skeys(mm))
 		goto out_up;
 
-	mm->context.uses_skeys = 1;
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				MADV_UNMERGEABLE, &vma->vm_flags)) {
-			mm->context.uses_skeys = 0;
-			rc = -ENOMEM;
-			goto out_up;
-		}
-	}
-	mm->def_flags &= ~VM_MERGEABLE;
+	rc = gmap_mark_unmergeable();
+	if (rc)
+		goto out_up;
 
+	mm->context.uses_skeys = 1;
 	walk_page_range(mm, 0, TASK_SIZE, &enable_skey_walk_ops, NULL);
 
 out_up:
-- 
2.20.1
