From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 8/9] KVM: s390: Inject machine check into the guest
Date: Wed, 28 Jun 2017 19:30:43 +0200
Message-ID: <1498671044-81240-9-git-send-email-borntraeger@de.ibm.com>
References: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1498671044-81240-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, QingFeng Hao <haoqf@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: QingFeng Hao <haoqf@linux.vnet.ibm.com>

If the exit flag of SIE indicates that a machine check has happened
during guest's running and needs to be injected, inject it to the guest
accordingly.
But some machine checks, e.g. Channel Report Pending (CRW), refer to
host conditions only (the guest's channel devices are not managed by
the kernel directly) and are therefore not injected into the guest.
External Damage (ED) is also not reinjected into the guest because ETR
conditions are gone in Linux and STP conditions are not enabled in the
guest, and ED contains only these 8 ETR and STP conditions.
In general, instruction-processing damage, system recovery,
storage error, service-processor damage and channel subsystem damage
will be reinjected into the guest, and the remain (System damage,
timing-facility damage, warning, ED and CRW) will be handled on the host.

Signed-off-by: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/nmi.h |  6 ++++++
 arch/s390/kvm/interrupt.c   | 43 ++++++++++++++++++++++++++++++++++++++++++-
 arch/s390/kvm/kvm-s390.c    | 12 ++++++++++++
 arch/s390/kvm/kvm-s390.h    |  2 ++
 4 files changed, 62 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/nmi.h b/arch/s390/include/asm/nmi.h
index 13623b9..9d91cf3 100644
--- a/arch/s390/include/asm/nmi.h
+++ b/arch/s390/include/asm/nmi.h
@@ -26,6 +26,12 @@
 #define MCCK_CODE_PSW_MWP_VALID		_BITUL(63 - 20)
 #define MCCK_CODE_PSW_IA_VALID		_BITUL(63 - 23)
 
+#define MCCK_CR14_CR_PENDING_SUB_MASK	(1 << 28)
+#define MCCK_CR14_RECOVERY_SUB_MASK	(1 << 27)
+#define MCCK_CR14_DEGRAD_SUB_MASK	(1 << 26)
+#define MCCK_CR14_EXT_DAMAGE_SUB_MASK	(1 << 25)
+#define MCCK_CR14_WARN_SUB_MASK		(1 << 24)
+
 #ifndef __ASSEMBLY__
 
 union mci {
diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 72f3aaf..f2c78fc 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -251,8 +251,13 @@ static unsigned long deliverable_irqs(struct kvm_vcpu *vcpu)
 		__clear_bit(IRQ_PEND_EXT_SERVICE, &active_mask);
 	if (psw_mchk_disabled(vcpu))
 		active_mask &= ~IRQ_PEND_MCHK_MASK;
+	/*
+	 * Check both floating and local interrupt's cr14 because
+	 * bit IRQ_PEND_MCHK_REP could be set in both cases.
+	 */
 	if (!(vcpu->arch.sie_block->gcr[14] &
-	      vcpu->kvm->arch.float_int.mchk.cr14))
+	   (vcpu->kvm->arch.float_int.mchk.cr14 |
+	   vcpu->arch.local_int.irq.mchk.cr14)))
 		__clear_bit(IRQ_PEND_MCHK_REP, &active_mask);
 
 	/*
@@ -2463,6 +2468,42 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
 	return ret;
 }
 
+/*
+ * Inject the machine check to the guest.
+ */
+void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
+				     struct mcck_volatile_info *mcck_info)
+{
+	struct kvm_s390_interrupt_info inti;
+	struct kvm_s390_irq irq;
+	struct kvm_s390_mchk_info *mchk;
+	union mci mci;
+	__u64 cr14 = 0;         /* upper bits are not used */
+
+	mci.val = mcck_info->mcic;
+	if (mci.sr)
+		cr14 |= MCCK_CR14_RECOVERY_SUB_MASK;
+	if (mci.dg)
+		cr14 |= MCCK_CR14_DEGRAD_SUB_MASK;
+	if (mci.w)
+		cr14 |= MCCK_CR14_WARN_SUB_MASK;
+
+	mchk = mci.ck ? &inti.mchk : &irq.u.mchk;
+	mchk->cr14 = cr14;
+	mchk->mcic = mcck_info->mcic;
+	mchk->ext_damage_code = mcck_info->ext_damage_code;
+	mchk->failing_storage_address = mcck_info->failing_storage_address;
+	if (mci.ck) {
+		/* Inject the floating machine check */
+		inti.type = KVM_S390_MCHK;
+		WARN_ON_ONCE(__inject_vm(vcpu->kvm, &inti));
+	} else {
+		/* Inject the machine check to specified vcpu */
+		irq.type = KVM_S390_MCHK;
+		WARN_ON_ONCE(kvm_s390_inject_vcpu(vcpu, &irq));
+	}
+}
+
 int kvm_set_routing_entry(struct kvm *kvm,
 			  struct kvm_kernel_irq_routing_entry *e,
 			  const struct kvm_irq_routing_entry *ue)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 90434760..a0f6b59 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -3041,6 +3041,9 @@ static int vcpu_post_run_fault_in_sie(struct kvm_vcpu *vcpu)
 
 static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 {
+	struct mcck_volatile_info *mcck_info;
+	struct sie_page *sie_page;
+
 	VCPU_EVENT(vcpu, 6, "exit sie icptcode %d",
 		   vcpu->arch.sie_block->icptcode);
 	trace_kvm_s390_sie_exit(vcpu, vcpu->arch.sie_block->icptcode);
@@ -3051,6 +3054,15 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
 	vcpu->run->s.regs.gprs[14] = vcpu->arch.sie_block->gg14;
 	vcpu->run->s.regs.gprs[15] = vcpu->arch.sie_block->gg15;
 
+	if (exit_reason == -EINTR) {
+		VCPU_EVENT(vcpu, 3, "%s", "machine check");
+		sie_page = container_of(vcpu->arch.sie_block,
+					struct sie_page, sie_block);
+		mcck_info = &sie_page->mcck_info;
+		kvm_s390_reinject_machine_check(vcpu, mcck_info);
+		return 0;
+	}
+
 	if (vcpu->arch.sie_block->icptcode > 0) {
 		int rc = kvm_handle_sie_intercept(vcpu);
 
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 55f5c84..6fedc8b 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -397,4 +397,6 @@ static inline int kvm_s390_use_sca_entries(void)
 	 */
 	return sclp.has_sigpif;
 }
+void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
+				     struct mcck_volatile_info *mcck_info);
 #endif
-- 
2.7.4
