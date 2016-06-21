From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 33/51] KVM: s390: vsie: support STFLE interpretation
Date: Tue, 21 Jun 2016 15:13:11 +0200
Message-ID: <1466514809-146638-34-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Issuing STFLE is extremely rare. Instead of copying 2k on every
VSIE call, let's do this lazily, when a guest 3 tries to execute
STFLE. We can setup the block and retry.

Unfortunately, we can't directly forward that facility list, as
we only have a 31 bit address for the facility list designation.
So let's use a DMA allocation for our vsie_page instead for now.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/vsie.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index aaed63c..cd4bbfa 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -18,6 +18,7 @@
 #include <asm/mmu_context.h>
 #include <asm/sclp.h>
 #include <asm/nmi.h>
+#include <asm/dis.h>
 #include "kvm-s390.h"
 #include "gaccess.h"
 
@@ -27,7 +28,8 @@ struct vsie_page {
 	struct kvm_s390_sie_block *scb_o;	/* 0x0200 */
 	/* the shadow gmap in use by the vsie_page */
 	struct gmap *gmap;			/* 0x0208 */
-	__u8 reserved[0x1000 - 0x0210];		/* 0x0210 */
+	__u8 reserved[0x0800 - 0x0210];		/* 0x0210 */
+	__u8 fac[S390_ARCH_FAC_LIST_SIZE_BYTE];	/* 0x0800 */
 } __packed;
 
 /* trigger a validity icpt for the given scb */
@@ -194,6 +196,7 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	scb_s->ecb2 = 0;
 	scb_s->ecb3 = 0;
 	scb_s->ecd = 0;
+	scb_s->fac = 0;
 
 	rc = prepare_cpuflags(vcpu, vsie_page);
 	if (rc)
@@ -521,6 +524,44 @@ static inline void clear_vsie_icpt(struct vsie_page *vsie_page)
 	vsie_page->scb_s.icptcode = 0;
 }
 
+/* rewind the psw and clear the vsie icpt, so we can retry execution */
+static void retry_vsie_icpt(struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	int ilen = insn_length(scb_s->ipa >> 8);
+
+	/* take care of EXECUTE instructions */
+	if (scb_s->icptstatus & 1) {
+		ilen = (scb_s->icptstatus >> 4) & 0x6;
+		if (!ilen)
+			ilen = 4;
+	}
+	scb_s->gpsw.addr = __rewind_psw(scb_s->gpsw, ilen);
+	clear_vsie_icpt(vsie_page);
+}
+
+/*
+ * Try to shadow + enable the guest 2 provided facility list.
+ * Retry instruction execution if enabled for and provided by guest 2.
+ *
+ * Returns: - 0 if handled (retry or guest 2 icpt)
+ *          - > 0 if control has to be given to guest 2
+ */
+static int handle_stfle(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
+{
+	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
+	__u32 fac = vsie_page->scb_o->fac & 0x7ffffff8U;
+
+	if (fac && test_kvm_facility(vcpu->kvm, 7)) {
+		retry_vsie_icpt(vsie_page);
+		if (read_guest_real(vcpu, fac, &vsie_page->fac,
+				    sizeof(vsie_page->fac)))
+			return set_validity_icpt(scb_s, 0x1090U);
+		scb_s->fac = (__u32)(__u64) &vsie_page->fac;
+	}
+	return 0;
+}
+
 /*
  * Run the vsie on a shadow scb and a shadow gmap, without any further
  * sanity checks, handling SIE faults.
@@ -558,6 +599,10 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		return handle_fault(vcpu, vsie_page);
 
 	switch (scb_s->icptcode) {
+	case ICPT_INST:
+		if (scb_s->ipa == 0xb2b0)
+			rc = handle_stfle(vcpu, vsie_page);
+		break;
 	case ICPT_STOP:
 		/* stop not requested by g2 - must have been a kick */
 		if (!(atomic_read(&scb_o->cpuflags) & CPUSTAT_STOP_INT))
@@ -690,7 +735,7 @@ static struct vsie_page *get_vsie_page(struct kvm *kvm, unsigned long addr)
 
 	mutex_lock(&kvm->arch.vsie.mutex);
 	if (kvm->arch.vsie.page_count < nr_vcpus) {
-		page = alloc_page(GFP_KERNEL | __GFP_ZERO);
+		page = alloc_page(GFP_KERNEL | __GFP_ZERO | GFP_DMA);
 		if (!page) {
 			mutex_unlock(&kvm->arch.vsie.mutex);
 			return ERR_PTR(-ENOMEM);
-- 
2.5.5
