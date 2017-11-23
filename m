From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [RFC PATCH] KVM: Only register preempt notifiers and load arch cpu state as needed
Date: Thu, 23 Nov 2017 17:05:21 +0100
Message-ID: <20171123160521.27260-1-christoffer.dall@linaro.org>
Return-path: <kvm-owner@vger.kernel.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Some architectures may decide to do different things during
kvm_arch_vcpu_load depending on the ioctl being executed.  For example,
arm64 is about to do significant work in vcpu load/put when running a
vcpu, but not when doing things like KVM_SET_ONE_REG or
KVM_SET_MP_STATE.

Therefore, take the mutex directly in the main kvm ioctl dispatch
function and leave it up to architecture-specific functions to register
preempt notifiers and to call the architecture specific load operations
when needed.

A new function is introduced for arch specific code, __vcpu_load(),
which can be called when already holding the vcpu mutex.  vcpu_load() is
then only used by x86, which calls it from outside the main vcpu ioctl
path, and the function now takes the vcpu mutex and calls __vcpu_load().

Suggested-by: Andrew Jones <drjones@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
Hi all,

Drew suggested this as an alternative approach to recording the ioctl
number on the vcpu struct [1] as it may benefit other architectures in
general.

I had a look at some of the specific ioctls across architectures, but
must admit that I can't easily tell which architecture specific logic
relies on having registered preempt notifiers and having called the
architecture specific load function.

It would be great if you would let me know if you think this is
generally useful or if you prefer the less invasive approach, and in
case this is useful, if you could have a look at all the vcpu ioctls for
your architecture and let me know if I am being too loose or too
careful in calling __vcpu_load() in this patch.

Much thanks,
-Christoffer

[1]:
https://lists.cs.columbia.edu/pipermail/kvmarm/2017-October/027528.html
---
 arch/mips/kvm/mips.c          | 50 ++++++++++++++++++++++++++++++------------
 arch/powerpc/kvm/booke.c      | 29 ++++++++++++++++--------
 arch/powerpc/kvm/powerpc.c    |  9 +++++++-
 arch/s390/kvm/kvm-s390.c      | 45 ++++++++++++++++++++++++++++----------
 arch/x86/kvm/x86.c            | 51 ++++++++++++++++++++++++++++++++++---------
 include/linux/kvm_host.h      |  2 ++
 virt/kvm/arm/arch_timer.c     |  4 ----
 virt/kvm/arm/arm.c            |  4 +++-
 virt/kvm/arm/vgic/vgic-init.c | 11 ----------
 virt/kvm/kvm_main.c           | 36 ++++++++++++++++++------------
 10 files changed, 165 insertions(+), 76 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index d535edc01434..6e81724de32a 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -447,6 +447,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int r = -EINTR;
 	sigset_t sigsaved;
 
+	__vcpu_load(vcpu);
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
@@ -483,6 +485,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+	__vcpu_put(vcpu);
+
 	return r;
 }
 
@@ -908,41 +912,54 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 {
 	struct kvm_vcpu *vcpu = filp->private_data;
 	void __user *argp = (void __user *)arg;
-	long r;
+	long r = 0;
+
+	__vcpu_load(vcpu);
 
 	switch (ioctl) {
 	case KVM_SET_ONE_REG:
 	case KVM_GET_ONE_REG: {
 		struct kvm_one_reg reg;
 
-		if (copy_from_user(&reg, argp, sizeof(reg)))
-			return -EFAULT;
+		if (copy_from_user(&reg, argp, sizeof(reg))) {
+			r = -EFAULT;
+			goto out;
+		}
+
 		if (ioctl == KVM_SET_ONE_REG)
-			return kvm_mips_set_reg(vcpu, &reg);
+			r = kvm_mips_set_reg(vcpu, &reg);
 		else
-			return kvm_mips_get_reg(vcpu, &reg);
+			r = kvm_mips_get_reg(vcpu, &reg);
+		break;
 	}
 	case KVM_GET_REG_LIST: {
 		struct kvm_reg_list __user *user_list = argp;
 		struct kvm_reg_list reg_list;
 		unsigned n;
 
-		if (copy_from_user(&reg_list, user_list, sizeof(reg_list)))
-			return -EFAULT;
+		if (copy_from_user(&reg_list, user_list, sizeof(reg_list))) {
+			r = -EFAULT;
+			goto out;
+		}
+
 		n = reg_list.n;
 		reg_list.n = kvm_mips_num_regs(vcpu);
 		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
-			return -EFAULT;
+			r = -EFAULT;
 		if (n < reg_list.n)
-			return -E2BIG;
-		return kvm_mips_copy_reg_indices(vcpu, user_list->reg);
+			r = -E2BIG;
+		if (!r)
+			r = kvm_mips_copy_reg_indices(vcpu, user_list->reg);
+		break;
 	}
 	case KVM_INTERRUPT:
 		{
 			struct kvm_mips_interrupt irq;
 
-			if (copy_from_user(&irq, argp, sizeof(irq)))
-				return -EFAULT;
+			if (copy_from_user(&irq, argp, sizeof(irq))) {
+				r = -EFAULT;
+				goto out;
+			}
 			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
 				  irq.irq);
 
@@ -952,14 +969,19 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl,
 	case KVM_ENABLE_CAP: {
 		struct kvm_enable_cap cap;
 
-		if (copy_from_user(&cap, argp, sizeof(cap)))
-			return -EFAULT;
+		if (copy_from_user(&cap, argp, sizeof(cap))) {
+			r = -EFAULT;
+			goto out;
+		}
 		r = kvm_vcpu_ioctl_enable_cap(vcpu, &cap);
 		break;
 	}
 	default:
 		r = -ENOIOCTLCMD;
 	}
+
+out:
+	__vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 071b87ee682f..9d8b74d871bb 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1997,12 +1997,15 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	struct debug_reg *dbg_reg;
 	int n, b = 0, w = 0;
+	int ret = 0;
+
+	__vcpu_load(vcpu);
 
 	if (!(dbg->control & KVM_GUESTDBG_ENABLE)) {
 		vcpu->arch.dbg_reg.dbcr0 = 0;
 		vcpu->guest_debug = 0;
 		kvm_guest_protect_msr(vcpu, MSR_DE, false);
-		return 0;
+		goto out;
 	}
 
 	kvm_guest_protect_msr(vcpu, MSR_DE, true);
@@ -2034,7 +2037,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 #endif
 
 	if (!(vcpu->guest_debug & KVM_GUESTDBG_USE_HW_BP))
-		return 0;
+		goto out;
 
 	for (n = 0; n < (KVMPPC_BOOKE_IAC_NUM + KVMPPC_BOOKE_DAC_NUM); n++) {
 		uint64_t addr = dbg->arch.bp[n].addr;
@@ -2045,22 +2048,30 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 
 		if (type & ~(KVMPPC_DEBUG_WATCH_READ |
 			     KVMPPC_DEBUG_WATCH_WRITE |
-			     KVMPPC_DEBUG_BREAKPOINT))
-			return -EINVAL;
+			     KVMPPC_DEBUG_BREAKPOINT)) {
+			ret = -EINVAL;
+			goto out;
+		}
 
 		if (type & KVMPPC_DEBUG_BREAKPOINT) {
 			/* Setting H/W breakpoint */
-			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++))
-				return -EINVAL;
+			if (kvmppc_booke_add_breakpoint(dbg_reg, addr, b++)) {
+				ret = -EINVAL;
+				goto out;
+			}
 		} else {
 			/* Setting H/W watchpoint */
 			if (kvmppc_booke_add_watchpoint(dbg_reg, addr,
-							type, w++))
-				return -EINVAL;
+							type, w++)) {
+				ret = -EINVAL;
+				goto out;
+			}
 		}
 	}
 
-	return 0;
+out:
+	__vcpu_put(vcpu);
+	return ret;
 }
 
 void kvmppc_booke_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 3480faaf1ef8..35361963c706 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -1410,6 +1410,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	int r;
 	sigset_t sigsaved;
 
+	__vcpu_load(vcpu);
+
 	if (vcpu->mmio_needed) {
 		vcpu->mmio_needed = 0;
 		if (!vcpu->mmio_is_write)
@@ -1424,7 +1426,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			r = kvmppc_emulate_mmio_vsx_loadstore(vcpu, run);
 			if (r == RESUME_HOST) {
 				vcpu->mmio_needed = 1;
-				return r;
+				goto out;
 			}
 		}
 #endif
@@ -1460,6 +1462,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+out:
+	__vcpu_put(vcpu);
 	return r;
 }
 
@@ -1614,6 +1618,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	void __user *argp = (void __user *)arg;
 	long r;
 
+	__vcpu_load(vcpu);
+
 	switch (ioctl) {
 	case KVM_INTERRUPT: {
 		struct kvm_interrupt irq;
@@ -1663,6 +1669,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 
 out:
+	__vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 40d0a1a97889..82ddfb3787db 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2793,13 +2793,19 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	int rc = 0;
 
+	__vcpu_load(vcpu);
+
 	vcpu->guest_debug = 0;
 	kvm_s390_clear_bp_data(vcpu);
 
-	if (dbg->control & ~VALID_GUESTDBG_FLAGS)
-		return -EINVAL;
-	if (!sclp.has_gpere)
-		return -EINVAL;
+	if (dbg->control & ~VALID_GUESTDBG_FLAGS) {
+		rc = -EINVAL;
+		goto out;
+	}
+	if (!sclp.has_gpere) {
+		rc = -EINVAL;
+		goto out;
+	}
 
 	if (dbg->control & KVM_GUESTDBG_ENABLE) {
 		vcpu->guest_debug = dbg->control;
@@ -2819,6 +2825,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		atomic_andnot(CPUSTAT_P, &vcpu->arch.sie_block->cpuflags);
 	}
 
+out:
+	__vcpu_put(vcpu);
 	return rc;
 }
 
@@ -3375,12 +3383,17 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	int rc;
 	sigset_t sigsaved;
 
-	if (kvm_run->immediate_exit)
-		return -EINTR;
+	__vcpu_load(vcpu);
+
+	if (kvm_run->immediate_exit) {
+		rc = -EINTR;
+		goto out;
+	}
 
 	if (guestdbg_exit_pending(vcpu)) {
 		kvm_s390_prepare_debug_exit(vcpu);
-		return 0;
+		rc = 0;
+		goto out;
 	}
 
 	if (vcpu->sigset_active)
@@ -3391,7 +3404,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	} else if (is_vcpu_stopped(vcpu)) {
 		pr_err_ratelimited("can't run stopped vcpu %d\n",
 				   vcpu->vcpu_id);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out;
 	}
 
 	sync_regs(vcpu, kvm_run);
@@ -3422,6 +3436,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
 	vcpu->stat.exit_userspace++;
+out:
+	__vcpu_put(vcpu);
 	return rc;
 }
 
@@ -3691,6 +3707,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	int idx;
 	long r;
 
+	__vcpu_load(vcpu);
+
 	switch (ioctl) {
 	case KVM_S390_IRQ: {
 		struct kvm_s390_irq s390irq;
@@ -3705,12 +3723,13 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		struct kvm_s390_interrupt s390int;
 		struct kvm_s390_irq s390irq;
 
-		r = -EFAULT;
+		r = 0;
 		if (copy_from_user(&s390int, argp, sizeof(s390int)))
-			break;
+			r = -EFAULT;
 		if (s390int_to_s390irq(&s390int, &s390irq))
-			return -EINVAL;
-		r = kvm_s390_inject_vcpu(vcpu, &s390irq);
+			r = -EINVAL;
+		if (!r)
+			r = kvm_s390_inject_vcpu(vcpu, &s390irq);
 		break;
 	}
 	case KVM_S390_STORE_STATUS:
@@ -3835,6 +3854,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	default:
 		r = -ENOTTY;
 	}
+
+	__vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 03869eb7fcd6..008a8c238fd8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3453,6 +3453,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		void *buffer;
 	} u;
 
+	__vcpu_load(vcpu);
+
 	u.buffer = NULL;
 	switch (ioctl) {
 	case KVM_GET_LAPIC: {
@@ -3478,8 +3480,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		if (!lapic_in_kernel(vcpu))
 			goto out;
 		u.lapic = memdup_user(argp, sizeof(*u.lapic));
-		if (IS_ERR(u.lapic))
-			return PTR_ERR(u.lapic);
+		if (IS_ERR(u.lapic)) {
+			r = PTR_ERR(u.lapic);
+			goto out;
+		}
 
 		r = kvm_vcpu_ioctl_set_lapic(vcpu, u.lapic);
 		break;
@@ -3653,8 +3657,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 	case KVM_SET_XSAVE: {
 		u.xsave = memdup_user(argp, sizeof(*u.xsave));
-		if (IS_ERR(u.xsave))
-			return PTR_ERR(u.xsave);
+		if (IS_ERR(u.xsave)) {
+			r = PTR_ERR(u.xsave);
+			goto out;
+		}
 
 		r = kvm_vcpu_ioctl_x86_set_xsave(vcpu, u.xsave);
 		break;
@@ -3676,8 +3682,10 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 	case KVM_SET_XCRS: {
 		u.xcrs = memdup_user(argp, sizeof(*u.xcrs));
-		if (IS_ERR(u.xcrs))
-			return PTR_ERR(u.xcrs);
+		if (IS_ERR(u.xcrs)) {
+			r = PTR_ERR(u.xcrs);
+			goto out;
+		}
 
 		r = kvm_vcpu_ioctl_x86_set_xcrs(vcpu, u.xcrs);
 		break;
@@ -3721,6 +3729,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	}
 out:
 	kfree(u.buffer);
+	__vcpu_put(vcpu);
 	return r;
 }
 
@@ -7225,6 +7234,8 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	int r;
 	sigset_t sigsaved;
 
+	__vcpu_load(vcpu);
+
 	fpu__initialize(fpu);
 
 	if (vcpu->sigset_active)
@@ -7274,11 +7285,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
 
+	__vcpu_put(vcpu);
 	return r;
 }
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	__vcpu_load(vcpu);
 	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
 		/*
 		 * We are here if userspace calls get_regs() in the middle of
@@ -7312,11 +7325,14 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->rip = kvm_rip_read(vcpu);
 	regs->rflags = kvm_get_rflags(vcpu);
 
+	__vcpu_put(vcpu);
 	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	__vcpu_load(vcpu);
+
 	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
 	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 
@@ -7346,6 +7362,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
+	__vcpu_put(vcpu);
 	return 0;
 }
 
@@ -7364,6 +7381,8 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 {
 	struct desc_ptr dt;
 
+	__vcpu_load(vcpu);
+
 	kvm_get_segment(vcpu, &sregs->cs, VCPU_SREG_CS);
 	kvm_get_segment(vcpu, &sregs->ds, VCPU_SREG_DS);
 	kvm_get_segment(vcpu, &sregs->es, VCPU_SREG_ES);
@@ -7395,12 +7414,15 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 		set_bit(vcpu->arch.interrupt.nr,
 			(unsigned long *)sregs->interrupt_bitmap);
 
+	__vcpu_put(vcpu);
 	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	__vcpu_load(vcpu);
+
 	kvm_apic_accept_events(vcpu);
 	if (vcpu->arch.mp_state == KVM_MP_STATE_HALTED &&
 					vcpu->arch.pv.pv_unhalted)
@@ -7408,6 +7430,7 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 	else
 		mp_state->mp_state = vcpu->arch.mp_state;
 
+	__vcpu_put(vcpu);
 	return 0;
 }
 
@@ -7461,15 +7484,18 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	int mmu_reset_needed = 0;
 	int pending_vec, max_bits, idx;
 	struct desc_ptr dt;
+	int ret = -EINVAL;
 
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 			(sregs->cr4 & X86_CR4_OSXSAVE))
-		return -EINVAL;
+		goto out;
 
 	apic_base_msr.data = sregs->apic_base;
 	apic_base_msr.host_initiated = true;
 	if (kvm_set_apic_base(vcpu, &apic_base_msr))
-		return -EINVAL;
+		goto out;
+
+	__vcpu_load(vcpu);
 
 	dt.size = sregs->idt.limit;
 	dt.address = sregs->idt.base;
@@ -7535,7 +7561,10 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
-	return 0;
+	ret = 0;
+out:
+	__vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
@@ -7544,6 +7573,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	unsigned long rflags;
 	int i, r;
 
+	__vcpu_load(vcpu);
+
 	if (dbg->control & (KVM_GUESTDBG_INJECT_DB | KVM_GUESTDBG_INJECT_BP)) {
 		r = -EBUSY;
 		if (vcpu->arch.exception.pending)
@@ -7589,7 +7620,7 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	r = 0;
 
 out:
-
+	__vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538eda32..5c760925af6c 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -533,7 +533,9 @@ static inline int kvm_vcpu_get_idx(struct kvm_vcpu *vcpu)
 int kvm_vcpu_init(struct kvm_vcpu *vcpu, struct kvm *kvm, unsigned id);
 void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 
+void __vcpu_load(struct kvm_vcpu *vcpu);
 int __must_check vcpu_load(struct kvm_vcpu *vcpu);
+void __vcpu_put(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
 #ifdef __KVM_HAVE_IOAPIC
diff --git a/virt/kvm/arm/arch_timer.c b/virt/kvm/arm/arch_timer.c
index 7b27316d4c3f..ecc88a1713e3 100644
--- a/virt/kvm/arm/arch_timer.c
+++ b/virt/kvm/arm/arch_timer.c
@@ -845,11 +845,7 @@ int kvm_timer_enable(struct kvm_vcpu *vcpu)
 		return ret;
 
 no_vgic:
-	preempt_disable();
 	timer->enabled = 1;
-	kvm_timer_vcpu_load_vgic(vcpu);
-	preempt_enable();
-
 	return 0;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a6bd563e5455..4c4566f5ed42 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -629,12 +629,13 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 			return ret;
 		if (kvm_arm_handle_step_debug(vcpu, vcpu->run))
 			return 0;
-
 	}
 
 	if (run->immediate_exit)
 		return -EINTR;
 
+	__vcpu_load(vcpu);
+
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &vcpu->sigset, &sigsaved);
 
@@ -770,6 +771,7 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	if (vcpu->sigset_active)
 		sigprocmask(SIG_SETMASK, &sigsaved, NULL);
+	__vcpu_put(vcpu);
 	return ret;
 }
 
diff --git a/virt/kvm/arm/vgic/vgic-init.c b/virt/kvm/arm/vgic/vgic-init.c
index 62310122ee78..a0688ef52ad7 100644
--- a/virt/kvm/arm/vgic/vgic-init.c
+++ b/virt/kvm/arm/vgic/vgic-init.c
@@ -300,17 +300,6 @@ int vgic_init(struct kvm *kvm)
 
 	dist->initialized = true;
 
-	/*
-	 * If we're initializing GICv2 on-demand when first running the VCPU
-	 * then we need to load the VGIC state onto the CPU.  We can detect
-	 * this easily by checking if we are in between vcpu_load and vcpu_put
-	 * when we just initialized the VGIC.
-	 */
-	preempt_disable();
-	vcpu = kvm_arm_get_running_vcpu();
-	if (vcpu)
-		kvm_vgic_load(vcpu);
-	preempt_enable();
 out:
 	return ret;
 }
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 9deb5a245b83..089a92e786fe 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -144,29 +144,38 @@ bool kvm_is_reserved_pfn(kvm_pfn_t pfn)
 	return true;
 }
 
-/*
- * Switches to specified vcpu, until a matching vcpu_put()
- */
-int vcpu_load(struct kvm_vcpu *vcpu)
+/* Load the vcpu from ioctl context after the vcpu mutex is already taken */
+void __vcpu_load(struct kvm_vcpu *vcpu)
 {
-	int cpu;
-
-	if (mutex_lock_killable(&vcpu->mutex))
-		return -EINTR;
-	cpu = get_cpu();
+	int cpu = get_cpu();
 	preempt_notifier_register(&vcpu->preempt_notifier);
 	kvm_arch_vcpu_load(vcpu, cpu);
 	put_cpu();
+}
+EXPORT_SYMBOL_GPL(__vcpu_load);
+
+/* Use this to load the vcpu without already holding the vcpu mutex */
+int vcpu_load(struct kvm_vcpu *vcpu)
+{
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
+	__vcpu_load(vcpu);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(vcpu_load);
 
-void vcpu_put(struct kvm_vcpu *vcpu)
+void __vcpu_put(struct kvm_vcpu *vcpu)
 {
 	preempt_disable();
 	kvm_arch_vcpu_put(vcpu);
 	preempt_notifier_unregister(&vcpu->preempt_notifier);
 	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(__vcpu_put);
+
+void vcpu_put(struct kvm_vcpu *vcpu)
+{
+	__vcpu_put(vcpu);
 	mutex_unlock(&vcpu->mutex);
 }
 EXPORT_SYMBOL_GPL(vcpu_put);
@@ -2529,9 +2538,8 @@ static long kvm_vcpu_ioctl(struct file *filp,
 #endif
 
 
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 	switch (ioctl) {
 	case KVM_RUN: {
 		struct pid *oldpid;
@@ -2703,7 +2711,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
 	}
 out:
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	kfree(fpu);
 	kfree(kvm_sregs);
 	return r;
-- 
2.14.2
