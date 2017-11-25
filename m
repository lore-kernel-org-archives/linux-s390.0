From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 09/15] KVM: Move vcpu_load to arch-specific
 kvm_arch_vcpu_ioctl_set_mpstate
Date: Sat, 25 Nov 2017 21:57:12 +0100
Message-ID: <20171125205718.7731-10-christoffer.dall@linaro.org>
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
implementations of kvm_arch_vcpu_ioctl_set_mpstate().

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/s390/kvm/kvm-s390.c |  7 ++++++-
 arch/x86/kvm/x86.c       | 17 ++++++++++++++---
 virt/kvm/arm/arm.c       | 11 +++++++++--
 virt/kvm/kvm_main.c      |  4 ----
 4 files changed, 29 insertions(+), 10 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index ccaf5088b73e..aa76d2988178 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -2870,7 +2870,11 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	int rc = 0;
+	int rc;
+
+	rc = vcpu_load(vcpu);
+	if (rc)
+		return rc;
 
 	/* user space knows about this interface - let it control the state */
 	vcpu->kvm->arch.user_cpu_state_ctrl = 1;
@@ -2889,6 +2893,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		rc = -ENXIO;
 	}
 
+	vcpu_put(vcpu);
 	return rc;
 }
 
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 71f0572a4e4a..1a4fa1f2fa46 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7446,15 +7446,22 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
+	ret = -EINVAL;
 	if (!lapic_in_kernel(vcpu) &&
 	    mp_state->mp_state != KVM_MP_STATE_RUNNABLE)
-		return -EINVAL;
+		goto out;
 
 	/* INITs are latched while in SMM */
 	if ((is_smm(vcpu) || vcpu->arch.smi_pending) &&
 	    (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED ||
 	     mp_state->mp_state == KVM_MP_STATE_INIT_RECEIVED))
-		return -EINVAL;
+		goto out;
 
 	if (mp_state->mp_state == KVM_MP_STATE_SIPI_RECEIVED) {
 		vcpu->arch.mp_state = KVM_MP_STATE_INIT_RECEIVED;
@@ -7462,7 +7469,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	} else
 		vcpu->arch.mp_state = mp_state->mp_state;
 	kvm_make_request(KVM_REQ_EVENT, vcpu);
-	return 0;
+
+	ret = 0;
+out:
+	vcpu_put(vcpu);
+	return ret;
 }
 
 int kvm_task_switch(struct kvm_vcpu *vcpu, u16 tss_selector, int idt_index,
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 4f36e6dd4d5e..631d04d87b25 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -399,6 +399,12 @@ int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
+	int ret;
+
+	ret = vcpu_load(vcpu);
+	if (ret)
+		return ret;
+
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_RUNNABLE:
 		vcpu->arch.power_off = false;
@@ -407,10 +413,11 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		vcpu_power_off(vcpu);
 		break;
 	default:
-		return -EINVAL;
+		ret = -EINVAL;
 	}
 
-	return 0;
+	vcpu_put(vcpu);
+	return ret;
 }
 
 /**
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 8b7c821e0244..bcfdb4800e44 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2626,11 +2626,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
 			goto out;
-		r = vcpu_load(vcpu);
-		if (r)
-			goto out;
 		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
-		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_TRANSLATE: {
-- 
2.14.2
