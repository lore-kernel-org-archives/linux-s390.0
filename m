Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 03/26] x86/kvmclock: Decrapify kvm_register_clock()
Date: Thu, 19 Jul 2018 16:55:22 -0400
Message-Id: <20180719205545.16512-4-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

The return value is pointless because the wrmsr cannot fail if
KVM_FEATURE_CLOCKSOURCE or KVM_FEATURE_CLOCKSOURCE2 are set.

kvm_register_clock() is only called locally so wants to be static.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_para.h |  1 -
 arch/x86/kernel/kvmclock.c      | 33 ++++++++++-----------------------
 2 files changed, 10 insertions(+), 24 deletions(-)

diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
index 3aea2658323a..4c723632c036 100644
--- a/arch/x86/include/asm/kvm_para.h
+++ b/arch/x86/include/asm/kvm_para.h
@@ -7,7 +7,6 @@
 #include <uapi/asm/kvm_para.h>
 
 extern void kvmclock_init(void);
-extern int kvm_register_clock(char *txt);
 
 #ifdef CONFIG_KVM_GUEST
 bool kvm_check_and_clear_guest_paused(void);
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index a995d7d7164c..f0a0aef5e9fa 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -187,23 +187,19 @@ struct clocksource kvm_clock = {
 };
 EXPORT_SYMBOL_GPL(kvm_clock);
 
-int kvm_register_clock(char *txt)
+static void kvm_register_clock(char *txt)
 {
-	int cpu = smp_processor_id();
-	int low, high, ret;
 	struct pvclock_vcpu_time_info *src;
+	int cpu = smp_processor_id();
+	u64 pa;
 
 	if (!hv_clock)
-		return 0;
+		return;
 
 	src = &hv_clock[cpu].pvti;
-	low = (int)slow_virt_to_phys(src) | 1;
-	high = ((u64)slow_virt_to_phys(src) >> 32);
-	ret = native_write_msr_safe(msr_kvm_system_time, low, high);
-	printk(KERN_INFO "kvm-clock: cpu %d, msr %x:%x, %s\n",
-	       cpu, high, low, txt);
-
-	return ret;
+	pa = slow_virt_to_phys(src) | 0x01ULL;
+	wrmsrl(msr_kvm_system_time, pa);
+	pr_info("kvm-clock: cpu %d, msr %llx, %s\n", cpu, pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
@@ -218,11 +214,7 @@ static void kvm_restore_sched_clock_state(void)
 #ifdef CONFIG_X86_LOCAL_APIC
 static void kvm_setup_secondary_clock(void)
 {
-	/*
-	 * Now that the first cpu already had this clocksource initialized,
-	 * we shouldn't fail.
-	 */
-	WARN_ON(kvm_register_clock("secondary cpu clock"));
+	kvm_register_clock("secondary cpu clock");
 }
 #endif
 
@@ -265,16 +257,11 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
-
-	if (kvm_register_clock("primary cpu clock")) {
-		hv_clock = NULL;
-		return;
-	}
-
 	printk(KERN_INFO "kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
+	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
+	kvm_register_clock("primary cpu clock");
 	pvclock_set_pvti_cpu0_va(hv_clock);
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
-- 
2.18.0
