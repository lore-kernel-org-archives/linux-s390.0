From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 13/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_fpu
Date: Sat, 25 Nov 2017 21:57:16 +0100
Message-ID: <20171125205718.7731-14-christoffer.dall@linaro.org>
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
implementations of kvm_arch_vcpu_ioctl_set_fpu().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 15 +++++++++++++--
 arch/x86/kvm/x86.c       | 11 +++++++++--
 virt/kvm/kvm_main.c      |  4 ----
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index e4ddf6a5cb4e..46d015083136 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2769,15 +2769,26 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
 	if (test_fp_ctl(fpu->fpc))
-		return -EINVAL;
+		goto out;
 	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
 				 (freg_t *) fpu->fprs);
 	else
 		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
-	return 0;
+
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index f275fefbc4e0..230d552cdc4b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7701,8 +7701,14 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	struct fxregs_state *fxsave =
-			&vcpu->arch.guest_fpu.state.fxsave;
+	int ret;
+	struct fxregs_state *fxsave;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
+	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
 
 	memcpy(fxsave->st_space, fpu->fpr, 128);
 	fxsave->cwd = fpu->fcw;
@@ -7713,6 +7719,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fxsave->rdp = fpu->last_dp;
 	memcpy(fxsave->xmm_space, fpu->xmm, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8f767922fbbd..08a610619572 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2697,11 +2697,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
-		vcpu_put(vcpu);
 		break;
 	}
 	default:
-- 
2.14.2
