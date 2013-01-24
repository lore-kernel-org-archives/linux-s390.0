From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 10/11] s390: Add default support for SCLP console
Date: Thu, 24 Jan 2013 13:28:10 +0100
Message-ID: <1359030491-46725-11-git-send-email-cornelia.huck@de.ibm.com>
References: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1359030491-46725-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
List-ID: <linux-s390.vger.kernel.org>

From: Alexander Graf <agraf@suse.de>

The current s390 machine uses the virtio console as default console,
but this doesn't mean that we always want to keep it that way for new
machines.

This patch introduces a way for a machine type to specify that it wants
the default console to be an SCLP console, which is a lot closer to what
real hardware does.

Signed-off-by: Alexander Graf <agraf@suse.de>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 hw/boards.h |  1 +
 vl.c        | 48 ++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/hw/boards.h b/hw/boards.h
index 3ff9665..3813d4e 100644
--- a/hw/boards.h
+++ b/hw/boards.h
@@ -33,6 +33,7 @@ typedef struct QEMUMachine {
     unsigned int no_serial:1,
         no_parallel:1,
         use_virtcon:1,
+        use_sclp:1,
         no_floppy:1,
         no_cdrom:1,
         no_sdcard:1;
diff --git a/vl.c b/vl.c
index 4ee1302..6a19a8f 100644
--- a/vl.c
+++ b/vl.c
@@ -176,6 +176,7 @@ int main(int argc, char **argv)
 #define DEFAULT_RAM_SIZE 128
 
 #define MAX_VIRTIO_CONSOLES 1
+#define MAX_SCLP_CONSOLES 1
 
 static const char *data_dir;
 const char *bios_name = NULL;
@@ -203,6 +204,7 @@ int no_quit = 0;
 CharDriverState *serial_hds[MAX_SERIAL_PORTS];
 CharDriverState *parallel_hds[MAX_PARALLEL_PORTS];
 CharDriverState *virtcon_hds[MAX_VIRTIO_CONSOLES];
+CharDriverState *sclp_hds[MAX_SCLP_CONSOLES];
 int win2k_install_hack = 0;
 int singlestep = 0;
 int smp_cpus = 1;
@@ -271,6 +273,7 @@ static int tcg_tb_size;
 static int default_serial = 1;
 static int default_parallel = 1;
 static int default_virtcon = 1;
+static int default_sclp = 1;
 static int default_monitor = 1;
 static int default_floppy = 1;
 static int default_cdrom = 1;
@@ -2340,6 +2343,7 @@ struct device_config {
         DEV_VIRTCON,   /* -virtioconsole */
         DEV_DEBUGCON,  /* -debugcon */
         DEV_GDB,       /* -gdb, -s */
+        DEV_SCLP,      /* s390 sclp */
     } type;
     const char *cmdline;
     Location loc;
@@ -2458,6 +2462,39 @@ static int virtcon_parse(const char *devname)
     return 0;
 }
 
+static int sclp_parse(const char *devname)
+{
+    QemuOptsList *device = qemu_find_opts("device");
+    static int index = 0;
+    char label[32];
+    QemuOpts *dev_opts;
+
+    if (strcmp(devname, "none") == 0) {
+        return 0;
+    }
+    if (index == MAX_SCLP_CONSOLES) {
+        fprintf(stderr, "qemu: too many sclp consoles\n");
+        exit(1);
+    }
+
+    assert(arch_type == QEMU_ARCH_S390X);
+
+    dev_opts = qemu_opts_create(device, NULL, 0, NULL);
+    qemu_opt_set(dev_opts, "driver", "sclpconsole");
+
+    snprintf(label, sizeof(label), "sclpcon%d", index);
+    sclp_hds[index] = qemu_chr_new(label, devname, NULL);
+    if (!sclp_hds[index]) {
+        fprintf(stderr, "qemu: could not connect sclp console"
+                " to character backend '%s'\n", devname);
+        return -1;
+    }
+    qemu_opt_set(dev_opts, "chardev", label);
+
+    index++;
+    return 0;
+}
+
 static int debugcon_parse(const char *devname)
 {   
     QemuOpts *opts;
@@ -3832,6 +3869,9 @@ int main(int argc, char **argv, char **envp)
     if (!machine->use_virtcon) {
         default_virtcon = 0;
     }
+    if (!machine->use_sclp) {
+        default_sclp = 0;
+    }
     if (machine->no_floppy) {
         default_floppy = 0;
     }
@@ -3873,11 +3913,15 @@ int main(int argc, char **argv, char **envp)
             add_device_config(DEV_SERIAL, "mon:stdio");
         } else if (default_virtcon && default_monitor) {
             add_device_config(DEV_VIRTCON, "mon:stdio");
+        } else if (default_sclp && default_monitor) {
+            add_device_config(DEV_SCLP, "mon:stdio");
         } else {
             if (default_serial)
                 add_device_config(DEV_SERIAL, "stdio");
             if (default_virtcon)
                 add_device_config(DEV_VIRTCON, "stdio");
+            if (default_sclp)
+                add_device_config(DEV_SCLP, "stdio");
             if (default_monitor)
                 monitor_parse("stdio", "readline");
         }
@@ -3890,6 +3934,8 @@ int main(int argc, char **argv, char **envp)
             monitor_parse("vc:80Cx24C", "readline");
         if (default_virtcon)
             add_device_config(DEV_VIRTCON, "vc:80Cx24C");
+        if (default_sclp)
+            add_device_config(DEV_SCLP, "vc:80Cx24C");
     }
 
     socket_init();
@@ -4060,6 +4106,8 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     if (foreach_device_config(DEV_VIRTCON, virtcon_parse) < 0)
         exit(1);
+    if (foreach_device_config(DEV_SCLP, sclp_parse) < 0)
+        exit(1);
     if (foreach_device_config(DEV_DEBUGCON, debugcon_parse) < 0)
         exit(1);
 
-- 
1.7.12.4
