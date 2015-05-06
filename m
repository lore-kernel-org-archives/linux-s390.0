From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: [PATCH 3/3] kvm/powerpc: report guest steal time in host
Date: Wed,  6 May 2015 17:26:36 +0530
Message-ID: <c0db7eafdd13fcec26a0398e2ad0b7225c3998e9.1430913088.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
In-Reply-To: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1430913087.git.naveen.n.rao@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, kvm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org
Cc: paulus@samba.org, mpe@ellerman.id.au, agraf@suse.de, mingo@redhat.com, ego@linux.vnet.ibm.com, warrier@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On powerpc, kvm tracks both the guest steal time as well as the time
when guest was idle and this gets sent in to the guest through DTL. The
guest accounts these entries as either steal time or idle time based on
the last running task. Since the true guest idle status is not visible
to the host, we can't accurately expose the guest steal time in the
host.

However, tracking the guest vcpu cede status can get us a reasonable
(within 5% variation) vcpu steal time since guest vcpus cede the
processor on entering the idle task. To do this, we introduce a new
field ceded_st in kvm_vcpu_arch structure to accurately track the guest
vcpu cede status (this is needed since the existing ceded field is
modified before we can use it). During DTL entry creation, we check this
flag and account the time as stolen if the guest vcpu had not ceded.

Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
---
Tests show that the steal time being reported in the host with this approach is
around 5% higher than the steal time shown in guest. I'd be interested to know
if there are ways to achieve better accounting of the guest steal time in host.

Thanks!
- Naveen

 arch/powerpc/include/asm/kvm_host.h     | 1 +
 arch/powerpc/kernel/asm-offsets.c       | 1 +
 arch/powerpc/kvm/book3s_hv.c            | 2 ++
 arch/powerpc/kvm/book3s_hv_rmhandlers.S | 3 +++
 4 files changed, 7 insertions(+)

diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
index a193a13..48cafd6 100644
--- a/arch/powerpc/include/asm/kvm_host.h
+++ b/arch/powerpc/include/asm/kvm_host.h
@@ -661,6 +661,7 @@ struct kvm_vcpu_arch {
 	u64 busy_preempt;
 
 	u32 emul_inst;
+	u8 ceded_st;
 #endif
 
 #ifdef CONFIG_KVM_BOOK3S_HV_EXIT_TIMING
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 0034b6b..7c11c84 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -534,6 +534,7 @@ int main(void)
 	DEFINE(VCPU_DEC_EXPIRES, offsetof(struct kvm_vcpu, arch.dec_expires));
 	DEFINE(VCPU_PENDING_EXC, offsetof(struct kvm_vcpu, arch.pending_exceptions));
 	DEFINE(VCPU_CEDED, offsetof(struct kvm_vcpu, arch.ceded));
+	DEFINE(VCPU_CEDED_ST, offsetof(struct kvm_vcpu, arch.ceded_st));
 	DEFINE(VCPU_PRODDED, offsetof(struct kvm_vcpu, arch.prodded));
 	DEFINE(VCPU_MMCR, offsetof(struct kvm_vcpu, arch.mmcr));
 	DEFINE(VCPU_PMC, offsetof(struct kvm_vcpu, arch.pmc));
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 48d3c5d..7a7e3ab 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -565,6 +565,8 @@ static void kvmppc_create_dtl_entry(struct kvm_vcpu *vcpu,
 	spin_lock_irq(&vcpu->arch.tbacct_lock);
 	stolen += vcpu->arch.busy_stolen;
 	vcpu->arch.busy_stolen = 0;
+	if (!vcpu->arch.ceded_st && stolen)
+		(pid_task(vcpu->pid, PIDTYPE_PID))->gstime += stolen;
 	spin_unlock_irq(&vcpu->arch.tbacct_lock);
 	if (!dt || !vpa)
 		return;
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 4d70df2..80efc31 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -924,6 +924,7 @@ deliver_guest_interrupt:
 fast_guest_return:
 	li	r0,0
 	stb	r0,VCPU_CEDED(r4)	/* cancel cede */
+	stb	r0,VCPU_CEDED_ST(r4)	/* cancel cede */
 	mtspr	SPRN_HSRR0,r10
 	mtspr	SPRN_HSRR1,r11
 
@@ -2059,6 +2060,7 @@ _GLOBAL(kvmppc_h_cede)		/* r3 = vcpu pointer, r11 = msr, r13 = paca */
 	std	r11,VCPU_MSR(r3)
 	li	r0,1
 	stb	r0,VCPU_CEDED(r3)
+	stb	r0,VCPU_CEDED_ST(r3)
 	sync			/* order setting ceded vs. testing prodded */
 	lbz	r5,VCPU_PRODDED(r3)
 	cmpwi	r5,0
@@ -2266,6 +2268,7 @@ kvm_cede_prodded:
 	stb	r0,VCPU_PRODDED(r3)
 	sync			/* order testing prodded vs. clearing ceded */
 	stb	r0,VCPU_CEDED(r3)
+	stb	r0,VCPU_CEDED_ST(r3)
 	li	r3,H_SUCCESS
 	blr
 
-- 
2.3.7
