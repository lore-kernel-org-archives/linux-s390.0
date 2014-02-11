From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 3/3] s390/kvm: Set preempted flag during vcpu wakeup and interrupt delivery
Date: Tue, 11 Feb 2014 12:45:32 +0100
Message-ID: <1392119132-50182-4-git-send-email-borntraeger@de.ibm.com>
References: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1392119132-50182-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Michael Mueller <mimu@linux.vnet.ibm.com>

Commit "kvm: Record the preemption status of vcpus using preempt notifiers"
caused a performance regression on s390. It turned out that in the case that
if a former sleeping cpu, that was woken up, this cpu is not a yield candidate
since it gave up the cpu voluntarily. To retain this candiate its preempted
flag is set during wakeup and interrupt delivery time.

This and commit "s390/kvm: Platform specific kvm_arch_vcpu_dont_yield" have to
be applied both in order to recover the performance regression.

Significant performance measurement work and code analysis to solve this
issue was provided by Mao Chuan Li and his team in Beijing.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 1848080..fff070b 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -505,6 +505,7 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
 	struct kvm_vcpu *vcpu;
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.ckc_timer);
+	vcpu->preempted = true;
 	tasklet_schedule(&vcpu->arch.tasklet);
 
 	return HRTIMER_NORESTART;
@@ -732,6 +733,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	if (waitqueue_active(li->wq))
 		wake_up_interruptible(li->wq);
+	kvm_get_vcpu(kvm, sigcpu)->preempted = true;
 	spin_unlock_bh(&li->lock);
 unlock_fi:
 	spin_unlock(&fi->lock);
@@ -877,6 +879,7 @@ int kvm_s390_inject_vcpu(struct kvm_vcpu *vcpu,
 	atomic_set_mask(CPUSTAT_EXT_INT, li->cpuflags);
 	if (waitqueue_active(&vcpu->wq))
 		wake_up_interruptible(&vcpu->wq);
+	vcpu->preempted = true;
 	spin_unlock_bh(&li->lock);
 	mutex_unlock(&vcpu->kvm->lock);
 	return 0;
-- 
1.8.4.2
