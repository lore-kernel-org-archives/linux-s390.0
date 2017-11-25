From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 07/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_sregs
Date: Sat, 25 Nov 2017 21:57:10 +0100
Message-ID: <20171125205718.7731-8-christoffer.dall@linaro.org>
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
implementations of kvm_arch_vcpu_ioctl_set_sregs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/powerpc/kvm/book3s.c | 10 +++++++++-
 arch/powerpc/kvm/booke.c  | 17 +++++++++++++----
 arch/s390/kvm/kvm-s390.c  |  8 ++++++++
 arch/x86/kvm/x86.c        | 15 ++++++++++++---
 virt/kvm/kvm_main.c       |  4 ----
 5 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index b7db75010843..63e68c24af0e 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -498,7 +498,15 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
-	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
+
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index d770f465cb9d..59d1d0bd6909 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1641,18 +1641,27 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 {
 	int ret;
 
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
 	if (vcpu->arch.pvr != sregs->pvr)
-		return -EINVAL;
+		goto out;
 
 	ret = set_sregs_base(vcpu, sregs);
 	if (ret < 0)
-		return ret;
+		goto out;
 
 	ret = set_sregs_arch206(vcpu, sregs);
 	if (ret < 0)
-		return ret;
+		goto out;
+
+	ret = vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
 
-	return vcpu->kvm->arch.kvm_ops->set_sregs(vcpu, sregs);
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvmppc_get_one_reg(struct kvm_vcpu *vcpu, u64 id,
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 93a19e7e4f59..51569cc97a07 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2738,8 +2738,16 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 				  struct kvm_sregs *sregs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	memcpy(&vcpu->run->s.regs.acrs, &sregs->acrs, sizeof(sregs->acrs));
 	memcpy(&vcpu->arch.sie_block->gcr, &sregs->crs, sizeof(sregs->crs));
+
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 7faa9479e8d8..1a701a2f25a3 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7486,15 +7486,21 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 	int mmu_reset_needed = 0;
 	int pending_vec, max_bits, idx;
 	struct desc_ptr dt;
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
 
+	ret = -EINVAL;
 	if (!guest_cpuid_has(vcpu, X86_FEATURE_XSAVE) &&
 			(sregs->cr4 & X86_CR4_OSXSAVE))
-		return -EINVAL;
+		goto out;
 
 	apic_base_msr.data = sregs->apic_base;
 	apic_base_msr.host_initiated = true;
 	if (kvm_set_apic_base(vcpu, &apic_base_msr))
-		return -EINVAL;
+		goto out;
 
 	dt.size = sregs->idt.limit;
 	dt.address = sregs->idt.base;
@@ -7560,7 +7566,10 @@ int kvm_arch_vcpu_ioctl_set_sregs(struct kvm_vcpu *vcpu,
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
-	return 0;
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index dbfaf190fca3..f68f45e64967 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2605,11 +2605,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			kvm_sregs = NULL;
 			goto out;
 		}
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_GET_MP_STATE: {
-- 
2.14.2
