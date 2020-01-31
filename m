Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11580 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729185AbgAaPCW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:02:22 -0500
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VF0bU0124480
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:21 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xvbeht2wh-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:02:20 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:02:16 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 09/12] kvm: clear dirty bitmaps from all overlapping memslots
Date: Fri, 31 Jan 2020 16:02:04 +0100
In-Reply-To: <20200131150207.73127-1-borntraeger@de.ibm.com>
References: <20200131150207.73127-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150207.73127-10-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Paolo Bonzini <pbonzini@redhat.com>

Currently MemoryRegionSection has 1:1 mapping to KVMSlot.
However next patch will allow splitting MemoryRegionSection into
several KVMSlot-s, make sure that kvm_physical_log_slot_clear()
is able to handle such 1:N mapping.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <20190924144751.24149-3-imammedo@redhat.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 accel/kvm/kvm-all.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index a85ec09486dd..ff9b95c0d103 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -589,8 +589,8 @@ static int kvm_log_clear_one_slot(KVMSlot *mem, int as_id, uint64_t start,
      * satisfy the KVM interface requirement.  Firstly, do the start
      * page alignment on 64 host pages
      */
-    bmap_start = (start - mem->start_addr) & KVM_CLEAR_LOG_MASK;
-    start_delta = start - mem->start_addr - bmap_start;
+    bmap_start = start & KVM_CLEAR_LOG_MASK;
+    start_delta = start - bmap_start;
     bmap_start /= psize;
 
     /*
@@ -694,8 +694,8 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
                                   MemoryRegionSection *section)
 {
     KVMState *s = kvm_state;
-    uint64_t start, size;
-    KVMSlot *mem = NULL;
+    uint64_t start, size, offset, count;
+    KVMSlot *mem;
     int ret, i;
 
     if (!s->manual_dirty_log_protect) {
@@ -713,22 +713,30 @@ static int kvm_physical_log_clear(KVMMemoryListener *kml,
 
     kvm_slots_lock(kml);
 
-    /* Find any possible slot that covers the section */
     for (i = 0; i < s->nr_slots; i++) {
         mem = &kml->slots[i];
-        if (mem->start_addr <= start &&
-            start + size <= mem->start_addr + mem->memory_size) {
+        /* Discard slots that are empty or do not overlap the section */
+        if (!mem->memory_size ||
+            mem->start_addr > start + size - 1 ||
+            start > mem->start_addr + mem->memory_size - 1) {
+            continue;
+        }
+
+        if (start >= mem->start_addr) {
+            /* The slot starts before section or is aligned to it.  */
+            offset = start - mem->start_addr;
+            count = MIN(mem->memory_size - offset, size);
+        } else {
+            /* The slot starts after section.  */
+            offset = 0;
+            count = MIN(mem->memory_size, size - (mem->start_addr - start));
+        }
+        ret = kvm_log_clear_one_slot(mem, kml->as_id, offset, count);
+        if (ret < 0) {
             break;
         }
     }
 
-    /*
-     * We should always find one memslot until this point, otherwise
-     * there could be something wrong from the upper layer
-     */
-    assert(mem && i != s->nr_slots);
-    ret = kvm_log_clear_one_slot(mem, kml->as_id, start, size);
-
     kvm_slots_unlock(kml);
 
     return ret;
-- 
2.21.0
