Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45460 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727162AbgBGLkI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 7 Feb 2020 06:40:08 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 11/35] KVM: s390/mm: Make pages accessible before destroying the guest
Date: Fri,  7 Feb 2020 06:39:34 -0500
Message-Id: <20200207113958.7320-12-borntraeger@de.ibm.com>
In-Reply-To: <20200207113958.7320-1-borntraeger@de.ibm.com>
References: <20200207113958.7320-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, Ulrich Weigand <Ulrich.Weigand@de.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Michael Mueller <mimu@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>

Before we destroy the secure configuration, we better make all
pages accessible again. This also happens during reboot, where we reboot
into a non-secure guest that then can go again into secure mode. As
this "new" secure guest will have a new ID we cannot reuse the old page
state.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/pgtable.h |  1 +
 arch/s390/kvm/pv.c              |  2 ++
 arch/s390/mm/gmap.c             | 35 +++++++++++++++++++++++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index dbd1453e6924..3e2ea997c334 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1669,6 +1669,7 @@ extern int vmem_remove_mapping(unsigned long start, unsigned long size);
 extern int s390_enable_sie(void);
 extern int s390_enable_skey(void);
 extern void s390_reset_cmma(struct mm_struct *mm);
+extern void s390_reset_acc(struct mm_struct *mm);
 
 /* s390 has a private copy of get unmapped area to deal with cache synonyms */
 #define HAVE_ARCH_UNMAPPED_AREA
diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
index 4795e61f4e16..392795a92bd9 100644
--- a/arch/s390/kvm/pv.c
+++ b/arch/s390/kvm/pv.c
@@ -66,6 +66,8 @@ int kvm_s390_pv_destroy_vm(struct kvm *kvm)
 	int rc;
 	u32 ret;
 
+	/* make all pages accessible before destroying the guest */
+	s390_reset_acc(kvm->mm);
 	rc = uv_cmd_nodata(kvm_s390_pv_handle(kvm),
 			   UVC_CMD_DESTROY_SEC_CONF, &ret);
 	WRITE_ONCE(kvm->arch.gmap->guest_handle, 0);
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 7291452fe5f0..27926a06df32 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2650,3 +2650,38 @@ void s390_reset_cmma(struct mm_struct *mm)
 	up_write(&mm->mmap_sem);
 }
 EXPORT_SYMBOL_GPL(s390_reset_cmma);
+
+/*
+ * make inaccessible pages accessible again
+ */
+static int __s390_reset_acc(pte_t *ptep, unsigned long addr,
+			    unsigned long next, struct mm_walk *walk)
+{
+	pte_t pte = READ_ONCE(*ptep);
+
+	if (pte_present(pte))
+		WARN_ON_ONCE(uv_convert_from_secure(pte_val(pte) & PAGE_MASK));
+	return 0;
+}
+
+static const struct mm_walk_ops reset_acc_walk_ops = {
+	.pte_entry		= __s390_reset_acc,
+};
+
+#include <linux/sched/mm.h>
+void s390_reset_acc(struct mm_struct *mm)
+{
+	/*
+	 * we might be called during
+	 * reset:                             we walk the pages and clear
+	 * close of all kvm file descriptors: we walk the pages and clear
+	 * exit of process on fd closure:     vma already gone, do nothing
+	 */
+	if (!mmget_not_zero(mm))
+		return;
+	down_read(&mm->mmap_sem);
+	walk_page_range(mm, 0, TASK_SIZE, &reset_acc_walk_ops, NULL);
+	up_read(&mm->mmap_sem);
+	mmput(mm);
+}
+EXPORT_SYMBOL_GPL(s390_reset_acc);
-- 
2.24.0
