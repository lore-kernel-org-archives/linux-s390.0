From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: [PATCH 2/6] s390/smp/kvm: unifiy sigp definitions
Date: Tue, 26 Jun 2012 16:06:37 +0200
Message-ID: <1340719601-11867-3-git-send-email-cornelia.huck@de.ibm.com>
References: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1340719601-11867-1-git-send-email-cornelia.huck@de.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Avi Kivity <avi@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Carsten Otte <cotte@de.ibm.com>, Alexander Graf <agraf@suse.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The smp and the kvm code have different defines for the sigp order codes.
Let's just have a single place where these are defined.
Also move the sigp condition code and sigp cpu status bits to the new
sigp.h header file.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Signed-off-by: Cornelia Huck <cornelia.huck@de.ibm.com>
---
 arch/s390/include/asm/sigp.h |   31 ++++++++++++++++++
 arch/s390/kernel/smp.c       |   72 ++++++++++++++----------------------------
 arch/s390/kvm/sigp.c         |   46 ++++++---------------------
 3 files changed, 64 insertions(+), 85 deletions(-)
 create mode 100644 arch/s390/include/asm/sigp.h

diff --git a/arch/s390/include/asm/sigp.h b/arch/s390/include/asm/sigp.h
new file mode 100644
index 0000000..7306270
--- /dev/null
+++ b/arch/s390/include/asm/sigp.h
@@ -0,0 +1,31 @@
+#ifndef __S390_ASM_SIGP_H
+#define __S390_ASM_SIGP_H
+
+/* SIGP order codes */
+#define SIGP_SENSE		      1
+#define SIGP_EXTERNAL_CALL	      2
+#define SIGP_EMERGENCY_SIGNAL	      3
+#define SIGP_STOP		      5
+#define SIGP_RESTART		      6
+#define SIGP_STOP_AND_STORE_STATUS    9
+#define SIGP_INITIAL_CPU_RESET	     11
+#define SIGP_SET_PREFIX		     13
+#define SIGP_STORE_STATUS_AT_ADDRESS 14
+#define SIGP_SET_ARCHITECTURE	     18
+#define SIGP_SENSE_RUNNING	     21
+
+/* SIGP condition codes */
+#define SIGP_CC_ORDER_CODE_ACCEPTED 0
+#define SIGP_CC_STATUS_STORED	    1
+#define SIGP_CC_BUSY		    2
+#define SIGP_CC_NOT_OPERATIONAL	    3
+
+/* SIGP cpu status bits */
+
+#define SIGP_STATUS_CHECK_STOP		0x00000010UL
+#define SIGP_STATUS_STOPPED		0x00000040UL
+#define SIGP_STATUS_INVALID_PARAMETER	0x00000100UL
+#define SIGP_STATUS_INCORRECT_STATE	0x00000200UL
+#define SIGP_STATUS_NOT_RUNNING		0x00000400UL
+
+#endif /* __S390_ASM_SIGP_H */
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index c78074c..6e4047e 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -44,34 +44,10 @@
 #include <asm/vdso.h>
 #include <asm/debug.h>
 #include <asm/os_info.h>
+#include <asm/sigp.h>
 #include "entry.h"
 
 enum {
-	sigp_sense = 1,
-	sigp_external_call = 2,
-	sigp_emergency_signal = 3,
-	sigp_start = 4,
-	sigp_stop = 5,
-	sigp_restart = 6,
-	sigp_stop_and_store_status = 9,
-	sigp_initial_cpu_reset = 11,
-	sigp_cpu_reset = 12,
-	sigp_set_prefix = 13,
-	sigp_store_status_at_address = 14,
-	sigp_store_extended_status_at_address = 15,
-	sigp_set_architecture = 18,
-	sigp_conditional_emergency_signal = 19,
-	sigp_sense_running = 21,
-};
-
-enum {
-	sigp_order_code_accepted = 0,
-	sigp_status_stored = 1,
-	sigp_busy = 2,
-	sigp_not_operational = 3,
-};
-
-enum {
 	ec_schedule = 0,
 	ec_call_function,
 	ec_call_function_single,
@@ -124,7 +100,7 @@ static inline int __pcpu_sigp_relax(u16 addr, u8 order, u32 parm, u32 *status)
 
 	while (1) {
 		cc = __pcpu_sigp(addr, order, parm, status);
-		if (cc != sigp_busy)
+		if (cc != SIGP_CC_BUSY)
 			return cc;
 		cpu_relax();
 	}
@@ -136,7 +112,7 @@ static int pcpu_sigp_retry(struct pcpu *pcpu, u8 order, u32 parm)
 
 	for (retry = 0; ; retry++) {
 		cc = __pcpu_sigp(pcpu->address, order, parm, &pcpu->status);
-		if (cc != sigp_busy)
+		if (cc != SIGP_CC_BUSY)
 			break;
 		if (retry >= 3)
 			udelay(10);
@@ -146,8 +122,8 @@ static int pcpu_sigp_retry(struct pcpu *pcpu, u8 order, u32 parm)
 
 static inline int pcpu_stopped(struct pcpu *pcpu)
 {
-	if (__pcpu_sigp(pcpu->address, sigp_sense,
-			0, &pcpu->status) != sigp_status_stored)
+	if (__pcpu_sigp(pcpu->address, SIGP_SENSE,
+			0, &pcpu->status) != SIGP_CC_STATUS_STORED)
 		return 0;
 	/* Check for stopped and check stop state */
 	return !!(pcpu->status & 0x50);
@@ -155,8 +131,8 @@ static inline int pcpu_stopped(struct pcpu *pcpu)
 
 static inline int pcpu_running(struct pcpu *pcpu)
 {
-	if (__pcpu_sigp(pcpu->address, sigp_sense_running,
-			0, &pcpu->status) != sigp_status_stored)
+	if (__pcpu_sigp(pcpu->address, SIGP_SENSE_RUNNING,
+			0, &pcpu->status) != SIGP_CC_STATUS_STORED)
 		return 1;
 	/* Status stored condition code is equivalent to cpu not running. */
 	return 0;
@@ -181,7 +157,7 @@ static void pcpu_ec_call(struct pcpu *pcpu, int ec_bit)
 
 	set_bit(ec_bit, &pcpu->ec_mask);
 	order = pcpu_running(pcpu) ?
-		sigp_external_call : sigp_emergency_signal;
+		SIGP_EXTERNAL_CALL : SIGP_EMERGENCY_SIGNAL;
 	pcpu_sigp_retry(pcpu, order, 0);
 }
 
@@ -214,7 +190,7 @@ static int __cpuinit pcpu_alloc_lowcore(struct pcpu *pcpu, int cpu)
 		goto out;
 #endif
 	lowcore_ptr[cpu] = lc;
-	pcpu_sigp_retry(pcpu, sigp_set_prefix, (u32)(unsigned long) lc);
+	pcpu_sigp_retry(pcpu, SIGP_SET_PREFIX, (u32)(unsigned long) lc);
 	return 0;
 out:
 	if (pcpu != &pcpu_devices[0]) {
@@ -229,7 +205,7 @@ out:
 
 static void pcpu_free_lowcore(struct pcpu *pcpu)
 {
-	pcpu_sigp_retry(pcpu, sigp_set_prefix, 0);
+	pcpu_sigp_retry(pcpu, SIGP_SET_PREFIX, 0);
 	lowcore_ptr[pcpu - pcpu_devices] = NULL;
 #ifndef CONFIG_64BIT
 	if (MACHINE_HAS_IEEE) {
@@ -288,7 +264,7 @@ static void pcpu_start_fn(struct pcpu *pcpu, void (*func)(void *), void *data)
 	lc->restart_fn = (unsigned long) func;
 	lc->restart_data = (unsigned long) data;
 	lc->restart_source = -1UL;
-	pcpu_sigp_retry(pcpu, sigp_restart, 0);
+	pcpu_sigp_retry(pcpu, SIGP_RESTART, 0);
 }
 
 /*
@@ -309,7 +285,7 @@ static void pcpu_delegate(struct pcpu *pcpu, void (*func)(void *),
 	if (pcpu->address == restart.source)
 		func(data);	/* should not return */
 	/* Stop target cpu (if func returns this stops the current cpu). */
-	pcpu_sigp_retry(pcpu, sigp_stop, 0);
+	pcpu_sigp_retry(pcpu, SIGP_STOP, 0);
 	/* Restart func on the target cpu and stop the current cpu. */
 	memcpy_absolute(&lc->restart_stack, &restart, sizeof(restart));
 	asm volatile(
@@ -388,8 +364,8 @@ void smp_emergency_stop(cpumask_t *cpumask)
 	for_each_cpu(cpu, cpumask) {
 		struct pcpu *pcpu = pcpu_devices + cpu;
 		set_bit(ec_stop_cpu, &pcpu->ec_mask);
-		while (__pcpu_sigp(pcpu->address, sigp_emergency_signal,
-				   0, NULL) == sigp_busy &&
+		while (__pcpu_sigp(pcpu->address, SIGP_EMERGENCY_SIGNAL,
+				   0, NULL) == SIGP_CC_BUSY &&
 		       get_clock() < end)
 			cpu_relax();
 	}
@@ -425,7 +401,7 @@ void smp_send_stop(void)
 	/* stop all processors */
 	for_each_cpu(cpu, &cpumask) {
 		struct pcpu *pcpu = pcpu_devices + cpu;
-		pcpu_sigp_retry(pcpu, sigp_stop, 0);
+		pcpu_sigp_retry(pcpu, SIGP_STOP, 0);
 		while (!pcpu_stopped(pcpu))
 			cpu_relax();
 	}
@@ -436,7 +412,7 @@ void smp_send_stop(void)
  */
 void smp_stop_cpu(void)
 {
-	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), sigp_stop, 0);
+	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), SIGP_STOP, 0);
 	for (;;) ;
 }
 
@@ -590,7 +566,7 @@ static void __init smp_get_save_area(int cpu, u16 address)
 	}
 #endif
 	/* Get the registers of a non-boot cpu. */
-	__pcpu_sigp_relax(address, sigp_stop_and_store_status, 0, NULL);
+	__pcpu_sigp_relax(address, SIGP_STOP_AND_STORE_STATUS, 0, NULL);
 	memcpy_real(save_area, lc + SAVE_AREA_BASE, sizeof(*save_area));
 }
 
@@ -599,8 +575,8 @@ int smp_store_status(int cpu)
 	struct pcpu *pcpu;
 
 	pcpu = pcpu_devices + cpu;
-	if (__pcpu_sigp_relax(pcpu->address, sigp_stop_and_store_status,
-			      0, NULL) != sigp_order_code_accepted)
+	if (__pcpu_sigp_relax(pcpu->address, SIGP_STOP_AND_STORE_STATUS,
+			      0, NULL) != SIGP_CC_ORDER_CODE_ACCEPTED)
 		return -EIO;
 	return 0;
 }
@@ -621,8 +597,8 @@ static struct sclp_cpu_info *smp_get_cpu_info(void)
 	if (info && (use_sigp_detection || sclp_get_cpu_info(info))) {
 		use_sigp_detection = 1;
 		for (address = 0; address <= MAX_CPU_ADDRESS; address++) {
-			if (__pcpu_sigp_relax(address, sigp_sense, 0, NULL) ==
-			    sigp_not_operational)
+			if (__pcpu_sigp_relax(address, SIGP_SENSE, 0, NULL) ==
+			    SIGP_CC_NOT_OPERATIONAL)
 				continue;
 			info->cpu[info->configured].address = address;
 			info->configured++;
@@ -734,8 +710,8 @@ int __cpuinit __cpu_up(unsigned int cpu, struct task_struct *tidle)
 	pcpu = pcpu_devices + cpu;
 	if (pcpu->state != CPU_STATE_CONFIGURED)
 		return -EIO;
-	if (pcpu_sigp_retry(pcpu, sigp_initial_cpu_reset, 0) !=
-	    sigp_order_code_accepted)
+	if (pcpu_sigp_retry(pcpu, SIGP_INITIAL_CPU_RESET, 0) !=
+	    SIGP_CC_ORDER_CODE_ACCEPTED)
 		return -EIO;
 
 	rc = pcpu_alloc_lowcore(pcpu, cpu);
@@ -795,7 +771,7 @@ void __cpu_die(unsigned int cpu)
 void __noreturn cpu_die(void)
 {
 	idle_task_exit();
-	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), sigp_stop, 0);
+	pcpu_sigp_retry(pcpu_devices + smp_processor_id(), SIGP_STOP, 0);
 	for (;;) ;
 }
 
diff --git a/arch/s390/kvm/sigp.c b/arch/s390/kvm/sigp.c
index 0ad4cf2..fda1d64 100644
--- a/arch/s390/kvm/sigp.c
+++ b/arch/s390/kvm/sigp.c
@@ -15,38 +15,10 @@
 #include <linux/kvm.h>
 #include <linux/kvm_host.h>
 #include <linux/slab.h>
+#include <asm/sigp.h>
 #include "gaccess.h"
 #include "kvm-s390.h"
 
-/* sigp order codes */
-#define SIGP_SENSE             0x01
-#define SIGP_EXTERNAL_CALL     0x02
-#define SIGP_EMERGENCY         0x03
-#define SIGP_START             0x04
-#define SIGP_STOP              0x05
-#define SIGP_RESTART           0x06
-#define SIGP_STOP_STORE_STATUS 0x09
-#define SIGP_INITIAL_CPU_RESET 0x0b
-#define SIGP_CPU_RESET         0x0c
-#define SIGP_SET_PREFIX        0x0d
-#define SIGP_STORE_STATUS_ADDR 0x0e
-#define SIGP_SET_ARCH          0x12
-#define SIGP_SENSE_RUNNING     0x15
-
-/* cpu status bits */
-#define SIGP_STAT_EQUIPMENT_CHECK   0x80000000UL
-#define SIGP_STAT_NOT_RUNNING	    0x00000400UL
-#define SIGP_STAT_INCORRECT_STATE   0x00000200UL
-#define SIGP_STAT_INVALID_PARAMETER 0x00000100UL
-#define SIGP_STAT_EXT_CALL_PENDING  0x00000080UL
-#define SIGP_STAT_STOPPED           0x00000040UL
-#define SIGP_STAT_OPERATOR_INTERV   0x00000020UL
-#define SIGP_STAT_CHECK_STOP        0x00000010UL
-#define SIGP_STAT_INOPERATIVE       0x00000004UL
-#define SIGP_STAT_INVALID_ORDER     0x00000002UL
-#define SIGP_STAT_RECEIVER_CHECK    0x00000001UL
-
-
 static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 			u64 *reg)
 {
@@ -65,7 +37,7 @@ static int __sigp_sense(struct kvm_vcpu *vcpu, u16 cpu_addr,
 		rc = 1; /* status stored */
 	} else {
 		*reg &= 0xffffffff00000000UL;
-		*reg |= SIGP_STAT_STOPPED;
+		*reg |= SIGP_STATUS_STOPPED;
 		rc = 1; /* status stored */
 	}
 	spin_unlock(&fi->lock);
@@ -235,7 +207,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	address = address & 0x7fffe000u;
 	if (copy_from_guest_absolute(vcpu, &tmp, address, 1) ||
 	   copy_from_guest_absolute(vcpu, &tmp, address + PAGE_SIZE, 1)) {
-		*reg |= SIGP_STAT_INVALID_PARAMETER;
+		*reg |= SIGP_STATUS_INVALID_PARAMETER;
 		return 1; /* invalid parameter */
 	}
 
@@ -249,7 +221,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 
 	if (li == NULL) {
 		rc = 1; /* incorrect state */
-		*reg &= SIGP_STAT_INCORRECT_STATE;
+		*reg &= SIGP_STATUS_INCORRECT_STATE;
 		kfree(inti);
 		goto out_fi;
 	}
@@ -258,7 +230,7 @@ static int __sigp_set_prefix(struct kvm_vcpu *vcpu, u16 cpu_addr, u32 address,
 	/* cpu must be in stopped state */
 	if (!(atomic_read(li->cpuflags) & CPUSTAT_STOPPED)) {
 		rc = 1; /* incorrect state */
-		*reg &= SIGP_STAT_INCORRECT_STATE;
+		*reg &= SIGP_STATUS_INCORRECT_STATE;
 		kfree(inti);
 		goto out_li;
 	}
@@ -300,7 +272,7 @@ static int __sigp_sense_running(struct kvm_vcpu *vcpu, u16 cpu_addr,
 		} else {
 			/* not running */
 			*reg &= 0xffffffff00000000UL;
-			*reg |= SIGP_STAT_NOT_RUNNING;
+			*reg |= SIGP_STATUS_NOT_RUNNING;
 			rc = 0;
 		}
 	}
@@ -375,7 +347,7 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		vcpu->stat.instruction_sigp_external_call++;
 		rc = __sigp_external_call(vcpu, cpu_addr);
 		break;
-	case SIGP_EMERGENCY:
+	case SIGP_EMERGENCY_SIGNAL:
 		vcpu->stat.instruction_sigp_emergency++;
 		rc = __sigp_emergency(vcpu, cpu_addr);
 		break;
@@ -383,12 +355,12 @@ int kvm_s390_handle_sigp(struct kvm_vcpu *vcpu)
 		vcpu->stat.instruction_sigp_stop++;
 		rc = __sigp_stop(vcpu, cpu_addr, ACTION_STOP_ON_STOP);
 		break;
-	case SIGP_STOP_STORE_STATUS:
+	case SIGP_STOP_AND_STORE_STATUS:
 		vcpu->stat.instruction_sigp_stop++;
 		rc = __sigp_stop(vcpu, cpu_addr, ACTION_STORE_ON_STOP |
 						 ACTION_STOP_ON_STOP);
 		break;
-	case SIGP_SET_ARCH:
+	case SIGP_SET_ARCHITECTURE:
 		vcpu->stat.instruction_sigp_arch++;
 		rc = __sigp_set_arch(vcpu, parameter);
 		break;
-- 
1.7.10.4
