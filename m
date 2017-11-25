From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 15/15] KVM: arm/arm64: Avoid vcpu_load for other vcpu ioctls
 than KVM_RUN
Date: Sat, 25 Nov 2017 21:57:18 +0100
Message-ID: <20171125205718.7731-16-christoffer.dall@linaro.org>
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

Calling vcpu_load() takes the vcpu->mutex, registers preempt notifiers
for this vcpu, and calls kvm_arch_vcpu_load().  The latter will soon be
doing a lot of heavy lifting on arm/arm64 and will try to do things such
as enabling the virtual timer and setting us up to handle interrupts
from the timer hardware.

Loading state onto hardware registers and enabling hardware to signal
interrupts can be problematic when we're not actually about to run the
VCPU, because it makes it difficult to establish the right context when
handling interrupts from the timer, and it makes the register access
code difficult to reason about.

Luckily, now when we call vcpu_load in each ioctl implementation, we can
simply change the non-KVM_RUN vcpu ioctls to only take the vcpu->mutex
instead of calling vcpu_load(), and our kvm_arch_vcpu_load() is only
used for loading vcpu content to the physical CPU when we're actually
going to run the vcpu.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 arch/arm64/kvm/guest.c |  8 ++++----
 virt/kvm/arm/arm.c     | 25 ++++++++++---------------
 2 files changed, 14 insertions(+), 19 deletions(-)

diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
index 0375d1f977c8..891d5c5e6e4f 100644
--- a/arch/arm64/kvm/guest.c
+++ b/arch/arm64/kvm/guest.c
@@ -363,9 +363,8 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 {
 	int ret;
 
-	ret = vcpu_load(vcpu);
-	if (ret)
-		return ret;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 
 	trace_kvm_set_guest_debug(vcpu, dbg->control);
 
@@ -387,8 +386,9 @@ int kvm_arch_vcpu_ioctl_set_guest_debug(struct kvm_vcpu *vcpu,
 		vcpu->guest_debug = 0;
 	}
 
+	ret = 0;
 out:
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	return ret;
 }
 
diff --git a/virt/kvm/arm/arm.c b/virt/kvm/arm/arm.c
index a1b486a71e85..5095366d3b21 100644
--- a/virt/kvm/arm/arm.c
+++ b/virt/kvm/arm/arm.c
@@ -381,29 +381,25 @@ static void vcpu_power_off(struct kvm_vcpu *vcpu)
 int kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	int ret;
-
-	ret = vcpu_load(vcpu);
-	if (ret)
-		return ret;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 
 	if (vcpu->arch.power_off)
 		mp_state->mp_state = KVM_MP_STATE_STOPPED;
 	else
 		mp_state->mp_state = KVM_MP_STATE_RUNNABLE;
 
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 				    struct kvm_mp_state *mp_state)
 {
-	int ret;
+	int ret = 0;
 
-	ret = vcpu_load(vcpu);
-	if (ret)
-		return ret;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 
 	switch (mp_state->mp_state) {
 	case KVM_MP_STATE_RUNNABLE:
@@ -416,7 +412,7 @@ int kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 		ret = -EINVAL;
 	}
 
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	return ret;
 }
 
@@ -1009,9 +1005,8 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 	struct kvm_device_attr attr;
 	long r;
 
-	r = vcpu_load(vcpu);
-	if (r)
-		return r;
+	if (mutex_lock_killable(&vcpu->mutex))
+		return -EINTR;
 
 	switch (ioctl) {
 	case KVM_ARM_VCPU_INIT: {
@@ -1089,7 +1084,7 @@ long kvm_arch_vcpu_ioctl(struct file *filp,
 		r = -EINVAL;
 	}
 
-	vcpu_put(vcpu);
+	mutex_unlock(&vcpu->mutex);
 	return r;
 }
 
-- 
2.14.2
