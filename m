Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v14 07/25] x86/kvmclock: Switch kvmclock data to a PER_CPU variable
Date: Tue, 17 Jul 2018 22:21:53 -0400
Message-Id: <20180718022211.6259-8-pasha.tatashin@oracle.com>
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

The previous removal of the memblock dependency from kvmclock introduced a
static data array sized 64bytes * CONFIG_NR_CPUS. That's wasteful on large
systems when kvmclock is not used.

Replace it with:

 - A static page sized array of pvclock data. It's page sized because the
   pvclock data of the boot cpu is mapped into the VDSO so otherwise random
   other data would be exposed to the vDSO

 - A PER_CPU variable of pvclock data pointers. This is used to access the
   pcvlock data storage on each CPU.

The setup is done in two stages:

 - Early boot stores the pointer to the static page for the boot CPU in
   the per cpu data.

 - In the preparatory stage of CPU hotplug assign either an element of
   the static array (when the CPU number is in that range) or allocate
   memory and initialize the per cpu pointer.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvmclock.c | 99 ++++++++++++++++++++++++--------------
 1 file changed, 62 insertions(+), 37 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 08e7726a5e62..ed170171fe49 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -23,6 +23,7 @@
 #include <asm/apic.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <linux/cpuhotplug.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
 #include <linux/mm.h>
@@ -55,12 +56,23 @@ early_param("no-kvmclock-vsyscall", parse_no_kvmclock_vsyscall);
 
 /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
 #define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
+#define HVC_BOOT_ARRAY_SIZE \
+	(PAGE_SIZE / sizeof(struct pvclock_vsyscall_time_info))
 
-static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
-
-/* The hypervisor will put information about time periodically here */
-static struct pvclock_vsyscall_time_info *hv_clock __ro_after_init;
+static struct pvclock_vsyscall_time_info
+			hv_clock_boot[HVC_BOOT_ARRAY_SIZE] __aligned(PAGE_SIZE);
 static struct pvclock_wall_clock wall_clock;
+static DEFINE_PER_CPU(struct pvclock_vsyscall_time_info *, hv_clock_per_cpu);
+
+static inline struct pvclock_vcpu_time_info *this_cpu_pvti(void)
+{
+	return &this_cpu_read(hv_clock_per_cpu)->pvti;
+}
+
+static inline struct pvclock_vsyscall_time_info *this_cpu_hvclock(void)
+{
+	return this_cpu_read(hv_clock_per_cpu);
+}
 
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
@@ -69,17 +81,10 @@ static struct pvclock_wall_clock wall_clock;
  */
 static void kvm_get_wallclock(struct timespec64 *now)
 {
-	struct pvclock_vcpu_time_info *vcpu_time;
-	int cpu;
-
 	wrmsrl(msr_kvm_wall_clock, slow_virt_to_phys(&wall_clock));
-
-	cpu = get_cpu();
-
-	vcpu_time = &hv_clock[cpu].pvti;
-	pvclock_read_wallclock(&wall_clock, vcpu_time, now);
-
-	put_cpu();
+	preempt_disable();
+	pvclock_read_wallclock(&wall_clock, this_cpu_pvti(), now);
+	preempt_enable();
 }
 
 static int kvm_set_wallclock(const struct timespec64 *now)
@@ -89,14 +94,10 @@ static int kvm_set_wallclock(const struct timespec64 *now)
 
 static u64 kvm_clock_read(void)
 {
-	struct pvclock_vcpu_time_info *src;
 	u64 ret;
-	int cpu;
 
 	preempt_disable_notrace();
-	cpu = smp_processor_id();
-	src = &hv_clock[cpu].pvti;
-	ret = pvclock_clocksource_read(src);
+	ret = pvclock_clocksource_read(this_cpu_pvti());
 	preempt_enable_notrace();
 	return ret;
 }
@@ -140,7 +141,7 @@ static inline void kvm_sched_clock_init(bool stable)
  */
 static unsigned long kvm_get_tsc_khz(void)
 {
-	return pvclock_tsc_khz(&hv_clock[0].pvti);
+	return pvclock_tsc_khz(this_cpu_pvti());
 }
 
 static void kvm_get_preset_lpj(void)
@@ -157,15 +158,14 @@ static void kvm_get_preset_lpj(void)
 
 bool kvm_check_and_clear_guest_paused(void)
 {
-	struct pvclock_vcpu_time_info *src;
+	struct pvclock_vsyscall_time_info *src = this_cpu_hvclock();
 	bool ret = false;
 
-	if (!hv_clock)
+	if (!src)
 		return ret;
 
-	src = &hv_clock[smp_processor_id()].pvti;
-	if ((src->flags & PVCLOCK_GUEST_STOPPED) != 0) {
-		src->flags &= ~PVCLOCK_GUEST_STOPPED;
+	if ((src->pvti.flags & PVCLOCK_GUEST_STOPPED) != 0) {
+		src->pvti.flags &= ~PVCLOCK_GUEST_STOPPED;
 		pvclock_touch_watchdogs();
 		ret = true;
 	}
@@ -183,17 +183,15 @@ EXPORT_SYMBOL_GPL(kvm_clock);
 
 static void kvm_register_clock(char *txt)
 {
-	struct pvclock_vcpu_time_info *src;
-	int cpu = smp_processor_id();
+	struct pvclock_vsyscall_time_info *src = this_cpu_hvclock();
 	u64 pa;
 
-	if (!hv_clock)
+	if (!src)
 		return;
 
-	src = &hv_clock[cpu].pvti;
-	pa = slow_virt_to_phys(src) | 0x01ULL;
+	pa = slow_virt_to_phys(&src->pvti) | 0x01ULL;
 	wrmsrl(msr_kvm_system_time, pa);
-	pr_info("kvm-clock: cpu %d, msr %llx, %s", cpu, pa, txt);
+	pr_info("kvm-clock: cpu %d, msr %llx, %s", smp_processor_id(), pa, txt);
 }
 
 static void kvm_save_sched_clock_state(void)
@@ -241,20 +239,42 @@ static int __init kvm_setup_vsyscall_timeinfo(void)
 #ifdef CONFIG_X86_64
 	u8 flags;
 
-	if (!hv_clock || !kvmclock_vsyscall)
+	if (!per_cpu(hv_clock_per_cpu, 0) || !kvmclock_vsyscall)
 		return 0;
 
-	flags = pvclock_read_flags(&hv_clock[0].pvti);
+	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	if (!(flags & PVCLOCK_TSC_STABLE_BIT))
-		return 1;
+		return 0;
 
-	pvclock_set_pvti_cpu0_va(hv_clock);
+	pvclock_set_pvti_cpu0_va(hv_clock_boot);
 	kvm_clock.archdata.vclock_mode = VCLOCK_PVCLOCK;
 #endif
 	return 0;
 }
 early_initcall(kvm_setup_vsyscall_timeinfo);
 
+static int kvmclock_setup_percpu(unsigned int cpu)
+{
+	struct pvclock_vsyscall_time_info *p = per_cpu(hv_clock_per_cpu, cpu);
+
+	/*
+	 * The per cpu area setup replicates CPU0 data to all cpu
+	 * pointers. So carefully check. CPU0 has been set up in init
+	 * already.
+	 */
+	if (!cpu || (p && p != per_cpu(hv_clock_per_cpu, 0)))
+		return 0;
+
+	/* Use the static page for the first CPUs, allocate otherwise */
+	if (cpu < HVC_BOOT_ARRAY_SIZE)
+		p = &hv_clock_boot[cpu];
+	else
+		p = kzalloc(sizeof(*p), GFP_KERNEL);
+
+	per_cpu(hv_clock_per_cpu, cpu) = p;
+	return p ? 0 : -ENOMEM;
+}
+
 void __init kvmclock_init(void)
 {
 	u8 flags;
@@ -269,16 +289,21 @@ void __init kvmclock_init(void)
 		return;
 	}
 
+	if (cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "kvmclock:setup_percpu",
+			      kvmclock_setup_percpu, NULL) < 0) {
+		return;
+	}
+
 	pr_info("kvm-clock: Using msrs %x and %x",
 		msr_kvm_system_time, msr_kvm_wall_clock);
 
-	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
+	this_cpu_write(hv_clock_per_cpu, &hv_clock_boot[0]);
 	kvm_register_clock("primary cpu clock");
 
 	if (kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE_STABLE_BIT))
 		pvclock_set_flags(PVCLOCK_TSC_STABLE_BIT);
 
-	flags = pvclock_read_flags(&hv_clock[0].pvti);
+	flags = pvclock_read_flags(&hv_clock_boot[0].pvti);
 	kvm_sched_clock_init(flags & PVCLOCK_TSC_STABLE_BIT);
 
 	x86_platform.calibrate_tsc = kvm_get_tsc_khz;
-- 
2.18.0
