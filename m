From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 04/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_regs
Date: Sat, 25 Nov 2017 21:57:07 +0100
Message-ID: <20171125205718.7731-5-christoffer.dall@linaro.org>
References: <20171125205718.7731-1-christoffer.dall@linaro.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171125205718.7731-1-christoffer.dall@linaro.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_get_regs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c      | 6 ++++++
 arch/powerpc/kvm/book3s.c | 6 ++++++
 arch/powerpc/kvm/booke.c  | 6 ++++++
 arch/s390/kvm/kvm-s390.c  | 6 ++++++
 arch/x86/kvm/x86.c        | 6 ++++++
 virt/kvm/kvm_main.c       | 4 ----
 6 files changed, 30 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index c93620e4b01f..1cb1020e044f 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1167,8 +1167,13 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	for (i = 0; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		regs->gpr[i] = vcpu->arch.gprs[i];
 
@@ -1176,6 +1181,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->lo = vcpu->arch.lo;
 	regs->pc = vcpu->arch.pc;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 72d977e30952..04cfe6749858 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -495,8 +495,13 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	regs->pc = kvmppc_get_pc(vcpu);
 	regs->cr = kvmppc_get_cr(vcpu);
 	regs->ctr = kvmppc_get_ctr(vcpu);
@@ -518,6 +523,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 071b87ee682f..19b6299a5aad 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1430,8 +1430,13 @@ void kvmppc_subarch_vcpu_uninit(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	regs->pc = vcpu->arch.pc;
 	regs->cr = kvmppc_get_cr(vcpu);
 	regs->ctr = vcpu->arch.ctr;
@@ -1453,6 +1458,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		regs->gpr[i] = kvmppc_get_gpr(vcpu, i);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index aaeae92983a6..51ad3c6fc694 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2719,7 +2719,13 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	memcpy(&regs->gprs, &vcpu->run->s.regs.gprs, sizeof(regs->gprs));
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 18e39666ada7..f6594eb2b3be 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7285,6 +7285,11 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *kvm_run)
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	if (vcpu->arch.emulate_regs_need_sync_to_vcpu) {
 		/*
 		 * We are here if userspace calls get_regs() in the middle of
@@ -7318,6 +7323,7 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	regs->rip = kvm_rip_read(vcpu);
 	regs->rflags = kvm_get_rflags(vcpu);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index b6941320d6e5..759f3a1e042e 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2560,11 +2560,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
 		if (!kvm_regs)
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
-		vcpu_put(vcpu);
 		if (r)
 			goto out_free1;
 		r = -EFAULT;
-- 
2.14.2
