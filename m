From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 5/9] KVM: s390: gs support for kvm guests
Date: Fri,  7 Apr 2017 12:47:58 +0200
Message-ID: <1491562082-6392-6-git-send-email-borntraeger@de.ibm.com>
References: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1491562082-6392-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Fan Zhang <zhangfan@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Fan Zhang <zhangfan@linux.vnet.ibm.com>

This patch adds guarded storage support for KVM guest. We need to
setup the necessary control blocks, the kvm_run structure for the
new registers, the necessary wrappers for VSIE, as well as the
machine check save areas.
GS is enabled lazily and the register saving and reloading is done in
KVM code.  As this feature adds new content for migration, we provide
a new capability for enablement (KVM_CAP_S390_GS).

Signed-off-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 Documentation/virtual/kvm/api.txt |  9 ++++++
 arch/s390/include/asm/kvm_host.h  |  8 ++++-
 arch/s390/include/uapi/asm/kvm.h  | 14 ++++++++-
 arch/s390/kvm/intercept.c         |  1 +
 arch/s390/kvm/interrupt.c         | 33 +++++++++++++++++++--
 arch/s390/kvm/kvm-s390.c          | 62 +++++++++++++++++++++++++++++++++++++++
 arch/s390/kvm/kvm-s390.h          |  1 +
 arch/s390/kvm/priv.c              | 27 +++++++++++++++++
 arch/s390/kvm/vsie.c              | 39 ++++++++++++++++++++++++
 include/uapi/linux/kvm.h          |  1 +
 10 files changed, 191 insertions(+), 4 deletions(-)

diff --git a/Documentation/virtual/kvm/api.txt b/Documentation/virtual/kvm/api.txt
index 3c248f7..7252508 100644
--- a/Documentation/virtual/kvm/api.txt
+++ b/Documentation/virtual/kvm/api.txt
@@ -4101,6 +4101,15 @@ to take care of that.
 This capability can be enabled dynamically even if VCPUs were already
 created and are running.
 
+7.9 KVM_CAP_S390_GS
+
+Architectures: s390
+Parameters: none
+Returns: 0 on success; -EINVAL if the machine does not support
+	 guarded storage; -EBUSY if a VCPU has already been created.
+
+Allows use of guarded storage for the KVM guest.
+
 8. Other capabilities.
 ----------------------
 
diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 54e36e7..1af090d 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -25,6 +25,7 @@
 #include <asm/cpu.h>
 #include <asm/fpu/api.h>
 #include <asm/isc.h>
+#include <asm/guarded_storage.h>
 
 #define KVM_S390_BSCA_CPU_SLOTS 64
 #define KVM_S390_ESCA_CPU_SLOTS 248
@@ -192,6 +193,7 @@ struct kvm_s390_sie_block {
 	__u32	ipb;			/* 0x0058 */
 	__u32	scaoh;			/* 0x005c */
 	__u8	reserved60;		/* 0x0060 */
+#define ECB_GS		0x40
 #define ECB_TE		0x10
 #define ECB_SRSI	0x04
 #define ECB_HOSTPROTINT	0x02
@@ -237,7 +239,9 @@ struct kvm_s390_sie_block {
 	__u32	crycbd;			/* 0x00fc */
 	__u64	gcr[16];		/* 0x0100 */
 	__u64	gbea;			/* 0x0180 */
-	__u8	reserved188[24];	/* 0x0188 */
+	__u8    reserved188[8];		/* 0x0188 */
+	__u64   sdnxo;			/* 0x0190 */
+	__u8    reserved198[8];		/* 0x0198 */
 	__u32	fac;			/* 0x01a0 */
 	__u8	reserved1a4[20];	/* 0x01a4 */
 	__u64	cbrlo;			/* 0x01b8 */
@@ -573,6 +577,7 @@ struct kvm_vcpu_arch {
 	/* if vsie is active, currently executed shadow sie control block */
 	struct kvm_s390_sie_block *vsie_block;
 	unsigned int      host_acrs[NUM_ACRS];
+	struct gs_cb      *host_gscb;
 	struct fpu	  host_fpregs;
 	struct kvm_s390_local_interrupt local_int;
 	struct hrtimer    ckc_timer;
@@ -593,6 +598,7 @@ struct kvm_vcpu_arch {
 	 */
 	seqcount_t cputm_seqcount;
 	__u64 cputm_start;
+	bool gs_enabled;
 };
 
 struct kvm_vm_stat {
diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index a2ffec4..5bd23cf 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -197,6 +197,10 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_VRS    (1UL << 6)
 #define KVM_SYNC_RICCB  (1UL << 7)
 #define KVM_SYNC_FPRS   (1UL << 8)
+#define KVM_SYNC_GSCB   (1UL << 9)
+/* length and alignment of the sdnx as a power of two */
+#define SDNXC 8
+#define SDNXL (1UL << SDNXC)
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 	__u64 prefix;	/* prefix register */
@@ -217,8 +221,16 @@ struct kvm_sync_regs {
 	};
 	__u8  reserved[512];	/* for future vector expansion */
 	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
-	__u8 padding[52];	/* riccb needs to be 64byte aligned */
+	__u8 padding1[52];	/* riccb needs to be 64byte aligned */
 	__u8 riccb[64];		/* runtime instrumentation controls block */
+	__u8 padding2[192];	/* sdnx needs to be 256byte aligned */
+	union {
+		__u8 sdnx[SDNXL];  /* state description annex */
+		struct {
+			__u64 reserved1[2];
+			__u64 gscb[4];
+		};
+	};
 };
 
 #define KVM_REG_S390_TODPR	(KVM_REG_S390 | KVM_REG_SIZE_U32 | 0x1)
diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
index e831f4b..f5378f3 100644
--- a/arch/s390/kvm/intercept.c
+++ b/arch/s390/kvm/intercept.c
@@ -35,6 +35,7 @@ static const intercept_handler_t instruction_handlers[256] = {
 	[0xb6] = kvm_s390_handle_stctl,
 	[0xb7] = kvm_s390_handle_lctl,
 	[0xb9] = kvm_s390_handle_b9,
+	[0xe3] = kvm_s390_handle_e3,
 	[0xe5] = kvm_s390_handle_e5,
 	[0xeb] = kvm_s390_handle_eb,
 };
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 169558d..311eef0 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -410,6 +410,7 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 				 struct kvm_s390_mchk_info *mchk)
 {
 	unsigned long ext_sa_addr;
+	unsigned long lc;
 	freg_t fprs[NUM_FPRS];
 	union mci mci;
 	int rc;
@@ -422,8 +423,28 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 	/* Extended save area */
 	rc = read_guest_lc(vcpu, __LC_MCESAD, &ext_sa_addr,
 			   sizeof(unsigned long));
-	/* Only bits 0-53 are used for address formation */
-	ext_sa_addr &= ~0x3ffUL;
+	/* Only bits 0 through 63-LC are used for address formation */
+	lc = ext_sa_addr & MCESA_LC_MASK;
+	if (test_kvm_facility(vcpu->kvm, 133)) {
+		switch (lc) {
+		case 0:
+		case 10:
+			ext_sa_addr &= ~0x3ffUL;
+			break;
+		case 11:
+			ext_sa_addr &= ~0x7ffUL;
+			break;
+		case 12:
+			ext_sa_addr &= ~0xfffUL;
+			break;
+		default:
+			ext_sa_addr = 0;
+			break;
+		}
+	} else {
+		ext_sa_addr &= ~0x3ffUL;
+	}
+
 	if (!rc && mci.vr && ext_sa_addr && test_kvm_facility(vcpu->kvm, 129)) {
 		if (write_guest_abs(vcpu, ext_sa_addr, vcpu->run->s.regs.vrs,
 				    512))
@@ -431,6 +452,14 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 	} else {
 		mci.vr = 0;
 	}
+	if (!rc && mci.gs && ext_sa_addr && test_kvm_facility(vcpu->kvm, 133)
+	    && (lc == 11 || lc == 12)) {
+		if (write_guest_abs(vcpu, ext_sa_addr + 1024,
+				    &vcpu->run->s.regs.gscb, 32))
+			mci.gs = 0;
+	} else {
+		mci.gs = 0;
+	}
 
 	/* General interruption information */
 	rc |= put_guest_lc(vcpu, 1, (u8 __user *) __LC_AR_MODE_ID);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 976373c..f83f18b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -405,6 +405,9 @@ int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
 	case KVM_CAP_S390_RI:
 		r = test_facility(64);
 		break;
+	case KVM_CAP_S390_GS:
+		r = test_facility(133);
+		break;
 	default:
 		r = 0;
 	}
@@ -541,6 +544,20 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
 		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_RI %s",
 			 r ? "(not available)" : "(success)");
 		break;
+	case KVM_CAP_S390_GS:
+		r = -EINVAL;
+		mutex_lock(&kvm->lock);
+		if (atomic_read(&kvm->online_vcpus)) {
+			r = -EBUSY;
+		} else if (test_facility(133)) {
+			set_kvm_facility(kvm->arch.model.fac_mask, 133);
+			set_kvm_facility(kvm->arch.model.fac_list, 133);
+			r = 0;
+		}
+		mutex_unlock(&kvm->lock);
+		VM_EVENT(kvm, 3, "ENABLE: CAP_S390_GS %s",
+			 r ? "(not available)" : "(success)");
+		break;
 	case KVM_CAP_S390_USER_STSI:
 		VM_EVENT(kvm, 3, "%s", "ENABLE: CAP_S390_USER_STSI");
 		kvm->arch.user_stsi = 1;
@@ -1749,6 +1766,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	kvm_s390_set_prefix(vcpu, 0);
 	if (test_kvm_facility(vcpu->kvm, 64))
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_RICCB;
+	if (test_kvm_facility(vcpu->kvm, 133))
+		vcpu->run->kvm_valid_regs |= KVM_SYNC_GSCB;
 	/* fprs can be synchronized via vrs, even if the guest has no vx. With
 	 * MACHINE_HAS_VX, (load|store)_fpu_regs() will work with vrs format.
 	 */
@@ -1993,6 +2012,8 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		vcpu->arch.sie_block->eca |= ECA_VX;
 		vcpu->arch.sie_block->ecd |= ECD_HOSTREGMGMT;
 	}
+	vcpu->arch.sie_block->sdnxo = ((unsigned long) &vcpu->run->s.regs.sdnx)
+					| SDNXC;
 	vcpu->arch.sie_block->riccbd = (unsigned long) &vcpu->run->s.regs.riccb;
 	vcpu->arch.sie_block->ictl |= ICTL_ISKE | ICTL_SSKE | ICTL_RRBE;
 
@@ -2720,8 +2741,10 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
 static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 {
 	struct runtime_instr_cb *riccb;
+	struct gs_cb *gscb;
 
 	riccb = (struct runtime_instr_cb *) &kvm_run->s.regs.riccb;
+	gscb = (struct gs_cb *) &kvm_run->s.regs.gscb;
 	vcpu->arch.sie_block->gpsw.mask = kvm_run->psw_mask;
 	vcpu->arch.sie_block->gpsw.addr = kvm_run->psw_addr;
 	if (kvm_run->kvm_dirty_regs & KVM_SYNC_PREFIX)
@@ -2756,6 +2779,19 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: RI (sync_regs)");
 		vcpu->arch.sie_block->ecb3 |= ECB3_RI;
 	}
+	/*
+	 * If userspace sets the gscb (e.g. after migration) to non-zero,
+	 * we should enable GS here instead of doing the lazy enablement.
+	 */
+	if ((kvm_run->kvm_dirty_regs & KVM_SYNC_GSCB) &&
+	    test_kvm_facility(vcpu->kvm, 133) &&
+	    gscb->gssm &&
+	    !vcpu->arch.gs_enabled) {
+		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: GS (sync_regs)");
+		vcpu->arch.sie_block->ecb |= ECB_GS;
+		vcpu->arch.sie_block->ecd |= ECD_HOSTREGMGMT;
+		vcpu->arch.gs_enabled = 1;
+	}
 	save_access_regs(vcpu->arch.host_acrs);
 	restore_access_regs(vcpu->run->s.regs.acrs);
 	/* save host (userspace) fprs/vrs */
@@ -2770,6 +2806,20 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (test_fp_ctl(current->thread.fpu.fpc))
 		/* User space provided an invalid FPC, let's clear it */
 		current->thread.fpu.fpc = 0;
+	if (MACHINE_HAS_GS) {
+		preempt_disable();
+		__ctl_set_bit(2, 4);
+		if (current->thread.gs_cb) {
+			vcpu->arch.host_gscb = current->thread.gs_cb;
+			save_gs_cb(vcpu->arch.host_gscb);
+		}
+		if (vcpu->arch.gs_enabled) {
+			current->thread.gs_cb = (struct gs_cb *)
+						&vcpu->run->s.regs.gscb;
+			restore_gs_cb(current->thread.gs_cb);
+		}
+		preempt_enable();
+	}
 
 	kvm_run->kvm_dirty_regs = 0;
 }
@@ -2796,6 +2846,18 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	/* Restore will be done lazily at return */
 	current->thread.fpu.fpc = vcpu->arch.host_fpregs.fpc;
 	current->thread.fpu.regs = vcpu->arch.host_fpregs.regs;
+	if (MACHINE_HAS_GS) {
+		__ctl_set_bit(2, 4);
+		if (vcpu->arch.gs_enabled)
+			save_gs_cb(current->thread.gs_cb);
+		preempt_disable();
+		current->thread.gs_cb = vcpu->arch.host_gscb;
+		restore_gs_cb(vcpu->arch.host_gscb);
+		preempt_enable();
+		if (!vcpu->arch.host_gscb)
+			__ctl_clear_bit(2, 4);
+		vcpu->arch.host_gscb = NULL;
+	}
 
 }
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index dfdcde1..455124f 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -246,6 +246,7 @@ static inline void kvm_s390_retry_instr(struct kvm_vcpu *vcpu)
 int is_valid_psw(psw_t *psw);
 int kvm_s390_handle_aa(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_b2(struct kvm_vcpu *vcpu);
+int kvm_s390_handle_e3(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_e5(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_01(struct kvm_vcpu *vcpu);
 int kvm_s390_handle_b9(struct kvm_vcpu *vcpu);
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index d42bb2d..0ffe973 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -53,6 +53,33 @@ int kvm_s390_handle_aa(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP;
 }
 
+static int handle_gs(struct kvm_vcpu *vcpu)
+{
+	if (test_kvm_facility(vcpu->kvm, 133)) {
+		VCPU_EVENT(vcpu, 3, "%s", "ENABLE: GS (lazy)");
+		preempt_disable();
+		__ctl_set_bit(2, 4);
+		current->thread.gs_cb = (struct gs_cb *)&vcpu->run->s.regs.gscb;
+		restore_gs_cb(current->thread.gs_cb);
+		preempt_enable();
+		vcpu->arch.sie_block->ecb |= ECB_GS;
+		vcpu->arch.sie_block->ecd |= ECD_HOSTREGMGMT;
+		vcpu->arch.gs_enabled = 1;
+		kvm_s390_retry_instr(vcpu);
+		return 0;
+	} else
+		return kvm_s390_inject_program_int(vcpu, PGM_OPERATION);
+}
+
+int kvm_s390_handle_e3(struct kvm_vcpu *vcpu)
+{
+	int code = vcpu->arch.sie_block->ipb & 0xff;
+
+	if (code == 0x49 || code == 0x4d)
+		return handle_gs(vcpu);
+	else
+		return -EOPNOTSUPP;
+}
 /* Handle SCK (SET CLOCK) interception */
 static int handle_set_clock(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
index d91f1df..2fafc2b 100644
--- a/arch/s390/kvm/vsie.c
+++ b/arch/s390/kvm/vsie.c
@@ -329,6 +329,11 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 	/* Instruction Execution Prevention */
 	if (test_kvm_facility(vcpu->kvm, 130))
 		scb_s->ecb2 |= scb_o->ecb2 & ECB2_IEP;
+	/* Guarded Storage */
+	if (test_kvm_facility(vcpu->kvm, 133)) {
+		scb_s->ecb |= scb_o->ecb & ECB_GS;
+		scb_s->ecd |= scb_o->ecd & ECD_HOSTREGMGMT;
+	}
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_SIIF))
 		scb_s->eca |= scb_o->eca & ECA_SII;
 	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_IB))
@@ -496,6 +501,13 @@ static void unpin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 		unpin_guest_page(vcpu->kvm, gpa, hpa);
 		scb_s->riccbd = 0;
 	}
+
+	hpa = scb_s->sdnxo;
+	if (hpa) {
+		gpa = scb_o->sdnxo;
+		unpin_guest_page(vcpu->kvm, gpa, hpa);
+		scb_s->sdnxo = 0;
+	}
 }
 
 /*
@@ -590,6 +602,33 @@ static int pin_blocks(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page)
 			goto unpin;
 		scb_s->riccbd = hpa;
 	}
+	if ((scb_s->ecb & ECB_GS) && !(scb_s->ecd & ECD_HOSTREGMGMT)) {
+		unsigned long sdnxc;
+
+		gpa = scb_o->sdnxo & ~0xfUL;
+		sdnxc = scb_o->sdnxo & 0xfUL;
+		if (!gpa || !(gpa & ~0x1fffUL)) {
+			rc = set_validity_icpt(scb_s, 0x10b0U);
+			goto unpin;
+		}
+		if (sdnxc < 6 || sdnxc > 12) {
+			rc = set_validity_icpt(scb_s, 0x10b1U);
+			goto unpin;
+		}
+		if (gpa & ((1 << sdnxc) - 1)) {
+			rc = set_validity_icpt(scb_s, 0x10b2U);
+			goto unpin;
+		}
+		/* Due to alignment rules (checked above) this cannot
+		 * cross page boundaries
+		 */
+		rc = pin_guest_page(vcpu->kvm, gpa, &hpa);
+		if (rc == -EINVAL)
+			rc = set_validity_icpt(scb_s, 0x10b0U);
+		if (rc)
+			goto unpin;
+		scb_s->sdnxo = hpa;
+	}
 	return 0;
 unpin:
 	unpin_blocks(vcpu, vsie_page);
diff --git a/include/uapi/linux/kvm.h b/include/uapi/linux/kvm.h
index f51d508..c9d5227 100644
--- a/include/uapi/linux/kvm.h
+++ b/include/uapi/linux/kvm.h
@@ -883,6 +883,7 @@ struct kvm_ppc_resize_hpt {
 #define KVM_CAP_PPC_MMU_RADIX 134
 #define KVM_CAP_PPC_MMU_HASH_V3 135
 #define KVM_CAP_IMMEDIATE_EXIT 136
+#define KVM_CAP_S390_GS 137
 
 #ifdef KVM_CAP_IRQ_ROUTING
 
-- 
2.7.4
