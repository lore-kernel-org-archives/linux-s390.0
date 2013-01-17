From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 09/12] s390: Wire up channel I/O in kvm.
Date: Thu, 17 Jan 2013 15:23:54 +0100
Message-ID: <1358432637-42512-10-git-send-email-cornelia.huck@de.ibm.com>
References: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1358432637-42512-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: qemu-devel <qemu-devel@nongnu.org>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>, Gleb Natapov <gleb@redhat.com>, Anthony Liguori <aliguori@us.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Trigger the code for our virtual css in case of instruction
intercepts for I/O instructions.

Handle the tsch exit for the subchannel-related part of tsch.

Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 target-s390x/cpu.h |  11 +++
 target-s390x/kvm.c | 252 ++++++++++++++++++++++++++++++++++++++++++++++++++---
 2 files changed, 250 insertions(+), 13 deletions(-)

diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index b619edb..4438dc8 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -1136,6 +1136,13 @@ void program_interrupt(CPUS390XState *env, uint32_t code, int ilen);
 void QEMU_NORETURN runtime_exception(CPUS390XState *env, int excp,
                                      uintptr_t retaddr);
 
+#ifdef CONFIG_KVM
+int kvm_s390_io_interrupt(S390CPU *cpu, uint16_t subchannel_id,
+                          uint16_t subchannel_nr, uint32_t io_int_parm,
+                          uint32_t io_int_word);
+int kvm_s390_crw_mchk(S390CPU *cpu);
+void kvm_s390_enable_css_support(S390CPU *cpu);
+#else
 static inline int kvm_s390_io_interrupt(S390CPU *cpu,
                                         uint16_t subchannel_id,
                                         uint16_t subchannel_nr,
@@ -1148,6 +1155,10 @@ static inline int kvm_s390_crw_mchk(S390CPU *cpu)
 {
     return -EOPNOTSUPP;
 }
+static inline void kvm_s390_enable_css_support(S390CPU *cpu)
+{
+}
+#endif
 
 static inline void s390_io_interrupt(S390CPU *cpu,
                                      uint16_t subchannel_id,
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index ae6ae07..7578880 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -30,6 +30,7 @@
 #include "sysemu/kvm.h"
 #include "cpu.h"
 #include "sysemu/device_tree.h"
+#include "ioinst.h"
 
 /* #define DEBUG_KVM */
 
@@ -43,9 +44,29 @@
 
 #define IPA0_DIAG                       0x8300
 #define IPA0_SIGP                       0xae00
-#define IPA0_PRIV                       0xb200
+#define IPA0_B2                         0xb200
+#define IPA0_B9                         0xb900
+#define IPA0_EB                         0xeb00
 
 #define PRIV_SCLP_CALL                  0x20
+#define PRIV_CSCH                       0x30
+#define PRIV_HSCH                       0x31
+#define PRIV_MSCH                       0x32
+#define PRIV_SSCH                       0x33
+#define PRIV_STSCH                      0x34
+#define PRIV_TSCH                       0x35
+#define PRIV_TPI                        0x36
+#define PRIV_SAL                        0x37
+#define PRIV_RSCH                       0x38
+#define PRIV_STCRW                      0x39
+#define PRIV_STCPS                      0x3a
+#define PRIV_RCHP                       0x3b
+#define PRIV_SCHM                       0x3c
+#define PRIV_CHSC                       0x5f
+#define PRIV_SIGA                       0x74
+#define PRIV_XSCH                       0x76
+#define PRIV_SQBS                       0x8a
+#define PRIV_EQBS                       0x9c
 #define DIAG_KVM_HYPERCALL              0x500
 #define DIAG_KVM_BREAKPOINT             0x501
 
@@ -364,10 +385,123 @@ static int kvm_sclp_service_call(S390CPU *cpu, struct kvm_run *run,
     return 0;
 }
 
-static int handle_priv(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
+static int kvm_handle_css_inst(S390CPU *cpu, struct kvm_run *run,
+                               uint8_t ipa0, uint8_t ipa1, uint8_t ipb)
+{
+    int r = 0;
+    int no_cc = 0;
+    CPUS390XState *env = &cpu->env;
+
+    if (ipa0 != 0xb2) {
+        /* Not handled for now. */
+        return -1;
+    }
+    cpu_synchronize_state(env);
+    switch (ipa1) {
+    case PRIV_XSCH:
+        r = ioinst_handle_xsch(env, env->regs[1]);
+        break;
+    case PRIV_CSCH:
+        r = ioinst_handle_csch(env, env->regs[1]);
+        break;
+    case PRIV_HSCH:
+        r = ioinst_handle_hsch(env, env->regs[1]);
+        break;
+    case PRIV_MSCH:
+        r = ioinst_handle_msch(env, env->regs[1], run->s390_sieic.ipb);
+        break;
+    case PRIV_SSCH:
+        r = ioinst_handle_ssch(env, env->regs[1], run->s390_sieic.ipb);
+        break;
+    case PRIV_STCRW:
+        r = ioinst_handle_stcrw(env, run->s390_sieic.ipb);
+        break;
+    case PRIV_STSCH:
+        r = ioinst_handle_stsch(env, env->regs[1], run->s390_sieic.ipb);
+        break;
+    case PRIV_TSCH:
+        /* We should only get tsch via KVM_EXIT_S390_TSCH. */
+        fprintf(stderr, "Spurious tsch intercept\n");
+        break;
+    case PRIV_CHSC:
+        r = ioinst_handle_chsc(env, run->s390_sieic.ipb);
+        break;
+    case PRIV_TPI:
+        /* This should have been handled by kvm already. */
+        fprintf(stderr, "Spurious tpi intercept\n");
+        break;
+    case PRIV_SCHM:
+        no_cc = 1;
+        r = ioinst_handle_schm(env, env->regs[1], env->regs[2],
+                               run->s390_sieic.ipb);
+        break;
+    case PRIV_RSCH:
+        r = ioinst_handle_rsch(env, env->regs[1]);
+        break;
+    case PRIV_RCHP:
+        r = ioinst_handle_rchp(env, env->regs[1]);
+        break;
+    case PRIV_STCPS:
+        /* We do not provide this instruction, it is suppressed. */
+        no_cc = 1;
+        r = 0;
+        break;
+    case PRIV_SAL:
+        no_cc = 1;
+        r = ioinst_handle_sal(env, env->regs[1]);
+        break;
+    default:
+        r = -1;
+        break;
+    }
+
+    if (r >= 0) {
+        if (!no_cc) {
+            setcc(cpu, r);
+        }
+        r = 0;
+    } else if (r < -1) {
+        r = 0;
+    }
+    return r;
+}
+
+static int is_ioinst(uint8_t ipa0, uint8_t ipa1, uint8_t ipb)
+{
+    int ret = 0;
+    uint16_t ipa = (ipa0 << 8) | ipa1;
+
+    switch (ipa) {
+    case IPA0_B2 | PRIV_CSCH:
+    case IPA0_B2 | PRIV_HSCH:
+    case IPA0_B2 | PRIV_MSCH:
+    case IPA0_B2 | PRIV_SSCH:
+    case IPA0_B2 | PRIV_STSCH:
+    case IPA0_B2 | PRIV_TPI:
+    case IPA0_B2 | PRIV_SAL:
+    case IPA0_B2 | PRIV_RSCH:
+    case IPA0_B2 | PRIV_STCRW:
+    case IPA0_B2 | PRIV_STCPS:
+    case IPA0_B2 | PRIV_RCHP:
+    case IPA0_B2 | PRIV_SCHM:
+    case IPA0_B2 | PRIV_CHSC:
+    case IPA0_B2 | PRIV_SIGA:
+    case IPA0_B2 | PRIV_XSCH:
+    case IPA0_B9 | PRIV_EQBS:
+    case IPA0_EB | PRIV_SQBS:
+        ret = 1;
+        break;
+    }
+
+    return ret;
+}
+
+static int handle_priv(S390CPU *cpu, struct kvm_run *run,
+                       uint8_t ipa0, uint8_t ipa1)
 {
     int r = 0;
     uint16_t ipbh0 = (run->s390_sieic.ipb & 0xffff0000) >> 16;
+    uint8_t ipb = run->s390_sieic.ipb & 0xff;
 
     dprintf("KVM: PRIV: %d\n", ipa1);
     switch (ipa1) {
@@ -375,8 +509,16 @@ static int handle_priv(S390CPU *cpu, struct kvm_run *run, uint8_t ipa1)
             r = kvm_sclp_service_call(cpu, run, ipbh0);
             break;
         default:
-            dprintf("KVM: unknown PRIV: 0x%x\n", ipa1);
-            r = -1;
+            if (is_ioinst(ipa0, ipa1, ipb)) {
+                r = kvm_handle_css_inst(cpu, run, ipa0, ipa1, ipb);
+                if (r == -1) {
+                    setcc(cpu, 3);
+                    r = 0;
+                }
+            } else {
+                dprintf("KVM: unknown PRIV: 0x%x\n", ipa1);
+                r = -1;
+            }
             break;
     }
 
@@ -517,15 +659,17 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
 
     dprintf("handle_instruction 0x%x 0x%x\n", run->s390_sieic.ipa, run->s390_sieic.ipb);
     switch (ipa0) {
-        case IPA0_PRIV:
-            r = handle_priv(cpu, run, ipa1);
-            break;
-        case IPA0_DIAG:
-            r = handle_diag(env, run, ipb_code);
-            break;
-        case IPA0_SIGP:
-            r = handle_sigp(cpu, run, ipa1);
-            break;
+    case IPA0_B2:
+    case IPA0_B9:
+    case IPA0_EB:
+        r = handle_priv(cpu, run, ipa0 >> 8, ipa1);
+        break;
+    case IPA0_DIAG:
+        r = handle_diag(env, run, ipb_code);
+        break;
+    case IPA0_SIGP:
+        r = handle_sigp(cpu, run, ipa1);
+        break;
     }
 
     if (r < 0) {
@@ -584,6 +728,43 @@ static int handle_intercept(S390CPU *cpu)
     return r;
 }
 
+static int handle_tsch(S390CPU *cpu)
+{
+    CPUS390XState *env = &cpu->env;
+    CPUState *cs = CPU(cpu);
+    struct kvm_run *run = cs->kvm_run;
+    int ret;
+
+    cpu_synchronize_state(env);
+    ret = ioinst_handle_tsch(env, env->regs[1], run->s390_tsch.ipb);
+    if (ret >= 0) {
+        /* Success; set condition code. */
+        setcc(cpu, ret);
+        ret = 0;
+    } else if (ret < -1) {
+        /*
+         * Failure.
+         * If an I/O interrupt had been dequeued, we have to reinject it.
+         */
+        if (run->s390_tsch.dequeued) {
+            uint16_t subchannel_id = run->s390_tsch.subchannel_id;
+            uint16_t subchannel_nr = run->s390_tsch.subchannel_nr;
+            uint32_t io_int_parm = run->s390_tsch.io_int_parm;
+            uint32_t io_int_word = run->s390_tsch.io_int_word;
+            uint32_t type = ((subchannel_id & 0xff00) << 24) |
+                ((subchannel_id & 0x00060) << 22) | (subchannel_nr << 16);
+
+            kvm_s390_interrupt_internal(cpu, type,
+                                        ((uint32_t)subchannel_id << 16)
+                                        | subchannel_nr,
+                                        ((uint64_t)io_int_parm << 32)
+                                        | io_int_word, 1);
+        }
+        ret = 0;
+    }
+    return ret;
+}
+
 int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
 {
     S390CPU *cpu = S390_CPU(cs);
@@ -596,6 +777,9 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
         case KVM_EXIT_S390_RESET:
             qemu_system_reset_request();
             break;
+        case KVM_EXIT_S390_TSCH:
+            ret = handle_tsch(cpu);
+            break;
         default:
             fprintf(stderr, "Unknown KVM exit: %d\n", run->exit_reason);
             break;
@@ -621,3 +805,45 @@ int kvm_arch_on_sigbus(int code, void *addr)
 {
     return 1;
 }
+
+int kvm_s390_io_interrupt(S390CPU *cpu, uint16_t subchannel_id,
+                          uint16_t subchannel_nr, uint32_t io_int_parm,
+                          uint32_t io_int_word)
+{
+    uint32_t type;
+
+    if (!kvm_enabled()) {
+        return -EOPNOTSUPP;
+    }
+
+    type = ((subchannel_id & 0xff00) << 24) |
+        ((subchannel_id & 0x00060) << 22) | (subchannel_nr << 16);
+    kvm_s390_interrupt_internal(cpu, type,
+                                ((uint32_t)subchannel_id << 16) | subchannel_nr,
+                                ((uint64_t)io_int_parm << 32) | io_int_word, 1);
+    return 0;
+}
+
+int kvm_s390_crw_mchk(S390CPU *cpu)
+{
+    if (!kvm_enabled()) {
+        return -EOPNOTSUPP;
+    }
+
+    kvm_s390_interrupt_internal(cpu, KVM_S390_MCHK, 1 << 28,
+                                0x00400f1d40330000, 1);
+    return 0;
+}
+
+void kvm_s390_enable_css_support(S390CPU *cpu)
+{
+    struct kvm_enable_cap cap = {};
+    int r;
+
+    /* Activate host kernel channel subsystem support. */
+    if (kvm_enabled()) {
+        cap.cap = KVM_CAP_S390_CSS_SUPPORT;
+        r = kvm_vcpu_ioctl(CPU(cpu), KVM_ENABLE_CAP, &cap);
+        assert(r == 0);
+    }
+}
-- 
1.7.12.4
