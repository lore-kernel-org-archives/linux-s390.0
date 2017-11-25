From: Christoffer Dall <christoffer.dall@linaro.org>
Subject: [PATCH 02/15] KVM: Factor out vcpu->pid adjustment for KVM_RUN
Date: Sat, 25 Nov 2017 21:57:05 +0100
Message-ID: <20171125205718.7731-3-christoffer.dall@linaro.org>
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

Every time userspace calls KVM_RUM, we check if another thread started
running the VCPU, and in that case, we adjust the vcpu->pid field to the
new thread.

We obviously only want to perform this logic once we hold the
vcpu->mutex and are actually going to run the VCPU.  As we are about to
move the vcpu_load() call into the architecture-specific implementation
of the ioctl, we first factor the pid adjustment logic out in its own
function which each architecture can call later on.

Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>
---
 include/linux/kvm_host.h |  2 ++
 virt/kvm/kvm_main.c      | 28 +++++++++++++++++-----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6882538eda32..739a2f8e74c5 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -536,6 +536,8 @@ void kvm_vcpu_uninit(struct kvm_vcpu *vcpu);
 int __must_check vcpu_load(struct kvm_vcpu *vcpu);
 void vcpu_put(struct kvm_vcpu *vcpu);
 
+void kvm_vcpu_run_adjust_pid(struct kvm_vcpu *vcpu);
+
 #ifdef __KVM_HAVE_IOAPIC
 void kvm_arch_post_irq_ack_notifier_list_update(struct kvm *kvm);
 void kvm_arch_post_irq_routing_update(struct kvm *kvm);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index fafafcc38b5a..c9549d44c489 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2504,6 +2504,22 @@ static int kvm_vcpu_ioctl_set_sigmask(struct kvm_vcpu *vcpu, sigset_t *sigset)
 	return 0;
 }
 
+void kvm_vcpu_run_adjust_pid(struct kvm_vcpu *vcpu)
+{
+	struct pid *oldpid;
+
+	oldpid = rcu_access_pointer(vcpu->pid);
+	if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
+		/* The thread running this VCPU changed. */
+		struct pid *newpid = get_task_pid(current, PIDTYPE_PID);
+
+		rcu_assign_pointer(vcpu->pid, newpid);
+		if (oldpid)
+			synchronize_rcu();
+		put_pid(oldpid);
+	}
+}
+
 static long kvm_vcpu_ioctl(struct file *filp,
 			   unsigned int ioctl, unsigned long arg)
 {
@@ -2530,23 +2546,13 @@ static long kvm_vcpu_ioctl(struct file *filp,
 
 	switch (ioctl) {
 	case KVM_RUN: {
-		struct pid *oldpid;
 		r = -EINVAL;
 		if (arg)
 			goto out;
 		r = vcpu_load(vcpu);
 		if (r)
 			goto out;
-		oldpid = rcu_access_pointer(vcpu->pid);
-		if (unlikely(oldpid != current->pids[PIDTYPE_PID].pid)) {
-			/* The thread running this VCPU changed. */
-			struct pid *newpid = get_task_pid(current, PIDTYPE_PID);
-
-			rcu_assign_pointer(vcpu->pid, newpid);
-			if (oldpid)
-				synchronize_rcu();
-			put_pid(oldpid);
-		}
+		kvm_vcpu_run_adjust_pid(vcpu);
 		r = kvm_arch_vcpu_ioctl_run(vcpu, vcpu->run);
 		vcpu_put(vcpu);
 		trace_kvm_userspace_exit(vcpu->run->exit_reason, r);
-- 
2.14.2
