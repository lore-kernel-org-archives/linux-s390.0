Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49720 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729211AbgAaPDV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 31 Jan 2020 10:03:21 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 00VF1mOp085191
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:03:20 -0500
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2xuvd6s4ms-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 31 Jan 2020 10:03:19 -0500
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <borntraeger@de.ibm.com>;
        Fri, 31 Jan 2020 15:02:16 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PULL 11/12] s390: do not call memory_region_allocate_system_memory() multiple times
Date: Fri, 31 Jan 2020 16:02:06 +0100
In-Reply-To: <20200131150207.73127-1-borntraeger@de.ibm.com>
References: <20200131150207.73127-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <20200131150207.73127-12-borntraeger@de.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>

From: Igor Mammedov <imammedo@redhat.com>

s390 was trying to solve limited KVM memslot size issue by abusing
memory_region_allocate_system_memory(), which breaks API contract
where the function might be called only once.

Beside an invalid use of API, the approach also introduced migration
issue, since RAM chunks for each KVM_SLOT_MAX_BYTES are transferred in
migration stream as separate RAMBlocks.

After discussion [1], it was agreed to break migration from older
QEMU for guest with RAM >8Tb (as it was relatively new (since 2.12)
and considered to be not actually used downstream).
Migration should keep working for guests with less than 8TB and for
more than 8TB with QEMU 4.2 and newer binary.
In case user tries to migrate more than 8TB guest, between incompatible
QEMU versions, migration should fail gracefully due to non-exiting
RAMBlock ID or RAMBlock size mismatch.

Taking in account above and that now KVM code is able to split too
big MemorySection into several memslots, partially revert commit
 (bb223055b s390-ccw-virtio: allow for systems larger that 7.999TB)
and use kvm_set_max_memslot_size() to set KVMSlot size to
KVM_SLOT_MAX_BYTES.

1) [PATCH RFC v2 4/4] s390: do not call  memory_region_allocate_system_memory() multiple times

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20190924144751.24149-5-imammedo@redhat.com>
Acked-by: Peter Xu <peterx@redhat.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c | 30 +++---------------------------
 target/s390x/kvm.c         | 11 +++++++++++
 2 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 8bfb6684cb72..18ad279a00a3 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -154,39 +154,15 @@ static void virtio_ccw_register_hcalls(void)
                                    virtio_ccw_hcall_early_printk);
 }
 
-/*
- * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
- * as the dirty bitmap must be managed by bitops that take an int as
- * position indicator. If we have a guest beyond that we will split off
- * new subregions. The split must happen on a segment boundary (1MB).
- */
-#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
-#define SEG_MSK (~0xfffffULL)
-#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
 static void s390_memory_init(ram_addr_t mem_size)
 {
     MemoryRegion *sysmem = get_system_memory();
-    ram_addr_t chunk, offset = 0;
-    unsigned int number = 0;
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
     Error *local_err = NULL;
-    gchar *name;
 
     /* allocate RAM for core */
-    name = g_strdup_printf("s390.ram");
-    while (mem_size) {
-        MemoryRegion *ram = g_new(MemoryRegion, 1);
-        uint64_t size = mem_size;
-
-        /* KVM does not allow memslots >= 8 TB */
-        chunk = MIN(size, KVM_SLOT_MAX_BYTES);
-        memory_region_allocate_system_memory(ram, NULL, name, chunk);
-        memory_region_add_subregion(sysmem, offset, ram);
-        mem_size -= chunk;
-        offset += chunk;
-        g_free(name);
-        name = g_strdup_printf("s390.ram.%u", ++number);
-    }
-    g_free(name);
+    memory_region_allocate_system_memory(ram, NULL, "s390.ram", mem_size);
+    memory_region_add_subregion(sysmem, 0, ram);
 
     /*
      * Configure the maximum page size. As no memory devices were created
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 97a662ad0ebf..54864c259c5e 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -28,6 +28,7 @@
 #include "cpu.h"
 #include "internal.h"
 #include "kvm_s390x.h"
+#include "sysemu/kvm_int.h"
 #include "qapi/error.h"
 #include "qemu/error-report.h"
 #include "qemu/timer.h"
@@ -122,6 +123,15 @@
  */
 #define VCPU_IRQ_BUF_SIZE(max_cpus) (sizeof(struct kvm_s390_irq) * \
                                      (max_cpus + NR_LOCAL_IRQS))
+/*
+ * KVM does only support memory slots up to KVM_MEM_MAX_NR_PAGES pages
+ * as the dirty bitmap must be managed by bitops that take an int as
+ * position indicator. If we have a guest beyond that we will split off
+ * new subregions. The split must happen on a segment boundary (1MB).
+ */
+#define KVM_MEM_MAX_NR_PAGES ((1ULL << 31) - 1)
+#define SEG_MSK (~0xfffffULL)
+#define KVM_SLOT_MAX_BYTES ((KVM_MEM_MAX_NR_PAGES * TARGET_PAGE_SIZE) & SEG_MSK)
 
 static CPUWatchpoint hw_watchpoint;
 /*
@@ -355,6 +365,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
      */
     /* kvm_vm_enable_cap(s, KVM_CAP_S390_AIS, 0); */
 
+    kvm_set_max_memslot_size(KVM_SLOT_MAX_BYTES);
     return 0;
 }
 
-- 
2.21.0
