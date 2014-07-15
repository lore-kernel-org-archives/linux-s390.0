From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 1/5] KVM: s390: allow only one SIGP STOP (AND STORE STATUS) at a time
Date: Tue, 15 Jul 2014 15:27:51 +0200
Message-ID: <1405430875-40722-2-git-send-email-borntraeger@de.ibm.com>
References: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1405430875-40722-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Graf <agraf@suse.de>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

A SIGP STOP (AND STORE STATUS) order is complete as soon as the VCPU has been
stopped. This patch makes sure that only one SIGP STOP (AND STORE STATUS) may
be pending at a time (as defined by the architecture). If the action_bits are
still set, a SIGP STOP has been issued but not completed yet. The VCPU is busy
for further SIGP STOP orders.

Also set the CPUSTAT_STOP_INT after the action_bits variable has been modified
(the same order that is used when injecting a KVM_S390_SIGP_STOP from
userspace).

Both changes are needed in preparation for a user space driven VCPU state change
(to avoid race conditions).

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/sigp.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 43079a4..fd7fb5c 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -136,6 +136,11 @@ static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
 	inti->type = KVM_S390_SIGP_STOP;
 
 	spin_lock_bh(&li->lock);
+	if (li->action_bits & ACTION_STOP_ON_STOP) {
+		/* another SIGP STOP is pending */
+		rc = SIGP_CC_BUSY;
+		goto out;
+	}
 	if ((atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
 		kfree(inti);
 		if ((action & ACTION_STORE_ON_STOP) != 0)
@@ -144,8 +149,8 @@ static int __inject_sigp_stop(struct kvm_s390_local_interrupt *li, int action)
 	}
 	list_add_tail(&inti->list, &li->list);
 	atomic_set(&li->active, 1);
-	atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
 	li->action_bits |= action;
+	atomic_set_mask(CPUSTAT_STOP_INT, li->cpuflags);
 	if (waitqueue_active(li->wq))
 		wake_up_interruptible(li->wq);
 out:
-- 
1.8.4.2
