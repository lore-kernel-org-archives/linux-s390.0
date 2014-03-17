From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH v2 5/5] KVM: Bump KVM_MAX_IRQ_ROUTES for s390
Date: Mon, 17 Mar 2014 19:11:39 +0100
Message-ID: <1395079899-29239-6-git-send-email-cornelia.huck@de.ibm.com>
References: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1395079899-29239-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Cc: borntraeger@de.ibm.com, agraf@suse.de, pbonzini@redhat.com, gleb@kernel.org, Cornelia Huck <cornelia.huck@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The maximum number for irq routes is currently 1024, which is a bit on
the small size for s390: We support up to 4 x 64k virtual devices with
up to 64 queues, and we need one route for each of the queues if we want
to operate it via irqfd.

Let's bump this to 4k on s390 for now, as this at least covers the saner
setups.

We need to find a more general solution, though, as we can't just grow
the routing table indefinitly.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 include/linux/kvm_host.h |    4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index da7510b..7d21cf9 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -922,7 +922,11 @@ static inline int mmu_notifier_retry(struct kvm *kvm, unsigned long mmu_seq)
 
 #ifdef CONFIG_HAVE_KVM_IRQ_ROUTING
 
+#ifdef CONFIG_S390
+#define KVM_MAX_IRQ_ROUTES 4096 //FIXME: we can have more than that...
+#else
 #define KVM_MAX_IRQ_ROUTES 1024
+#endif
 
 int kvm_setup_default_irq_routing(struct kvm *kvm);
 int kvm_set_irq_routing(struct kvm *kvm,
-- 
1.7.9.5
