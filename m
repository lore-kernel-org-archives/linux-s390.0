From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 2/2] KVM: s390: handle floating point registers in the run ioctl not in vcpu_put/load
Date: Mon, 28 Nov 2016 10:06:38 +0100
Message-ID: <1480323998-210045-3-git-send-email-borntraeger@de.ibm.com>
References: <1480323998-210045-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1480323998-210045-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

Right now we switch the host fprs/vrs in kvm_arch_vcpu_load and switch
back in kvm_arch_vcpu_put. This process is already optimized
since commit 9977e886cbbc7 ("s390/kernel: lazy restore fpu registers")
avoiding double save/restores on schedule. We still reload the pointers
and test the guest fpc on each context switch, though.

We can minimize the cost of vcpu_load/put by doing the test in the
VCPU_RUN ioctl itself. As most VCPU threads almost never exit to
userspace in the common fast path, this allows to avoid this overhead
for the common case (eventfd driven I/O, all exits including sleep
handled in the kernel) - making kvm_arch_vcpu_load/put basically
disappear in perf top.

Also adapt the fpu get/set ioctls.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 45 +++++++++++++++++++++------------------------
 1 file changed, 21 insertions(+), 24 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4105e1e..bec71e9 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -1812,19 +1812,6 @@ __u64 kvm_s390_get_cpu_timer(struct kvm_vcpu *vcpu)
 
 void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 {
-	/* Save host register state */
-	save_fpu_regs();
-	vcpu->arch.host_fpregs.fpc = current->thread.fpu.fpc;
-	vcpu->arch.host_fpregs.regs = current->thread.fpu.regs;
-
-	if (MACHINE_HAS_VX)
-		current->thread.fpu.regs = vcpu->run->s.regs.vrs;
-	else
-		current->thread.fpu.regs = vcpu->run->s.regs.fprs;
-	current->thread.fpu.fpc = vcpu->run->s.regs.fpc;
-	if (test_fp_ctl(current->thread.fpu.fpc))
-		/* User space provided an invalid FPC, let's clear it */
-		current->thread.fpu.fpc = 0;
 
 	gmap_enable(vcpu->arch.enabled_gmap);
 	atomic_or(CPUSTAT_RUNNING, &vcpu->arch.sie_block->cpuflags);
@@ -1842,13 +1829,6 @@ void kvm_arch_vcpu_put(struct kvm_vcpu *vcpu)
 	vcpu->arch.enabled_gmap = gmap_get_enabled();
 	gmap_disable(vcpu->arch.enabled_gmap);
 
-	/* Save guest register state */
-	save_fpu_regs();
-	vcpu->run->s.regs.fpc = current->thread.fpu.fpc;
-
-	/* Restore host register state */
-	current->thread.fpu.fpc = vcpu->arch.host_fpregs.fpc;
-	current->thread.fpu.regs = vcpu->arch.host_fpregs.regs;
 }
 
 static void kvm_s390_vcpu_initial_reset(struct kvm_vcpu *vcpu)
@@ -2251,11 +2231,9 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	/* make sure the new values will be lazily loaded */
-	save_fpu_regs();
 	if (test_fp_ctl(fpu->fpc))
 		return -EINVAL;
-	current->thread.fpu.fpc = fpu->fpc;
+	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
 				 (freg_t *) fpu->fprs);
@@ -2273,7 +2251,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 				 (__vector128 *) vcpu->run->s.regs.vrs);
 	else
 		memcpy(fpu->fprs, vcpu->run->s.regs.fprs, sizeof(fpu->fprs));
-	fpu->fpc = current->thread.fpu.fpc;
+	fpu->fpc = vcpu->run->s.regs.fpc;
 	return 0;
 }
 
@@ -2736,6 +2714,18 @@ static void sync_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	}
 	save_access_regs(vcpu->arch.host_acrs);
 	restore_access_regs(vcpu->run->s.regs.acrs);
+	/* save host (userspace) fprs/vrs */
+	save_fpu_regs();
+	vcpu->arch.host_fpregs.fpc = current->thread.fpu.fpc;
+	vcpu->arch.host_fpregs.regs = current->thread.fpu.regs;
+	if (MACHINE_HAS_VX)
+		current->thread.fpu.regs = vcpu->run->s.regs.vrs;
+	else
+		current->thread.fpu.regs = vcpu->run->s.regs.fprs;
+	current->thread.fpu.fpc = vcpu->run->s.regs.fpc;
+	if (test_fp_ctl(current->thread.fpu.fpc))
+		/* User space provided an invalid FPC, let's clear it */
+		current->thread.fpu.fpc = 0;
 
 	kvm_run->kvm_dirty_regs = 0;
 }
@@ -2756,6 +2746,13 @@ static void store_regs(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 	kvm_run->s.regs.pfc = vcpu->arch.pfault_compare;
 	save_access_regs(vcpu->run->s.regs.acrs);
 	restore_access_regs(vcpu->arch.host_acrs);
+	/* Save guest register state */
+	save_fpu_regs();
+	vcpu->run->s.regs.fpc = current->thread.fpu.fpc;
+	/* Restore will be done lazily at return */
+	current->thread.fpu.fpc = vcpu->arch.host_fpregs.fpc;
+	current->thread.fpu.regs = vcpu->arch.host_fpregs.regs;
+
 }
 
 int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
-- 
2.5.5
