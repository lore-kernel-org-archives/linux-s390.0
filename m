Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 6 Oct 2015 11:15:07 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.3-rc5
Message-ID: <20151006111507.678a0415@mschwide>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Hi Linus,

please pull from the 'for-linus' branch of

	git://git.kernel.org/pub/scm/linux/kernel/git/s390/linux.git for-linus

to receive the following updates:

Three bug fixes and an update to the default configuration.

Christian Borntraeger (1):
      s390/boot/decompression: disable floating point in decompressor

Martin Schwidefsky (2):
      s390/numa: use correct type for node_to_cpumask_map
      s390/vtime: correct scaled cputime of partially idle CPUs

Sebastian Ott (1):
      s390/defconfig: set SCSI_DH=y

 arch/s390/boot/compressed/Makefile      |  2 +-
 arch/s390/configs/default_defconfig     |  2 +-
 arch/s390/configs/gcov_defconfig        |  2 +-
 arch/s390/configs/performance_defconfig |  2 +-
 arch/s390/include/asm/numa.h            |  2 +-
 arch/s390/include/asm/topology.h        |  2 +-
 arch/s390/kernel/asm-offsets.c          |  1 +
 arch/s390/kernel/entry.S                | 30 ++++++++++++++-
 arch/s390/kernel/vtime.c                | 66 ++++++++++++++++++---------------
 arch/s390/numa/mode_emu.c               |  4 +-
 arch/s390/numa/numa.c                   |  4 +-
 11 files changed, 77 insertions(+), 40 deletions(-)

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index d478811..fac6ac9 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -10,7 +10,7 @@ targets += misc.o piggy.o sizes.h head.o
 
 KBUILD_CFLAGS := -m64 -D__KERNEL__ $(LINUX_INCLUDE) -O2
 KBUILD_CFLAGS += -DDISABLE_BRANCH_PROFILING
-KBUILD_CFLAGS += $(cflags-y) -fno-delete-null-pointer-checks
+KBUILD_CFLAGS += $(cflags-y) -fno-delete-null-pointer-checks -msoft-float
 KBUILD_CFLAGS += $(call cc-option,-mpacked-stack)
 KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 
diff --git a/arch/s390/configs/default_defconfig b/arch/s390/configs/default_defconfig
index 0c98f15..ed7da28 100644
--- a/arch/s390/configs/default_defconfig
+++ b/arch/s390/configs/default_defconfig
@@ -381,7 +381,7 @@ CONFIG_ISCSI_TCP=m
 CONFIG_SCSI_DEBUG=m
 CONFIG_ZFCP=y
 CONFIG_SCSI_VIRTIO=m
-CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_HP_SW=m
 CONFIG_SCSI_DH_EMC=m
diff --git a/arch/s390/configs/gcov_defconfig b/arch/s390/configs/gcov_defconfig
index 82083e1..9858b14 100644
--- a/arch/s390/configs/gcov_defconfig
+++ b/arch/s390/configs/gcov_defconfig
@@ -377,7 +377,7 @@ CONFIG_ISCSI_TCP=m
 CONFIG_SCSI_DEBUG=m
 CONFIG_ZFCP=y
 CONFIG_SCSI_VIRTIO=m
-CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_HP_SW=m
 CONFIG_SCSI_DH_EMC=m
diff --git a/arch/s390/configs/performance_defconfig b/arch/s390/configs/performance_defconfig
index c05c9e0..7f14f80 100644
--- a/arch/s390/configs/performance_defconfig
+++ b/arch/s390/configs/performance_defconfig
@@ -377,7 +377,7 @@ CONFIG_ISCSI_TCP=m
 CONFIG_SCSI_DEBUG=m
 CONFIG_ZFCP=y
 CONFIG_SCSI_VIRTIO=m
-CONFIG_SCSI_DH=m
+CONFIG_SCSI_DH=y
 CONFIG_SCSI_DH_RDAC=m
 CONFIG_SCSI_DH_HP_SW=m
 CONFIG_SCSI_DH_EMC=m
diff --git a/arch/s390/include/asm/numa.h b/arch/s390/include/asm/numa.h
index 2a0efc6..dc19ee0 100644
--- a/arch/s390/include/asm/numa.h
+++ b/arch/s390/include/asm/numa.h
@@ -19,7 +19,7 @@ int numa_pfn_to_nid(unsigned long pfn);
 int __node_distance(int a, int b);
 void numa_update_cpu_topology(void);
 
-extern cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
+extern cpumask_t node_to_cpumask_map[MAX_NUMNODES];
 extern int numa_debug_enabled;
 
 #else
diff --git a/arch/s390/include/asm/topology.h b/arch/s390/include/asm/topology.h
index 27ebde6..94fc55f 100644
--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -68,7 +68,7 @@ static inline int cpu_to_node(int cpu)
 #define cpumask_of_node cpumask_of_node
 static inline const struct cpumask *cpumask_of_node(int node)
 {
-	return node_to_cpumask_map[node];
+	return &node_to_cpumask_map[node];
 }
 
 /*
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 48c9af7..3aeeb1b 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -176,6 +176,7 @@ int main(void)
 	DEFINE(__LC_PASTE, offsetof(struct _lowcore, paste));
 	DEFINE(__LC_FP_CREG_SAVE_AREA, offsetof(struct _lowcore, fpt_creg_save_area));
 	DEFINE(__LC_LAST_BREAK, offsetof(struct _lowcore, breaking_event_addr));
+	DEFINE(__LC_PERCPU_OFFSET, offsetof(struct _lowcore, percpu_offset));
 	DEFINE(__LC_VDSO_PER_CPU, offsetof(struct _lowcore, vdso_per_cpu_data));
 	DEFINE(__LC_GMAP, offsetof(struct _lowcore, gmap));
 	DEFINE(__LC_PGM_TDB, offsetof(struct _lowcore, pgm_tdb));
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 09b039d..582fe44 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -733,6 +733,14 @@ ENTRY(psw_idle)
 	stg	%r3,__SF_EMPTY(%r15)
 	larl	%r1,.Lpsw_idle_lpsw+4
 	stg	%r1,__SF_EMPTY+8(%r15)
+#ifdef CONFIG_SMP
+	larl	%r1,smp_cpu_mtid
+	llgf	%r1,0(%r1)
+	ltgr	%r1,%r1
+	jz	.Lpsw_idle_stcctm
+	.insn	rsy,0xeb0000000017,%r1,5,__SF_EMPTY+16(%r15)
+.Lpsw_idle_stcctm:
+#endif
 	STCK	__CLOCK_IDLE_ENTER(%r2)
 	stpt	__TIMER_IDLE_ENTER(%r2)
 .Lpsw_idle_lpsw:
@@ -1159,7 +1167,27 @@ cleanup_critical:
 	jhe	1f
 	mvc	__CLOCK_IDLE_ENTER(8,%r2),__CLOCK_IDLE_EXIT(%r2)
 	mvc	__TIMER_IDLE_ENTER(8,%r2),__TIMER_IDLE_EXIT(%r2)
-1:	# account system time going idle
+1:	# calculate idle cycles
+#ifdef CONFIG_SMP
+	clg	%r9,BASED(.Lcleanup_idle_insn)
+	jl	3f
+	larl	%r1,smp_cpu_mtid
+	llgf	%r1,0(%r1)
+	ltgr	%r1,%r1
+	jz	3f
+	.insn	rsy,0xeb0000000017,%r1,5,__SF_EMPTY+80(%r15)
+	larl	%r3,mt_cycles
+	ag	%r3,__LC_PERCPU_OFFSET
+	la	%r4,__SF_EMPTY+16(%r15)
+2:	lg	%r0,0(%r3)
+	slg	%r0,0(%r4)
+	alg	%r0,64(%r4)
+	stg	%r0,0(%r3)
+	la	%r3,8(%r3)
+	la	%r4,8(%r4)
+	brct	%r1,2b
+#endif
+3:	# account system time going idle
 	lg	%r9,__LC_STEAL_TIMER
 	alg	%r9,__CLOCK_IDLE_ENTER(%r2)
 	slg	%r9,__LC_LAST_UPDATE_CLOCK
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index c865343..dafc44f 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -25,7 +25,7 @@ static DEFINE_SPINLOCK(virt_timer_lock);
 static atomic64_t virt_timer_current;
 static atomic64_t virt_timer_elapsed;
 
-static DEFINE_PER_CPU(u64, mt_cycles[32]);
+DEFINE_PER_CPU(u64, mt_cycles[8]);
 static DEFINE_PER_CPU(u64, mt_scaling_mult) = { 1 };
 static DEFINE_PER_CPU(u64, mt_scaling_div) = { 1 };
 static DEFINE_PER_CPU(u64, mt_scaling_jiffies);
@@ -60,6 +60,34 @@ static inline int virt_timer_forward(u64 elapsed)
 	return elapsed >= atomic64_read(&virt_timer_current);
 }
 
+static void update_mt_scaling(void)
+{
+	u64 cycles_new[8], *cycles_old;
+	u64 delta, fac, mult, div;
+	int i;
+
+	stcctm5(smp_cpu_mtid + 1, cycles_new);
+	cycles_old = this_cpu_ptr(mt_cycles);
+	fac = 1;
+	mult = div = 0;
+	for (i = 0; i <= smp_cpu_mtid; i++) {
+		delta = cycles_new[i] - cycles_old[i];
+		div += delta;
+		mult *= i + 1;
+		mult += delta * fac;
+		fac *= i + 1;
+	}
+	div *= fac;
+	if (div > 0) {
+		/* Update scaling factor */
+		__this_cpu_write(mt_scaling_mult, mult);
+		__this_cpu_write(mt_scaling_div, div);
+		memcpy(cycles_old, cycles_new,
+		       sizeof(u64) * (smp_cpu_mtid + 1));
+	}
+	__this_cpu_write(mt_scaling_jiffies, jiffies_64);
+}
+
 /*
  * Update process times based on virtual cpu times stored by entry.S
  * to the lowcore fields user_timer, system_timer & steal_clock.
@@ -69,7 +97,6 @@ static int do_account_vtime(struct task_struct *tsk, int hardirq_offset)
 	struct thread_info *ti = task_thread_info(tsk);
 	u64 timer, clock, user, system, steal;
 	u64 user_scaled, system_scaled;
-	int i;
 
 	timer = S390_lowcore.last_update_timer;
 	clock = S390_lowcore.last_update_clock;
@@ -85,34 +112,10 @@ static int do_account_vtime(struct task_struct *tsk, int hardirq_offset)
 	S390_lowcore.system_timer += timer - S390_lowcore.last_update_timer;
 	S390_lowcore.steal_timer += S390_lowcore.last_update_clock - clock;
 
-	/* Do MT utilization calculation */
+	/* Update MT utilization calculation */
 	if (smp_cpu_mtid &&
-	    time_after64(jiffies_64, __this_cpu_read(mt_scaling_jiffies))) {
-		u64 cycles_new[32], *cycles_old;
-		u64 delta, fac, mult, div;
-
-		cycles_old = this_cpu_ptr(mt_cycles);
-		if (stcctm5(smp_cpu_mtid + 1, cycles_new) < 2) {
-			fac = 1;
-			mult = div = 0;
-			for (i = 0; i <= smp_cpu_mtid; i++) {
-				delta = cycles_new[i] - cycles_old[i];
-				div += delta;
-				mult *= i + 1;
-				mult += delta * fac;
-				fac *= i + 1;
-			}
-			div *= fac;
-			if (div > 0) {
-				/* Update scaling factor */
-				__this_cpu_write(mt_scaling_mult, mult);
-				__this_cpu_write(mt_scaling_div, div);
-				memcpy(cycles_old, cycles_new,
-				       sizeof(u64) * (smp_cpu_mtid + 1));
-			}
-		}
-		__this_cpu_write(mt_scaling_jiffies, jiffies_64);
-	}
+	    time_after64(jiffies_64, this_cpu_read(mt_scaling_jiffies)))
+		update_mt_scaling();
 
 	user = S390_lowcore.user_timer - ti->user_timer;
 	S390_lowcore.steal_timer -= user;
@@ -181,6 +184,11 @@ void vtime_account_irq_enter(struct task_struct *tsk)
 	S390_lowcore.last_update_timer = get_vtimer();
 	S390_lowcore.system_timer += timer - S390_lowcore.last_update_timer;
 
+	/* Update MT utilization calculation */
+	if (smp_cpu_mtid &&
+	    time_after64(jiffies_64, this_cpu_read(mt_scaling_jiffies)))
+		update_mt_scaling();
+
 	system = S390_lowcore.system_timer - ti->system_timer;
 	S390_lowcore.steal_timer -= system;
 	ti->system_timer = S390_lowcore.system_timer;
diff --git a/arch/s390/numa/mode_emu.c b/arch/s390/numa/mode_emu.c
index 7de4e2f..30b2698 100644
--- a/arch/s390/numa/mode_emu.c
+++ b/arch/s390/numa/mode_emu.c
@@ -368,7 +368,7 @@ static void topology_add_core(struct toptree *core)
 		cpumask_copy(&top->thread_mask, &core->mask);
 		cpumask_copy(&top->core_mask, &core_mc(core)->mask);
 		cpumask_copy(&top->book_mask, &core_book(core)->mask);
-		cpumask_set_cpu(cpu, node_to_cpumask_map[core_node(core)->id]);
+		cpumask_set_cpu(cpu, &node_to_cpumask_map[core_node(core)->id]);
 		top->node_id = core_node(core)->id;
 	}
 }
@@ -383,7 +383,7 @@ static void toptree_to_topology(struct toptree *numa)
 
 	/* Clear all node masks */
 	for (i = 0; i < MAX_NUMNODES; i++)
-		cpumask_clear(node_to_cpumask_map[i]);
+		cpumask_clear(&node_to_cpumask_map[i]);
 
 	/* Rebuild all masks */
 	toptree_for_each(core, numa, CORE)
diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 09b1d23..43f32ce 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -23,7 +23,7 @@
 pg_data_t *node_data[MAX_NUMNODES];
 EXPORT_SYMBOL(node_data);
 
-cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
+cpumask_t node_to_cpumask_map[MAX_NUMNODES];
 EXPORT_SYMBOL(node_to_cpumask_map);
 
 const struct numa_mode numa_mode_plain = {
@@ -144,7 +144,7 @@ void __init numa_setup(void)
 static int __init numa_init_early(void)
 {
 	/* Attach all possible CPUs to node 0 for now. */
-	cpumask_copy(node_to_cpumask_map[0], cpu_possible_mask);
+	cpumask_copy(&node_to_cpumask_map[0], cpu_possible_mask);
 	return 0;
 }
 early_initcall(numa_init_early);
