Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:33884 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727178AbgBGLkI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:08 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 10/35] KVM: s390: protvirt: Secure memory is not mergeable
Date: Fri,  7 Feb 2020 06:39:33 -0500
Message-Id: <20200207113958.7320-11-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

From: Janosch Frank <frankja@linux.ibm.com>

KSM will not work on secure pages, because when the kernel reads a
secure page, it will be encrypted and hence no two pages will look the
same.

Let's mark the guest pages as unmergeable when we transition to secure
mode.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
[borntraeger@de.ibm.com: patch merging, splitting, fixing]
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  1 +
 arch/s390/kvm/kvm-s390.c     |  8 ++++++++
 arch/s390/mm/gmap.c          | 30 ++++++++++++++++++++----------
 3 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index e2d2f48c5c7c..e1f2cc0b2b00 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -146,4 +146,5 @@ int gmap_mprotect_notify(struct gmap *, unsigned long start,
 
 void gmap_sync_dirty_log_pmd(struct gmap *gmap, unsigned long dirty_bitmap[4],
 			     unsigned long gaddr, unsigned long vmaddr);
+int gmap_mark_unmergeable(void);
 #endif /* _ASM_S390_GMAP_H */
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e1bccbb41fdd..ad86e74e27ec 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2182,6 +2182,14 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
 		if (r)
 			break;
 
+		down_write(&current->mm->mmap_sem);
+		r = gmap_mark_unmergeable();
+		up_write(&current->mm->mmap_sem);
+		if (r) {
+			kvm_s390_pv_dealloc_vm(kvm);
+			break;
+		}
+
 		mutex_lock(&kvm->lock);
 		kvm_s390_vcpu_block_all(kvm);
 		/* FMT 4 SIE needs esca */
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index edcdca97e85e..7291452fe5f0 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2548,6 +2548,22 @@ int s390_enable_sie(void)
 }
 EXPORT_SYMBOL_GPL(s390_enable_sie);
 
+int gmap_mark_unmergeable(void)
+{
+	struct mm_struct *mm = current->mm;
+	struct vm_area_struct *vma;
+
+	for (vma = mm->mmap; vma; vma = vma->vm_next) {
+		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
+				MADV_UNMERGEABLE, &vma->vm_flags)) {
+			return -ENOMEM;
+		}
+	}
+	mm->def_flags &= ~VM_MERGEABLE;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(gmap_mark_unmergeable);
+
 /*
  * Enable storage key handling from now on and initialize the storage
  * keys with the default key.
@@ -2593,7 +2609,6 @@ static const struct mm_walk_ops enable_skey_walk_ops = {
 int s390_enable_skey(void)
 {
 	struct mm_struct *mm = current->mm;
-	struct vm_area_struct *vma;
 	int rc = 0;
 
 	down_write(&mm->mmap_sem);
@@ -2601,16 +2616,11 @@ int s390_enable_skey(void)
 		goto out_up;
 
 	mm->context.uses_skeys = 1;
-	for (vma = mm->mmap; vma; vma = vma->vm_next) {
-		if (ksm_madvise(vma, vma->vm_start, vma->vm_end,
-				MADV_UNMERGEABLE, &vma->vm_flags)) {
-			mm->context.uses_skeys = 0;
-			rc = -ENOMEM;
-			goto out_up;
-		}
+	rc = gmap_mark_unmergeable();
+	if (rc) {
+		mm->context.uses_skeys = 0;
+		goto out_up;
 	}
-	mm->def_flags &= ~VM_MERGEABLE;
-
 	walk_page_range(mm, 0, TASK_SIZE, &enable_skey_walk_ops, NULL);
 
 out_up:
-- 
2.24.0
