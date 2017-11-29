From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH v2 12/16] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_get_fpu
Date: Wed, 29 Nov 2017 17:41:12 +0100
Message-ID: <20171129164116.16167-13-christoffer.dall@linaro.org>
References: <20171129164116.16167-1-christoffer.dall@linaro.org>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171129164116.16167-1-christoffer.dall@linaro.org>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu, linux-arm-kernel@lists.infradead.org, James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org, Alexander Graf <agraf@suse.com>, kvm-ppc@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_get_fpu().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 4 ++++
 arch/x86/kvm/x86.c       | 7 +++++--
 virt/kvm/kvm_main.c      | 2 --
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 4bf80b5..88dcb89 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2765,6 +2765,8 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
+	vcpu_load(vcpu);
+
 	/* make sure we have the latest values */
 	save_fpu_regs();
 	if (MACHINE_HAS_VX)
@@ -2773,6 +2775,8 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	else
 		memcpy(fpu->fprs, vcpu->run->s.regs.fprs, sizeof(fpu->fprs));
 	fpu->fpc = vcpu->run->s.regs.fpc;
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index a074b0bd..8b54567 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7679,9 +7679,11 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	struct fxregs_state *fxsave =
-			&vcpu->arch.guest_fpu.state.fxsave;
+	struct fxregs_state *fxsave;
 
+	vcpu_load(vcpu);
+
+	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
 	memcpy(fpu->fpr, fxsave->st_space, 128);
 	fpu->fcw = fxsave->cwd;
 	fpu->fsw = fxsave->swd;
@@ -7691,6 +7693,7 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fpu->last_dp = fxsave->rdp;
 	memcpy(fpu->xmm, fxsave->xmm_space, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c688eb7..73ad70a 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2673,9 +2673,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!fpu)
 			goto out;
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.7.4
