From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 08/10] KVM: s390: switch to get_tod_clock() and fix STP sync races
Date: Tue, 13 Oct 2015 16:06:06 +0200
Message-ID: <1444745168-21479-9-git-send-email-borntraeger@de.ibm.com>
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

Nobody except early.c makes use of store_tod_clock() to handle the
cc. So if we would get a cc != 0, we would be in more trouble.

Let's replace all users with get_tod_clock(). Returning a cc
on an ioctl sounded strange either way.

We can now also easily move the get_tod_clock() call into the
preempt_disable() section. This is in fact necessary to make the
STP sync work as expected. Otherwise the host TOD could change
and we would end up with a wrong epoch calculation.

Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 18 ++++--------------
 arch/s390/kvm/priv.c     |  8 ++------
 2 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0a67c40..a090779 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -523,19 +523,14 @@ static int kvm_s390_set_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 {
 	struct kvm_vcpu *cur_vcpu;
 	unsigned int vcpu_idx;
-	u64 host_tod, gtod;
-	int r;
+	u64 gtod;
 
 	if (copy_from_user(&gtod, (void __user *)attr->addr, sizeof(gtod)))
 		return -EFAULT;
 
-	r = store_tod_clock(&host_tod);
-	if (r)
-		return r;
-
 	mutex_lock(&kvm->lock);
 	preempt_disable();
-	kvm->arch.epoch = gtod - host_tod;
+	kvm->arch.epoch = gtod - get_tod_clock();
 	kvm_s390_vcpu_block_all(kvm);
 	kvm_for_each_vcpu(vcpu_idx, cur_vcpu, kvm)
 		cur_vcpu->arch.sie_block->epoch = kvm->arch.epoch;
@@ -581,15 +576,10 @@ static int kvm_s390_get_tod_high(struct kvm *kvm, struct kvm_device_attr *attr)
 
 static int kvm_s390_get_tod_low(struct kvm *kvm, struct kvm_device_attr *attr)
 {
-	u64 host_tod, gtod;
-	int r;
-
-	r = store_tod_clock(&host_tod);
-	if (r)
-		return r;
+	u64 gtod;
 
 	preempt_disable();
-	gtod = host_tod + kvm->arch.epoch;
+	gtod = get_tod_clock() + kvm->arch.epoch;
 	preempt_enable();
 	if (copy_to_user((void __user *)attr->addr, &gtod, sizeof(gtod)))
 		return -EFAULT;
diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
index 4d21dc4..b253de5 100644
--- a/arch/s390/kvm/priv.c
+++ b/arch/s390/kvm/priv.c
@@ -34,7 +34,7 @@
 static int handle_set_clock(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *cpup;
-	s64 hostclk, val;
+	s64 val;
 	int i, rc;
 	ar_t ar;
 	u64 op2;
@@ -49,15 +49,11 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
 	if (rc)
 		return kvm_s390_inject_prog_cond(vcpu, rc);
 
-	if (store_tod_clock(&hostclk)) {
-		kvm_s390_set_psw_cc(vcpu, 3);
-		return 0;
-	}
 	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", val);
-	val = (val - hostclk) & ~0x3fUL;
 
 	mutex_lock(&vcpu->kvm->lock);
 	preempt_disable();
+	val = (val - get_tod_clock()) & ~0x3fUL;
 	kvm_for_each_vcpu(i, cpup, vcpu->kvm)
 		cpup->arch.sie_block->epoch = val;
 	preempt_enable();
-- 
2.4.3
