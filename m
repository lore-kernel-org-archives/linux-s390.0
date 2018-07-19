Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 05/26] x86/kvmclock: Mark variables __initdata and __ro_after_init
Date: Thu, 19 Jul 2018 16:55:24 -0400
Message-Id: <20180719205545.16512-6-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

The kvmclock parameter is init data and the other variables are not
modified after init.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kernel/kvmclock.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/kvmclock.c b/arch/x86/kernel/kvmclock.c
index 4afb03e49a4f..78aec160f5e0 100644
--- a/arch/x86/kernel/kvmclock.c
+++ b/arch/x86/kernel/kvmclock.c
@@ -32,10 +32,10 @@
 #include <asm/reboot.h>
 #include <asm/kvmclock.h>
 
-static int kvmclock __ro_after_init = 1;
-static int msr_kvm_system_time = MSR_KVM_SYSTEM_TIME;
-static int msr_kvm_wall_clock = MSR_KVM_WALL_CLOCK;
-static u64 kvm_sched_clock_offset;
+static int kvmclock __initdata = 1;
+static int msr_kvm_system_time __ro_after_init = MSR_KVM_SYSTEM_TIME;
+static int msr_kvm_wall_clock __ro_after_init = MSR_KVM_WALL_CLOCK;
+static u64 kvm_sched_clock_offset __ro_after_init;
 
 static int __init parse_no_kvmclock(char *arg)
 {
@@ -50,7 +50,7 @@ early_param("no-kvmclock", parse_no_kvmclock);
 static u8 hv_clock_mem[PAGE_ALIGN(HV_CLOCK_SIZE)] __aligned(PAGE_SIZE);
 
 /* The hypervisor will put information about time periodically here */
-static struct pvclock_vsyscall_time_info *hv_clock;
+static struct pvclock_vsyscall_time_info *hv_clock __ro_after_init;
 static struct pvclock_wall_clock wall_clock;
 
 /*
-- 
2.18.0
