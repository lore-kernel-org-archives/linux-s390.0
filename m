From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 10/15] KVM: Move vcpu_load to arch-specific kvm_arch_vcpu_ioctl_translate
Date: Sat, 25 Nov 2017 21:57:13 +0100
Message-ID: <20171125205718.7731-11-christoffer.dall@linaro.org>
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
implementations of kvm_arch_vcpu_ioctl_translate().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/booke.c | 4 ++++
 arch/x86/kvm/x86.c       | 6 ++++++
 virt/kvm/kvm_main.c      | 4 ----
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 59d1d0bd6909..8069d93bf654 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1804,7 +1804,11 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 {
 	int r;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	r = kvmppc_core_vcpu_translate(vcpu, tr);
+	vcpu_put(vcpu);
 	return r;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 1a4fa1f2fa46..ae8685155d11 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7654,6 +7654,11 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	unsigned long vaddr = tr->linear_address;
 	gpa_t gpa;
 	int idx;
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 
 	idx = srcu_read_lock(&vcpu->kvm->srcu);
 	gpa = kvm_mmu_gva_to_gpa_system(vcpu, vaddr, NULL);
@@ -7663,6 +7668,7 @@ int kvm_arch_vcpu_ioctl_translate(struct kvm_vcpu *vcpu,
 	tr->writeable = 1;
 	tr->usermode = 0;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index bcfdb4800e44..173f98d9c58d 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2635,11 +2635,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
-		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
-- 
2.14.2
