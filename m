From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 10/10] KVM: s390: factor out reading of the guest TOD clock
Date: Tue, 13 Oct 2015 16:06:08 +0200
Message-ID: <1444745168-21479-11-git-send-email-borntraeger@de.ibm.com>
References: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1444745168-21479-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Let's factor this out and always use get_tod_clock_fast() when
reading the guest TOD.

STORE CLOCK FAST does not do serialization and, therefore, might
result in some fuzziness between different processors in a way
that subsequent calls on different CPUs might have time stamps that
are earlier. This semantics is fine though for all KVM use cases.
To make it obvious that the new function has STORE CLOCK FAST
semantics we name it kvm_s390_get_tod_clock_fast.

With this patch, we only have a handful of places were we
have to care about STP sync (using preempt_disable() logic).

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 15 +++------------
 arch/s390/kvm/kvm-s390.c  |  4 +---
 arch/s390/kvm/kvm-s390.h  | 10 ++++++++++
 3 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a8be542..373e323 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -69,13 +69,8 @@ static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
 
 static int ckc_irq_pending(struct kvm_vcpu *vcpu)
 {
-	preempt_disable();
-	if (!(vcpu->arch.sie_block->ckc <
-	      get_tod_clock_fast() + vcpu->arch.sie_block->epoch)) {
-		preempt_enable();
+	if (vcpu->arch.sie_block->ckc >= kvm_s390_get_tod_clock_fast(vcpu->kvm))
 		return 0;
-	}
-	preempt_enable();
 	return ckc_interrupts_enabled(vcpu);
 }
 
@@ -851,9 +846,7 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 		goto no_timer;
 	}
 
-	preempt_disable();
-	now = get_tod_clock_fast() + vcpu->arch.sie_block->epoch;
-	preempt_enable();
+	now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
 	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
 
 	/* underflow */
@@ -892,9 +885,7 @@ enum hrtimer_restart kvm_s390_idle_wakeup(struct hrtimer *timer)
 	u64 now, sltime;
 
 	vcpu = container_of(timer, struct kvm_vcpu, arch.ckc_timer);
-	preempt_disable();
-	now = get_tod_clock_fast() + vcpu->arch.sie_block->epoch;
-	preempt_enable();
+	now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
 	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
 
 	/*
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 87bd602..618c854 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -568,9 +568,7 @@ static int kvm_s390_get_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	u64 gtod;
 
-	preempt_disable();
-	gtod = get_tod_clock() + kvm->arch.epoch;
-	preempt_enable();
+	gtod = kvm_s390_get_tod_clock_fast(kvm);
 	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
 		return -EFAULT;
 	VM_EVENT(kvm, 3, "QUERY: TOD base: 0x%llx\n", gtod);
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index cc15ea3..1e70e00 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -271,6 +271,16 @@ static inline void kvm_s390_vcpu_unblock_all(struct kvm *kvm)
 		kvm_s390_vcpu_unblock(vcpu);
 }
 
+static inline u64 kvm_s390_get_tod_clock_fast(struct kvm *kvm)
+{
+	u64 rc;
+
+	preempt_disable();
+	rc = get_tod_clock_fast() + kvm->arch.epoch;
+	preempt_enable();
+	return rc;
+}
+
 /**
  * kvm_s390_inject_prog_cond - conditionally inject a program check
  * @vcpu: virtual cpu
-- 
2.4.3
