From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH/RFC 5/5] s390x/kvm: propagate s390 cpu state to kvm
Date: Thu, 10 Jul 2014 15:10:39 +0200
Message-ID: <1404997839-29038-6-git-send-email-borntraeger@de.ibm.com>
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

Let QEMU propagate the cpu state to kvm. If kvm doesn't yet support it, it is
silently ignored as kvm will still handle the cpu state itself in that case.

The state is not synced back, thus kvm won't have a chance to actively modify
the cpu state. To do so, control has to be given back to QEMU (which is already
done so in all relevant cases).

Setting of the cpu state can fail either because kvm doesn't support the
interface yet, or because the state is invalid/not supported. Failed attempts
will be traced

Signed-off-by: David Hildenbrand <dahi@linux.vnet.ibm.com>
Reviewed-by: Thomas Huth <thuth@linux.vnet.ibm.com>
Reviewed-by: Cornelia Huck <cornelia.huck@de.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 target-s390x/cpu.c |  3 +++
 target-s390x/cpu.h |  5 +++++
 target-s390x/kvm.c | 33 +++++++++++++++++++++++++++++++++
 trace-events       |  1 +
 4 files changed, 42 insertions(+)

diff --git a/target-s390x/cpu.c b/target-s390x/cpu.c
index 1d32f5a..cf62ebd 100644
--- a/target-s390x/cpu.c
+++ b/target-s390x/cpu.c
@@ -289,6 +289,9 @@ unsigned int s390_cpu_set_state(uint8_t cpu_state, S390CPU *cpu)
                      cpu_state);
         exit(1);
     }
+    if (kvm_enabled() && cpu->env.cpu_state != cpu_state) {
+        kvm_s390_set_cpu_state(cpu, cpu_state);
+    }
     cpu->env.cpu_state = cpu_state;
 
     return s390_count_running_cpus();
diff --git a/target-s390x/cpu.h b/target-s390x/cpu.h
index 892726c..ce4a6ca 100644
--- a/target-s390x/cpu.h
+++ b/target-s390x/cpu.h
@@ -1088,6 +1088,7 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
                                     int vq, bool assign);
 int kvm_s390_cpu_restart(S390CPU *cpu);
 void kvm_s390_clear_cmma_callback(void *opaque);
+int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state);
 #else
 static inline void kvm_s390_io_interrupt(uint16_t subchannel_id,
                                         uint16_t subchannel_nr,
@@ -1114,6 +1115,10 @@ static inline int kvm_s390_cpu_restart(S390CPU *cpu)
 static inline void kvm_s390_clear_cmma_callback(void *opaque)
 {
 }
+static inline int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+{
+    return -ENOSYS;
+}
 #endif
 
 static inline void cmma_reset(S390CPU *cpu)
diff --git a/target-s390x/kvm.c b/target-s390x/kvm.c
index 00125f1..d8ecd0b 100644
--- a/target-s390x/kvm.c
+++ b/target-s390x/kvm.c
@@ -1289,3 +1289,36 @@ int kvm_s390_assign_subch_ioeventfd(EventNotifier *notifier, uint32_t sch,
     }
     return kvm_vm_ioctl(kvm_state, KVM_IOEVENTFD, &kick);
 }
+
+int kvm_s390_set_cpu_state(S390CPU *cpu, uint8_t cpu_state)
+{
+    struct kvm_mp_state mp_state = {};
+    int ret;
+
+    switch (cpu_state) {
+    case CPU_STATE_STOPPED:
+        mp_state.mp_state = KVM_MP_STATE_STOPPED;
+        break;
+    case CPU_STATE_CHECK_STOP:
+        mp_state.mp_state = KVM_MP_STATE_CHECK_STOP;
+        break;
+    case CPU_STATE_OPERATING:
+        mp_state.mp_state = KVM_MP_STATE_OPERATING;
+        break;
+    case CPU_STATE_LOAD:
+        mp_state.mp_state = KVM_MP_STATE_LOAD;
+        break;
+    default:
+        error_report("Requested CPU state is not a valid S390 CPU state: %u",
+                     cpu_state);
+        exit(1);
+    }
+
+    ret = kvm_vcpu_ioctl(CPU(cpu), KVM_SET_MP_STATE, &mp_state);
+    if (ret) {
+        trace_kvm_failed_cpu_state_set(CPU(cpu)->cpu_index, cpu_state,
+                                       strerror(-ret));
+    }
+
+    return ret;
+}
diff --git a/trace-events b/trace-events
index c652606..56a7dab 100644
--- a/trace-events
+++ b/trace-events
@@ -1301,6 +1301,7 @@ mhp_pc_dimm_assigned_address(uint64_t addr) "0x%"PRIx64
 # target-s390x/kvm.c
 kvm_enable_cmma(int rc) "CMMA: enabling with result code %d"
 kvm_clear_cmma(int rc) "CMMA: clearing with result code %d"
+kvm_failed_cpu_state_set(int cpu_index, uint8_t state, const char *msg) "Warning: Unable to set cpu %d state %" PRIu8 " to KVM: %s"
 
 # target-s390x/cpu.c
 cpu_set_state(int cpu_index, uint8_t state) "setting cpu %d state to %" PRIu8
-- 
1.8.4.2
