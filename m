Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 01/26] x86/kvmclock: Remove memblock dependency
Date: Thu, 19 Jul 2018 16:55:20 -0400
Message-Id: <20180719205545.16512-2-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

KVM clock is initialized later compared to other hypervisor clocks because
it has a dependency on the memblock allocator.

Bring it in line with other hypervisors by using memory from the BSS
instead of allocating it.

The benefits:

  - Remove ifdef from common code
  - Earlier availability of the clock
  - Remove dependency on memblock, and reduce code

The downside:

  - Static allocation of the per cpu data structures sized NR_CPUS * 64byte
    Will be addressed in follow up patches.

[ tglx: Split out from larger series ]

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvm.c      |  1 +
 arch/x86/kernel/kvmclock.c | 66 +++++++-------------------------------
 arch/x86/kernel/setup.c    |  4 ---
 3 files changed, 12 insertions(+), 59 deletions(-)

diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index 5b2300b818af..c65c232d3ddd 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -628,6 +628,7 @@ const __initconst struct hypervisor_x86 x86_hyper_kvm = {
 	.name			= "KVM",
 	.detect			= kvm_detect,
 	.type			= X86_HYPER_KVM,
+	.init.init_platform	= kvmclock_init,
 	.init.guest_late_init	= kvm_guest_init,
 	.init.x2apic_available	= kvm_para_available,
 };
diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 3b8e7c13c614..1f6ac5aaa904 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -23,9 +23,9 @@
 #include <asm/apic.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
-#include <linux/memblock.h>
 #include <linux/sched.h>
 #include <linux/sched/clock.h>
+#include <linux/mm.h>
 
 #include <asm/mem_encrypt.h>
 #include <asm/x86_init.h>
@@ -44,6 +44,13 @@ static int parse_no_kvmclock(char *arg)
 }
 early_param("no-kvmclock", parse_no_kvmclock);
 
+/* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
+#define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
+#define WALL_CLOCK_SIZE	(sizeof(struct pvclock_wall_clock))
+
+static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
+static u8 wall_clock_mem[PAGE_ALIGN(WALL_CLOCK_SIZE)] __aligned(PAGE_SIZE);
+
 /* The hypervisor will put information about time periodically here */
 static struct pvclock_vsyscall_time_info *hv_clock;
 static struct pvclock_wall_clock *wall_clock;
@@ -245,43 +252,12 @@ static void kvm_shutdown(void)
 	native_machine_shutdown();
 }
 
-static phys_addr_t __init kvm_memblock_alloc(phys_addr_t size,
-					     phys_addr_t align)
-{
-	phys_addr_t mem;
-
-	mem = memblock_alloc(size, align);
-	if (!mem)
-		return 0;
-
-	if (sev_active()) {
-		if (early_set_memory_decrypted((unsigned long)__va(mem), size))
-			goto e_free;
-	}
-
-	return mem;
-e_free:
-	memblock_free(mem, size);
-	return 0;
-}
-
-static void __init kvm_memblock_free(phys_addr_t addr, phys_addr_t size)
-{
-	if (sev_active())
-		early_set_memory_encrypted((unsigned long)__va(addr), size);
-
-	memblock_free(addr, size);
-}
-
 void __init kvmclock_init(void)
 {
 	struct pvclock_vcpu_time_info *vcpu_time;
-	unsigned long mem, mem_wall_clock;
-	int size, cpu, wall_clock_size;
+	int cpu;
 	u8 flags;
 
-	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
-
 	if (!kvm_para_available())
 		return;
 
@@ -291,28 +267,11 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	wall_clock_size = PAGE_ALIGN(sizeof(struct pvclock_wall_clock));
-	mem_wall_clock = kvm_memblock_alloc(wall_clock_size, PAGE_SIZE);
-	if (!mem_wall_clock)
-		return;
-
-	wall_clock = __va(mem_wall_clock);
-	memset(wall_clock, 0, wall_clock_size);
-
-	mem = kvm_memblock_alloc(size, PAGE_SIZE);
-	if (!mem) {
-		kvm_memblock_free(mem_wall_clock, wall_clock_size);
-		wall_clock = NULL;
-		return;
-	}
-
-	hv_clock = __va(mem);
-	memset(hv_clock, 0, size);
+	wall_clock = (struct pvclock_wall_clock *)wall_clock_mem;
+	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
 
 	if (kvm_register_clock("primary cpu clock")) {
 		hv_clock = NULL;
-		kvm_memblock_free(mem, size);
-		kvm_memblock_free(mem_wall_clock, wall_clock_size);
 		wall_clock = NULL;
 		return;
 	}
@@ -357,13 +316,10 @@ int __init kvm_setup_vsyscall_timeinfo(void)
 	int cpu;
 	u8 flags;
 	struct pvclock_vcpu_time_info *vcpu_time;
-	unsigned int size;
 
 	if (!hv_clock)
 		return 0;
 
-	size = PAGE_ALIGN(sizeof(struct pvclock_vsyscall_time_info)*NR_CPUS);
-
 	cpu = get_cpu();
 
 	vcpu_time = &hv_clock[cpu].pvti;
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2f86d883dd95..da1dbd99cb6e 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -1197,10 +1197,6 @@ void __init setup_arch(char **cmdline_p)
 
 	memblock_find_dma_reserve();
 
-#ifdef CONFIG_KVM_GUEST
-	kvmclock_init();
-#endif
-
 	tsc_early_delay_calibrate();
 	if (!early_xdbc_setup_hardware())
 		early_xdbc_register_console();
-- 
2.18.0
