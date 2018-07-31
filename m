From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:51 +0000
Subject: [GIT PULL 05/19] KVM: s390: add etoken support for guests
Message-Id: <20180731084405.28953-6-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

We want to provide facility 156 (etoken facility) to our
guests. This includes migration support (via sync regs) and
VSIE changes. The tokens are being reset on clear reset. This
has to be implemented by userspace (via sync regs).

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Acked-by: Cornelia Huck <cohuck@redhat.com>
---
 arch/s390/include/asm/kvm_host.h | 1 +
 arch/s390/include/uapi/asm/kvm.h | 5 ++++-
 arch/s390/kvm/kvm-s390.c         | 8 ++++++--
 arch/s390/kvm/vsie.c             | 9 +++++++--
 arch/s390/tools/gen_facilities.c | 3 ++-
 5 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 44b09b366782..1a7b6834797e 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -269,6 +269,7 @@ struct kvm_s390_sie_block {
 	__u8	reserved1c0[8];		/* 0x01c0 */
 #define ECD_HOSTREGMGMT	0x20000000
 #define ECD_MEF		0x08000000
+#define ECD_ETOKENF	0x02000000
 	__u32	ecd;			/* 0x01c8 */
 	__u8	reserved1cc[18];	/* 0x01cc */
 	__u64	pp;			/* 0x01de */
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index 4cdaa55fabfe..9a50f02b9894 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -4,7 +4,7 @@
 /*
  * KVM s390 specific structures and definitions
  *
- * Copyright IBM Corp. 2008
+ * Copyright IBM Corp. 2008, 2018
  *
  *    Author(s): Carsten Otte <cotte@de.ibm.com>
  *               Christian Borntraeger <borntraeger@de.ibm.com>
@@ -225,6 +225,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_FPRS   (1UL << 8)
 #define KVM_SYNC_GSCB   (1UL << 9)
 #define KVM_SYNC_BPBC   (1UL << 10)
+#define KVM_SYNC_ETOKEN (1UL << 11)
 /* length and alignment of the sdnx as a power of two */
 #define SDNXC 8
 #define SDNXL (1UL << SDNXC)
@@ -258,6 +259,8 @@ struct kvm_sync_regs {
 		struct {
 			__u64 reserved1[2];
 			__u64 gscb[4];
+			__u64 etoken;
+			__u64 etoken_extension;
 		};
 	};
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index b350ec14d882..0cc8a48fc732 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2355,6 +2355,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_BPBC;
 	if (test_kvm_facility(vcpu->kvm, 133))
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_GSCB;
+	if (test_kvm_facility(vcpu->kvm, 156))
+		vcpu->run->kvm_valid_regs |= KVM_SYNC_ETOKEN;
 	/* fprs can be synchronized via vrs, even if the guest has no vx. With
 	 * MACHINE_HAS_VX, (load|store)_fpu_regs() will work with vrs format.
 	 */
@@ -2604,7 +2606,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 	}
 	if (test_kvm_facility(vcpu->kvm, 139))
 		vcpu->arch.sie_block->ecd |= ECD_MEF;
-
+	if (test_kvm_facility(vcpu->kvm, 156))
+		vcpu->arch.sie_block->ecd |= ECD_ETOKENF;
 	if (vcpu->arch.sie_block->gd) {
 		vcpu->arch.sie_block->eca |= ECA_AIV;
 		VCPU_EVENT(vcpu, 3, "AIV gisa format-%u enabled for cpu %03u",
@@ -3522,6 +3525,7 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		}
 		preempt_enable();
 	}
+	/* SIE will load etoken directly from SDNX and therefore kvm_run */
 
 	kvm_run->kvm_dirty_regs = 0;
 }
@@ -3561,7 +3565,7 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 			__ctl_clear_bit(2, 4);
 		vcpu->arch.host_gscb = NULL;
 	}
-
+	/* SIE will save etoken directly into SDNX and therefore kvm_run */
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index 5539df037f91..63844b95c22c 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -2,7 +2,7 @@
 /*
  * kvm nested virtualization support for s390x
  *
- * Copyright IBM Corp. 2016
+ * Copyright IBM Corp. 2016, 2018
  *
  *    Author(s): David Hildenbrand <dahi@linux.vnet.ibm.com>
  */
@@ -378,6 +378,10 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	if (test_kvm_facility(vcpu->kvm, 139))
 		scb_s->ecd |= scb_o->ecd & ECD_MEF;
 
+	/* etoken */
+	if (test_kvm_facility(vcpu->kvm, 156))
+		scb_s->ecd |= scb_o->ecd & ECD_ETOKENF;
+
 	prepare_ibc(vcpu, vsie_page);
 	rc = shadow_crycb(vcpu, vsie_page);
 out:
@@ -627,7 +631,8 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		vsie_page->riccbd_gpa = gpa;
 		scb_s->riccbd = hpa;
 	}
-	if ((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
+	if (((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) ||
+	    (scb_s->ecd & ECD_ETOKENF)) {
 		unsigned long sdnxc;
 
 		gpa = READ_ONCE(scb_o->sdnxo) & ~0xfUL;
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index 90a8c9e84ca6..0c85aedcf9b3 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -4,7 +4,7 @@
  * numbering scheme from the Princples of Operations: most significant bit
  * has bit number 0.
  *
- *    Copyright IBM Corp. 2015
+ *    Copyright IBM Corp. 2015, 2018
  *
  */
 
@@ -106,6 +106,7 @@ static struct facility_def facility_defs[] = {
 
 		.name = "FACILITIES_KVM_CPUMODEL",
 		.bits = (int[]){
+			156, /* etoken facility */
 			-1  /* END */
 		}
 	},
-- 
2.17.0
