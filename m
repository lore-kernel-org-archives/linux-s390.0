Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59198 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729163AbgAaPCX (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:02:23 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VF0Iif143032
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:22 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xv7e2x7jc-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:20 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:02:16 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 08/12] kvm: extract kvm_log_clear_one_slot
Date: Fri, 31 Jan 2020 16:02:03 +0100
In-Reply-To: <20200131150207.73127-1-borntraeger@de.ibm.com>
References: <20200131150207.73127-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150207.73127-9-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

We may need to clear the dirty bitmap for more than one KVM memslot.
First do some code movement with no semantic change.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190924144751.24149-2-imammedo@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[fixup line break]
---
 accel/kvm/kvm-all.c | 103 ++++++++++++++++++++++++--------------------
 1 file changed, 57 insertions(+), 46 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index b09bad08048d..a85ec09486dd 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -575,55 +575,14 @@ out:
 #define KVM_CLEAR_LOG_ALIGN  (qemu_real_host_page_size << KVM_CLEAR_LOG_SHIFT)
 #define KVM_CLEAR_LOG_MASK   (-KVM_CLEAR_LOG_ALIGN)
 
-/**
- * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
- *
- * NOTE: this will be a no-op if we haven't enabled manual dirty log
- * protection in the host kernel because in that case this operation
- * will be done within log_sync().
- *
- * @kml:     the kvm memory listener
- * @section: the memory range to clear dirty bitmap
- */
-static int kvm_physical_log_clear(KVMMemoryListener *kml,
-                                  MemoryRegionSection *section)
+static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start,
+                                  uint64_t size)
 {
     KVMState *s = kvm_state;
+    uint64_t end, bmap_start, start_delta, bmap_npages;
     struct kvm_clear_dirty_log d;
-    uint64_t start, end, bmap_start, start_delta, bmap_npages, size;
     unsigned long *bmap_clear = NULL, psize = qemu_real_host_page_size;
-    KVMSlot *mem = NULL;
-    int ret, i;
-
-    if (!s->manual_dirty_log_protect) {
-        /* No need to do explicit clear */
-        return 0;
-    }
-
-    start = section->offset_within_address_space;
-    size = int128_get64(section->size);
-
-    if (!size) {
-        /* Nothing more we can do... */
-        return 0;
-    }
-
-    kvm_slots_lock(kml);
-
-    /* Find any possible slot that covers the section */
-    for (i = 0; i < s->nr_slots; i++) {
-        mem = &kml->slots[i];
-        if (mem->start_addr <= start &&
-            start + size <= mem->start_addr + mem->memory_size) {
-            break;
-        }
-    }
-
-    /*
-     * We should always find one memslot until this point, otherwise
-     * there could be something wrong from the upper layer
-     */
-    assert(mem && i != s->nr_slots);
+    int ret;
 
     /*
      * We need to extend either the start or the size or both to
@@ -694,7 +653,7 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
     /* It should never overflow.  If it happens, say something */
     assert(bmap_npages <= UINT32_MAX);
     d.num_pages = bmap_npages;
-    d.slot = mem->slot | (kml->as_id << 16);
+    d.slot = mem->slot | (as_id << 16);
 
     if (kvm_vm_ioctl(s, KVM_CLEAR_DIRTY_LOG, &d) == -1) {
         ret = -errno;
@@ -717,6 +676,58 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
                  size / psize);
     /* This handles the NULL case well */
     g_free(bmap_clear);
+    return ret;
+}
+
+
+/**
+ * kvm_physical_log_clear - Clear the kernel's dirty bitmap for range
+ *
+ * NOTE: this will be a no-op if we haven't enabled manual dirty log
+ * protection in the host kernel because in that case this operation
+ * will be done within log_sync().
+ *
+ * @kml:     the kvm memory listener
+ * @section: the memory range to clear dirty bitmap
+ */
+static int kvm_physical_log_clear(KVMMemoryListener *kml,
+                                  MemoryRegionSection *section)
+{
+    KVMState *s = kvm_state;
+    uint64_t start, size;
+    KVMSlot *mem = NULL;
+    int ret, i;
+
+    if (!s->manual_dirty_log_protect) {
+        /* No need to do explicit clear */
+        return 0;
+    }
+
+    start = section->offset_within_address_space;
+    size = int128_get64(section->size);
+
+    if (!size) {
+        /* Nothing more we can do... */
+        return 0;
+    }
+
+    kvm_slots_lock(kml);
+
+    /* Find any possible slot that covers the section */
+    for (i = 0; i < s->nr_slots; i++) {
+        mem = &kml->slots[i];
+        if (mem->start_addr <= start &&
+            start + size <= mem->start_addr + mem->memory_size) {
+            break;
+        }
+    }
+
+    /*
+     * We should always find one memslot until this point, otherwise
+     * there could be something wrong from the upper layer
+     */
+    assert(mem && i != s->nr_slots);
+    ret = kvm_log_clear_one_slot(mem, kml->as_id, start, size);
 
     kvm_slots_unlock(kml);
 
-- 
2.21.0
