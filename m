From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 02/18] KVM: s390: sync of fp registers via kvm_run
Date: Fri, 12 Feb 2016 14:22:46 +0100
Message-ID: <1455283382-62999-3-git-send-email-borntraeger@de.ibm.com>
References: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1455283382-62999-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

As we already store the floating point registers in the vector save area
in floating point register format when we don't have MACHINE_HAS_VX, we can
directly expose them to user space using a new sync flag.

The floating point registers will be valid when KVM_SYNC_FPRS is set. The
fpc will also be valid when KVM_SYNC_FPRS is set.

Either KVM_SYNC_FPRS or KVM_SYNC_VRS will be enabled, never both.

Let's also change two positions where we access vrs, making the code easier
to read and one comment superfluous.

Suggested-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/uapi/asm/kvm.h |  8 ++++++--
 arch/s390/kvm/kvm-s390.c         | 12 +++++++-----
 2 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
index fe84bd5..347fe5a 100644
--- a/arch/s390/include/uapi/asm/kvm.h
+++ b/arch/s390/include/uapi/asm/kvm.h
@@ -154,6 +154,7 @@ struct kvm_guest_debug_arch {
 #define KVM_SYNC_PFAULT (1UL << 5)
 #define KVM_SYNC_VRS    (1UL << 6)
 #define KVM_SYNC_RICCB  (1UL << 7)
+#define KVM_SYNC_FPRS   (1UL << 8)
 /* definition of registers in kvm_run */
 struct kvm_sync_regs {
 	__u64 prefix;	/* prefix register */
@@ -168,9 +169,12 @@ struct kvm_sync_regs {
 	__u64 pft;	/* pfault token [PFAULT] */
 	__u64 pfs;	/* pfault select [PFAULT] */
 	__u64 pfc;	/* pfault compare [PFAULT] */
-	__u64 vrs[32][2];	/* vector registers */
+	union {
+		__u64 vrs[32][2];	/* vector registers (KVM_SYNC_VRS) */
+		__u64 fprs[16];		/* fp registers (KVM_SYNC_FPRS) */
+	};
 	__u8  reserved[512];	/* for future vector expansion */
-	__u32 fpc;	/* only valid with vector registers */
+	__u32 fpc;		/* valid on KVM_SYNC_VRS or KVM_SYNC_FPRS */
 	__u8 padding[52];	/* riccb needs to be 64byte aligned */
 	__u8 riccb[64];		/* runtime instrumentation controls block */
 };
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 8fcdf98..2270fe4 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1419,6 +1419,8 @@ int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 	 */
 	if (MACHINE_HAS_VX)
 		vcpu->run->kvm_valid_regs |= KVM_SYNC_VRS;
+	else
+		vcpu->run->kvm_valid_regs |= KVM_SYNC_FPRS;
 
 	if (kvm_is_ucontrol(vcpu->kvm))
 		return __kvm_ucontrol_vcpu_init(vcpu);
@@ -1433,10 +1435,10 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 	vcpu->arch.host_fpregs.fpc = current->thread.fpu.fpc;
 	vcpu->arch.host_fpregs.regs = current->thread.fpu.regs;
 
-	/* Depending on MACHINE_HAS_VX, data stored to vrs either
-	 * has vector register or floating point register format.
-	 */
-	current->thread.fpu.regs = vcpu->run->s.regs.vrs;
+	if (MACHINE_HAS_VX)
+		current->thread.fpu.regs = vcpu->run->s.regs.vrs;
+	else
+		current->thread.fpu.regs = vcpu->run->s.regs.fprs;
 	current->thread.fpu.fpc = vcpu->run->s.regs.fpc;
 	if (test_fp_ctl(current->thread.fpu.fpc))
 		/* User space provided an invalid FPC, let's clear it */
@@ -2389,7 +2391,7 @@ int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long gpa)
 				     fprs, 128);
 	} else {
 		rc = write_guest_abs(vcpu, gpa + __LC_FPREGS_SAVE_AREA,
-				     vcpu->run->s.regs.vrs, 128);
+				     vcpu->run->s.regs.fprs, 128);
 	}
 	rc |= write_guest_abs(vcpu, gpa + __LC_GPREGS_SAVE_AREA,
 			      vcpu->run->s.regs.gprs, 128);
-- 
2.3.0
