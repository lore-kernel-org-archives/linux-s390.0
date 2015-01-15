From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 05/21] KVM: s390: prevent sleep duration underflows in handle_wait()
Date: Thu, 15 Jan 2015 14:43:18 +0100
Message-ID: <1421329414-76826-6-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

We sometimes get an underflow for the sleep duration, which most
likely won't result in the short sleep time we wanted.

So let's check for sleep duration underflows and directly continue
to run the guest if we get one.

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/interrupt.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index a845e35..5744303 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -804,14 +804,20 @@ int kvm_s390_handle_wait(struct kvm_vcpu *vcpu)
 		return -EOPNOTSUPP; /* disabled wait */
 	}
 
-	__set_cpu_idle(vcpu);
 	if (!ckc_interrupts_enabled(vcpu)) {
 		VCPU_EVENT(vcpu, 3, "%s", "enabled wait w/o timer");
+		__set_cpu_idle(vcpu);
 		goto no_timer;
 	}
 
 	now = get_tod_clock_fast() + vcpu->arch.sie_block->epoch;
 	sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
+
+	/* underflow */
+	if (vcpu->arch.sie_block->ckc < now)
+		return 0;
+
+	__set_cpu_idle(vcpu);
 	hrtimer_start(&vcpu->arch.ckc_timer, ktime_set (0, sltime) , HRTIMER_MODE_REL);
 	VCPU_EVENT(vcpu, 5, "enabled wait via clock comparator: %llx ns", sltime);
 no_timer:
-- 
1.9.3
