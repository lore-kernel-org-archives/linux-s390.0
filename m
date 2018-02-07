From: David Hildenbrand <david@redhat.com>
Subject: [PATCH RFC 4/6] KVM: s390: consider epoch index on TOD clock syncs
Date: Wed,  7 Feb 2018 12:46:45 +0100
Message-ID: <20180207114647.6220-5-david@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180207114647.6220-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

For now, we don't take care of over/underflows. Especially underflows
are critical:

Assume the epoch is currently 0 and we get a sync request for delta=1,
meaning the TOD is moved forward by 1 and we have to fix it up by
subtracting 1 from the epoch. Right now, this will leave the epoch
index untouched, resulting in epoch=-1, epoch_idx=0, which is wrong.

We have to take care of over and underflows, also for the VSIE case. So
let's factor out calculation into a separate function.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kvm/kvm-s390.c | 32 +++++++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index d007b737cd4d..c2b62379049e 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -179,6 +179,28 @@ int kvm_arch_hardware_enable(void)
 static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
 			      unsigned long end);
 
+static void kvm_clock_sync_scb(struct kvm_s390_sie_block *scb, u64 delta)
+{
+	u64 delta_idx = 0;
+
+	/*
+	 * The TOD jumps by delta, we have to compensate this by adding
+	 * -delta to the epoch.
+	 */
+	delta = -delta;
+
+	/* sign-extension - we're adding to signed values below */
+	if ((s64)delta < 0)
+		delta_idx = 0xff;
+
+	scb->epoch += delta;
+	if (scb->ecd & ECD_MEF) {
+		scb->epdx += delta_idx;
+		if (scb->epoch < delta)
+			scb->epdx += 1;
+	}
+}
+
 /*
  * This callback is executed during stop_machine(). All CPUs are therefore
  * temporarily stopped. In order not to change guest behavior, we have to
@@ -194,13 +216,17 @@ static int kvm_clock_sync(struct notifier_block *notifier, unsigned long val,
 	unsigned long long *delta = v;
 
 	list_for_each_entry(kvm, &vm_list, vm_list) {
-		kvm->arch.epoch -= *delta;
 		kvm_for_each_vcpu(i, vcpu, kvm) {
-			vcpu->arch.sie_block->epoch -= *delta;
+			kvm_clock_sync_scb(vcpu->arch.sie_block, *delta);
+			if (i == 0) {
+				kvm->arch.epoch = vcpu->arch.sie_block->epoch;
+				kvm->arch.epdx = vcpu->arch.sie_block->epdx;
+			}
 			if (vcpu->arch.cputm_enabled)
 				vcpu->arch.cputm_start += *delta;
 			if (vcpu->arch.vsie_block)
-				vcpu->arch.vsie_block->epoch -= *delta;
+				kvm_clock_sync_scb(vcpu->arch.vsie_block,
+						   *delta);
 		}
 	}
 	return NOTIFY_OK;
-- 
2.14.3
