From: Christoffer Dall <cdall@kernel.org>
Subject: [PATCH v3 13/16] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_fpu
Date: Mon,  4 Dec 2017 21:35:35 +0100
Message-ID: <20171204203538.8370-14-cdall@kernel.org>
References: <20171204203538.8370-1-cdall@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvmarm-bounces@lists.cs.columbia.edu>
In-Reply-To: <20171204203538.8370-1-cdall@kernel.org>
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
Cc: linux-mips@linux-mips.org, Marc Zyngier <marc.zyngier@arm.com>, James Hogan <jhogan@kernel.org>, Cornelia Huck <cohuck@redhat.com>, kvm-ppc@vger.kernel.org, Paul Mackerras <paulus@ozlabs.org>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-arm-kernel@lists.infradead.org, Paolo Bonzini <pbonzini@redhat.com>, linux-s390@vger.kernel.org, kvmarm@lists.cs.columbia.edu
List-ID: <linux-s390.vger.kernel.org>

From: Christoffer Dall <christoffer.dall@linaro.org>

Move vcpu_load() and vcpu_put() into the architecture specific
implementations of kvm_arch_vcpu_ioctl_set_fpu().

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c | 15 ++++++++++++---
 arch/x86/kvm/x86.c       |  8 ++++++--
 virt/kvm/kvm_main.c      |  2 --
 3 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 88dcb89656be..43278f334ce3 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2752,15 +2752,24 @@ int kvm_arch_vcpu_ioctl_get_sregs(struct kvm_vcpu *vcpu,
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	if (test_fp_ctl(fpu->fpc))
-		return -EINVAL;
+	int ret = 0;
+
+	vcpu_load(vcpu);
+
+	if (test_fp_ctl(fpu->fpc)) {
+		ret = -EINVAL;
+		goto out;
+	}
 	vcpu->run->s.regs.fpc = fpu->fpc;
 	if (MACHINE_HAS_VX)
 		convert_fp_to_vx((__vector128 *) vcpu->run->s.regs.vrs,
 				 (freg_t *) fpu->fprs);
 	else
 		memcpy(vcpu->run->s.regs.fprs, &fpu->fprs, sizeof(fpu->fprs));
-	return 0;
+
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 19b70e016858..95a329580c8b 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7698,8 +7698,11 @@ int kvm_arch_vcpu_ioctl_get_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 
 int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 {
-	struct fxregs_state *fxsave =
-			&vcpu->arch.guest_fpu.state.fxsave;
+	struct fxregs_state *fxsave;
+
+	vcpu_load(vcpu);
+
+	fxsave = &vcpu->arch.guest_fpu.state.fxsave;
 
 	memcpy(fxsave->st_space, fpu->fpr, 128);
 	fxsave->cwd = fpu->fcw;
@@ -7710,6 +7713,7 @@ int kvm_arch_vcpu_ioctl_set_fpu(struct kvm_vcpu *vcpu, struct kvm_fpu *fpu)
 	fxsave->rdp = fpu->last_dp;
 	memcpy(fxsave->xmm_space, fpu->xmm, sizeof fxsave->xmm_space);
 
+	vcpu_put(vcpu);
 	return 0;
 }
 
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 73ad70af6b2d..06751bbecd58 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2689,9 +2689,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
-		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
-		vcpu_put(vcpu);
 		break;
 	}
 	default:
-- 
2.14.2
