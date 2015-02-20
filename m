Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 20 Feb 2015 08:49:38 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 3.20 merge window #2
Message-ID: <20150220084938.2929bc10@mschwide>
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
Two patches to save some memory if CONFIG_NR_CPUS is large, a changed
default for the use of compare-and-delay, and a couple of bug fixes.

Heiko Carstens (5):
      s390/topology: delay initialization of topology cpu masks
      s390/topology: convert cpu_topology array to per cpu variable
      s390/smp: reduce size of struct pcpu
      s390/cacheinfo: fix shared cpu masks
      s390/cacheinfo: coding style changes

Martin Schwidefsky (3):
      s390/vdso: fix clock_gettime for CLOCK_THREAD_CPUTIME_ID, -2 and -3
      s390/mm: align 64-bit PIE binaries to 4GB
      s390/spinlock: disabled compare-and-delay by default

 arch/s390/include/asm/topology.h        |  24 ++----
 arch/s390/kernel/cache.c                |  25 ++----
 arch/s390/kernel/early.c                |  12 +--
 arch/s390/kernel/setup.c                |   1 -
 arch/s390/kernel/smp.c                  |  54 ++++++-------
 arch/s390/kernel/topology.c             | 134 +++++++++++++++-----------------
 arch/s390/kernel/vdso64/clock_gettime.S |   6 +-
 arch/s390/mm/mmap.c                     |   5 +-
 8 files changed, 119 insertions(+), 142 deletions(-)

diff --git a/arch/s390/include/asm/topology.h b/arch/s390/include/asm/topology.h
index c4fbb95..b1453a2 100644
--- a/arch/s390/include/asm/topology.h
+++ b/arch/s390/include/asm/topology.h
@@ -18,15 +18,15 @@ struct cpu_topology_s390 {
 	cpumask_t book_mask;
 };
 
-extern struct cpu_topology_s390 cpu_topology[NR_CPUS];
+DECLARE_PER_CPU(struct cpu_topology_s390, cpu_topology);
 
-#define topology_physical_package_id(cpu)	(cpu_topology[cpu].socket_id)
-#define topology_thread_id(cpu)			(cpu_topology[cpu].thread_id)
-#define topology_thread_cpumask(cpu)		(&cpu_topology[cpu].thread_mask)
-#define topology_core_id(cpu)			(cpu_topology[cpu].core_id)
-#define topology_core_cpumask(cpu)		(&cpu_topology[cpu].core_mask)
-#define topology_book_id(cpu)			(cpu_topology[cpu].book_id)
-#define topology_book_cpumask(cpu)		(&cpu_topology[cpu].book_mask)
+#define topology_physical_package_id(cpu) (per_cpu(cpu_topology, cpu).socket_id)
+#define topology_thread_id(cpu)		  (per_cpu(cpu_topology, cpu).thread_id)
+#define topology_thread_cpumask(cpu)	  (&per_cpu(cpu_topology, cpu).thread_mask)
+#define topology_core_id(cpu)		  (per_cpu(cpu_topology, cpu).core_id)
+#define topology_core_cpumask(cpu)	  (&per_cpu(cpu_topology, cpu).core_mask)
+#define topology_book_id(cpu)		  (per_cpu(cpu_topology, cpu).book_id)
+#define topology_book_cpumask(cpu)	  (&per_cpu(cpu_topology, cpu).book_mask)
 
 #define mc_capable() 1
 
@@ -51,14 +51,6 @@ static inline void topology_expect_change(void) { }
 #define POLARIZATION_VM		(2)
 #define POLARIZATION_VH		(3)
 
-#ifdef CONFIG_SCHED_BOOK
-void s390_init_cpu_topology(void);
-#else
-static inline void s390_init_cpu_topology(void)
-{
-};
-#endif
-
 #include <asm-generic/topology.h>
 
 #endif /* _ASM_S390_TOPOLOGY_H */
diff --git a/arch/s390/kernel/cache.c b/arch/s390/kernel/cache.c
index 632fa06..0969d113 100644
--- a/arch/s390/kernel/cache.c
+++ b/arch/s390/kernel/cache.c
@@ -91,12 +91,9 @@ static inline enum cache_type get_cache_type(struct cache_info *ci, int level)
 {
 	if (level >= CACHE_MAX_LEVEL)
 		return CACHE_TYPE_NOCACHE;
-
 	ci += level;
-
 	if (ci->scope != CACHE_SCOPE_SHARED && ci->scope != CACHE_SCOPE_PRIVATE)
 		return CACHE_TYPE_NOCACHE;
-
 	return cache_type_map[ci->type];
 }
 
@@ -111,23 +108,19 @@ static inline unsigned long ecag(int ai, int li, int ti)
 }
 
 static void ci_leaf_init(struct cacheinfo *this_leaf, int private,
-			 enum cache_type type, unsigned int level)
+			 enum cache_type type, unsigned int level, int cpu)
 {
 	int ti, num_sets;
-	int cpu = smp_processor_id();
 
 	if (type == CACHE_TYPE_INST)
 		ti = CACHE_TI_INSTRUCTION;
 	else
 		ti = CACHE_TI_UNIFIED;
-
 	this_leaf->level = level + 1;
 	this_leaf->type = type;
 	this_leaf->coherency_line_size = ecag(EXTRACT_LINE_SIZE, level, ti);
-	this_leaf->ways_of_associativity = ecag(EXTRACT_ASSOCIATIVITY,
-						level, ti);
+	this_leaf->ways_of_associativity = ecag(EXTRACT_ASSOCIATIVITY, level, ti);
 	this_leaf->size = ecag(EXTRACT_SIZE, level, ti);
-
 	num_sets = this_leaf->size / this_leaf->coherency_line_size;
 	num_sets /= this_leaf->ways_of_associativity;
 	this_leaf->number_of_sets = num_sets;
@@ -145,7 +138,6 @@ int init_cache_level(unsigned int cpu)
 
 	if (!this_cpu_ci)
 		return -EINVAL;
-
 	ct.raw = ecag(EXTRACT_TOPOLOGY, 0, 0);
 	do {
 		ctype = get_cache_type(&ct.ci[0], level);
@@ -154,34 +146,31 @@ int init_cache_level(unsigned int cpu)
 		/* Separate instruction and data caches */
 		leaves += (ctype == CACHE_TYPE_SEPARATE) ? 2 : 1;
 	} while (++level < CACHE_MAX_LEVEL);
-
 	this_cpu_ci->num_levels = level;
 	this_cpu_ci->num_leaves = leaves;
-
 	return 0;
 }
 
 int populate_cache_leaves(unsigned int cpu)
 {
+	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
+	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
 	unsigned int level, idx, pvt;
 	union cache_topology ct;
 	enum cache_type ctype;
-	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
-	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
 
 	ct.raw = ecag(EXTRACT_TOPOLOGY, 0, 0);
 	for (idx = 0, level = 0; level < this_cpu_ci->num_levels &&
 	     idx < this_cpu_ci->num_leaves; idx++, level++) {
 		if (!this_leaf)
 			return -EINVAL;
-
 		pvt = (ct.ci[level].scope == CACHE_SCOPE_PRIVATE) ? 1 : 0;
 		ctype = get_cache_type(&ct.ci[0], level);
 		if (ctype == CACHE_TYPE_SEPARATE) {
-			ci_leaf_init(this_leaf++, pvt, CACHE_TYPE_DATA, level);
-			ci_leaf_init(this_leaf++, pvt, CACHE_TYPE_INST, level);
+			ci_leaf_init(this_leaf++, pvt, CACHE_TYPE_DATA, level, cpu);
+			ci_leaf_init(this_leaf++, pvt, CACHE_TYPE_INST, level, cpu);
 		} else {
-			ci_leaf_init(this_leaf++, pvt, ctype, level);
+			ci_leaf_init(this_leaf++, pvt, ctype, level, cpu);
 		}
 	}
 	return 0;
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index 70a3294..4427ab7 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -393,17 +393,19 @@ static __init void detect_machine_facilities(void)
 		S390_lowcore.machine_flags |= MACHINE_FLAG_TLB_LC;
 	if (test_facility(129))
 		S390_lowcore.machine_flags |= MACHINE_FLAG_VX;
-	if (test_facility(128))
-		S390_lowcore.machine_flags |= MACHINE_FLAG_CAD;
 #endif
 }
 
-static int __init nocad_setup(char *str)
+static int __init cad_setup(char *str)
 {
-	S390_lowcore.machine_flags &= ~MACHINE_FLAG_CAD;
+	int val;
+
+	get_option(&str, &val);
+	if (val && test_facility(128))
+		S390_lowcore.machine_flags |= MACHINE_FLAG_CAD;
 	return 0;
 }
-early_param("nocad", nocad_setup);
+early_param("cad", cad_setup);
 
 static int __init cad_init(void)
 {
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index bfac77a..a5ea8bc 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -909,7 +909,6 @@ void __init setup_arch(char **cmdline_p)
 	setup_lowcore();
 	smp_fill_possible_mask();
         cpu_init();
-	s390_init_cpu_topology();
 
 	/*
 	 * Setup capabilities (ELF_HWCAP & ELF_PLATFORM).
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index a668993..db8f111 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -59,14 +59,13 @@ enum {
 	CPU_STATE_CONFIGURED,
 };
 
+static DEFINE_PER_CPU(struct cpu *, cpu_device);
+
 struct pcpu {
-	struct cpu *cpu;
 	struct _lowcore *lowcore;	/* lowcore page(s) for the cpu */
-	unsigned long async_stack;	/* async stack for the cpu */
-	unsigned long panic_stack;	/* panic stack for the cpu */
 	unsigned long ec_mask;		/* bit mask for ec_xxx functions */
-	int state;			/* physical cpu state */
-	int polarization;		/* physical polarization */
+	signed char state;		/* physical cpu state */
+	signed char polarization;	/* physical polarization */
 	u16 address;			/* physical cpu address */
 };
 
@@ -173,25 +172,30 @@ static void pcpu_ec_call(struct pcpu *pcpu, int ec_bit)
 	pcpu_sigp_retry(pcpu, order, 0);
 }
 
+#define ASYNC_FRAME_OFFSET (ASYNC_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE)
+#define PANIC_FRAME_OFFSET (PAGE_SIZE - STACK_FRAME_OVERHEAD - __PT_SIZE)
+
 static int pcpu_alloc_lowcore(struct pcpu *pcpu, int cpu)
 {
+	unsigned long async_stack, panic_stack;
 	struct _lowcore *lc;
 
 	if (pcpu != &pcpu_devices[0]) {
 		pcpu->lowcore =	(struct _lowcore *)
 			__get_free_pages(GFP_KERNEL | GFP_DMA, LC_ORDER);
-		pcpu->async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
-		pcpu->panic_stack = __get_free_page(GFP_KERNEL);
-		if (!pcpu->lowcore || !pcpu->panic_stack || !pcpu->async_stack)
+		async_stack = __get_free_pages(GFP_KERNEL, ASYNC_ORDER);
+		panic_stack = __get_free_page(GFP_KERNEL);
+		if (!pcpu->lowcore || !panic_stack || !async_stack)
 			goto out;
+	} else {
+		async_stack = pcpu->lowcore->async_stack - ASYNC_FRAME_OFFSET;
+		panic_stack = pcpu->lowcore->panic_stack - PANIC_FRAME_OFFSET;
 	}
 	lc = pcpu->lowcore;
 	memcpy(lc, &S390_lowcore, 512);
 	memset((char *) lc + 512, 0, sizeof(*lc) - 512);
-	lc->async_stack = pcpu->async_stack + ASYNC_SIZE
-		- STACK_FRAME_OVERHEAD - sizeof(struct pt_regs);
-	lc->panic_stack = pcpu->panic_stack + PAGE_SIZE
-		- STACK_FRAME_OVERHEAD - sizeof(struct pt_regs);
+	lc->async_stack = async_stack + ASYNC_FRAME_OFFSET;
+	lc->panic_stack = panic_stack + PANIC_FRAME_OFFSET;
 	lc->cpu_nr = cpu;
 	lc->spinlock_lockval = arch_spin_lockval(cpu);
 #ifndef CONFIG_64BIT
@@ -212,8 +216,8 @@ static int pcpu_alloc_lowcore(struct pcpu *pcpu, int cpu)
 	return 0;
 out:
 	if (pcpu != &pcpu_devices[0]) {
-		free_page(pcpu->panic_stack);
-		free_pages(pcpu->async_stack, ASYNC_ORDER);
+		free_page(panic_stack);
+		free_pages(async_stack, ASYNC_ORDER);
 		free_pages((unsigned long) pcpu->lowcore, LC_ORDER);
 	}
 	return -ENOMEM;
@@ -235,11 +239,11 @@ static void pcpu_free_lowcore(struct pcpu *pcpu)
 #else
 	vdso_free_per_cpu(pcpu->lowcore);
 #endif
-	if (pcpu != &pcpu_devices[0]) {
-		free_page(pcpu->panic_stack);
-		free_pages(pcpu->async_stack, ASYNC_ORDER);
-		free_pages((unsigned long) pcpu->lowcore, LC_ORDER);
-	}
+	if (pcpu == &pcpu_devices[0])
+		return;
+	free_page(pcpu->lowcore->panic_stack-PANIC_FRAME_OFFSET);
+	free_pages(pcpu->lowcore->async_stack-ASYNC_FRAME_OFFSET, ASYNC_ORDER);
+	free_pages((unsigned long) pcpu->lowcore, LC_ORDER);
 }
 
 #endif /* CONFIG_HOTPLUG_CPU */
@@ -366,7 +370,8 @@ void smp_call_online_cpu(void (*func)(void *), void *data)
 void smp_call_ipl_cpu(void (*func)(void *), void *data)
 {
 	pcpu_delegate(&pcpu_devices[0], func, data,
-		      pcpu_devices->panic_stack + PAGE_SIZE);
+		      pcpu_devices->lowcore->panic_stack -
+		      PANIC_FRAME_OFFSET + PAGE_SIZE);
 }
 
 int smp_find_processor_id(u16 address)
@@ -935,10 +940,6 @@ void __init smp_prepare_boot_cpu(void)
 	pcpu->state = CPU_STATE_CONFIGURED;
 	pcpu->address = stap();
 	pcpu->lowcore = (struct _lowcore *)(unsigned long) store_prefix();
-	pcpu->async_stack = S390_lowcore.async_stack - ASYNC_SIZE
-		+ STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
-	pcpu->panic_stack = S390_lowcore.panic_stack - PAGE_SIZE
-		+ STACK_FRAME_OVERHEAD + sizeof(struct pt_regs);
 	S390_lowcore.percpu_offset = __per_cpu_offset[0];
 	smp_cpu_set_polarization(0, POLARIZATION_UNKNOWN);
 	set_cpu_present(0, true);
@@ -1078,8 +1079,7 @@ static int smp_cpu_notify(struct notifier_block *self, unsigned long action,
 			  void *hcpu)
 {
 	unsigned int cpu = (unsigned int)(long)hcpu;
-	struct cpu *c = pcpu_devices[cpu].cpu;
-	struct device *s = &c->dev;
+	struct device *s = &per_cpu(cpu_device, cpu)->dev;
 	int err = 0;
 
 	switch (action & ~CPU_TASKS_FROZEN) {
@@ -1102,7 +1102,7 @@ static int smp_add_present_cpu(int cpu)
 	c = kzalloc(sizeof(*c), GFP_KERNEL);
 	if (!c)
 		return -ENOMEM;
-	pcpu_devices[cpu].cpu = c;
+	per_cpu(cpu_device, cpu) = c;
 	s = &c->dev;
 	c->hotpluggable = 1;
 	rc = register_cpu(c, cpu);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 24ee33f..14da43b 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -7,14 +7,14 @@
 #define pr_fmt(fmt) KMSG_COMPONENT ": " fmt
 
 #include <linux/workqueue.h>
-#include <linux/bootmem.h>
 #include <linux/cpuset.h>
 #include <linux/device.h>
 #include <linux/export.h>
 #include <linux/kernel.h>
 #include <linux/sched.h>
-#include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
@@ -42,8 +42,8 @@ static DEFINE_SPINLOCK(topology_lock);
 static struct mask_info socket_info;
 static struct mask_info book_info;
 
-struct cpu_topology_s390 cpu_topology[NR_CPUS];
-EXPORT_SYMBOL_GPL(cpu_topology);
+DEFINE_PER_CPU(struct cpu_topology_s390, cpu_topology);
+EXPORT_PER_CPU_SYMBOL_GPL(cpu_topology);
 
 static cpumask_t cpu_group_map(struct mask_info *info, unsigned int cpu)
 {
@@ -90,15 +90,15 @@ static struct mask_info *add_cpus_to_mask(struct topology_core *tl_core,
 		if (lcpu < 0)
 			continue;
 		for (i = 0; i <= smp_cpu_mtid; i++) {
-			cpu_topology[lcpu + i].book_id = book->id;
-			cpu_topology[lcpu + i].core_id = rcore;
-			cpu_topology[lcpu + i].thread_id = lcpu + i;
+			per_cpu(cpu_topology, lcpu + i).book_id = book->id;
+			per_cpu(cpu_topology, lcpu + i).core_id = rcore;
+			per_cpu(cpu_topology, lcpu + i).thread_id = lcpu + i;
 			cpumask_set_cpu(lcpu + i, &book->mask);
 			cpumask_set_cpu(lcpu + i, &socket->mask);
 			if (one_socket_per_cpu)
-				cpu_topology[lcpu + i].socket_id = rcore;
+				per_cpu(cpu_topology, lcpu + i).socket_id = rcore;
 			else
-				cpu_topology[lcpu + i].socket_id = socket->id;
+				per_cpu(cpu_topology, lcpu + i).socket_id = socket->id;
 			smp_cpu_set_polarization(lcpu + i, tl_core->pp);
 		}
 		if (one_socket_per_cpu)
@@ -249,14 +249,14 @@ static void update_cpu_masks(void)
 
 	spin_lock_irqsave(&topology_lock, flags);
 	for_each_possible_cpu(cpu) {
-		cpu_topology[cpu].thread_mask = cpu_thread_map(cpu);
-		cpu_topology[cpu].core_mask = cpu_group_map(&socket_info, cpu);
-		cpu_topology[cpu].book_mask = cpu_group_map(&book_info, cpu);
+		per_cpu(cpu_topology, cpu).thread_mask = cpu_thread_map(cpu);
+		per_cpu(cpu_topology, cpu).core_mask = cpu_group_map(&socket_info, cpu);
+		per_cpu(cpu_topology, cpu).book_mask = cpu_group_map(&book_info, cpu);
 		if (!MACHINE_HAS_TOPOLOGY) {
-			cpu_topology[cpu].thread_id = cpu;
-			cpu_topology[cpu].core_id = cpu;
-			cpu_topology[cpu].socket_id = cpu;
-			cpu_topology[cpu].book_id = cpu;
+			per_cpu(cpu_topology, cpu).thread_id = cpu;
+			per_cpu(cpu_topology, cpu).core_id = cpu;
+			per_cpu(cpu_topology, cpu).socket_id = cpu;
+			per_cpu(cpu_topology, cpu).book_id = cpu;
 		}
 	}
 	spin_unlock_irqrestore(&topology_lock, flags);
@@ -334,50 +334,6 @@ void topology_expect_change(void)
 	set_topology_timer();
 }
 
-static int __init early_parse_topology(char *p)
-{
-	if (strncmp(p, "off", 3))
-		return 0;
-	topology_enabled = 0;
-	return 0;
-}
-early_param("topology", early_parse_topology);
-
-static void __init alloc_masks(struct sysinfo_15_1_x *info,
-			       struct mask_info *mask, int offset)
-{
-	int i, nr_masks;
-
-	nr_masks = info->mag[TOPOLOGY_NR_MAG - offset];
-	for (i = 0; i < info->mnest - offset; i++)
-		nr_masks *= info->mag[TOPOLOGY_NR_MAG - offset - 1 - i];
-	nr_masks = max(nr_masks, 1);
-	for (i = 0; i < nr_masks; i++) {
-		mask->next = alloc_bootmem_align(
-			roundup_pow_of_two(sizeof(struct mask_info)),
-			roundup_pow_of_two(sizeof(struct mask_info)));
-		mask = mask->next;
-	}
-}
-
-void __init s390_init_cpu_topology(void)
-{
-	struct sysinfo_15_1_x *info;
-	int i;
-
-	if (!MACHINE_HAS_TOPOLOGY)
-		return;
-	tl_info = alloc_bootmem_pages(PAGE_SIZE);
-	info = tl_info;
-	store_topology(info);
-	pr_info("The CPU configuration topology of the machine is:");
-	for (i = 0; i < TOPOLOGY_NR_MAG; i++)
-		printk(KERN_CONT " %d", info->mag[i]);
-	printk(KERN_CONT " / %d\n", info->mnest);
-	alloc_masks(info, &socket_info, 1);
-	alloc_masks(info, &book_info, 2);
-}
-
 static int cpu_management;
 
 static ssize_t dispatching_show(struct device *dev,
@@ -467,20 +423,29 @@ int topology_cpu_init(struct cpu *cpu)
 
 const struct cpumask *cpu_thread_mask(int cpu)
 {
-	return &cpu_topology[cpu].thread_mask;
+	return &per_cpu(cpu_topology, cpu).thread_mask;
 }
 
 
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
-	return &cpu_topology[cpu].core_mask;
+	return &per_cpu(cpu_topology, cpu).core_mask;
 }
 
 static const struct cpumask *cpu_book_mask(int cpu)
 {
-	return &cpu_topology[cpu].book_mask;
+	return &per_cpu(cpu_topology, cpu).book_mask;
 }
 
+static int __init early_parse_topology(char *p)
+{
+	if (strncmp(p, "off", 3))
+		return 0;
+	topology_enabled = 0;
+	return 0;
+}
+early_param("topology", early_parse_topology);
+
 static struct sched_domain_topology_level s390_topology[] = {
 	{ cpu_thread_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
 	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
@@ -489,6 +454,42 @@ static struct sched_domain_topology_level s390_topology[] = {
 	{ NULL, },
 };
 
+static void __init alloc_masks(struct sysinfo_15_1_x *info,
+			       struct mask_info *mask, int offset)
+{
+	int i, nr_masks;
+
+	nr_masks = info->mag[TOPOLOGY_NR_MAG - offset];
+	for (i = 0; i < info->mnest - offset; i++)
+		nr_masks *= info->mag[TOPOLOGY_NR_MAG - offset - 1 - i];
+	nr_masks = max(nr_masks, 1);
+	for (i = 0; i < nr_masks; i++) {
+		mask->next = kzalloc(sizeof(*mask->next), GFP_KERNEL);
+		mask = mask->next;
+	}
+}
+
+static int __init s390_topology_init(void)
+{
+	struct sysinfo_15_1_x *info;
+	int i;
+
+	if (!MACHINE_HAS_TOPOLOGY)
+		return 0;
+	tl_info = (struct sysinfo_15_1_x *)__get_free_page(GFP_KERNEL);
+	info = tl_info;
+	store_topology(info);
+	pr_info("The CPU configuration topology of the machine is:");
+	for (i = 0; i < TOPOLOGY_NR_MAG; i++)
+		printk(KERN_CONT " %d", info->mag[i]);
+	printk(KERN_CONT " / %d\n", info->mnest);
+	alloc_masks(info, &socket_info, 1);
+	alloc_masks(info, &book_info, 2);
+	set_sched_topology(s390_topology);
+	return 0;
+}
+early_initcall(s390_topology_init);
+
 static int __init topology_init(void)
 {
 	if (MACHINE_HAS_TOPOLOGY)
@@ -498,10 +499,3 @@ static int __init topology_init(void)
 	return device_create_file(cpu_subsys.dev_root, &dev_attr_dispatching);
 }
 device_initcall(topology_init);
-
-static int __init early_topology_init(void)
-{
-	set_sched_topology(s390_topology);
-	return 0;
-}
-early_initcall(early_topology_init);
diff --git a/arch/s390/kernel/vdso64/clock_gettime.S b/arch/s390/kernel/vdso64/clock_gettime.S
index 7699e73..61541fb 100644
--- a/arch/s390/kernel/vdso64/clock_gettime.S
+++ b/arch/s390/kernel/vdso64/clock_gettime.S
@@ -25,9 +25,7 @@ __kernel_clock_gettime:
 	je	4f
 	cghi	%r2,__CLOCK_REALTIME
 	je	5f
-	cghi	%r2,__CLOCK_THREAD_CPUTIME_ID
-	je	9f
-	cghi	%r2,-2		/* Per-thread CPUCLOCK with PID=0, VIRT=1 */
+	cghi	%r2,-3		/* Per-thread CPUCLOCK with PID=0, VIRT=1 */
 	je	9f
 	cghi	%r2,__CLOCK_MONOTONIC_COARSE
 	je	3f
@@ -106,7 +104,7 @@ __kernel_clock_gettime:
 	aghi	%r15,16
 	br	%r14
 
-	/* CLOCK_THREAD_CPUTIME_ID for this thread */
+	/* CPUCLOCK_VIRT for this thread */
 9:	icm	%r0,15,__VDSO_ECTG_OK(%r5)
 	jz	12f
 	ear	%r2,%a4
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index d008f638..179a2c2 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -183,7 +183,10 @@ unsigned long randomize_et_dyn(void)
 {
 	unsigned long base;
 
-	base = (STACK_TOP / 3 * 2) & (~mmap_align_mask << PAGE_SHIFT);
+	base = STACK_TOP / 3 * 2;
+	if (!is_32bit_task())
+		/* Align to 4GB */
+		base &= ~((1UL << 32) - 1);
 	return base + mmap_rnd();
 }
 
