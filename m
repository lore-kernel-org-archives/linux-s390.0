From: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
Date: Mon, 30 Apr 2018 16:33:24 +0000
Subject: [PATCH v5 1/2] KVM: s390: a utility function for migration
Message-Id: <1525106005-13931-2-git-send-email-imbrenda@linux.vnet.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Introduce a utility function that will be used later on for storage
attributes migration, and use it in kvm_main.c to replace existing code
that does the same thing.

Signed-off-by: Claudio Imbrenda <imbrenda@linux.vnet.ibm.com>
---
 include/linux/kvm_host.h | 7 +++++++
 virt/kvm/kvm_main.c      | 2 +-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6930c63..60bb167 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -308,6 +308,13 @@ static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memsl
 	return ALIGN(memslot->npages, BITS_PER_LONG) / 8;
 }
 
+static inline unsigned long *kvm_second_dirty_bitmap(struct kvm_memory_slot *memslot)
+{
+	unsigned long len = kvm_dirty_bitmap_bytes(memslot);
+
+	return memslot->dirty_bitmap + len / sizeof(*memslot->dirty_bitmap);
+}
+
 struct kvm_s390_adapter_int {
 	u64 ind_addr;
 	u64 summary_addr;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index c7b2e92..ff06394 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1152,7 +1152,7 @@ int kvm_get_dirty_log_protect(struct kvm *kvm,
 
 	n = kvm_dirty_bitmap_bytes(memslot);
 
-	dirty_bitmap_buffer = dirty_bitmap + n / sizeof(long);
+	dirty_bitmap_buffer = kvm_second_dirty_bitmap(memslot);
 	memset(dirty_bitmap_buffer, 0, n);
 
 	spin_lock(&kvm->mmu_lock);
-- 
2.7.4
