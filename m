From: Christoffer Dall <cdall@kernel.org>
Subject: [PATCH v3 02/16] KVM: Prepare for moving vcpu_load/vcpu_put into arch
 specific code
Date: Mon,  4 Dec 2017 21:35:24 +0100
Message-ID: <20171204203538.8370-3-cdall@kernel.org>
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

In preparation for moving calls to vcpu_load() and vcpu_put() into the
architecture specific implementations of the KVM vcpu ioctls, move the
calls in the main kvm_vcpu_ioctl() dispatcher function to each case
of the ioctl select statement.  This allows us to move the vcpu_load()
and vcpu_put() calls into architecture specific implementations of vcpu
ioctls, one by one.

Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 virt/kvm/kvm_main.c | 26 ++++++++++++++++++++++++--
 1 file changed, 24 insertions(+), 2 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 39961fb8aef7..480b16c48f6b 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2525,13 +2525,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
 
 	if (mutex_lock_killable(&vcpu->mutex))
 		return -EINTR;
-	vcpu_load(vcpu);
 	switch (ioctl) {
 	case KVM_RUN: {
 		struct pid *oldpid;
 		r = -EINVAL;
 		if (arg)
 			goto out;
+		vcpu_load(vcpu);
 		oldpid = rcu_access_pointer(vcpu->pid);
 		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
 			/* The thread running this VCPU changed. */
@@ -2543,6 +2543,7 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			put_pid(oldpid);
 		}
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
+		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
 		break;
 	}
@@ -2553,7 +2554,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		kvm_regs = kzalloc(sizeof(struct kvm_regs), GFP_KERNEL);
 		if (!kvm_regs)
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_regs(vcpu, kvm_regs);
+		vcpu_put(vcpu);
 		if (r)
 			goto out_free1;
 		r = -EFAULT;
@@ -2573,7 +2576,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			r = PTR_ERR(kvm_regs);
 			goto out;
 		}
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_regs(vcpu, kvm_regs);
+		vcpu_put(vcpu);
 		kfree(kvm_regs);
 		break;
 	}
@@ -2582,7 +2587,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!kvm_sregs)
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_sregs(vcpu, kvm_sregs);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2598,13 +2605,17 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			kvm_sregs = NULL;
 			goto out;
 		}
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_sregs(vcpu, kvm_sregs);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_GET_MP_STATE: {
 		struct kvm_mp_state mp_state;
 
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_mpstate(vcpu, &mp_state);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2619,7 +2630,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&mp_state, argp, sizeof(mp_state)))
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_mpstate(vcpu, &mp_state);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_TRANSLATE: {
@@ -2628,7 +2641,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&tr, argp, sizeof(tr)))
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_translate(vcpu, &tr);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2643,7 +2658,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&dbg, argp, sizeof(dbg)))
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_guest_debug(vcpu, &dbg);
+		vcpu_put(vcpu);
 		break;
 	}
 	case KVM_SET_SIGNAL_MASK: {
@@ -2674,7 +2691,9 @@ static long kvm_vcpu_ioctl(struct file *filp,
 		r = -ENOMEM;
 		if (!fpu)
 			goto out;
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_get_fpu(vcpu, fpu);
+		vcpu_put(vcpu);
 		if (r)
 			goto out;
 		r = -EFAULT;
@@ -2690,14 +2709,17 @@ static long kvm_vcpu_ioctl(struct file *filp,
 			fpu = NULL;
 			goto out;
 		}
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl_set_fpu(vcpu, fpu);
+		vcpu_put(vcpu);
 		break;
 	}
 	default:
+		vcpu_load(vcpu);
 		r = kvm_arch_vcpu_ioctl(filp, ioctl, arg);
+		vcpu_put(vcpu);
 	}
 out:
-	vcpu_put(vcpu);
 	mutex_unlock(&vcpu->mutex);
 	kfree(fpu);
 	kfree(kvm_sregs);
-- 
2.14.2
