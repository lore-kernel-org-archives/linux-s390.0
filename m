From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 11/12] s390-virtio: Factor out some initialization code.
Date: Thu, 17 Jan 2013 15:23:56 +0100
Message-ID: <1358432637-42512-12-git-send-email-cornelia.huck@de.ibm.com>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Some of the machine initialization for s390-virtio will be reused
by virtio-ccw.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/s390-virtio.c | 155 ++++++++++++++++++++++++++++++-------------------------
 hw/s390-virtio.h |   5 ++
 2 files changed, 91 insertions(+), 69 deletions(-)

diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
index bded30b..603f6b0 100644
--- a/hw/s390-virtio.c
+++ b/hw/s390-virtio.c
@@ -155,62 +155,10 @@ unsigned s390_del_running_cpu(CPUS390XState *env)
     return s390_running_cpus;
 }
 
-/* PC hardware initialisation */
-static void s390_init(QEMUMachineInitArgs *args)
+void s390_init_cpus(const char *cpu_model, uint8_t *storage_keys)
 {
-    ram_addr_t my_ram_size = args->ram_size;
-    const char *cpu_model = args->cpu_model;
-    const char *kernel_filename = args->kernel_filename;
-    const char *kernel_cmdline = args->kernel_cmdline;
-    const char *initrd_filename = args->initrd_filename;
-    CPUS390XState *env = NULL;
-    MemoryRegion *sysmem = get_system_memory();
-    MemoryRegion *ram = g_new(MemoryRegion, 1);
-    ram_addr_t kernel_size = 0;
-    ram_addr_t initrd_offset;
-    ram_addr_t initrd_size = 0;
-    int shift = 0;
-    uint8_t *storage_keys;
-    void *virtio_region;
-    hwaddr virtio_region_len;
-    hwaddr virtio_region_start;
     int i;
 
-    /* s390x ram size detection needs a 16bit multiplier + an increment. So
-       guests > 64GB can be specified in 2MB steps etc. */
-    while ((my_ram_size >> (20 + shift)) > 65535) {
-        shift++;
-    }
-    my_ram_size = my_ram_size >> (20 + shift) << (20 + shift);
-
-    /* lets propagate the changed ram size into the global variable. */
-    ram_size = my_ram_size;
-
-    /* get a BUS */
-    s390_bus = s390_virtio_bus_init(&my_ram_size);
-    s390_sclp_init();
-
-    /* register hypercalls */
-    s390_virtio_register_hcalls();
-
-    /* allocate RAM */
-    memory_region_init_ram(ram, "s390.ram", my_ram_size);
-    vmstate_register_ram_global(ram);
-    memory_region_add_subregion(sysmem, 0, ram);
-
-    /* clear virtio region */
-    virtio_region_len = my_ram_size - ram_size;
-    virtio_region_start = ram_size;
-    virtio_region = cpu_physical_memory_map(virtio_region_start,
-                                            &virtio_region_len, true);
-    memset(virtio_region, 0, virtio_region_len);
-    cpu_physical_memory_unmap(virtio_region, virtio_region_len, 1,
-                              virtio_region_len);
-
-    /* allocate storage keys */
-    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
-
-    /* init CPUs */
     if (cpu_model == NULL) {
         cpu_model = "host";
     }
@@ -219,21 +167,27 @@ static void s390_init(QEMUMachineInitArgs *args)
 
     for (i = 0; i < smp_cpus; i++) {
         S390CPU *cpu;
-        CPUS390XState *tmp_env;
 
         cpu = cpu_s390x_init(cpu_model);
-        tmp_env = &cpu->env;
-        if (!env) {
-            env = tmp_env;
-        }
+
         ipi_states[i] = cpu;
-        tmp_env->halted = 1;
-        tmp_env->exception_index = EXCP_HLT;
-        tmp_env->storage_keys = storage_keys;
+        cpu->env.halted = 1;
+        cpu->env.exception_index = EXCP_HLT;
+        cpu->env.storage_keys = storage_keys;
     }
+}
+
+void s390_set_up_kernel(const char *kernel_filename,
+                        const char *kernel_cmdline,
+                        const char *initrd_filename)
+{
+    ram_addr_t kernel_size = 0;
+    ram_addr_t initrd_offset;
+    ram_addr_t initrd_size = 0;
+    S390CPU *cpu = s390_cpu_addr2state(0);
 
     /* One CPU has to run */
-    s390_add_running_cpu(env);
+    s390_add_running_cpu(&cpu->env);
 
     if (kernel_filename) {
 
@@ -252,8 +206,8 @@ static void s390_init(QEMUMachineInitArgs *args)
          * value was 0x800 (the SALIPL loader) and it wont work. For
          * all (Linux) cases 0x10000 (KERN_IMAGE_START) should be fine.
          */
-        env->psw.addr = KERN_IMAGE_START;
-        env->psw.mask = 0x0000000180000000ULL;
+        cpu->env.psw.addr = KERN_IMAGE_START;
+        cpu->env.psw.mask = 0x0000000180000000ULL;
     } else {
         ram_addr_t bios_size = 0;
         char *bios_filename;
@@ -275,8 +229,8 @@ static void s390_init(QEMUMachineInitArgs *args)
             hw_error("stage1 bootloader is > 4k\n");
         }
 
-        env->psw.addr = ZIPL_START;
-        env->psw.mask = 0x0000000180000000ULL;
+        cpu->env.psw.addr = ZIPL_START;
+        cpu->env.psw.mask = 0x0000000180000000ULL;
     }
 
     if (initrd_filename) {
@@ -302,9 +256,13 @@ static void s390_init(QEMUMachineInitArgs *args)
         memcpy(rom_ptr(KERN_PARM_AREA), kernel_cmdline,
                strlen(kernel_cmdline) + 1);
     }
+}
 
-    /* Create VirtIO network adapters */
-    for(i = 0; i < nb_nics; i++) {
+void s390_create_virtio_net(BusState *bus, const char *name)
+{
+    int i;
+
+    for (i = 0; i < nb_nics; i++) {
         NICInfo *nd = &nd_table[i];
         DeviceState *dev;
 
@@ -317,12 +275,71 @@ static void s390_init(QEMUMachineInitArgs *args)
             exit(1);
         }
 
-        dev = qdev_create((BusState *)s390_bus, "virtio-net-s390");
+        dev = qdev_create(bus, name);
         qdev_set_nic_properties(dev, nd);
         qdev_init_nofail(dev);
     }
 }
 
+/* PC hardware initialisation */
+static void s390_init(QEMUMachineInitArgs *args)
+{
+    ram_addr_t my_ram_size = args->ram_size;
+    const char *cpu_model = args->cpu_model;
+    const char *kernel_filename = args->kernel_filename;
+    const char *kernel_cmdline = args->kernel_cmdline;
+    const char *initrd_filename = args->initrd_filename;
+    MemoryRegion *sysmem = get_system_memory();
+    MemoryRegion *ram = g_new(MemoryRegion, 1);
+    int shift = 0;
+    uint8_t *storage_keys;
+    void *virtio_region;
+    hwaddr virtio_region_len;
+    hwaddr virtio_region_start;
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
+    s390_bus = s390_virtio_bus_init(&my_ram_size);
+    s390_sclp_init();
+
+    /* register hypercalls */
+    s390_virtio_register_hcalls();
+
+    /* allocate RAM */
+    memory_region_init_ram(ram, "s390.ram", my_ram_size);
+    vmstate_register_ram_global(ram);
+    memory_region_add_subregion(sysmem, 0, ram);
+
+    /* clear virtio region */
+    virtio_region_len = my_ram_size - ram_size;
+    virtio_region_start = ram_size;
+    virtio_region = cpu_physical_memory_map(virtio_region_start,
+                                            &virtio_region_len, true);
+    memset(virtio_region, 0, virtio_region_len);
+    cpu_physical_memory_unmap(virtio_region, virtio_region_len, 1,
+                              virtio_region_len);
+
+    /* allocate storage keys */
+    storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
+
+    /* init CPUs */
+    s390_init_cpus(cpu_model, storage_keys);
+
+    s390_set_up_kernel(kernel_filename, kernel_cmdline, initrd_filename);
+
+    /* Create VirtIO network adapters */
+    s390_create_virtio_net((BusState *)s390_bus, "virtio-net-s390");
+}
+
 static QEMUMachine s390_machine = {
     .name = "s390-virtio",
     .alias = "s390",
diff --git a/hw/s390-virtio.h b/hw/s390-virtio.h
index 25bb610..aefc99d 100644
--- a/hw/s390-virtio.h
+++ b/hw/s390-virtio.h
@@ -19,4 +19,9 @@
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
 
+void s390_init_cpus(const char *cpu_model, uint8_t *storage_keys);
+void s390_set_up_kernel(const char *kernel_filename,
+                        const char *kernel_cmdline,
+                        const char *initrd_filename);
+void s390_create_virtio_net(BusState *bus, const char *name);
 #endif
-- 
1.7.12.4
