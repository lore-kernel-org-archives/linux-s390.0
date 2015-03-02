From: Michael Mueller <mimu@linux.vnet.ibm.com>
Subject: [PATCH v3 02/16] Introduce option --probe to switch into probe mode
Date: Mon,  2 Mar 2015 13:43:54 +0100
Message-ID: <1425300248-40277-3-git-send-email-mimu@linux.vnet.ibm.com>
References: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1425300248-40277-1-git-send-email-mimu@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel@nongnu.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Gleb Natapov <gleb@kernel.org>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Andreas Faerber <afaerber@suse.de>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The option --probe allows to switch into probe mode also for machines
different from none. If one or more accelerators are specified these
accelerators are used to provide probable properties. If no accelerator
is given a list of accelerators that support probing is used.

Signed-off-by: Michael Mueller <mimu@linux.vnet.ibm.com>
---
 accel.c                | 13 ++++++++-----
 include/sysemu/accel.h |  2 +-
 qemu-options.hx        |  8 ++++++++
 vl.c                   |  7 ++++++-
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/accel.c b/accel.c
index 260b009..4ed6df8 100644
--- a/accel.c
+++ b/accel.c
@@ -81,7 +81,7 @@ static int accel_init_machine(AccelClass *acc, MachineState *ms,
     return ret;
 }
 
-int configure_accelerator(MachineState *ms)
+int configure_accelerator(MachineState *ms, int probe)
 {
     const char *p, *name;
     char buf[10];
@@ -90,13 +90,16 @@ int configure_accelerator(MachineState *ms)
     bool init_failed = false;
     AccelClass *acc = NULL;
     ObjectClass *oc;
-    bool probe_mode = false;
+    bool probe_mode;
 
+    probe_mode = probe != 0;
     p = qemu_opt_get(qemu_get_machine_opts(), "accel");
     if (p == NULL) {
-        oc = (ObjectClass *) MACHINE_GET_CLASS(current_machine);
-        name = object_class_get_name(oc);
-        probe_mode = !strcmp(name, "none" TYPE_MACHINE_SUFFIX);
+        if (!probe_mode) {
+            oc = (ObjectClass *) MACHINE_GET_CLASS(current_machine);
+            name = object_class_get_name(oc);
+            probe_mode = !strcmp(name, "none" TYPE_MACHINE_SUFFIX);
+        }
         if (probe_mode) {
             /* Use these accelerators in probe mode, tcg should be last */
             p = probe_mode_accels;
diff --git a/include/sysemu/accel.h b/include/sysemu/accel.h
index 997720f..3adb6ba 100644
--- a/include/sysemu/accel.h
+++ b/include/sysemu/accel.h
@@ -57,6 +57,6 @@ typedef struct AccelClass {
 
 extern int tcg_tb_size;
 
-int configure_accelerator(MachineState *ms);
+int configure_accelerator(MachineState *ms, int probe);
 
 #endif
diff --git a/qemu-options.hx b/qemu-options.hx
index 85ca3ad..22e7544 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -2847,6 +2847,14 @@ STEXI
 Do not start CPU at startup (you must type 'c' in the monitor).
 ETEXI
 
+DEF("probe", 0, QEMU_OPTION_probe, \
+    "-probe          startup in probe mode, option -S is selected as well\n", QEMU_ARCH_ALL)
+STEXI
+@item -probe
+@findex -probe
+Startup in probe mode.
+ETEXI
+
 DEF("realtime", HAS_ARG, QEMU_OPTION_realtime,
     "-realtime [mlock=on|off]\n"
     "                run qemu with realtime features\n"
diff --git a/vl.c b/vl.c
index e1ffd0a..ba1730c 100644
--- a/vl.c
+++ b/vl.c
@@ -138,6 +138,7 @@ bool enable_mlock = false;
 int nb_nics;
 NICInfo nd_table[MAX_NICS];
 int autostart;
+int probe;
 static int rtc_utc = 1;
 static int rtc_date_offset = -1; /* -1 means no change */
 QEMUClockType rtc_clock;
@@ -3144,6 +3145,10 @@ int main(int argc, char **argv, char **envp)
             case QEMU_OPTION_S:
                 autostart = 0;
                 break;
+            case QEMU_OPTION_probe:
+                probe = 1;
+                autostart = 0;
+                break;
             case QEMU_OPTION_k:
                 keyboard_layout = optarg;
                 break;
@@ -4023,7 +4028,7 @@ int main(int argc, char **argv, char **envp)
         exit(1);
     }
 
-    configure_accelerator(current_machine);
+    configure_accelerator(current_machine, probe);
 
     if (qtest_chrdev) {
         Error *local_err = NULL;
-- 
1.8.3.1
