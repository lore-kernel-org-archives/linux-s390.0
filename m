From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 05/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_regs
Date: Sat, 25 Nov 2017 21:57:08 +0100
Message-ID: <20171125205718.7731-6-christoffer.dall@linaro.org>
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
implementations of kvm_arch_vcpu_ioctl_set_regs().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/mips/kvm/mips.c      | 6 ++++++
 arch/powerpc/kvm/book3s.c | 6 ++++++
 arch/powerpc/kvm/booke.c  | 6 ++++++
 arch/s390/kvm/kvm-s390.c  | 6 ++++++
 arch/x86/kvm/x86.c        | 7 +++++++
 virt/kvm/kvm_main.c       | 4 ----
 6 files changed, 31 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index 1cb1020e044f..55d2e6e2c4e6 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -1153,8 +1153,13 @@ int kvm_arch_vcpu_dump_regs(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
 		vcpu->arch.gprs[i] = regs->gpr[i];
 	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
@@ -1162,6 +1167,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	vcpu->arch.lo = regs->lo;
 	vcpu->arch.pc = regs->pc;
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/book3s.c b/arch/powerpc/kvm/book3s.c
index 04cfe6749858..047d3178d70f 100644
--- a/arch/powerpc/kvm/book3s.c
+++ b/arch/powerpc/kvm/book3s.c
@@ -529,8 +529,13 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	kvmppc_set_pc(vcpu, regs->pc);
 	kvmppc_set_cr(vcpu, regs->cr);
 	kvmppc_set_ctr(vcpu, regs->ctr);
@@ -551,6 +556,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/powerpc/kvm/booke.c b/arch/powerpc/kvm/booke.c
index 19b6299a5aad..47b3d11345ed 100644
--- a/arch/powerpc/kvm/booke.c
+++ b/arch/powerpc/kvm/booke.c
@@ -1464,8 +1464,13 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
 	int i;
 
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	vcpu->arch.pc = regs->pc;
 	kvmppc_set_cr(vcpu, regs->cr);
 	vcpu->arch.ctr = regs->ctr;
@@ -1487,6 +1492,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 	for (i = 0; i < ARRAY_SIZE(regs->gpr); i++)
 		kvmppc_set_gpr(vcpu, i, regs->gpr[i]);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 51ad3c6fc694..eb2724d6e524 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2713,7 +2713,13 @@ static int kvm_arch_vcpu_ioctl_initial_reset(struct kvm_vcpu *vcpu)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
 	memcpy(&vcpu->run->s.regs.gprs, &regs->gprs, sizeof(regs->gprs));
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f6594eb2b3be..e4e34af97ba0 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7329,6 +7329,12 @@ int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
+	int r;
+
+	r = vcpu_load(vcpu);
+	if (r)
+		return r;
+
 	vcpu->arch.emulate_regs_need_sync_from_vcpu = true;
 	vcpu->arch.emulate_regs_need_sync_to_vcpu = false;
 
@@ -7358,6 +7364,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 759f3a1e042e..7671ebb5971f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2580,11 +2580,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			r = PTR_ERR(kvm_regs);
 			goto out;
 		}
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
-		vcpu_put(vcpu);
 		kfree(kvm_regs);
 		break;
 	}
-- 
2.14.2
