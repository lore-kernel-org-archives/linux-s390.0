From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 2/5] s390x/kvm: introduce proper states for s390 cpus
Date: Thu, 10 Jul 2014 15:10:36 +0200
Message-ID: <1404997839-29038-3-git-send-email-borntraeger@de.ibm.com>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, "Jason J. Herne" <jjherne@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

Until now, when a s390 cpu was stopped or halted, the number of running
CPUs was tracked in a global variable. This was problematic for migration,
so Jason came up with a per-cpu running state.
As it turns out, we want to track the full logical state of a target vcpu,
so we need real s390 cpu states.

This patch is based on an initial patch by Jason Herne, but was heavily
rewritten when adding the cpu states STOPPED and OPERATING. On the way we
move add_del_running to cpu.c (the declaration is already in cpu.h) and
modify the users where appropriate.

Please note that the cpu is still set to be stopped when it is
halted, which is wrong. This will be fixed in the next patch. The LOAD and
CHECK-STOP state will not be used in the first step.

Signed-off-by: Jason J. Herne <jjherne@us.ibm.com>
Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
[folded Jason's patch into David's patch to avoid add/remove same lines]
---
 hw/s390x/s390-virtio.c | 32 --------------------------------
 target-s390x/cpu.c     | 43 +++++++++++++++++++++++++++++++++++++++++++
 target-s390x/cpu.h     | 14 ++++++++++++++
 3 files changed, 57 insertions(+), 32 deletions(-)

diff --git a/hw/s390x/s390-virtio.c b/hw/s390x/s390-virtio.c
index 93c7ace..91baa18 100644
--- a/hw/s390x/s390-virtio.c
+++ b/hw/s390x/s390-virtio.c
@@ -124,38 +124,6 @@ static void s390_virtio_register_hcalls(void)
                                    s390_virtio_hcall_set_status);
 }
 
-/*
- * The number of running CPUs. On s390 a shutdown is the state of all CPUs
- * being either stopped or disabled (for interrupts) waiting. We have to
- * track this number to call the shutdown sequence accordingly. This
- * number is modified either on startup or while holding the big qemu lock.
- */
-static unsigned s390_running_cpus;
-
-void s390_add_running_cpu(S390CPU *cpu)
-{
-    CPUState *cs = CPU(cpu);
-
-    if (cs->halted) {
-        s390_running_cpus++;
-        cs->halted = 0;
-        cs->exception_index = -1;
-    }
-}
-
-unsigned s390_del_running_cpu(S390CPU *cpu)
-{
-    CPUState *cs = CPU(cpu);
-
-    if (cs->halted == 0) {
-        assert(s390_running_cpus >= 1);
-        s390_running_cpus--;
-        cs->halted = 1;
-        cs->exception_index = EXCP_HLT;
-    }
-    return s390_running_cpus;
-}
-
 void s390_init_ipl_dev(const char *kernel_filename,
                        const char *kernel_cmdline,
                        const char *initrd_filename,
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index c3082b7..a6edd07 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -224,6 +224,49 @@ static void s390_cpu_finalize(Object *obj)
 #endif
 }
 
+#if !defined(CONFIG_USER_ONLY)
+static unsigned s390_count_running_cpus(void)
+{
+    CPUState *cpu;
+    int nr_running = 0;
+
+    CPU_FOREACH(cpu) {
+        uint8_t state = S390_CPU(cpu)->env.cpu_state;
+        if (state == CPU_STATE_OPERATING ||
+            state == CPU_STATE_LOAD) {
+            nr_running++;
+        }
+    }
+
+    return nr_running;
+}
+
+void s390_add_running_cpu(S390CPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+
+    if (cs->halted) {
+        cpu->env.cpu_state = CPU_STATE_OPERATING;
+        cs->halted = 0;
+        cs->exception_index = -1;
+    }
+}
+
+unsigned s390_del_running_cpu(S390CPU *cpu)
+{
+    CPUState *cs = CPU(cpu);
+
+    if (cs->halted == 0) {
+        assert(s390_count_running_cpus() >= 1);
+        cpu->env.cpu_state = CPU_STATE_STOPPED;
+        cs->halted = 1;
+        cs->exception_index = EXCP_HLT;
+    }
+
+    return s390_count_running_cpus();
+}
+#endif
+
 static const VMStateDescription vmstate_s390_cpu = {
     .name = "cpu",
     .unmigratable = 1,
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index b13761d..af22ba6 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -141,6 +141,20 @@ typedef struct CPUS390XState {
     QEMUTimer *tod_timer;
 
     QEMUTimer *cpu_timer;
+
+    /*
+     * The cpu state represents the logical state of a cpu. In contrast to other
+     * architectures, there is a difference between a halt and a stop on s390.
+     * If all cpus are either stopped (including check stop) or in the disabled
+     * wait state, the vm can be shut down.
+     */
+#define CPU_STATE_UNINITIALIZED        0x00
+#define CPU_STATE_STOPPED              0x01
+#define CPU_STATE_CHECK_STOP           0x02
+#define CPU_STATE_OPERATING            0x03
+#define CPU_STATE_LOAD                 0x04
+    uint8_t cpu_state;
+
 } CPUS390XState;
 
 #include "cpu-qom.h"
-- 
1.8.4.2
