From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv2] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Mon, 24 Feb 2014 12:58:46 +0100
Message-ID: <1393243126-27376-1-git-send-email-borntraeger@de.ibm.com>
References: <53078E75.2040603@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <53078E75.2040603@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gleb Natapov <gleb@minantech.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Alexander Graf <agraf@suse.de>, "Michael S. Tsirkin" <mst@redhat.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When starting lots of dataplane devices the bootup takes very long on my
s390 system(prototype irqfd code). With larger setups we are even able
to trigger some timeouts in some userspace components.
Turns out that the KVM_SET_GSI_ROUTING ioctl takes very
long (strace claims up to 0.1 sec) when having multiple CPUs.
This is caused by the  synchronize_rcu and the HZ=100 of s390.
By changing the code to use a private srcu we can speed things up.

This patch reduces the boot time till mounting root from 8 to 2
seconds on my s390 guest with 100 disks.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>

---
v1-v2: Fix missing hunk in kvm_irq_has_notifier. This was unnoticed on
       s390, as our code did not use it.
---
 virt/kvm/irqchip.c | 33 ++++++++++++++++++---------------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 20dc9e4..7598f5a 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -26,26 +26,29 @@
 
 #include <linux/kvm_host.h>
 #include <linux/slab.h>
+#include <linux/srcu.h>
 #include <linux/export.h>
 #include <trace/events/kvm.h>
 #include "irq.h"
 
+DEFINE_STATIC_SRCU(irq_srcu);
+
 bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin)
 {
 	struct kvm_irq_ack_notifier *kian;
-	int gsi;
+	int gsi, idx;
 
-	rcu_read_lock();
-	gsi = rcu_dereference(kvm->irq_routing)->chip[irqchip][pin];
+	idx = srcu_read_lock(&irq_srcu);
+	gsi = srcu_dereference(kvm->irq_routing, &irq_srcu)->chip[irqchip][pin];
 	if (gsi != -1)
 		hlist_for_each_entry_rcu(kian, &kvm->irq_ack_notifier_list,
 					 link)
 			if (kian->gsi == gsi) {
-				rcu_read_unlock();
+				srcu_read_unlock(&irq_srcu, idx);
 				return true;
 			}
 
-	rcu_read_unlock();
+	srcu_read_unlock(&irq_srcu, idx);
 
 	return false;
 }
@@ -54,18 +57,18 @@ EXPORT_SYMBOL_GPL(kvm_irq_has_notifier);
 void kvm_notify_acked_irq(struct kvm *kvm, unsigned irqchip, unsigned pin)
 {
 	struct kvm_irq_ack_notifier *kian;
-	int gsi;
+	int gsi, idx;
 
 	trace_kvm_ack_irq(irqchip, pin);
 
-	rcu_read_lock();
-	gsi = rcu_dereference(kvm->irq_routing)->chip[irqchip][pin];
+	idx = srcu_read_lock(&irq_srcu);
+	gsi = srcu_dereference(kvm->irq_routing, &irq_srcu)->chip[irqchip][pin];
 	if (gsi != -1)
 		hlist_for_each_entry_rcu(kian, &kvm->irq_ack_notifier_list,
 					 link)
 			if (kian->gsi == gsi)
 				kian->irq_acked(kian);
-	rcu_read_unlock();
+	srcu_read_unlock(&irq_srcu, idx);
 }
 
 void kvm_register_irq_ack_notifier(struct kvm *kvm,
@@ -85,7 +88,7 @@ void kvm_unregister_irq_ack_notifier(struct kvm *kvm,
 	mutex_lock(&kvm->irq_lock);
 	hlist_del_init_rcu(&kian->link);
 	mutex_unlock(&kvm->irq_lock);
-	synchronize_rcu();
+	synchronize_srcu_expedited(&irq_srcu);
 #ifdef __KVM_HAVE_IOAPIC
 	kvm_vcpu_request_scan_ioapic(kvm);
 #endif
@@ -115,7 +118,7 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
 		bool line_status)
 {
 	struct kvm_kernel_irq_routing_entry *e, irq_set[KVM_NR_IRQCHIPS];
-	int ret = -1, i = 0;
+	int ret = -1, i = 0, idx;
 	struct kvm_irq_routing_table *irq_rt;
 
 	trace_kvm_set_irq(irq, level, irq_source_id);
@@ -124,12 +127,12 @@ int kvm_set_irq(struct kvm *kvm, int irq_source_id, u32 irq, int level,
 	 * IOAPIC.  So set the bit in both. The guest will ignore
 	 * writes to the unused one.
 	 */
-	rcu_read_lock();
-	irq_rt = rcu_dereference(kvm->irq_routing);
+	idx = srcu_read_lock(&irq_srcu);
+	irq_rt = srcu_dereference(kvm->irq_routing, &irq_srcu);
 	if (irq < irq_rt->nr_rt_entries)
 		hlist_for_each_entry(e, &irq_rt->map[irq], link)
 			irq_set[i++] = *e;
-	rcu_read_unlock();
+	srcu_read_unlock(&irq_srcu, idx);
 
 	while(i--) {
 		int r;
@@ -226,7 +229,7 @@ int kvm_set_irq_routing(struct kvm *kvm,
 	kvm_irq_routing_update(kvm, new);
 	mutex_unlock(&kvm->irq_lock);
 
-	synchronize_rcu();
+	synchronize_srcu_expedited(&irq_srcu);
 
 	new = old;
 	r = 0;
-- 
1.8.4.2
