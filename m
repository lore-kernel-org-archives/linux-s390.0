Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54542 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2392127AbhARNSh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 18 Jan 2021 08:18:37 -0500
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 1/1] KVM: s390: diag9c forwarding
Date: Mon, 18 Jan 2021 14:17:39 +0100
Message-Id: <20210118131739.7272-2-borntraeger@de.ibm.com>
In-Reply-To: <20210118131739.7272-1-borntraeger@de.ibm.com>
References: <20210118131739.7272-1-borntraeger@de.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Pierre Morel <pmorel@linux.ibm.com>, Thomas Huth <thuth@redhat.com>

From: Pierre Morel <pmorel@linux.ibm.com>

When we receive intercept a DIAG_9C from the guest we verify
that the target real CPU associated with the virtual CPU
designated by the guest is running and if not we forward the
DIAG_9C to the target real CPU.

To avoid a diag9c storm we allow a maximal rate of diag9c forwarding.

The rate is calculated as a count per second defined as a
new parameter of the s390 kvm module: diag9c_forwarding_hz .

The default value is to not forward diag9c.

Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 arch/s390/include/asm/kvm_host.h |  1 +
 arch/s390/include/asm/smp.h      |  1 +
 arch/s390/kernel/smp.c           |  1 +
 arch/s390/kvm/diag.c             | 31 ++++++++++++++++++++++++++++---
 arch/s390/kvm/kvm-s390.c         |  6 ++++++
 arch/s390/kvm/kvm-s390.h         |  8 ++++++++
 6 files changed, 45 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
index 74f9a036bab2..98ae55f79620 100644
--- a/arch/s390/include/asm/kvm_host.h
+++ b/arch/s390/include/asm/kvm_host.h
@@ -455,6 +455,7 @@ struct kvm_vcpu_stat {
 	u64 diagnose_44;
 	u64 diagnose_9c;
 	u64 diagnose_9c_ignored;
+	u64 diagnose_9c_forward;
 	u64 diagnose_258;
 	u64 diagnose_308;
 	u64 diagnose_500;
diff --git a/arch/s390/include/asm/smp.h b/arch/s390/include/asm/smp.h
index 01e360004481..e317fd4866c1 100644
--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -63,5 +63,6 @@ extern void __noreturn cpu_die(void);
 extern void __cpu_die(unsigned int cpu);
 extern int __cpu_disable(void);
 extern void schedule_mcck_handler(void);
+void notrace smp_yield_cpu(int cpu);
 
 #endif /* __ASM_SMP_H */
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index c5abbb94ac6e..32622e9c15f0 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -422,6 +422,7 @@ void notrace smp_yield_cpu(int cpu)
 	asm volatile("diag %0,0,0x9c"
 		     : : "d" (pcpu_devices[cpu].address));
 }
+EXPORT_SYMBOL(smp_yield_cpu);
 
 /*
  * Send cpus emergency shutdown signal. This gives the cpus the
diff --git a/arch/s390/kvm/diag.c b/arch/s390/kvm/diag.c
index 5b8ec1c447e1..fc1ec4aa81ed 100644
--- a/arch/s390/kvm/diag.c
+++ b/arch/s390/kvm/diag.c
@@ -150,6 +150,19 @@ static int __diag_time_slice_end(struct kvm_vcpu *vcpu)
 	return 0;
 }
 
+static unsigned int forward_cnt;
+static unsigned long cur_slice;
+
+static int diag9c_forwarding_overrun(void)
+{
+	/* Reset the count on a new slice */
+	if (time_after(jiffies, cur_slice)) {
+		cur_slice = jiffies;
+		forward_cnt = diag9c_forwarding_hz / HZ;
+	}
+	return forward_cnt-- ? 1 : 0;
+}
+
 static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 {
 	struct kvm_vcpu *tcpu;
@@ -167,9 +180,21 @@ static int __diag_time_slice_end_directed(struct kvm_vcpu *vcpu)
 	if (!tcpu)
 		goto no_yield;
 
-	/* target already running */
-	if (READ_ONCE(tcpu->cpu) >= 0)
-		goto no_yield;
+	/* target VCPU already running */
+	if (READ_ONCE(tcpu->cpu) >= 0) {
+		if (!diag9c_forwarding_hz || diag9c_forwarding_overrun())
+			goto no_yield;
+
+		/* target CPU already running */
+		if (!vcpu_is_preempted(tcpu->cpu))
+			goto no_yield;
+		smp_yield_cpu(tcpu->cpu);
+		VCPU_EVENT(vcpu, 5,
+			   "diag time slice end directed to %d: yield forwarded",
+			   tid);
+		vcpu->stat.diagnose_9c_forward++;
+		return 0;
+	}
 
 	if (kvm_vcpu_yield_to(tcpu) <= 0)
 		goto no_yield;
diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
index 759bbc012b6c..9b98db81db31 100644
--- a/arch/s390/kvm/kvm-s390.c
+++ b/arch/s390/kvm/kvm-s390.c
@@ -158,6 +158,7 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	VCPU_STAT("instruction_diag_44", diagnose_44),
 	VCPU_STAT("instruction_diag_9c", diagnose_9c),
 	VCPU_STAT("diag_9c_ignored", diagnose_9c_ignored),
+	VCPU_STAT("diag_9c_forward", diagnose_9c_forward),
 	VCPU_STAT("instruction_diag_258", diagnose_258),
 	VCPU_STAT("instruction_diag_308", diagnose_308),
 	VCPU_STAT("instruction_diag_500", diagnose_500),
@@ -191,6 +192,11 @@ static bool use_gisa  = true;
 module_param(use_gisa, bool, 0644);
 MODULE_PARM_DESC(use_gisa, "Use the GISA if the host supports it.");
 
+/* maximum diag9c forwarding per second */
+unsigned int diag9c_forwarding_hz;
+module_param(diag9c_forwarding_hz, uint, 0644);
+MODULE_PARM_DESC(diag9c_forwarding_hz, "Maximum diag9c forwarding per second");
+
 /*
  * For now we handle at most 16 double words as this is what the s390 base
  * kernel handles and stores in the prefix page. If we ever need to go beyond
diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
index 79dcd647b378..9fad25109b0d 100644
--- a/arch/s390/kvm/kvm-s390.h
+++ b/arch/s390/kvm/kvm-s390.h
@@ -471,4 +471,12 @@ void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
  * @kvm: the KVM guest
  */
 void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
+
+/**
+ * diag9c_forwarding_hz
+ *
+ * Set the maximum number of diag9c forwarding per second
+ */
+extern unsigned int diag9c_forwarding_hz;
+
 #endif
-- 
2.28.0
