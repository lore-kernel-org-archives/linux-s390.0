Return-Path: <SRS0=drEb=P7=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 23 Jan 2019 13:01:47 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 5.0 #2
MIME-Version: 1.0
Message-Id: <20190123130147.079a7007@mschwideX1>
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull s390 fixes [and features] for 4.xx

The following changes since commit 1bdbe227492075d058e37cb3d400e6468d0095b5:

  Merge tag 'vfio-v5.0-rc2' of git://github.com/awilliam/linux-vfio (2019-01-10 09:20:46 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git tags/s390-5.0-2

for you to fetch changes up to 60f1bf29c0b2519989927cae640cd1f50f59dc7f:

  s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU (2019-01-11 17:12:03 +0100)

----------------------------------------------------------------
s390 update with bug fixes for 5.0-rc4

 - Do not claim to run under z/VM if the hypervisor can not be identified

 - Fix crashes due to outdated ASCEs in CR1

 - Avoid a deadlock in regard to CPU hotplug

 - Really fix the vdso mapping issue for compat tasks

 - Avoid crash on restart due to an incorrect stack address

----------------------------------------------------------------
Christian Borntraeger (1):
      s390/early: improve machine detection

David Hildenbrand (1):
      s390/smp: Fix calling smp_call_ipl_cpu() from ipl CPU

Gerald Schaefer (1):
      s390/smp: fix CPU hotplug deadlock with CPU rescan

Martin Schwidefsky (1):
      s390/mm: always force a load of the primary ASCE on context switch

Vasily Gorbik (1):
      s390/vdso: correct vdso mapping for compat tasks

 arch/s390/include/asm/mmu_context.h |  7 +++----
 arch/s390/kernel/early.c            |  4 ++--
 arch/s390/kernel/setup.c            |  2 ++
 arch/s390/kernel/smp.c              | 11 ++++++++++-
 arch/s390/kernel/vdso.c             |  5 ++---
 drivers/s390/char/sclp_config.c     |  2 ++
 6 files changed, 21 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index ccbb53e..8d04e6f 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -25,7 +25,7 @@ static inline int init_new_context(struct task_struct *tsk,
 	atomic_set(&mm->context.flush_count, 0);
 	mm->context.gmap_asce = 0;
 	mm->context.flush_mm = 0;
-	mm->context.compat_mm = 0;
+	mm->context.compat_mm = test_thread_flag(TIF_31BIT);
 #ifdef CONFIG_PGSTE
 	mm->context.alloc_pgste = page_table_allocate_pgste ||
 		test_thread_flag(TIF_PGSTE) ||
@@ -90,8 +90,6 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 {
 	int cpu = smp_processor_id();
 
-	if (prev == next)
-		return;
 	S390_lowcore.user_asce = next->context.asce;
 	cpumask_set_cpu(cpu, &next->context.cpu_attach_mask);
 	/* Clear previous user-ASCE from CR1 and CR7 */
@@ -103,7 +101,8 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 		__ctl_load(S390_lowcore.vdso_asce, 7, 7);
 		clear_cpu_flag(CIF_ASCE_SECONDARY);
 	}
-	cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
+	if (prev != next)
+		cpumask_clear_cpu(cpu, &prev->context.cpu_attach_mask);
 }
 
 #define finish_arch_post_lock_switch finish_arch_post_lock_switch
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index af5c2b3..a8c7789 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -63,10 +63,10 @@ static noinline __init void detect_machine_type(void)
 	if (stsi(vmms, 3, 2, 2) || !vmms->count)
 		return;
 
-	/* Running under KVM? If not we assume z/VM */
+	/* Detect known hypervisors */
 	if (!memcmp(vmms->vm[0].cpi, "\xd2\xe5\xd4", 3))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_KVM;
-	else
+	else if (!memcmp(vmms->vm[0].cpi, "\xa9\x61\xe5\xd4", 4))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_VM;
 }
 
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index 72dd23e..7ed90a7 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -1006,6 +1006,8 @@ void __init setup_arch(char **cmdline_p)
 		pr_info("Linux is running under KVM in 64-bit mode\n");
 	else if (MACHINE_IS_LPAR)
 		pr_info("Linux is running natively in 64-bit mode\n");
+	else
+		pr_info("Linux is running as a guest in 64-bit mode\n");
 
 	/* Have one command line that is parsed and saved in /proc/cmdline */
 	/* boot_command_line has been already set up in early.c */
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index f82b3d3..b198ece 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -381,8 +381,13 @@ void smp_call_online_cpu(void (*func)(void *), void *data)
  */
 void smp_call_ipl_cpu(void (*func)(void *), void *data)
 {
+	struct lowcore *lc = pcpu_devices->lowcore;
+
+	if (pcpu_devices[0].address == stap())
+		lc = &S390_lowcore;
+
 	pcpu_delegate(&pcpu_devices[0], func, data,
-		      pcpu_devices->lowcore->nodat_stack);
+		      lc->nodat_stack);
 }
 
 int smp_find_processor_id(u16 address)
@@ -1166,7 +1171,11 @@ static ssize_t __ref rescan_store(struct device *dev,
 {
 	int rc;
 
+	rc = lock_device_hotplug_sysfs();
+	if (rc)
+		return rc;
 	rc = smp_rescan_cpus();
+	unlock_device_hotplug();
 	return rc ? rc : count;
 }
 static DEVICE_ATTR_WO(rescan);
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index ebe748a..4ff3548 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -224,10 +224,9 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
 
 	vdso_pages = vdso64_pages;
 #ifdef CONFIG_COMPAT
-	if (is_compat_task()) {
+	mm->context.compat_mm = is_compat_task();
+	if (mm->context.compat_mm)
 		vdso_pages = vdso32_pages;
-		mm->context.compat_mm = 1;
-	}
 #endif
 	/*
 	 * vDSO has a problem and was disabled, just don't "enable" it for
diff --git a/drivers/s390/char/sclp_config.c b/drivers/s390/char/sclp_config.c
index 194ffd5..039b207 100644
--- a/drivers/s390/char/sclp_config.c
+++ b/drivers/s390/char/sclp_config.c
@@ -60,7 +60,9 @@ static void sclp_cpu_capability_notify(struct work_struct *work)
 
 static void __ref sclp_cpu_change_notify(struct work_struct *work)
 {
+	lock_device_hotplug();
 	smp_rescan_cpus();
+	unlock_device_hotplug();
 }
 
 static void sclp_conf_receiver_fn(struct evbuf_header *evbuf)
