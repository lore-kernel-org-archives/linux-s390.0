Return-Path: <SRS0=35zj=KC=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v14 02/25] x86/kvmclock: Remove page size requirement from wall_clock
Date: Tue, 17 Jul 2018 22:21:48 -0400
Message-Id: <20180718022211.6259-3-pasha.tatashin@oracle.com>
In-Reply-To: <20180718022211.6259-1-pasha.tatashin@oracle.com>
References: <20180718022211.6259-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

There is no requirement for wall_clock data to be page aligned or page
sized.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvmclock.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 890e9e58e4bf..e9863639312c 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -46,14 +46,12 @@ early_param("no-kvmclock", parse_no_kvmclock);
 
 /* Aligned to page sizes to match whats mapped via vsyscalls to userspace */
 #define HV_CLOCK_SIZE	(sizeof(struct pvclock_vsyscall_time_info) * NR_CPUS)
-#define WALL_CLOCK_SIZE	(sizeof(struct pvclock_wall_clock))
 
 static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
-static u8 wall_clock_mem[PAGE_ALIGN(WALL_CLOCK_SIZE)] __aligned(PAGE_SIZE);
 
 /* The hypervisor will put information about time periodically here */
 static struct pvclock_vsyscall_time_info *hv_clock;
-static struct pvclock_wall_clock *wall_clock;
+static struct pvclock_wall_clock wall_clock;
 
 /*
  * The wallclock is the time of day when we booted. Since then, some time may
@@ -66,15 +64,15 @@ static void kvm_get_wallclock(struct timespec64 *now)
 	int low, high;
 	int cpu;
 
-	low = (int)slow_virt_to_phys(wall_clock);
-	high = ((u64)slow_virt_to_phys(wall_clock) >> 32);
+	low = (int)slow_virt_to_phys(&wall_clock);
+	high = ((u64)slow_virt_to_phys(&wall_clock) >> 32);
 
 	native_write_msr(msr_kvm_wall_clock, low, high);
 
 	cpu = get_cpu();
 
 	vcpu_time = &hv_clock[cpu].pvti;
-	pvclock_read_wallclock(wall_clock, vcpu_time, now);
+	pvclock_read_wallclock(&wall_clock, vcpu_time, now);
 
 	put_cpu();
 }
@@ -266,12 +264,10 @@ void __init kvmclock_init(void)
 	} else if (!(kvmclock && kvm_para_has_feature(KVM_FEATURE_CLOCKSOURCE)))
 		return;
 
-	wall_clock = (struct pvclock_wall_clock *)wall_clock_mem;
 	hv_clock = (struct pvclock_vsyscall_time_info *)hv_clock_mem;
 
 	if (kvm_register_clock("primary cpu clock")) {
 		hv_clock = NULL;
-		wall_clock = NULL;
 		return;
 	}
 
-- 
2.18.0
