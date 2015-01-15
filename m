From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 06/21] KVM: s390: base hrtimer on a monotonic clock
Date: Thu, 15 Jan 2015 14:43:19 +0100
Message-ID: <1421329414-76826-7-git-send-email-borntraeger@de.ibm.com>
References: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <stable-owner@vger.kernel.org>
In-Reply-To: <1421329414-76826-1-git-send-email-borntraeger@de.ibm.com>
Sender: stable-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, David Hildenbrand <dahi@linux.vnet.ibm.com>, stable@vger.kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

The hrtimer that handles the wait with enabled timer interrupts
should not be disturbed by changes of the host time.

This patch changes our hrtimer to be based on a monotonic clock.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Acked-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: stable@vger.kernel.org
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/kvm/kvm-s390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 14cdf1c..37ef06c 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -735,7 +735,7 @@ int kvm_arch_vcpu_setup(struct kvm_vcpu *vcpu)
 		if (rc)
 			return rc;
 	}
-	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_REALTIME, HRTIMER_MODE_ABS);
+	hrtimer_init(&vcpu->arch.ckc_timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	vcpu->arch.ckc_timer.function = kvm_s390_idle_wakeup;
 	get_cpu_id(&vcpu->arch.cpu_id);
 	vcpu->arch.cpu_id.version = 0xff;
-- 
1.9.3
