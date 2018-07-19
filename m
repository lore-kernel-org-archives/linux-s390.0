Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 06/26] x86/kvmclock: Move kvmclock vsyscall param and init to kvmclock
Date: Thu, 19 Jul 2018 16:55:25 -0400
Message-Id: <20180719205545.16512-7-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

There is no point to have this in the kvm code itself and call it from
there. This can be called from an initcall and the parameter is cleared
when the hypervisor is not KVM.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/include/asm/kvm_guest.h |  7 -----
 arch/x86/kernel/kvm.c            | 13 ----------
 arch/x86/kernel/kvmclock.c       | 44 ++++++++++++++++++++------------
 3 files changed, 27 insertions(+), 37 deletions(-)
 delete mode 100644 arch/x86/include/asm/kvm_guest.h

diff --git a/arch/x86/include/asm/kvm_guest.h b/arch/x86/include/asm/kvm_guest.h
deleted file mode 100644
index 46185263d9c2..000000000000
--- a/arch/x86/include/asm/kvm_guest.h
+++ /dev/null
@@ -1,7 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_X86_KVM_GUEST_H
-#define _ASM_X86_KVM_GUEST_H
-
-int kvm_setup_vsyscall_timeinfo(void);
-
-#endif /* _ASM_X86_KVM_GUEST_H */
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index c65c232d3ddd..a560750cc76f 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -45,7 +45,6 @@
 #include <asm/apic.h>
 #include <asm/apicdef.h>
 #include <asm/hypervisor.h>
-#include <asm/kvm_guest.h>
 
 static int kvmapf = 1;
 
@@ -66,15 +65,6 @@ static int __init parse_no_stealacc(char *arg)
 
 early_param("no-steal-acc", parse_no_stealacc);
 
-static int kvmclock_vsyscall = 1;
-static int __init parse_no_kvmclock_vsyscall(char *arg)
-{
-        kvmclock_vsyscall = 0;
-        return 0;
-}
-
-early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
-
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_vcpu_pv_apf_data, apf_reason) __aligned(64);
 static DEFINE_PER_CPU_DECRYPTED(struct kvm_steal_time, steal_time) __aligned(64);
 static int has_steal_clock = 0;
@@ -560,9 +550,6 @@ static void __init kvm_guest_init(void)
 	if (kvm_para_has_feature(KVM_FEATURE_PV_EOI))
 		apic_set_eoi_write(kvm_guest_apic_eoi_write);
 
-	if (kvmclock_vsyscall)
-		kvm_setup_vsyscall_timeinfo();
-
 #ifdef CONFIG_SMP
 	smp_ops.smp_prepare_cpus = kvm_smp_prepare_cpus;
 	smp_ops.smp_prepare_boot_cpu = kvm_smp_prepare_boot_cpu;
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 78aec160f5e0..7d690d2238f8 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -27,12 +27,14 @@
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
 
+#include <asm/hypervisor.h>
 #include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
 #include <asm/reboot.h>
 #include <asm/kvmclock.h>
 
 static int kvmclock __initdata = 1;
+static int kvmclock_vsyscall __initdata = 1;
 static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
 static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
 static u64 kvm_sched_clock_offset __ro_after_init;
@@ -44,6 +46,13 @@ static int __init parse_no_kvmclock(char *arg)
 }
 early_param("no-kvmclock", parse_no_kvmclock);
 
+static int __init parse_no_kvmclock_vsyscall(char *arg)
+{
+	kvmclock_vsyscall = 0;
+	return 0;
+}
+early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
+
 /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
 #define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
 
@@ -228,6 +237,24 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
+static int __init kvm_setup_vsyscall_timeinfo(void)
+{
+#ifdef CONFIG_X86_64
+	u8 flags;
+
+	if (!hv_clock || !kvmclock_vsyscall)
+		return 0;
+
+	flags = pvclock_read_flags(&hv_clock[0].pvti);
+	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
+		return 1;
+
+	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
+#endif
+	return 0;
+}
+early_initcall(kvm_setup_vsyscall_timeinfo);
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
@@ -272,20 +299,3 @@ void __init kvmclock_init(void)
 	clocksource_register_hz(&kvm_clock, NSEC_PER_SEC);
 	pv_info.name = "KVM";
 }
-
-int __init kvm_setup_vsyscall_timeinfo(void)
-{
-#ifdef CONFIG_X86_64
-	u8 flags;
-
-	if (!hv_clock)
-		return 0;
-
-	flags = pvclock_read_flags(&hv_clock[0].pvti);
-	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
-		return 1;
-
-	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
-#endif
-	return 0;
-}
-- 
2.18.0
