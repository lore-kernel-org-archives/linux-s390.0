From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 11/11] s390: Add s390-ccw-virtio machine.
Date: Thu, 24 Jan 2013 13:28:11 +0100
Message-ID: <1359030491-46725-12-git-send-email-cornelia.huck@de.ibm.com>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Add a new machine type, s390-ccw-virtio, making use of the
virtio-ccw transport to present virtio devices as channel
devices.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---

v5 -> v6:
- Don't make virtio-ccw the default yet
- Adapt to ipl device changes
- Adapt to VirtioBus changes
- Default to sclp console
---
 hw/s390-virtio.h           |   1 +
 hw/s390x/Makefile.objs     |   1 +
 hw/s390x/s390-virtio-ccw.c | 134 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 136 insertions(+)
 create mode 100644 hw/s390x/s390-virtio-ccw.c

diff --git a/hw/s390-virtio.h b/hw/s390-virtio.h
index 67bfd20..a6c4c19 100644
--- a/hw/s390-virtio.h
+++ b/hw/s390-virtio.h
@@ -15,6 +15,7 @@
 #define KVM_S390_VIRTIO_NOTIFY          0
 #define KVM_S390_VIRTIO_RESET           1
 #define KVM_S390_VIRTIO_SET_STATUS      2
+#define KVM_S390_VIRTIO_CCW_NOTIFY      3
 
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
index f6b461b..9eed6d9 100644
--- a/hw/s390x/Makefile.objs
+++ b/hw/s390x/Makefile.objs
@@ -7,4 +7,5 @@ obj-y += event-facility.o
 obj-y += sclpquiesce.o sclpconsole.o
 obj-y += ipl.o
 obj-y += css.o
+obj-y += s390-virtio-ccw.o
 obj-y += virtio-ccw.o
diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
new file mode 100644
index 0000000..9575d00
--- /dev/null
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -0,0 +1,134 @@
+/*
+ * virtio ccw machine
+ *
+ * Copyright 2012 IBM Corp.
+ * Author(s): Cornelia Huck <cornelia.huck@de.ibm.com>
+ *
+ * This work is licensed under the terms of the GNU GPL, version 2 or (at
+ * your option) any later version. See the COPYING file in the top-level
+ * directory.
+ */
+
+#include "hw/boards.h"
+#include "exec/address-spaces.h"
+#include "hw/s390-virtio.h"
+#include "hw/s390x/sclp.h"
+#include "ioinst.h"
+#include "css.h"
+#include "virtio-ccw.h"
+
+static int virtio_ccw_hcall_notify(const uint64_t *args)
+{
+    uint64_t subch_id = args[0];
+    uint64_t queue = args[1];
+    SubchDev *sch;
+    int cssid, ssid, schid, m;
+
+    if (ioinst_disassemble_sch_ident(subch_id, &m, &cssid, &ssid, &schid)) {
+        return -EINVAL;
+    }
+    sch = css_find_subch(m, cssid, ssid, schid);
+    if (!sch || !css_subch_visible(sch)) {
+        return -EINVAL;
+    }
+    virtio_queue_notify(virtio_ccw_get_vdev(sch), queue);
+    return 0;
+
+}
+
+static int virtio_ccw_hcall_early_printk(const uint64_t *args)
+{
+    uint64_t mem = args[0];
+
+    if (mem < ram_size) {
+        /* Early printk */
+        return 0;
+    }
+    return -EINVAL;
+}
+
+static void virtio_ccw_register_hcalls(void)
+{
+    s390_register_virtio_hypercall(KVM_S390_VIRTIO_CCW_NOTIFY,
+                                   virtio_ccw_hcall_notify);
+    /* Tolerate early printk. */
+    s390_register_virtio_hypercall(KVM_S390_VIRTIO_NOTIFY,
+                                   virtio_ccw_hcall_early_printk);
+}
+
+static void ccw_init(QEMUMachineInitArgs *args)
+{
+    ram_addr_t my_ram_size = args->ram_size;
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    int shift = 0;
+    uint8_t *storage_keys;
+    int ret;
+    VirtualCssBus *css_bus;
+
+    /* s390x ram size detection needs a 16bit multiplier + an increment. So
+       guests > 64GB can be specified in 2MB steps etc. */
+    while ((my_ram_size >> (20 + shift)) > 65535) {
+        shift++;
+    }
+    my_ram_size = my_ram_size >> (20 + shift) << (20 + shift);
+
+    /* lets propagate the changed ram size into the global variable. */
+    ram_size = my_ram_size;
+
+    /* get a BUS */
+    css_bus = virtual_css_bus_init();
+    s390_sclp_init();
+    s390_init_ipl_dev(args->kernel_filename, args->kernel_cmdline,
+                      args->initrd_filename);
+
+    /* register hypercalls */
+    virtio_ccw_register_hcalls();
+
+    /* allocate RAM */
+    memory_region_init_ram(ram, "s390.ram", my_ram_size);
+    vmstate_register_ram_global(ram);
+    memory_region_add_subregion(sysmem, 0, ram);
+
+    /* allocate storage keys */
+    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
+
+    /* init CPUs */
+    s390_init_cpus(args->cpu_model, storage_keys);
+
+    if (kvm_enabled()) {
+        kvm_s390_enable_css_support(s390_cpu_addr2state(0));
+    }
+    /*
+     * Create virtual css and set it as default so that non mcss-e
+     * enabled guests only see virtio devices.
+     */
+    ret = css_create_css_image(VIRTUAL_CSSID, true);
+    assert(ret == 0);
+
+    /* Create VirtIO network adapters */
+    s390_create_virtio_net(BUS(css_bus), "virtio-net-ccw");
+}
+
+static QEMUMachine ccw_machine = {
+    .name = "s390-ccw-virtio",
+    .alias = "s390-ccw",
+    .desc = "VirtIO-ccw based S390 machine",
+    .init = ccw_init,
+    .block_default_type = IF_VIRTIO,
+    .no_cdrom = 1,
+    .no_floppy = 1,
+    .no_serial = 1,
+    .no_parallel = 1,
+    .no_sdcard = 1,
+    .use_sclp = 1,
+    .max_cpus = 255,
+    DEFAULT_MACHINE_OPTIONS,
+};
+
+static void ccw_machine_init(void)
+{
+    qemu_register_machine(&ccw_machine);
+}
+
+machine_init(ccw_machine_init);
-- 
1.7.12.4
