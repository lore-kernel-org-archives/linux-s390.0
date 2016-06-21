From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 06/51] s390/mm: add kvm shadow fault function
Date: Tue, 21 Jun 2016 15:12:44 +0200
Message-ID: <1466514809-146638-7-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

This patch introduces function kvm_s390_shadow_fault() used to resolve a
fault on a shadow gmap. This function will do validity checking and
build up the shadow page table hierarchy in order to fault in the
requested page into the shadow page table structure.

If an exception occurs while shadowing, guest 2 has to be notified about
it using either an exception or a program interrupt intercept. If
concurrent unshadowing occurres, this function will simply return with
-EAGAIN and the caller has to retry.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/gaccess.c | 168 ++++++++++++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/gaccess.h |   2 +
 2 files changed, 170 insertions(+)

diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 8e245e7..ba49852 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -8,6 +8,7 @@
 #include <linux/vmalloc.h>
 #include <linux/err.h>
 #include <asm/pgtable.h>
+#include <asm/gmap.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 #include <asm/switch_to.h>
@@ -946,3 +947,170 @@ int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra)
 		return 0;
 	return trans_exc(vcpu, PGM_PROTECTION, gra, 0, GACC_STORE, PROT_TYPE_LA);
 }
+
+/**
+ * kvm_s390_shadow_tables - walk the guest page table and create shadow tables
+ * @sg: pointer to the shadow guest address space structure
+ * @saddr: faulting address in the shadow gmap
+ * @pgt: pointer to the page table address result
+ */
+static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
+				  unsigned long *pgt, int *dat_protection)
+{
+	struct gmap *parent;
+	union asce asce;
+	union vaddress vaddr;
+	unsigned long ptr;
+	int rc;
+
+	parent = sg->parent;
+	vaddr.addr = saddr;
+	asce.val = sg->orig_asce;
+	ptr = asce.origin * 4096;
+	switch (asce.dt) {
+	case ASCE_TYPE_REGION1:
+		if (vaddr.rfx01 > asce.tl)
+			return PGM_REGION_FIRST_TRANS;
+		break;
+	case ASCE_TYPE_REGION2:
+		if (vaddr.rfx)
+			return PGM_ASCE_TYPE;
+		if (vaddr.rsx01 > asce.tl)
+			return PGM_REGION_SECOND_TRANS;
+		break;
+	case ASCE_TYPE_REGION3:
+		if (vaddr.rfx || vaddr.rsx)
+			return PGM_ASCE_TYPE;
+		if (vaddr.rtx01 > asce.tl)
+			return PGM_REGION_THIRD_TRANS;
+		break;
+	case ASCE_TYPE_SEGMENT:
+		if (vaddr.rfx || vaddr.rsx || vaddr.rtx)
+			return PGM_ASCE_TYPE;
+		if (vaddr.sx01 > asce.tl)
+			return PGM_SEGMENT_TRANSLATION;
+		break;
+	}
+
+	switch (asce.dt) {
+	case ASCE_TYPE_REGION1: {
+		union region1_table_entry rfte;
+
+		rc = gmap_read_table(parent, ptr + vaddr.rfx * 8, &rfte.val);
+		if (rc)
+			return rc;
+		if (rfte.i)
+			return PGM_REGION_FIRST_TRANS;
+		if (rfte.tt != TABLE_TYPE_REGION1)
+			return PGM_TRANSLATION_SPEC;
+		if (vaddr.rsx01 < rfte.tf || vaddr.rsx01 > rfte.tl)
+			return PGM_REGION_SECOND_TRANS;
+		rc = gmap_shadow_r2t(sg, saddr, rfte.val);
+		if (rc)
+			return rc;
+		ptr = rfte.rto * 4096;
+		/* fallthrough */
+	}
+	case ASCE_TYPE_REGION2: {
+		union region2_table_entry rste;
+
+		rc = gmap_read_table(parent, ptr + vaddr.rsx * 8, &rste.val);
+		if (rc)
+			return rc;
+		if (rste.i)
+			return PGM_REGION_SECOND_TRANS;
+		if (rste.tt != TABLE_TYPE_REGION2)
+			return PGM_TRANSLATION_SPEC;
+		if (vaddr.rtx01 < rste.tf || vaddr.rtx01 > rste.tl)
+			return PGM_REGION_THIRD_TRANS;
+		rc = gmap_shadow_r3t(sg, saddr, rste.val);
+		if (rc)
+			return rc;
+		ptr = rste.rto * 4096;
+		/* fallthrough */
+	}
+	case ASCE_TYPE_REGION3: {
+		union region3_table_entry rtte;
+
+		rc = gmap_read_table(parent, ptr + vaddr.rtx * 8, &rtte.val);
+		if (rc)
+			return rc;
+		if (rtte.i)
+			return PGM_REGION_THIRD_TRANS;
+		if (rtte.tt != TABLE_TYPE_REGION3)
+			return PGM_TRANSLATION_SPEC;
+		if (vaddr.sx01 < rtte.fc0.tf || vaddr.sx01 > rtte.fc0.tl)
+			return PGM_SEGMENT_TRANSLATION;
+		rc = gmap_shadow_sgt(sg, saddr, rtte.val);
+		if (rc)
+			return rc;
+		ptr = rtte.fc0.sto * 4096;
+		/* fallthrough */
+	}
+	case ASCE_TYPE_SEGMENT: {
+		union segment_table_entry ste;
+
+		rc = gmap_read_table(parent, ptr + vaddr.sx * 8, &ste.val);
+		if (rc)
+			return rc;
+		if (ste.i)
+			return PGM_SEGMENT_TRANSLATION;
+		if (ste.tt != TABLE_TYPE_SEGMENT)
+			return PGM_TRANSLATION_SPEC;
+		if (ste.cs && asce.p)
+			return PGM_TRANSLATION_SPEC;
+		*dat_protection = ste.fc0.p;
+		rc = gmap_shadow_pgt(sg, saddr, ste.val);
+		if (rc)
+			return rc;
+		ptr = ste.fc0.pto * 2048;
+	}
+	}
+	/* Return the parent address of the page table */
+	*pgt = ptr;
+	return 0;
+}
+
+/**
+ * kvm_s390_shadow_fault - handle fault on a shadow page table
+ * @sg: pointer to the shadow guest address space structure
+ * @saddr: faulting address in the shadow gmap
+ * @write: =1 map r/w, =0 map r/o
+ *
+ * Returns: - 0 if the shadow fault was successfully resolved
+ *	    - > 0 (pgm exception code) on exceptions while faulting
+ *	    - -EAGAIN if the caller can retry immediately
+ *	    - -EFAULT when accessing invalid guest addresses
+ *	    - -ENOMEM if out of memory
+ */
+int kvm_s390_shadow_fault(struct gmap *sg, unsigned long saddr, int write)
+{
+	union vaddress vaddr;
+	union page_table_entry pte;
+	unsigned long pgt;
+	int dat_protection;
+	int rc;
+
+	rc = gmap_shadow_pgt_lookup(sg, saddr, &pgt, &dat_protection);
+	if (rc) {
+		rc = kvm_s390_shadow_tables(sg, saddr, &pgt, &dat_protection);
+		if (rc)
+			return rc;
+	}
+
+	vaddr.addr = saddr;
+	rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val);
+	if (rc)
+		return rc;
+	if (pte.i)
+		return PGM_PAGE_TRANSLATION;
+	if (pte.z || pte.co)
+		return PGM_TRANSLATION_SPEC;
+	dat_protection |= pte.p;
+	if (write && dat_protection)
+		return PGM_PROTECTION;
+	rc = gmap_shadow_page(sg, saddr, pte.pfra * 4096, write);
+	if (rc)
+		return rc;
+	return 0;
+}
diff --git a/arch/s390/kvm/gaccess.h b/arch/s390/kvm/gaccess.h
index df0a79d..e5ec473 100644
--- a/arch/s390/kvm/gaccess.h
+++ b/arch/s390/kvm/gaccess.h
@@ -361,4 +361,6 @@ void ipte_unlock(struct kvm_vcpu *vcpu);
 int ipte_lock_held(struct kvm_vcpu *vcpu);
 int kvm_s390_check_low_addr_prot_real(struct kvm_vcpu *vcpu, unsigned long gra);
 
+int kvm_s390_shadow_fault(struct gmap *shadow, unsigned long saddr, int write);
+
 #endif /* __KVM_S390_GACCESS_H */
-- 
2.5.5
