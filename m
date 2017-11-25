From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 11/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_guest_debug
Date: Sat, 25 Nov 2017 21:57:14 +0100
Message-ID: <20171125205718.7731-12-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
List-Unsubscribe: <https://lists.cs.columbia.edu/mailman/options/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=unsubscribe>
List-Archive: <https://lists.cs.columbia.edu/pipermail/kvmarm>
List-Post: <mailto:kvmarm@lists.cs.columbia.edu>
List-Help: <mailto:kvmarm-request@lists.cs.columbia.edu?subject=help>
List-Subscribe: <https://lists.cs.columbia.edu/mailman/listinfo/kvmarm>,
 <mailto:kvmarm-request@lists.cs.columbia.edu?subject=subscribe>
Errors-To: kvmarm-bounces@lists.cs.columbia.edu
Sender: kvmarm-bounces@lists.cs.columbia.edu
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm-ppc@vger.kernel.org, Alexander Graf <agraf@suse.com>, linux-arm-kernel@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_set_guest_debug().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/guest.c    | 17 ++++++++++++++---
 arch/powerpc/kvm/book3s.c |  6 ++++++
 arch/powerpc/kvm/booke.c  | 21 +++++++++++++++------
 arch/s390/kvm/kvm-s390.c  | 14 +++++++++++---
 arch/x86/kvm/x86.c        |  6 +++++-
 virt/kvm/kvm_main.c       |  4 ----
 6 files changed, 51 insertions(+), 17 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 5c7f657dd207..0375d1f977c8 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -361,10 +361,18 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
 	trace_kvm_set_guest_debug(vcpu, dbg->control);
 
-	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK)
-		return -EINVAL;
+	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK) {
+		ret = -EINVAL;
+		goto out;
+	}
 
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
@@ -378,7 +386,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		/* If not enabled clear all flags */
 		vcpu->guest_debug = 0;
 	}
-	return 0;
+
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arm_vcpu_arch_set_attr(struct kvm_vcpu *vcpu,
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 63e68c24af0e..6d9885b6e77c 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -765,7 +765,13 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	vcpu->guest_debug = dbg->control;
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 8069d93bf654..fcc033a4d958 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -2031,12 +2031,17 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	struct debug_reg *dbg_reg;
 	int n, b = 0, w = 0;
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
 
 	if (!(dbg->control & KVM_GUESTDBG_ENABLE)) {
 		vcpu->arch.dbg_reg.dbcr0 = 0;
 		vcpu->guest_debug = 0;
 		kvm_guest_protect_msr(vcpu, MSR_DE, false);
-		return 0;
+		goto out;
 	}
 
 	kvm_guest_protect_msr(vcpu, MSR_DE, true);
@@ -2068,8 +2073,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 #endif
 
 	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
-		return 0;
+		goto out;
 
+	ret = -EINVAL;
 	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
 		uint64_t addr = dbg->arch.bp[n].addr;
 		uint32_t type = dbg->arch.bp[n].type;
@@ -2080,21 +2086,24 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
 			     KVMPPC_DEBUG_WATCH_WRITE |
 			     KVMPPC_DEBUG_BREAKPOINT))
-			return -EINVAL;
+			goto out;
 
 		if (type & KVMPPC_DEBUG_BREAKPOINT) {
 			/* Setting H/W breakpoint */
 			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++))
-				return -EINVAL;
+				goto out;
 		} else {
 			/* Setting H/W watchpoint */
 			if (kvmppc_booke_add_watchpoint(dbg_reg, addr,
 							type, w++))
-				return -EINVAL;
+				goto out;
 		}
 	}
 
-	return 0;
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index aa76d2988178..ac26d95444c9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2819,15 +2819,20 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 					struct kvm_guest_debug *dbg)
 {
-	int rc = 0;
+	int rc;
+
+	rc = vcpu_load(vcpu);
+	if (rc)
+		return rc;
 
 	vcpu->guest_debug = 0;
 	kvm_s390_clear_bp_data(vcpu);
 
+	rc = -EINVAL;
 	if (dbg->control & ~VALID_GUESTDBG_FLAGS)
-		return -EINVAL;
+		goto out;
 	if (!sclp.has_gpere)
-		return -EINVAL;
+		goto out;
 
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
@@ -2847,6 +2852,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
 	}
 
+	rc = 0;
+out:
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index ae8685155d11..09135bd759a4 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7596,6 +7596,10 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	unsigned long rflags;
 	int i, r;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	if (dbg->control & (KVM_GUESTDBG_INJECT_DB | KVM_GUESTDBG_INJECT_BP)) {
 		r = -EBUSY;
 		if (vcpu->arch.exception.pending)
@@ -7641,7 +7645,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	r = 0;
 
 out:
-
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 173f98d9c58d..6b87c24c60da 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2650,11 +2650,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&dbg, argp, sizeof(dbg)))
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_SET_SIGNAL_MASK: {
-- 
2.14.2
