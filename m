From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 1/6] KVM: s390: take care of clock-comparator sign control
Date: Wed,  7 Feb 2018 12:46:42 +0100
Message-ID: <20180207114647.6220-2-david@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180207114647.6220-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Missed when enabling the Multiple-epoch facility. If the facility is
installed and the control is set, a sign based comaprison has to be
performed.

Right now we would inject wrong interrupts and ignore interrupt
conditions. Also the sleep time is calculated in a wrong way.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/interrupt.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
index 3ea9cfa31b16..a616e9b65f91 100644
--- a/arch/s390/kvm/interrupt.c
+++ b/arch/s390/kvm/interrupt.c
@@ -169,8 +169,15 @@ static int ckc_interrupts_enabled(struct kvm_vcpu *vcpu)
 
 static int ckc_irq_pending(struct kvm_vcpu *vcpu)
 {
-	if (vcpu->arch.sie_block->ckc >= kvm_s390_get_tod_clock_fast(vcpu->kvm))
+	const u64 now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
+	const u64 ckc = vcpu->arch.sie_block->ckc;
+
+	if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
+		if ((s64)ckc >= (s64)now)
+			return 0;
+	} else if (ckc >= now) {
 		return 0;
+	}
 	return ckc_interrupts_enabled(vcpu);
 }
 
@@ -1042,13 +1049,19 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 
 static u64 __calculate_sltime(struct kvm_vcpu *vcpu)
 {
-	u64 now, cputm, sltime = 0;
+	const u64 now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
+	const u64 ckc = vcpu->arch.sie_block->ckc;
+	u64 cputm, sltime = 0;
 
 	if (ckc_interrupts_enabled(vcpu)) {
-		now = kvm_s390_get_tod_clock_fast(vcpu->kvm);
-		sltime = tod_to_ns(vcpu->arch.sie_block->ckc - now);
-		/* already expired or overflow? */
-		if (!sltime || vcpu->arch.sie_block->ckc <= now)
+		if (vcpu->arch.sie_block->gcr[0] & 0x0020000000000000ul) {
+			if ((s64)now < (s64)ckc)
+				sltime = tod_to_ns((s64)ckc - (s64)now);
+		} else if (now < ckc) {
+			sltime = tod_to_ns(ckc - now);
+		}
+		/* already expired */
+		if (!sltime)
 			return 0;
 		if (cpu_timer_interrupts_enabled(vcpu)) {
 			cputm = kvm_s390_get_cpu_timer(vcpu);
-- 
2.14.3
