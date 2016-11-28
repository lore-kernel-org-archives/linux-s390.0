From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/2] KVM: s390: handle access registers in the run ioctl not in vcpu_put/load
Date: Mon, 28 Nov 2016 10:06:37 +0100
Message-ID: <1480323998-210045-2-git-send-email-borntraeger@de.ibm.com>
References: <1480323998-210045-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1480323998-210045-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Right now we save the host access registers in kvm_arch_vcpu_load
and load them in kvm_arch_vcpu_put. Vice versa for the guest access
registers. On schedule this means, that we load/save access registers
multiple times.

e.g. VCPU_RUN with just one reschedule and then return does

[from user space via VCPU_RUN]
- save the host registers in kvm_arch_vcpu_load (via ioctl)
- load the guest registers in kvm_arch_vcpu_load (via ioctl)
- do guest stuff
- decide to schedule/sleep
- save the guest registers in kvm_arch_vcpu_put (via sched)
- load the host registers in kvm_arch_vcpu_put (via sched)
- save the host registers in switch_to (via sched)
- schedule
- return
- load the host registers in switch_to (via sched)
- save the host registers in kvm_arch_vcpu_load (via sched)
- load the guest registers in kvm_arch_vcpu_load (via sched)
- do guest stuff
- decide to go to userspace
- save the guest registers in kvm_arch_vcpu_put (via ioctl)
- load the host registers in kvm_arch_vcpu_put (via ioctl)
[back to user space]

As the kernel does not use access registers, we can avoid
this reloading and simply piggy back on switch_to (let it save
the guest values instead of host values in thread.acrs) by
moving the host/guest switch into the VCPU_RUN ioctl function.
We now do

[from user space via VCPU_RUN]
- save the host registers in kvm_arch_vcpu_ioctl_run
- load the guest registers in kvm_arch_vcpu_ioctl_run
- do guest stuff
- decide to schedule/sleep
- save the guest registers in switch_to
- schedule
- return
- load the guest registers in switch_to (via sched)
- do guest stuff
- decide to go to userspace
- save the guest registers in kvm_arch_vcpu_ioctl_run
- load the host registers in kvm_arch_vcpu_ioctl_run

This seems to save about 10% of the vcpu_put/load functions
according to perf.

As vcpu_load no longer switches the acrs, We can also loading
the acrs in kvm_arch_vcpu_ioctl_set_sregs.

Suggested-by: Fan Zhang <zhangfan@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c |  2 +-
 arch/s390/kvm/kvm-s390.c  | 12 +++++-------
 2 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index be4db07..af13f1a 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -415,7 +415,7 @@ static int __write_machine_check(struct kvm_vcpu *vcpu,
 	int rc;
 
 	mci.val = mchk->mcic;
-	/* take care of lazy register loading via vcpu load/put */
+	/* take care of lazy register loading */
 	save_fpu_regs();
 	save_access_regs(vcpu->run->s.regs.acrs);
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 9c7a1ec..4105e1e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1826,8 +1826,6 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 		/* User space provided an invalid FPC, let's clear it */
 		current->thread.fpu.fpc = 0;
 
-	save_access_regs(vcpu->arch.host_acrs);
-	restore_access_regs(vcpu->run->s.regs.acrs);
 	gmap_enable(vcpu->arch.enabled_gmap);
 	atomic_or(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
 	if (vcpu->arch.cputm_enabled && !is_vcpu_idle(vcpu))
@@ -1851,9 +1849,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	/* Restore host register state */
 	current->thread.fpu.fpc = vcpu->arch.host_fpregs.fpc;
 	current->thread.fpu.regs = vcpu->arch.host_fpregs.regs;
-
-	save_access_regs(vcpu->run->s.regs.acrs);
-	restore_access_regs(vcpu->arch.host_acrs);
 }
 
 static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
@@ -2243,7 +2238,6 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 {
 	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
 	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
-	restore_access_regs(vcpu->run->s.regs.acrs);
 	return 0;
 }
 
@@ -2740,6 +2734,8 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 		if (riccb->valid)
 			vcpu->arch.sie_block->ecb3 |= 0x01;
 	}
+	save_access_regs(vcpu->arch.host_acrs);
+	restore_access_regs(vcpu->run->s.regs.acrs);
 
 	kvm_run->kvm_dirty_regs = 0;
 }
@@ -2758,6 +2754,8 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	kvm_run->s.regs.pft = vcpu->arch.pfault_token;
 	kvm_run->s.regs.pfs = vcpu->arch.pfault_select;
 	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
+	save_access_regs(vcpu->run->s.regs.acrs);
+	restore_access_regs(vcpu->arch.host_acrs);
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
@@ -2874,7 +2872,7 @@ int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr)
 {
 	/*
 	 * The guest FPRS and ACRS are in the host FPRS/ACRS due to the lazy
-	 * copying in vcpu load/put. Lets update our copies before we save
+	 * switch in the run ioctl. Let's update our copies before we save
 	 * it into the save area
 	 */
 	save_fpu_regs();
-- 
2.5.5
