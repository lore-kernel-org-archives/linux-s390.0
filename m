From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCHv2/RFC] kvm/irqchip: Speed up KVM_SET_GSI_ROUTING
Date: Thu, 16 Jan 2014 13:44:20 +0100
Message-ID: <1389876260-46636-1-git-send-email-borntraeger@de.ibm.com>
References: <52D7C186.1070700@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <52D7C186.1070700@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Gleb Natapov <gleb@minantech.com>, Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, agraf@suse.de, mst@redhat.com, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When starting lots of dataplane devices the bootup takes very long on my
s390 system(prototype irqfd code). With larger setups we are even able
to
trigger some timeouts in some components.
Turns out that the KVM_SET_GSI_ROUTING ioctl takes very
long (strace claims up to 0.1 sec) when having multiple CPUs.
This is caused by the  synchronize_rcu and the HZ=100 of s390.
By changing the code to use a private srcu we can speed things up.

This patch reduces the boot time till mounting root from 8 to 2
seconds on my s390 guest with 100 disks.

I converted most of the rcu routines to srcu. Review for the unconverted
use of hlist_for_each_entry_rcu, hlist_add_head_rcu, hlist_del_init_rcu
is necessary, though. They look fine to me since they are protected by
outer functions.

In addition, we should also discuss if a global srcu (for all guests) is
fine.

Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 virt/kvm/irqchip.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/irqchip.c b/virt/kvm/irqchip.c
index 20dc9e4..5283eb8 100644
--- a/virt/kvm/irqchip.c
+++ b/virt/kvm/irqchip.c
@@ -26,17 +26,20 @@
 
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
@@ -45,7 +48,7 @@ bool kvm_irq_has_notifier(struct kvm *kvm, unsigned irqchip, unsigned pin)
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
