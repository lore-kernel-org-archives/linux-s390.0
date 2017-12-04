From: Christoffer Dall <cdall@kernel.org>
Subject: [PATCH v3 15/16] KVM: arm/arm64: Avoid vcpu_load for other vcpu
 ioctls than KVM_RUN
Date: Mon,  4 Dec 2017 21:35:37 +0100
Message-ID: <20171204203538.8370-16-cdall@kernel.org>
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

Calling vcpu_load() registers preempt notifiers for this vcpu and calls
kvm_arch_vcpu_load().  The latter will soon be doing a lot of heavy
lifting on arm/arm64 and will try to do things such as enabling the
virtual timer and setting us up to handle interrupts from the timer
hardware.

Loading state onto hardware registers and enabling hardware to signal
interrupts can be problematic when we're not actually about to run the
VCPU, because it makes it difficult to establish the right context when
handling interrupts from the timer, and it makes the register access
code difficult to reason about.

Luckily, now when we call vcpu_load in each ioctl implementation, we can
simply remove the call from the non-KVM_RUN vcpu ioctls, and our
kvm_arch_vcpu_load() is only used for loading vcpu content to the
physical CPU when we're actually going to run the vcpu.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/guest.c | 3 ---
 virt/kvm/arm/arm.c     | 9 ---------
 2 files changed, 12 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index d7e3299a7734..959e50d2588c 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -363,8 +363,6 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	int ret = 0;
 
-	vcpu_load(vcpu);
-
 	trace_kvm_set_guest_debug(vcpu, dbg->control);
 
 	if (dbg->control & ~KVM_GUESTDBG_VALID_MASK) {
@@ -386,7 +384,6 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 	}
 
 out:
-	vcpu_put(vcpu);
 	return ret;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index 8223c59be507..a760ef1803be 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -381,14 +381,11 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	vcpu_load(vcpu);
-
 	if (vcpu->arch.power_off)
 		mp_state->mp_state = KVM_MP_STATE_STOPPED;
 	else
 		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
 
-	vcpu_put(vcpu);
 	return 0;
 }
 
@@ -397,8 +394,6 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 {
 	int ret = 0;
 
-	vcpu_load(vcpu);
-
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_RUNNABLE:
 		vcpu->arch.power_off = false;
@@ -410,7 +405,6 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		ret = -EINVAL;
 	}
 
-	vcpu_put(vcpu);
 	return ret;
 }
 
@@ -1003,8 +997,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	struct kvm_device_attr attr;
 	long r;
 
-	vcpu_load(vcpu);
-
 	switch (ioctl) {
 	case KVM_ARM_VCPU_INIT: {
 		struct kvm_vcpu_init init;
@@ -1081,7 +1073,6 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -EINVAL;
 	}
 
-	vcpu_put(vcpu);
 	return r;
 }
 
-- 
2.14.2
