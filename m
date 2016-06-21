From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [GIT PULL 01/51] s390/kvm: page table invalidation notifier
Date: Tue, 21 Jun 2016 15:12:39 +0200
Message-ID: <1466514809-146638-2-git-send-email-borntraeger@de.ibm.com>
References: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1466514809-146638-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Pass an address range to the page table invalidation notifier
for KVM. This allows to notify changes that affect a larger
virtual memory area, e.g. for 1MB pages.

Reviewed-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/gmap.h |  3 ++-
 arch/s390/kvm/kvm-s390.c     | 18 +++++++++++++-----
 arch/s390/mm/gmap.c          | 19 ++++++++++++++++---
 3 files changed, 31 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index d054c1b..bc0eadf 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -39,7 +39,8 @@ struct gmap {
  */
 struct gmap_notifier {
 	struct list_head list;
-	void (*notifier_call)(struct gmap *gmap, unsigned long gaddr);
+	void (*notifier_call)(struct gmap *gmap, unsigned long start,
+			      unsigned long end);
 };
 
 struct gmap *gmap_alloc(struct mm_struct *mm, unsigned long limit);
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 0dcf9b8..67f1b6b 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -150,7 +150,8 @@ int kvm_arch_hardware_enable(void)
 	return 0;
 }
 
-static void kvm_gmap_notifier(struct gmap *gmap, unsigned long address);
+static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
+			      unsigned long end);
 
 /*
  * This callback is executed during stop_machine(). All CPUs are therefore
@@ -1976,16 +1977,23 @@ void kvm_s390_sync_request(int req, struct kvm_vcpu *vcpu)
 	kvm_s390_vcpu_request(vcpu);
 }
 
-static void kvm_gmap_notifier(struct gmap *gmap, unsigned long address)
+static void kvm_gmap_notifier(struct gmap *gmap, unsigned long start,
+			      unsigned long end)
 {
-	int i;
 	struct kvm *kvm = gmap->private;
 	struct kvm_vcpu *vcpu;
+	unsigned long prefix;
+	int i;
 
+	if (start >= 1UL << 31)
+		/* We are only interested in prefix pages */
+		return;
 	kvm_for_each_vcpu(i, vcpu, kvm) {
 		/* match against both prefix pages */
-		if (kvm_s390_get_prefix(vcpu) == (address & ~0x1000UL)) {
-			VCPU_EVENT(vcpu, 2, "gmap notifier for %lx", address);
+		prefix = kvm_s390_get_prefix(vcpu);
+		if (prefix <= end && start <= prefix + 2*PAGE_SIZE - 1) {
+			VCPU_EVENT(vcpu, 2, "gmap notifier for %lx-%lx",
+				   start, end);
 			kvm_s390_sync_request(KVM_REQ_MMU_RELOAD, vcpu);
 		}
 	}
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index cace818..b5820bf 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -573,6 +573,21 @@ void gmap_unregister_ipte_notifier(struct gmap_notifier *nb)
 EXPORT_SYMBOL_GPL(gmap_unregister_ipte_notifier);
 
 /**
+ * gmap_call_notifier - call all registered invalidation callbacks
+ * @gmap: pointer to guest mapping meta data structure
+ * @start: start virtual address in the guest address space
+ * @end: end virtual address in the guest address space
+ */
+static void gmap_call_notifier(struct gmap *gmap, unsigned long start,
+			       unsigned long end)
+{
+	struct gmap_notifier *nb;
+
+	list_for_each_entry(nb, &gmap_notifier_list, list)
+		nb->notifier_call(gmap, start, end);
+}
+
+/**
  * gmap_ipte_notify - mark a range of ptes for invalidation notification
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
@@ -643,7 +658,6 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr, pte_t *pte)
 {
 	unsigned long offset, gaddr;
 	unsigned long *table;
-	struct gmap_notifier *nb;
 	struct gmap *gmap;
 
 	offset = ((unsigned long) pte) & (255 * sizeof(pte_t));
@@ -655,8 +669,7 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr, pte_t *pte)
 		if (!table)
 			continue;
 		gaddr = __gmap_segment_gaddr(table) + offset;
-		list_for_each_entry(nb, &gmap_notifier_list, list)
-			nb->notifier_call(gmap, gaddr);
+		gmap_call_notifier(gmap, gaddr, gaddr + PAGE_SIZE - 1);
 	}
 	spin_unlock(&gmap_notifier_lock);
 }
-- 
2.5.5
