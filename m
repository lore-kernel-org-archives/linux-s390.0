From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 3/5] s390x/kvm: proper use of the cpu states OPERATING and STOPPED
Date: Thu, 10 Jul 2014 15:10:37 +0200
Message-ID: <1404997839-29038-4-git-send-email-borntraeger@de.ibm.com>
References: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1404997839-29038-1-git-send-email-borntraeger@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: KVM <kvm@vger.kernel.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, linux-s390 <linux-s390@vger.kernel.org>, Cornelia Huck <cornelia.huck@de.ibm.com>, Jens Freimann <jfrei@linux.vnet.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: David Hildenbrand <dahi@linux.vnet.ibm.com>

This patch makes sure that halting a cpu and stopping a cpu are two different
things. Stopping a cpu will also set the cpu halted - this is needed for common
infrastructure to work (note that the stop and stopped flag cannot be used for
our purpose because they are already used by other mechanisms).

A cpu can be halted ("waiting") when it is operating. If interrupts are
disabled, this is called a "disabled wait", as it can't be woken up anymore. A
stopped cpu is treated like a "disabled wait" cpu, but in order to prepare for a
proper cpu state synchronization with the kvm part, we need to track the real
logical state of a cpu.

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 hw/s390x/ipl.c        |  2 +-
 target-s390x/cpu.c    | 78 +++++++++++++++++++++++++++++++++------------------
 target-s390x/cpu.h    | 14 ++++++---
 target-s390x/helper.c | 11 ++------
 target-s390x/kvm.c    | 11 ++++----
 trace-events          |  5 ++++
 6 files changed, 75 insertions(+), 46 deletions(-)

diff --git a/hw/s390x/ipl.c b/hw/s390x/ipl.c
index 4fa9cff..3b77c9a 100644
--- a/hw/s390x/ipl.c
+++ b/hw/s390x/ipl.c
@@ -176,7 +176,7 @@ static void s390_ipl_reset(DeviceState *dev)
         }
     }
 
-    s390_add_running_cpu(cpu);
+    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
 }
 
 static void s390_ipl_class_init(ObjectClass *klass, void *data)
diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index a6edd07..c5ab98f 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -26,7 +26,9 @@
 #include "cpu.h"
 #include "qemu-common.h"
 #include "qemu/timer.h"
+#include "qemu/error-report.h"
 #include "hw/hw.h"
+#include "trace.h"
 #ifndef CONFIG_USER_ONLY
 #include "sysemu/arch_init.h"
 #endif
@@ -81,7 +83,7 @@ static void s390_cpu_load_normal(CPUState *s)
     S390CPU *cpu = S390_CPU(s);
     cpu->env.psw.addr = ldl_phys(s->as, 4) & PSW_MASK_ESA_ADDR;
     cpu->env.psw.mask = PSW_MASK_32 | PSW_MASK_64;
-    s390_add_running_cpu(cpu);
+    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
 }
 #endif
 
@@ -93,11 +95,8 @@ static void s390_cpu_reset(CPUState *s)
     CPUS390XState *env = &cpu->env;
 
     env->pfault_token = -1UL;
-    s390_del_running_cpu(cpu);
     scc->parent_reset(s);
-#if !defined(CONFIG_USER_ONLY)
-    s->halted = 1;
-#endif
+    s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
     tlb_flush(s, 1);
 }
 
@@ -135,9 +134,8 @@ static void s390_cpu_full_reset(CPUState *s)
     S390CPUClass *scc = S390_CPU_GET_CLASS(cpu);
     CPUS390XState *env = &cpu->env;
 
-    s390_del_running_cpu(cpu);
-
     scc->parent_reset(s);
+    s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
 
     memset(env, 0, offsetof(CPUS390XState, cpu_num));
 
@@ -147,12 +145,7 @@ static void s390_cpu_full_reset(CPUState *s)
 
     env->pfault_token = -1UL;
 
-    /* set halted to 1 to make sure we can add the cpu in
-     * s390_ipl_cpu code, where CPUState::halted is set back to 0
-     * after incrementing the cpu counter */
 #if !defined(CONFIG_USER_ONLY)
-    s->halted = 1;
-
     if (kvm_enabled()) {
         kvm_s390_reset_vcpu(cpu);
     }
@@ -201,10 +194,7 @@ static void s390_cpu_initfn(Object *obj)
     env->tod_basetime = 0;
     env->tod_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_tod_timer, cpu);
     env->cpu_timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, s390x_cpu_timer, cpu);
-    /* set CPUState::halted state to 1 to avoid decrementing the running
-     * cpu counter in s390_cpu_reset to a negative number at
-     * initial ipl */
-    cs->halted = 1;
+    s390_cpu_set_state(CPU_STATE_STOPPED, cpu);
 #endif
     env->cpu_num = cpu_num++;
     env->ext_index = -1;
@@ -225,6 +215,12 @@ static void s390_cpu_finalize(Object *obj)
 }
 
 #if !defined(CONFIG_USER_ONLY)
+static bool disabled_wait(CPUState *cpu)
+{
+    return cpu->halted && !(S390_CPU(cpu)->env.psw.mask &
+                            (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK));
+}
+
 static unsigned s390_count_running_cpus(void)
 {
     CPUState *cpu;
@@ -234,34 +230,60 @@ static unsigned s390_count_running_cpus(void)
         uint8_t state = S390_CPU(cpu)->env.cpu_state;
         if (state == CPU_STATE_OPERATING ||
             state == CPU_STATE_LOAD) {
-            nr_running++;
+            if (!disabled_wait(cpu)) {
+                nr_running++;
+            }
         }
     }
 
     return nr_running;
 }
 
-void s390_add_running_cpu(S390CPU *cpu)
+unsigned int s390_cpu_halt(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
+    trace_cpu_halt(cs->cpu_index);
 
-    if (cs->halted) {
-        cpu->env.cpu_state = CPU_STATE_OPERATING;
-        cs->halted = 0;
-        cs->exception_index = -1;
+    if (!cs->halted) {
+        cs->halted = 1;
+        cs->exception_index = EXCP_HLT;
     }
+
+    return s390_count_running_cpus();
 }
 
-unsigned s390_del_running_cpu(S390CPU *cpu)
+void s390_cpu_unhalt(S390CPU *cpu)
 {
     CPUState *cs = CPU(cpu);
+    trace_cpu_unhalt(cs->cpu_index);
 
-    if (cs->halted == 0) {
-        assert(s390_count_running_cpus() >= 1);
-        cpu->env.cpu_state = CPU_STATE_STOPPED;
-        cs->halted = 1;
-        cs->exception_index = EXCP_HLT;
+    if (cs->halted) {
+        cs->halted = 0;
+        cs->exception_index = -1;
+    }
+}
+
+unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
+ {
+    trace_cpu_set_state(CPU(cpu)->cpu_index, cpu_state);
+
+    switch (cpu_state) {
+    case CPU_STATE_STOPPED:
+    case CPU_STATE_CHECK_STOP:
+        /* halt the cpu for common infrastructure */
+        s390_cpu_halt(cpu);
+        break;
+    case CPU_STATE_OPERATING:
+    case CPU_STATE_LOAD:
+        /* unhalt the cpu for common infrastructure */
+        s390_cpu_unhalt(cpu);
+        break;
+    default:
+        error_report("Requested CPU state is not a valid S390 CPU state: %u",
+                     cpu_state);
+        exit(1);
     }
+    cpu->env.cpu_state = cpu_state;
 
     return s390_count_running_cpus();
 }
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index af22ba6..892726c 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -392,8 +392,9 @@ static inline void kvm_s390_service_interrupt(uint32_t parm)
 }
 #endif
 S390CPU *s390_cpu_addr2state(uint16_t cpu_addr);
-void s390_add_running_cpu(S390CPU *cpu);
-unsigned s390_del_running_cpu(S390CPU *cpu);
+unsigned int s390_cpu_halt(S390CPU *cpu);
+void s390_cpu_unhalt(S390CPU *cpu);
+unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu);
 
 /* service interrupts are floating therefore we must not pass an cpustate */
 void s390_sclp_extint(uint32_t parm);
@@ -402,11 +403,16 @@ void s390_sclp_extint(uint32_t parm);
 extern const hwaddr virtio_size;
 
 #else
-static inline void s390_add_running_cpu(S390CPU *cpu)
+static inline unsigned int s390_cpu_halt(S390CPU *cpu)
+{
+    return 0;
+}
+
+static inline void s390_cpu_unhalt(S390CPU *cpu)
 {
 }
 
-static inline unsigned s390_del_running_cpu(S390CPU *cpu)
+static inline unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
 {
     return 0;
 }
diff --git a/target-s390x/helper.c b/target-s390x/helper.c
index 67ab106..cd33500 100644
--- a/target-s390x/helper.c
+++ b/target-s390x/helper.c
@@ -506,16 +506,11 @@ void load_psw(CPUS390XState *env, uint64_t mask, uint64_t addr)
 {
     if (mask & PSW_MASK_WAIT) {
         S390CPU *cpu = s390_env_get_cpu(env);
-        CPUState *cs = CPU(cpu);
-        if (!(mask & (PSW_MASK_IO | PSW_MASK_EXT | PSW_MASK_MCHECK))) {
-            if (s390_del_running_cpu(cpu) == 0) {
+        if (s390_cpu_halt(cpu) == 0) {
 #ifndef CONFIG_USER_ONLY
-                qemu_system_shutdown_request();
+            qemu_system_shutdown_request();
 #endif
-            }
         }
-        cs->halted = 1;
-        cs->exception_index = EXCP_HLT;
     }
 
     env->psw.addr = addr;
@@ -818,7 +813,7 @@ void s390_cpu_do_interrupt(CPUState *cs)
     qemu_log_mask(CPU_LOG_INT, "%s: %d at pc=%" PRIx64 "\n",
                   __func__, cs->exception_index, env->psw.addr);
 
-    s390_add_running_cpu(cpu);
+    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
     /* handle machine checks */
     if ((env->psw.mask & PSW_MASK_MCHECK) &&
         (cs->exception_index == -1)) {
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index a6e587b..db2e42c 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -895,7 +895,7 @@ static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
 
 static int kvm_s390_cpu_start(S390CPU *cpu)
 {
-    s390_add_running_cpu(cpu);
+    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
     qemu_cpu_kick(CPU(cpu));
     DPRINTF("DONE: KVM cpu start: %p\n", &cpu->env);
     return 0;
@@ -908,7 +908,7 @@ int kvm_s390_cpu_restart(S390CPU *cpu)
     };
 
     kvm_s390_vcpu_interrupt(cpu, &irq);
-    s390_add_running_cpu(cpu);
+    s390_cpu_set_state(CPU_STATE_OPERATING, cpu);
     qemu_cpu_kick(CPU(cpu));
     DPRINTF("DONE: KVM cpu restart: %p\n", &cpu->env);
     return 0;
@@ -1042,7 +1042,7 @@ static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
     error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",
                  str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
                  ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
-    s390_del_running_cpu(cpu);
+    s390_cpu_halt(cpu);
     guest_panicked();
 }
 
@@ -1071,7 +1071,8 @@ static int handle_intercept(S390CPU *cpu)
             break;
         case ICPT_WAITPSW:
             /* disabled wait, since enabled wait is handled in kernel */
-            if (s390_del_running_cpu(cpu) == 0) {
+            cpu_synchronize_state(cs);
+            if (s390_cpu_halt(cpu) == 0) {
                 if (is_special_wait_psw(cs)) {
                     qemu_system_shutdown_request();
                 } else {
@@ -1081,7 +1082,7 @@ static int handle_intercept(S390CPU *cpu)
             r = EXCP_HALTED;
             break;
         case ICPT_CPU_STOP:
-            if (s390_del_running_cpu(cpu) == 0) {
+            if (s390_cpu_set_state(CPU_STATE_STOPPED, cpu) == 0) {
                 qemu_system_shutdown_request();
             }
             r = EXCP_HALTED;
diff --git a/trace-events b/trace-events
index 11a17a8..c652606 100644
--- a/trace-events
+++ b/trace-events
@@ -1301,3 +1301,8 @@ mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
 # target-s390x/kvm.c
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
+
+# target-s390x/cpu.c
+cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
+cpu_halt(int cpu_index) "halting cpu %d"
+cpu_unhalt(int cpu_index) "unhalting cpu %d"
-- 
1.8.4.2
