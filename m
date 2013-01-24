From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 09/11] s390-virtio: Factor out some initialization code.
Date: Thu, 24 Jan 2013 13:28:09 +0100
Message-ID: <1359030491-46725-10-git-send-email-cornelia.huck@de.ibm.com>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

Some of the machine initialization for s390-virtio will be reused
by virtio-ccw.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>

---

v5 -> v6:
- Adapt to ipl device changes
---
 hw/s390-virtio.c | 118 +++++++++++++++++++++++++++++++------------------------
 hw/s390-virtio.h |   5 +++
 2 files changed, 72 insertions(+), 51 deletions(-)

diff --git a/hw/s390-virtio.c b/hw/s390-virtio.c
index 5edaabb..6e0f53b 100644
--- a/hw/s390-virtio.c
+++ b/hw/s390-virtio.c
@@ -147,13 +147,73 @@ unsigned s390_del_running_cpu(CPUS390XState *env)
     return s390_running_cpus;
 }
 
+void s390_init_ipl_dev(const char *kernel_filename,
+                       const char *kernel_cmdline,
+                       const char *initrd_filename)
+{
+    DeviceState *dev;
+
+    dev  = qdev_create(NULL, "s390-ipl");
+    if (kernel_filename) {
+        qdev_prop_set_string(dev, "kernel", kernel_filename);
+    }
+    if (initrd_filename) {
+        qdev_prop_set_string(dev, "initrd", initrd_filename);
+    }
+    qdev_prop_set_string(dev, "cmdline", kernel_cmdline);
+    qdev_init_nofail(dev);
+}
+
+void s390_init_cpus(const char *cpu_model, uint8_t *storage_keys)
+{
+    int i;
+
+    if (cpu_model == NULL) {
+        cpu_model = "host";
+    }
+
+    ipi_states = g_malloc(sizeof(S390CPU *) * smp_cpus);
+
+    for (i = 0; i < smp_cpus; i++) {
+        S390CPU *cpu;
+
+        cpu = cpu_s390x_init(cpu_model);
+
+        ipi_states[i] = cpu;
+        cpu->env.halted = 1;
+        cpu->env.exception_index = EXCP_HLT;
+        cpu->env.storage_keys = storage_keys;
+    }
+}
+
+
+void s390_create_virtio_net(BusState *bus, const char *name)
+{
+    int i;
+
+    for (i = 0; i < nb_nics; i++) {
+        NICInfo *nd = &nd_table[i];
+        DeviceState *dev;
+
+        if (!nd->model) {
+            nd->model = g_strdup("virtio");
+        }
+
+        if (strcmp(nd->model, "virtio")) {
+            fprintf(stderr, "S390 only supports VirtIO nics\n");
+            exit(1);
+        }
+
+        dev = qdev_create(bus, name);
+        qdev_set_nic_properties(dev, nd);
+        qdev_init_nofail(dev);
+    }
+}
+
 /* PC hardware initialisation */
 static void s390_init(QEMUMachineInitArgs *args)
 {
     ram_addr_t my_ram_size = args->ram_size;
-    const char *cpu_model = args->cpu_model;
-    CPUS390XState *env = NULL;
-    DeviceState *dev;
     MemoryRegion *sysmem = get_system_memory();
     MemoryRegion *ram = g_new(MemoryRegion, 1);
     int shift = 0;
@@ -161,7 +221,6 @@ static void s390_init(QEMUMachineInitArgs *args)
     void *virtio_region;
     hwaddr virtio_region_len;
     hwaddr virtio_region_start;
-    int i;
 
     /* s390x ram size detection needs a 16bit multiplier + an increment. So
        guests > 64GB can be specified in 2MB steps etc. */
@@ -176,15 +235,8 @@ static void s390_init(QEMUMachineInitArgs *args)
     /* get a BUS */
     s390_bus = s390_virtio_bus_init(&my_ram_size);
     s390_sclp_init();
-    dev  = qdev_create(NULL, "s390-ipl");
-    if (args->kernel_filename) {
-        qdev_prop_set_string(dev, "kernel", args->kernel_filename);
-    }
-    if (args->initrd_filename) {
-        qdev_prop_set_string(dev, "initrd", args->initrd_filename);
-    }
-    qdev_prop_set_string(dev, "cmdline", args->kernel_cmdline);
-    qdev_init_nofail(dev);
+    s390_init_ipl_dev(args->kernel_filename, args->kernel_cmdline,
+                      args->initrd_filename);
 
     /* register hypercalls */
     s390_virtio_register_hcalls();
@@ -207,46 +259,10 @@ static void s390_init(QEMUMachineInitArgs *args)
     storage_keys = g_malloc0(my_ram_size / TARGET_PAGE_SIZE);
 
     /* init CPUs */
-    if (cpu_model == NULL) {
-        cpu_model = "host";
-    }
-
-    ipi_states = g_malloc(sizeof(S390CPU *) * smp_cpus);
-
-    for (i = 0; i < smp_cpus; i++) {
-        S390CPU *cpu;
-        CPUS390XState *tmp_env;
-
-        cpu = cpu_s390x_init(cpu_model);
-        tmp_env = &cpu->env;
-        if (!env) {
-            env = tmp_env;
-        }
-        ipi_states[i] = cpu;
-        tmp_env->halted = 1;
-        tmp_env->exception_index = EXCP_HLT;
-        tmp_env->storage_keys = storage_keys;
-    }
-
+    s390_init_cpus(args->cpu_model, storage_keys);
 
     /* Create VirtIO network adapters */
-    for(i = 0; i < nb_nics; i++) {
-        NICInfo *nd = &nd_table[i];
-        DeviceState *dev;
-
-        if (!nd->model) {
-            nd->model = g_strdup("virtio");
-        }
-
-        if (strcmp(nd->model, "virtio")) {
-            fprintf(stderr, "S390 only supports VirtIO nics\n");
-            exit(1);
-        }
-
-        dev = qdev_create((BusState *)s390_bus, "virtio-net-s390");
-        qdev_set_nic_properties(dev, nd);
-        qdev_init_nofail(dev);
-    }
+    s390_create_virtio_net((BusState *)s390_bus, "virtio-net-s390");
 }
 
 static QEMUMachine s390_machine = {
diff --git a/hw/s390-virtio.h b/hw/s390-virtio.h
index 25bb610..67bfd20 100644
--- a/hw/s390-virtio.h
+++ b/hw/s390-virtio.h
@@ -19,4 +19,9 @@
 typedef int (*s390_virtio_fn)(const uint64_t *args);
 void s390_register_virtio_hypercall(uint64_t code, s390_virtio_fn fn);
 
+void s390_init_cpus(const char *cpu_model, uint8_t *storage_keys);
+void s390_init_ipl_dev(const char *kernel_filename,
+                       const char *kernel_cmdline,
+                       const char *initrd_filename);
+void s390_create_virtio_net(BusState *bus, const char *name);
 #endif
-- 
1.7.12.4
