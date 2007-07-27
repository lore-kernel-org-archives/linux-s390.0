Return-Path: <linux-kernel-owner+w=401wt.eu-S937152AbXG0Lh1@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Fri, 27 Jul 2007 13:40:07 +0200
Message-Id: <1185536408.3781.1.camel@localhost>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: torvalds@linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Please pull from 'for-linus' branch of

	git://git390.osdl.marist.edu/pub/scm/linux-2.6.git for-linus

to receive the following updates:

 Documentation/feature-removal-schedule.txt |   16 --
 arch/s390/appldata/appldata_base.c         |   12 +-
 arch/s390/kernel/compat_wrapper.S          |   10 +
 arch/s390/kernel/entry.S                   |    6 +-
 arch/s390/kernel/entry64.S                 |    6 +-
 arch/s390/kernel/head.S                    |    1 +
 arch/s390/kernel/smp.c                     |   30 ++--
 arch/s390/kernel/sys_s390.c                |   20 +++
 arch/s390/kernel/syscalls.S                |    2 +-
 arch/s390/kernel/vmlinux.lds.S             |    1 +
 arch/s390/kernel/vtime.c                   |    2 +-
 arch/s390/mm/vmem.c                        |    6 +-
 drivers/s390/char/Kconfig                  |   12 +-
 drivers/s390/char/raw3270.c                |    6 +-
 drivers/s390/char/sclp_vt220.c             |   62 +++++---
 drivers/s390/char/vmur.c                   |    2 +-
 drivers/s390/cio/blacklist.c               |   19 +--
 drivers/s390/cio/ccwgroup.c                |    3 -
 drivers/s390/cio/chp.c                     |   19 +--
 drivers/s390/cio/chsc.c                    |   26 ++--
 drivers/s390/cio/chsc.h                    |    2 +
 drivers/s390/cio/cio.c                     |   13 +-
 drivers/s390/cio/cio_debug.h               |    2 +
 drivers/s390/cio/cmf.c                     |   16 +-
 drivers/s390/cio/css.c                     |   32 +++-
 drivers/s390/cio/css.h                     |    1 -
 drivers/s390/cio/device.c                  |   60 ++++---
 drivers/s390/cio/device_fsm.c              |   20 ++-
 drivers/s390/cio/device_ops.c              |  257 ----------------------------
 include/asm-s390/ccwdev.h                  |    5 -
 include/asm-s390/s390_ext.h                |    2 +
 include/asm-s390/smp.h                     |   11 +-
 include/asm-s390/unistd.h                  |    2 +-
 net/iucv/iucv.c                            |   15 +-
 34 files changed, 236 insertions(+), 463 deletions(-)

Christian Borntraeger (1):
      [S390] add types.h include to s390_ext.h

Cornelia Huck (6):
      [S390] cio: css_sch_device_register() can be made static.
      [S390] cio: Remove remains of _ccw_device_get_device_number().
      [S390] cio: Remove deprecated rdc/rcd.
      [S390] cio: Clean up messages.
      [S390] cio: Make CIO_* macros safe if dbfs are not available.
      [S390] cio: Reorganize initialization.

Frank Munzert (1):
      [S390] vmur: fix diag14_read.

Heiko Carstens (6):
      [S390] Convert to smp_call_function_single.
      [S390] Improve __smp_call_function_map.
      [S390] sclp: kill unused SCLP config option.
      [S390] Get rid of new section mismatch warnings.
      [S390] Fix IRQ tracing.
      [S390] Fix sclp_vt220 error handling.

Martin Schwidefsky (1):
      [S390] Wire up sys_fallocate.

diff --git a/Documentation/feature-removal-schedule.txt b/Documentation/feature-removal-schedule.txt
index c175eed..a43d287 100644
--- a/Documentation/feature-removal-schedule.txt
+++ b/Documentation/feature-removal-schedule.txt
@@ -211,22 +211,6 @@ Who:	Richard Purdie <rpurdie@rpsys.net>
 
 ---------------------------
 
-What:	read_dev_chars(), read_conf_data{,_lpm}() (s390 common I/O layer)
-When:	December 2007
-Why:	These functions are a leftover from 2.4 times. They have several
-	problems:
-	- Duplication of checks that are done in the device driver's
-	  interrupt handler
-	- common I/O layer can't do device specific error recovery
-	- device driver can't be notified for conditions happening during
-	  execution of the function
-	Device drivers should issue the read device characteristics and read
-	configuration data ccws and do the appropriate error handling
-	themselves.
-Who:	Cornelia Huck <cornelia.huck@de.ibm.com>
-
----------------------------
-
 What:	i2c-ixp2000, i2c-ixp4xx and scx200_i2c drivers
 When:	September 2007
 Why:	Obsolete. The new i2c-gpio driver replaces all hardware-specific
diff --git a/arch/s390/appldata/appldata_base.c b/arch/s390/appldata/appldata_base.c
index 6ffbab7..62391fb 100644
--- a/arch/s390/appldata/appldata_base.c
+++ b/arch/s390/appldata/appldata_base.c
@@ -173,7 +173,7 @@ int appldata_diag(char record_nr, u16 function, unsigned long buffer,
 /*
  * appldata_mod_vtimer_wrap()
  *
- * wrapper function for mod_virt_timer(), because smp_call_function_on()
+ * wrapper function for mod_virt_timer(), because smp_call_function_single()
  * accepts only one parameter.
  */
 static void __appldata_mod_vtimer_wrap(void *p) {
@@ -208,9 +208,9 @@ __appldata_vtimer_setup(int cmd)
 					  num_online_cpus()) * TOD_MICRO;
 		for_each_online_cpu(i) {
 			per_cpu(appldata_timer, i).expires = per_cpu_interval;
-			smp_call_function_on(add_virt_timer_periodic,
-					     &per_cpu(appldata_timer, i),
-					     0, 1, i);
+			smp_call_function_single(i, add_virt_timer_periodic,
+						 &per_cpu(appldata_timer, i),
+						 0, 1);
 		}
 		appldata_timer_active = 1;
 		P_INFO("Monitoring timer started.\n");
@@ -236,8 +236,8 @@ __appldata_vtimer_setup(int cmd)
 			} args;
 			args.timer = &per_cpu(appldata_timer, i);
 			args.expires = per_cpu_interval;
-			smp_call_function_on(__appldata_mod_vtimer_wrap,
-					     &args, 0, 1, i);
+			smp_call_function_single(i, __appldata_mod_vtimer_wrap,
+						 &args, 0, 1);
 		}
 	}
 }
diff --git a/arch/s390/kernel/compat_wrapper.S b/arch/s390/kernel/compat_wrapper.S
index acc4154..6ee1bed 100644
--- a/arch/s390/kernel/compat_wrapper.S
+++ b/arch/s390/kernel/compat_wrapper.S
@@ -1710,3 +1710,13 @@ compat_sys_timerfd_wrapper:
 sys_eventfd_wrapper:
 	llgfr	%r2,%r2			# unsigned int
 	jg	sys_eventfd
+
+	.globl	sys_fallocate_wrapper
+sys_fallocate_wrapper:
+	lgfr	%r2,%r2			# int
+	lgfr	%r3,%r3			# int
+	sllg	%r4,%r4,32		# get high word of 64bit loff_t
+	lr	%r4,%r5			# get low word of 64bit loff_t
+	sllg	%r5,%r6,32		# get high word of 64bit loff_t
+	l	%r5,164(%r15)		# get low word of 64bit loff_t
+	jg	sys_fallocate
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index bc7ff36..f3bceb1 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -624,9 +624,11 @@ io_work_loop:
 # _TIF_MCCK_PENDING is set, call handler
 #
 io_mcck_pending:
+	TRACE_IRQS_OFF
 	l	%r1,BASED(.Ls390_handle_mcck)
-	la	%r14,BASED(io_work_loop)
-	br	%r1			# TIF bit will be cleared by handler
+	basr	%r14,%r1		# TIF bit will be cleared by handler
+	TRACE_IRQS_ON
+	b	BASED(io_work_loop)
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
diff --git a/arch/s390/kernel/entry64.S b/arch/s390/kernel/entry64.S
index 2a7b130..9c0d5cc 100644
--- a/arch/s390/kernel/entry64.S
+++ b/arch/s390/kernel/entry64.S
@@ -611,8 +611,10 @@ io_work_loop:
 # _TIF_MCCK_PENDING is set, call handler
 #
 io_mcck_pending:
-	larl	%r14,io_work_loop
-	jg	s390_handle_mcck	# TIF bit will be cleared by handler
+	TRACE_IRQS_OFF
+	brasl	%r14,s390_handle_mcck	# TIF bit will be cleared by handler
+	TRACE_IRQS_ON
+	j	io_work_loop
 
 #
 # _TIF_NEED_RESCHED is set, call schedule
diff --git a/arch/s390/kernel/head.S b/arch/s390/kernel/head.S
index 8f8c802..83477c7 100644
--- a/arch/s390/kernel/head.S
+++ b/arch/s390/kernel/head.S
@@ -35,6 +35,7 @@
 #define ARCH_OFFSET	0
 #endif
 
+.section ".text.head","ax"
 #ifndef CONFIG_IPL
 	.org   0
 	.long  0x00080000,0x80000000+startup	# Just a restart PSW
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 182c085..03674fb 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -120,7 +120,7 @@ static void __smp_call_function_map(void (*func) (void *info), void *info,
 	if (wait)
 		data.finished = CPU_MASK_NONE;
 
-	spin_lock_bh(&call_lock);
+	spin_lock(&call_lock);
 	call_data = &data;
 
 	for_each_cpu_mask(cpu, map)
@@ -129,18 +129,16 @@ static void __smp_call_function_map(void (*func) (void *info), void *info,
 	/* Wait for response */
 	while (!cpus_equal(map, data.started))
 		cpu_relax();
-
 	if (wait)
 		while (!cpus_equal(map, data.finished))
 			cpu_relax();
-
-	spin_unlock_bh(&call_lock);
-
+	spin_unlock(&call_lock);
 out:
-	local_irq_disable();
-	if (local)
+	if (local) {
+		local_irq_disable();
 		func(info);
-	local_irq_enable();
+		local_irq_enable();
+	}
 }
 
 /*
@@ -170,30 +168,28 @@ int smp_call_function(void (*func) (void *info), void *info, int nonatomic,
 EXPORT_SYMBOL(smp_call_function);
 
 /*
- * smp_call_function_on:
+ * smp_call_function_single:
+ * @cpu: the CPU where func should run
  * @func: the function to run; this must be fast and non-blocking
  * @info: an arbitrary pointer to pass to the function
  * @nonatomic: unused
  * @wait: if true, wait (atomically) until function has completed on other CPUs
- * @cpu: the CPU where func should run
  *
  * Run a function on one processor.
  *
  * You must not call this function with disabled interrupts, from a
  * hardware interrupt handler or from a bottom half.
  */
-int smp_call_function_on(void (*func) (void *info), void *info, int nonatomic,
-			 int wait, int cpu)
+int smp_call_function_single(int cpu, void (*func) (void *info), void *info,
+			     int nonatomic, int wait)
 {
-	cpumask_t map = CPU_MASK_NONE;
-
 	preempt_disable();
-	cpu_set(cpu, map);
-	__smp_call_function_map(func, info, nonatomic, wait, map);
+	__smp_call_function_map(func, info, nonatomic, wait,
+				cpumask_of_cpu(cpu));
 	preempt_enable();
 	return 0;
 }
-EXPORT_SYMBOL(smp_call_function_on);
+EXPORT_SYMBOL(smp_call_function_single);
 
 static void do_send_stop(void)
 {
diff --git a/arch/s390/kernel/sys_s390.c b/arch/s390/kernel/sys_s390.c
index 1c90c7e..13e27bd 100644
--- a/arch/s390/kernel/sys_s390.c
+++ b/arch/s390/kernel/sys_s390.c
@@ -265,3 +265,23 @@ s390_fadvise64_64(struct fadvise64_64_args __user *args)
 		return -EFAULT;
 	return sys_fadvise64_64(a.fd, a.offset, a.len, a.advice);
 }
+
+#ifndef CONFIG_64BIT
+/*
+ * This is a wrapper to call sys_fallocate(). For 31 bit s390 the last
+ * 64 bit argument "len" is split into the upper and lower 32 bits. The
+ * system call wrapper in the user space loads the value to %r6/%r7.
+ * The code in entry.S keeps the values in %r2 - %r6 where they are and
+ * stores %r7 to 96(%r15). But the standard C linkage requires that
+ * the whole 64 bit value for len is stored on the stack and doesn't
+ * use %r6 at all. So s390_fallocate has to convert the arguments from
+ *   %r2: fd, %r3: mode, %r4/%r5: offset, %r6/96(%r15)-99(%r15): len
+ * to
+ *   %r2: fd, %r3: mode, %r4/%r5: offset, 96(%r15)-103(%r15): len
+ */
+asmlinkage long s390_fallocate(int fd, int mode, loff_t offset,
+			       u32 len_high, u32 len_low)
+{
+	return sys_fallocate(fd, mode, offset, ((u64)len_high << 32) | len_low);
+}
+#endif
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 738feb4..9e26ed9 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -322,7 +322,7 @@ NI_SYSCALL							/* 310 sys_move_pages */
 SYSCALL(sys_getcpu,sys_getcpu,sys_getcpu_wrapper)
 SYSCALL(sys_epoll_pwait,sys_epoll_pwait,compat_sys_epoll_pwait_wrapper)
 SYSCALL(sys_utimes,sys_utimes,compat_sys_utimes_wrapper)
-NI_SYSCALL							/* 314 sys_fallocate */
+SYSCALL(s390_fallocate,sys_fallocate,sys_fallocate_wrapper)
 SYSCALL(sys_utimensat,sys_utimensat,compat_sys_utimensat_wrapper)	/* 315 */
 SYSCALL(sys_signalfd,sys_signalfd,compat_sys_signalfd_wrapper)
 SYSCALL(sys_timerfd,sys_timerfd,compat_sys_timerfd_wrapper)
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 6ab7d4e..b4622a3 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -21,6 +21,7 @@ SECTIONS
   . = 0x00000000;
   _text = .;			/* Text and read-only data */
   .text : {
+	*(.text.head)
 	TEXT_TEXT
 	SCHED_TEXT
 	LOCK_TEXT
diff --git a/arch/s390/kernel/vtime.c b/arch/s390/kernel/vtime.c
index b6ed143..84ff78d 100644
--- a/arch/s390/kernel/vtime.c
+++ b/arch/s390/kernel/vtime.c
@@ -415,7 +415,7 @@ EXPORT_SYMBOL(add_virt_timer_periodic);
 
 /*
  * If we change a pending timer the function must be called on the CPU
- * where the timer is running on, e.g. by smp_call_function_on()
+ * where the timer is running on, e.g. by smp_call_function_single()
  *
  * The original mod_timer adds the timer if it is not pending. For compatibility
  * we do the same. The timer will be added on the current CPU as a oneshot timer.
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index 92a5651..fd594d5 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -29,8 +29,8 @@ struct memory_segment {
 
 static LIST_HEAD(mem_segs);
 
-void memmap_init(unsigned long size, int nid, unsigned long zone,
-		 unsigned long start_pfn)
+void __meminit memmap_init(unsigned long size, int nid, unsigned long zone,
+			   unsigned long start_pfn)
 {
 	struct page *start, *end;
 	struct page *map_start, *map_end;
@@ -66,7 +66,7 @@ void memmap_init(unsigned long size, int nid, unsigned long zone,
 	}
 }
 
-static inline void *vmem_alloc_pages(unsigned int order)
+static void __init_refok *vmem_alloc_pages(unsigned int order)
 {
 	if (slab_is_available())
 		return (void *)__get_free_pages(GFP_KERNEL, order);
diff --git a/drivers/s390/char/Kconfig b/drivers/s390/char/Kconfig
index 3f36cb3..6430338 100644
--- a/drivers/s390/char/Kconfig
+++ b/drivers/s390/char/Kconfig
@@ -44,15 +44,9 @@ config CCW_CONSOLE
 	depends on TN3215_CONSOLE || TN3270_CONSOLE
 	default y
 
-config SCLP
-	bool "Support for SCLP"
-	depends on S390
-	help
-	  Include support for the SCLP interface to the service element.
-
 config SCLP_TTY
 	bool "Support for SCLP line mode terminal"
-	depends on SCLP
+	depends on S390
 	help
 	  Include support for IBM SCLP line-mode terminals.
 
@@ -65,7 +59,7 @@ config SCLP_CONSOLE
 
 config SCLP_VT220_TTY
 	bool "Support for SCLP VT220-compatible terminal"
-	depends on SCLP
+	depends on S390
 	help
 	  Include support for an IBM SCLP VT220-compatible terminal.
 
@@ -78,7 +72,7 @@ config SCLP_VT220_CONSOLE
 
 config SCLP_CPI
 	tristate "Control-Program Identification"
-	depends on SCLP
+	depends on S390
 	help
 	  This option enables the hardware console interface for system
 	  identification. This is commonly used for workload management and
diff --git a/drivers/s390/char/raw3270.c b/drivers/s390/char/raw3270.c
index 743944a..4f2f81b 100644
--- a/drivers/s390/char/raw3270.c
+++ b/drivers/s390/char/raw3270.c
@@ -147,8 +147,7 @@ raw3270_request_alloc(size_t size)
  * Allocate a new 3270 ccw request from bootmem. Only works very
  * early in the boot process. Only con3270.c should be using this.
  */
-struct raw3270_request *
-raw3270_request_alloc_bootmem(size_t size)
+struct raw3270_request __init *raw3270_request_alloc_bootmem(size_t size)
 {
 	struct raw3270_request *rq;
 
@@ -848,8 +847,7 @@ raw3270_setup_device(struct ccw_device *cdev, struct raw3270 *rp, char *ascebc)
 /*
  * Setup 3270 device configured as console.
  */
-struct raw3270 *
-raw3270_setup_console(struct ccw_device *cdev)
+struct raw3270 __init *raw3270_setup_console(struct ccw_device *cdev)
 {
 	struct raw3270 *rp;
 	char *ascebc;
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 7263347..40cd21b 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -621,11 +621,24 @@ sclp_vt220_flush_buffer(struct tty_struct *tty)
 /*
  * Initialize all relevant components and register driver with system.
  */
-static int
-__sclp_vt220_init(int early)
+static void __init __sclp_vt220_cleanup(void)
+{
+	struct list_head *page, *p;
+
+	list_for_each_safe(page, p, &sclp_vt220_empty) {
+		list_del(page);
+		if (slab_is_available())
+			free_page((unsigned long) page);
+		else
+			free_bootmem((unsigned long) page, PAGE_SIZE);
+	}
+}
+
+static int __init __sclp_vt220_init(void)
 {
 	void *page;
 	int i;
+	int num_pages;
 
 	if (sclp_vt220_initialized)
 		return 0;
@@ -642,13 +655,16 @@ __sclp_vt220_init(int early)
 	sclp_vt220_flush_later = 0;
 
 	/* Allocate pages for output buffering */
-	for (i = 0; i < (early ? MAX_CONSOLE_PAGES : MAX_KMEM_PAGES); i++) {
-		if (early)
-			page = alloc_bootmem_low_pages(PAGE_SIZE);
-		else
+	num_pages = slab_is_available() ? MAX_KMEM_PAGES : MAX_CONSOLE_PAGES;
+	for (i = 0; i < num_pages; i++) {
+		if (slab_is_available())
 			page = (void *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
-		if (!page)
+		else
+			page = alloc_bootmem_low_pages(PAGE_SIZE);
+		if (!page) {
+			__sclp_vt220_cleanup();
 			return -ENOMEM;
+		}
 		list_add_tail((struct list_head *) page, &sclp_vt220_empty);
 	}
 	return 0;
@@ -662,14 +678,13 @@ static const struct tty_operations sclp_vt220_ops = {
 	.flush_chars = sclp_vt220_flush_chars,
 	.write_room = sclp_vt220_write_room,
 	.chars_in_buffer = sclp_vt220_chars_in_buffer,
-	.flush_buffer = sclp_vt220_flush_buffer
+	.flush_buffer = sclp_vt220_flush_buffer,
 };
 
 /*
  * Register driver with SCLP and Linux and initialize internal tty structures.
  */
-static int __init
-sclp_vt220_tty_init(void)
+static int __init sclp_vt220_tty_init(void)
 {
 	struct tty_driver *driver;
 	int rc;
@@ -679,18 +694,15 @@ sclp_vt220_tty_init(void)
 	driver = alloc_tty_driver(1);
 	if (!driver)
 		return -ENOMEM;
-	rc = __sclp_vt220_init(0);
-	if (rc) {
-		put_tty_driver(driver);
-		return rc;
-	}
+	rc = __sclp_vt220_init();
+	if (rc)
+		goto out_driver;
 	rc = sclp_register(&sclp_vt220_register);
 	if (rc) {
 		printk(KERN_ERR SCLP_VT220_PRINT_HEADER
 		       "could not register tty - "
 		       "sclp_register returned %d\n", rc);
-		put_tty_driver(driver);
-		return rc;
+		goto out_init;
 	}
 
 	driver->owner = THIS_MODULE;
@@ -709,14 +721,20 @@ sclp_vt220_tty_init(void)
 		printk(KERN_ERR SCLP_VT220_PRINT_HEADER
 		       "could not register tty - "
 		       "tty_register_driver returned %d\n", rc);
-		put_tty_driver(driver);
-		return rc;
+		goto out_sclp;
 	}
 	sclp_vt220_driver = driver;
 	return 0;
-}
 
-module_init(sclp_vt220_tty_init);
+out_sclp:
+	sclp_unregister(&sclp_vt220_register);
+out_init:
+	__sclp_vt220_cleanup();
+out_driver:
+	put_tty_driver(driver);
+	return rc;
+}
+__initcall(sclp_vt220_tty_init);
 
 #ifdef CONFIG_SCLP_VT220_CONSOLE
 
@@ -762,7 +780,7 @@ sclp_vt220_con_init(void)
 
 	if (!CONSOLE_IS_SCLP)
 		return 0;
-	rc = __sclp_vt220_init(1);
+	rc = __sclp_vt220_init();
 	if (rc)
 		return rc;
 	/* Attach linux console */
diff --git a/drivers/s390/char/vmur.c b/drivers/s390/char/vmur.c
index e90b0f8..161867c 100644
--- a/drivers/s390/char/vmur.c
+++ b/drivers/s390/char/vmur.c
@@ -486,7 +486,7 @@ static ssize_t diag14_read(struct file *file, char __user *ubuf, size_t count,
 		}
 		if (rc)
 			goto fail;
-		if (reclen)
+		if (reclen && (copied == 0) && (*offs < PAGE_SIZE))
 			*((u16 *) &buf[FILE_RECLEN_OFFSET]) = reclen;
 		len = min(count - copied, PAGE_SIZE - res);
 		if (copy_to_user(ubuf + copied, buf + res, len)) {
diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index ec04048..bd5f16f 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -51,7 +51,7 @@ blacklist_range (range_action action, unsigned int from, unsigned int to,
 		to = from;
 
 	if (from > to || to > __MAX_SUBCHANNEL || ssid > __MAX_SSID) {
-		printk (KERN_WARNING "Invalid blacklist range "
+		printk (KERN_WARNING "cio: Invalid blacklist range "
 			"0.%x.%04x to 0.%x.%04x, skipping\n",
 			ssid, from, ssid, to);
 		return;
@@ -119,7 +119,7 @@ blacklist_busid(char **str, int *id0, int *ssid, int *devno)
 	return 0;
 confused:
 	strsep(str, ",\n");
-	printk(KERN_WARNING "Invalid cio_ignore parameter '%s'\n", sav);
+	printk(KERN_WARNING "cio: Invalid cio_ignore parameter '%s'\n", sav);
 	return 1;
 }
 
@@ -166,22 +166,19 @@ blacklist_parse_parameters (char *str, range_action action)
 					continue;
 			}
 			if (*str == '-') {
-				printk(KERN_WARNING "invalid cio_ignore "
+				printk(KERN_WARNING "cio: invalid cio_ignore "
 					"parameter '%s'\n",
 					strsep(&str, ",\n"));
 				continue;
 			}
 			if ((from_id0 != to_id0) ||
 			    (from_ssid != to_ssid)) {
-				printk(KERN_WARNING "invalid cio_ignore range "
-					"%x.%x.%04x-%x.%x.%04x\n",
-					from_id0, from_ssid, from,
-					to_id0, to_ssid, to);
+				printk(KERN_WARNING "cio: invalid cio_ignore "
+				       "range %x.%x.%04x-%x.%x.%04x\n",
+				       from_id0, from_ssid, from,
+				       to_id0, to_ssid, to);
 				continue;
 			}
-			pr_debug("blacklist_setup: adding range "
-				 "from %x.%x.%04x to %x.%x.%04x\n",
-				 from_id0, from_ssid, from, to_id0, to_ssid, to);
 			blacklist_range (ra, from, to, to_ssid);
 		}
 	}
@@ -239,7 +236,7 @@ blacklist_parse_proc_parameters (char *buf)
 		 */
 		blacklist_parse_parameters (buf + 4, add);
 	} else {
-		printk (KERN_WARNING "cio_ignore: Parse error; \n"
+		printk (KERN_WARNING "cio: cio_ignore: Parse error; \n"
 			KERN_WARNING "try using 'free all|<devno-range>,"
 				     "<devno-range>,...'\n"
 			KERN_WARNING "or 'add <devno-range>,"
diff --git a/drivers/s390/cio/ccwgroup.c b/drivers/s390/cio/ccwgroup.c
index e5ccda6..b0a18f5 100644
--- a/drivers/s390/cio/ccwgroup.c
+++ b/drivers/s390/cio/ccwgroup.c
@@ -359,7 +359,6 @@ ccwgroup_probe (struct device *dev)
 	if ((ret = device_create_file(dev, &dev_attr_online)))
 		return ret;
 
-	pr_debug("%s: device %s\n", __func__, gdev->dev.bus_id);
 	ret = gdrv->probe ? gdrv->probe(gdev) : -ENODEV;
 	if (ret)
 		device_remove_file(dev, &dev_attr_online);
@@ -376,8 +375,6 @@ ccwgroup_remove (struct device *dev)
 	gdev = to_ccwgroupdev(dev);
 	gdrv = to_ccwgroupdrv(dev->driver);
 
-	pr_debug("%s: device %s\n", __func__, gdev->dev.bus_id);
-
 	device_remove_file(dev, &dev_attr_online);
 
 	if (gdrv && gdrv->remove)
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index b57d93d..920dd71 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -121,14 +121,8 @@ static int s390_vary_chpid(struct chp_id chpid, int on)
 	CIO_TRACE_EVENT( 2, dbf_text);
 
 	status = chp_get_status(chpid);
-	if (status < 0) {
-		printk(KERN_ERR "Can't vary unknown chpid %x.%02x\n",
-		       chpid.cssid, chpid.id);
-		return -EINVAL;
-	}
-
 	if (!on && !status) {
-		printk(KERN_ERR "chpid %x.%02x is already offline\n",
+		printk(KERN_ERR "cio: chpid %x.%02x is already offline\n",
 		       chpid.cssid, chpid.id);
 		return -EINVAL;
 	}
@@ -421,21 +415,14 @@ int chp_new(struct chp_id chpid)
 		if (ret)
 			goto out_free;
 	} else {
-		static int msg_done;
-
-		if (!msg_done) {
-			printk(KERN_WARNING "cio: Channel measurements not "
-			       "available, continuing.\n");
-			msg_done = 1;
-		}
 		chp->cmg = -1;
 	}
 
 	/* make it known to the system */
 	ret = device_register(&chp->dev);
 	if (ret) {
-		printk(KERN_WARNING "%s: could not register %x.%02x\n",
-		       __func__, chpid.cssid, chpid.id);
+		CIO_MSG_EVENT(0, "Could not register chp%x.%02x: %d\n",
+			      chpid.cssid, chpid.id, ret);
 		goto out_free;
 	}
 	ret = sysfs_create_group(&chp->dev.kobj, &chp_attr_group);
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index ea92ac4..597c0c7 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -990,16 +990,20 @@ out:
 	return ret;
 }
 
-static int __init
-chsc_alloc_sei_area(void)
+int __init chsc_alloc_sei_area(void)
 {
 	sei_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!sei_page)
-		printk(KERN_WARNING"Can't allocate page for processing of " \
-		       "chsc machine checks!\n");
+		CIO_MSG_EVENT(0, "Can't allocate page for processing of "
+			      "chsc machine checks!\n");
 	return (sei_page ? 0 : -ENOMEM);
 }
 
+void __init chsc_free_sei_area(void)
+{
+	kfree(sei_page);
+}
+
 int __init
 chsc_enable_facility(int operation_code)
 {
@@ -1051,8 +1055,6 @@ chsc_enable_facility(int operation_code)
 	return ret;
 }
 
-subsys_initcall(chsc_alloc_sei_area);
-
 struct css_general_char css_general_characteristics;
 struct css_chsc_char css_chsc_characteristics;
 
@@ -1073,8 +1075,8 @@ chsc_determine_css_characteristics(void)
 
 	scsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scsc_area) {
-	        printk(KERN_WARNING"cio: Was not able to determine available" \
-		       "CHSCs due to no memory.\n");
+		CIO_MSG_EVENT(0, "Was not able to determine available"
+			      "CHSCs due to no memory.\n");
 		return -ENOMEM;
 	}
 
@@ -1083,15 +1085,15 @@ chsc_determine_css_characteristics(void)
 
 	result = chsc(scsc_area);
 	if (result) {
-		printk(KERN_WARNING"cio: Was not able to determine " \
-		       "available CHSCs, cc=%i.\n", result);
+		CIO_MSG_EVENT(0, "Was not able to determine available CHSCs, "
+			      "cc=%i.\n", result);
 		result = -EIO;
 		goto exit;
 	}
 
 	if (scsc_area->response.code != 1) {
-		printk(KERN_WARNING"cio: Was not able to determine " \
-		       "available CHSCs.\n");
+		CIO_MSG_EVENT(0, "Was not able to determine "
+			      "available CHSCs.\n");
 		result = -EIO;
 		goto exit;
 	}
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 2ad81d1..d1f5db1 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -79,6 +79,8 @@ extern int chsc_get_ssd_info(struct subchannel_id schid,
 			     struct chsc_ssd_info *ssd);
 extern int chsc_determine_css_characteristics(void);
 extern int css_characteristics_avail;
+extern int chsc_alloc_sei_area(void);
+extern void chsc_free_sei_area(void);
 
 extern int chsc_enable_facility(int);
 struct channel_subsystem;
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index ea1defb..f2708d6 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -47,8 +47,8 @@ cio_setup (char *parm)
 	else if (!strcmp (parm, "no"))
 		cio_show_msg = 0;
 	else
-		printk (KERN_ERR "cio_setup : invalid cio_msg parameter '%s'",
-			parm);
+		printk(KERN_ERR "cio: cio_setup: "
+		       "invalid cio_msg parameter '%s'", parm);
 	return 1;
 }
 
@@ -80,7 +80,6 @@ cio_debug_init (void)
 		goto out_unregister;
 	debug_register_view (cio_debug_crw_id, &debug_sprintf_view);
 	debug_set_level (cio_debug_crw_id, 2);
-	pr_debug("debugging initialized\n");
 	return 0;
 
 out_unregister:
@@ -90,7 +89,7 @@ out_unregister:
 		debug_unregister (cio_debug_trace_id);
 	if (cio_debug_crw_id)
 		debug_unregister (cio_debug_crw_id);
-	pr_debug("could not initialize debugging\n");
+	printk(KERN_WARNING"cio: could not initialize debugging\n");
 	return -1;
 }
 
@@ -568,7 +567,7 @@ cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
 	 */
 	if (sch->st != 0) {
 		CIO_DEBUG(KERN_INFO, 0,
-			  "Subchannel 0.%x.%04x reports "
+			  "cio: Subchannel 0.%x.%04x reports "
 			  "non-I/O subchannel type %04X\n",
 			  sch->schid.ssid, sch->schid.sch_no, sch->st);
 		/* We stop here for non-io subchannels. */
@@ -601,7 +600,7 @@ cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
 
 	CIO_DEBUG(KERN_INFO, 0,
-		  "Detected device %04x on subchannel 0.%x.%04X"
+		  "cio: Detected device %04x on subchannel 0.%x.%04X"
 		  " - PIM = %02X, PAM = %02X, POM = %02X\n",
 		  sch->schib.pmcw.dev, sch->schid.ssid,
 		  sch->schid.sch_no, sch->schib.pmcw.pim,
@@ -766,7 +765,7 @@ cio_get_console_sch_no(void)
 		/* unlike in 2.4, we cannot autoprobe here, since
 		 * the channel subsystem is not fully initialized.
 		 * With some luck, the HWC console can take over */
-		printk(KERN_WARNING "No ccw console found!\n");
+		printk(KERN_WARNING "cio: No ccw console found!\n");
 		return -1;
 	}
 	return console_irq;
diff --git a/drivers/s390/cio/cio_debug.h b/drivers/s390/cio/cio_debug.h
index f88844a..c9bf898 100644
--- a/drivers/s390/cio/cio_debug.h
+++ b/drivers/s390/cio/cio_debug.h
@@ -23,6 +23,8 @@ extern debug_info_t *cio_debug_crw_id;
 static inline void
 CIO_HEX_EVENT(int level, void *data, int length)
 {
+	if (unlikely(!cio_debug_trace_id))
+		return;
 	while (length > 0) {
 		debug_event(cio_debug_trace_id, level, data, length);
 		length -= cio_debug_trace_id->buf_size;
diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
index 28abd69..02fd00b 100644
--- a/drivers/s390/cio/cmf.c
+++ b/drivers/s390/cio/cmf.c
@@ -1185,12 +1185,12 @@ static ssize_t cmb_enable_store(struct device *dev, struct device_attribute *att
 	case '0':
 		ret = disable_cmf(cdev);
 		if (ret)
-			printk(KERN_INFO "disable_cmf failed (%d)\n", ret);
+			dev_info(&cdev->dev, "disable_cmf failed (%d)\n", ret);
 		break;
 	case '1':
 		ret = enable_cmf(cdev);
 		if (ret && ret != -EBUSY)
-			printk(KERN_INFO "enable_cmf failed (%d)\n", ret);
+			dev_info(&cdev->dev, "enable_cmf failed (%d)\n", ret);
 		break;
 	}
 
@@ -1280,10 +1280,10 @@ init_cmf(void)
 		format_string = "basic";
 		cmbops = &cmbops_basic;
 		if (cmb_area.num_channels > 4096 || cmb_area.num_channels < 1) {
-			printk(KERN_ERR "Basic channel measurement facility"
-					" can only use 1 to 4096 devices\n"
+			printk(KERN_ERR "cio: Basic channel measurement "
+			       "facility can only use 1 to 4096 devices\n"
 			       KERN_ERR "when the cmf driver is built"
-					" as a loadable module\n");
+			       " as a loadable module\n");
 			return 1;
 		}
 		break;
@@ -1292,13 +1292,13 @@ init_cmf(void)
 		cmbops = &cmbops_extended;
 		break;
 	default:
-		printk(KERN_ERR "Invalid format %d for channel "
+		printk(KERN_ERR "cio: Invalid format %d for channel "
 			"measurement facility\n", format);
 		return 1;
 	}
 
-	printk(KERN_INFO "Channel measurement facility using %s format (%s)\n",
-		format_string, detect_string);
+	printk(KERN_INFO "cio: Channel measurement facility using %s "
+	       "format (%s)\n", format_string, detect_string);
 	return 0;
 }
 
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index dfca0ef..1c27a5a 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -109,7 +109,7 @@ css_subchannel_release(struct device *dev)
 	}
 }
 
-int css_sch_device_register(struct subchannel *sch)
+static int css_sch_device_register(struct subchannel *sch)
 {
 	int ret;
 
@@ -184,8 +184,8 @@ static int css_register_subchannel(struct subchannel *sch)
 	/* make it known to the system */
 	ret = css_sch_device_register(sch);
 	if (ret) {
-		printk (KERN_WARNING "%s: could not register %s\n",
-			__func__, sch->dev.bus_id);
+		CIO_MSG_EVENT(0, "Could not register sch 0.%x.%04x: %d\n",
+			      sch->schid.ssid, sch->schid.sch_no, ret);
 		return ret;
 	}
 	return ret;
@@ -371,15 +371,12 @@ static int __init slow_subchannel_init(void)
 	spin_lock_init(&slow_subchannel_lock);
 	slow_subchannel_set = idset_sch_new();
 	if (!slow_subchannel_set) {
-		printk(KERN_WARNING "cio: could not allocate slow subchannel "
-		       "set\n");
+		CIO_MSG_EVENT(0, "could not allocate slow subchannel set\n");
 		return -ENOMEM;
 	}
 	return 0;
 }
 
-subsys_initcall(slow_subchannel_init);
-
 static void css_slow_path_func(struct work_struct *unused)
 {
 	struct subchannel_id schid;
@@ -425,8 +422,8 @@ static int reprobe_subchannel(struct subchannel_id schid, void *data)
 	struct subchannel *sch;
 	int ret;
 
-	CIO_DEBUG(KERN_INFO, 6, "cio: reprobe 0.%x.%04x\n",
-		  schid.ssid, schid.sch_no);
+	CIO_MSG_EVENT(6, "cio: reprobe 0.%x.%04x\n",
+		      schid.ssid, schid.sch_no);
 	if (need_reprobe)
 		return -EAGAIN;
 
@@ -642,9 +639,20 @@ init_channel_subsystem (void)
 {
 	int ret, i;
 
-	if (chsc_determine_css_characteristics() == 0)
+	ret = chsc_determine_css_characteristics();
+	if (ret == -ENOMEM)
+		goto out; /* No need to continue. */
+	if (ret == 0)
 		css_characteristics_avail = 1;
 
+	ret = chsc_alloc_sei_area();
+	if (ret)
+		goto out;
+
+	ret = slow_subchannel_init();
+	if (ret)
+		goto out;
+
 	if ((ret = bus_register(&css_bus_type)))
 		goto out;
 
@@ -710,6 +718,10 @@ out_unregister:
 out_bus:
 	bus_unregister(&css_bus_type);
 out:
+	chsc_free_sei_area();
+	kfree(slow_subchannel_set);
+	printk(KERN_WARNING"cio: failed to initialize css driver (%d)!\n",
+	       ret);
 	return ret;
 }
 
diff --git a/drivers/s390/cio/css.h b/drivers/s390/cio/css.h
index ed79775..5d65e83 100644
--- a/drivers/s390/cio/css.h
+++ b/drivers/s390/cio/css.h
@@ -139,7 +139,6 @@ struct css_driver {
  */
 extern struct bus_type css_bus_type;
 
-extern int css_sch_device_register(struct subchannel *);
 extern void css_sch_device_unregister(struct subchannel *);
 extern struct subchannel * get_subchannel_by_schid(struct subchannel_id);
 extern int css_init_done;
diff --git a/drivers/s390/cio/device.c b/drivers/s390/cio/device.c
index 001682e..297659f 100644
--- a/drivers/s390/cio/device.c
+++ b/drivers/s390/cio/device.c
@@ -338,15 +338,20 @@ ccw_device_remove_disconnected(struct ccw_device *cdev)
 		rc = device_schedule_callback(&cdev->dev,
 					      ccw_device_remove_orphan_cb);
 		if (rc)
-			dev_info(&cdev->dev, "Couldn't unregister orphan\n");
+			CIO_MSG_EVENT(2, "Couldn't unregister orphan "
+				      "0.%x.%04x\n",
+				      cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno);
 		return;
 	}
 	/* Deregister subchannel, which will kill the ccw device. */
 	rc = device_schedule_callback(cdev->dev.parent,
 				      ccw_device_remove_sch_cb);
 	if (rc)
-		dev_info(&cdev->dev,
-			 "Couldn't unregister disconnected device\n");
+		CIO_MSG_EVENT(2, "Couldn't unregister disconnected device "
+			      "0.%x.%04x\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 }
 
 int
@@ -379,8 +384,10 @@ ccw_device_set_offline(struct ccw_device *cdev)
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
 	else {
-		pr_debug("ccw_device_offline returned %d, device %s\n",
-			 ret, cdev->dev.bus_id);
+		CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+			      "device 0.%x.%04x\n",
+			      ret, cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 		cdev->online = 1;
 	}
  	return ret;
@@ -402,8 +409,10 @@ ccw_device_set_online(struct ccw_device *cdev)
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
 	else {
-		pr_debug("ccw_device_online returned %d, device %s\n",
-			 ret, cdev->dev.bus_id);
+		CIO_MSG_EVENT(2, "ccw_device_online returned %d, "
+			      "device 0.%x.%04x\n",
+			      ret, cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 		return ret;
 	}
 	if (cdev->private->state != DEV_STATE_ONLINE)
@@ -417,9 +426,11 @@ ccw_device_set_online(struct ccw_device *cdev)
 	spin_unlock_irq(cdev->ccwlock);
 	if (ret == 0)
 		wait_event(cdev->private->wait_q, dev_fsm_final_state(cdev));
-	else 
-		pr_debug("ccw_device_offline returned %d, device %s\n",
-			 ret, cdev->dev.bus_id);
+	else
+		CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+			      "device 0.%x.%04x\n",
+			      ret, cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno);
 	return (ret == 0) ? -ENODEV : ret;
 }
 
@@ -439,9 +450,10 @@ static int online_store_recog_and_online(struct ccw_device *cdev)
 	if (cdev->id.cu_type == 0) {
 		ret = ccw_device_recognition(cdev);
 		if (ret) {
-			printk(KERN_WARNING"Couldn't start recognition "
-			       "for device %s (ret=%d)\n",
-			       cdev->dev.bus_id, ret);
+			CIO_MSG_EVENT(0, "Couldn't start recognition "
+				      "for device 0.%x.%04x (ret=%d)\n",
+				      cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno, ret);
 			return ret;
 		}
 		wait_event(cdev->private->wait_q,
@@ -461,8 +473,8 @@ static void online_store_handle_online(struct ccw_device *cdev, int force)
 	if (force && cdev->private->state == DEV_STATE_BOXED) {
 		ret = ccw_device_stlck(cdev);
 		if (ret) {
-			printk(KERN_WARNING"ccw_device_stlck for device %s "
-			       "returned %d!\n", cdev->dev.bus_id, ret);
+			dev_warn(&cdev->dev,
+				 "ccw_device_stlck returned %d!\n", ret);
 			return;
 		}
 		if (cdev->id.cu_type == 0)
@@ -893,8 +905,10 @@ io_subchannel_register(struct work_struct *work)
 			ret = device_reprobe(&cdev->dev);
 			if (ret)
 				/* We can't do much here. */
-				dev_info(&cdev->dev, "device_reprobe() returned"
-					 " %d\n", ret);
+				CIO_MSG_EVENT(2, "device_reprobe() returned"
+					      " %d for 0.%x.%04x\n", ret,
+					      cdev->private->dev_id.ssid,
+					      cdev->private->dev_id.devno);
 		}
 		goto out;
 	}
@@ -907,8 +921,9 @@ io_subchannel_register(struct work_struct *work)
 	/* make it known to the system */
 	ret = ccw_device_register(cdev);
 	if (ret) {
-		printk (KERN_WARNING "%s: could not register %s\n",
-			__func__, cdev->dev.bus_id);
+		CIO_MSG_EVENT(0, "Could not register ccw dev 0.%x.%04x: %d\n",
+			      cdev->private->dev_id.ssid,
+			      cdev->private->dev_id.devno, ret);
 		put_device(&cdev->dev);
 		spin_lock_irqsave(sch->lock, flags);
 		sch->dev.driver_data = NULL;
@@ -1361,7 +1376,6 @@ ccw_device_remove (struct device *dev)
 	struct ccw_driver *cdrv = cdev->drv;
 	int ret;
 
-	pr_debug("removing device %s\n", cdev->dev.bus_id);
 	if (cdrv->remove)
 		cdrv->remove(cdev);
 	if (cdev->online) {
@@ -1374,8 +1388,10 @@ ccw_device_remove (struct device *dev)
 				   dev_fsm_final_state(cdev));
 		else
 			//FIXME: we can't fail!
-			pr_debug("ccw_device_offline returned %d, device %s\n",
-				 ret, cdev->dev.bus_id);
+			CIO_MSG_EVENT(2, "ccw_device_offline returned %d, "
+				      "device 0.%x.%04x\n",
+				      ret, cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno);
 	}
 	ccw_device_set_timeout(cdev, 0);
 	cdev->drv = NULL;
diff --git a/drivers/s390/cio/device_fsm.c b/drivers/s390/cio/device_fsm.c
index 6bba809..8633dc5 100644
--- a/drivers/s390/cio/device_fsm.c
+++ b/drivers/s390/cio/device_fsm.c
@@ -268,7 +268,7 @@ ccw_device_recog_done(struct ccw_device *cdev, int state)
 	switch (state) {
 	case DEV_STATE_NOT_OPER:
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "SenseID : unknown device %04x on subchannel "
+			  "cio: SenseID : unknown device %04x on subchannel "
 			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
@@ -293,7 +293,8 @@ ccw_device_recog_done(struct ccw_device *cdev, int state)
 			return;
 		}
 		/* Issue device info message. */
-		CIO_DEBUG(KERN_INFO, 2, "SenseID : device 0.%x.%04x reports: "
+		CIO_DEBUG(KERN_INFO, 2,
+			  "cio: SenseID : device 0.%x.%04x reports: "
 			  "CU  Type/Mod = %04X/%02X, Dev Type/Mod = "
 			  "%04X/%02X\n",
 			  cdev->private->dev_id.ssid,
@@ -303,7 +304,7 @@ ccw_device_recog_done(struct ccw_device *cdev, int state)
 		break;
 	case DEV_STATE_BOXED:
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "SenseID : boxed device %04x on subchannel "
+			  "cio: SenseID : boxed device %04x on subchannel "
 			  "0.%x.%04x\n", cdev->private->dev_id.devno,
 			  sch->schid.ssid, sch->schid.sch_no);
 		break;
@@ -388,7 +389,7 @@ ccw_device_done(struct ccw_device *cdev, int state)
 
 	if (state == DEV_STATE_BOXED)
 		CIO_DEBUG(KERN_WARNING, 2,
-			  "Boxed device %04x on subchannel %04x\n",
+			  "cio: Boxed device %04x on subchannel %04x\n",
 			  cdev->private->dev_id.devno, sch->schid.sch_no);
 
 	if (cdev->private->flags.donotify) {
@@ -946,9 +947,10 @@ ccw_device_w4sense(struct ccw_device *cdev, enum dev_event dev_event)
 			/* Basic sense hasn't started. Try again. */
 			ccw_device_do_sense(cdev, irb);
 		else {
-			printk(KERN_INFO "Huh? %s(%s): unsolicited "
-			       "interrupt...\n",
-			       __FUNCTION__, cdev->dev.bus_id);
+			CIO_MSG_EVENT(2, "Huh? 0.%x.%04x: unsolicited "
+				      "interrupt during w4sense...\n",
+				      cdev->private->dev_id.ssid,
+				      cdev->private->dev_id.devno);
 			if (cdev->handler)
 				cdev->handler (cdev, 0, irb);
 		}
@@ -1215,8 +1217,8 @@ ccw_device_nop(struct ccw_device *cdev, enum dev_event dev_event)
 static void
 ccw_device_bug(struct ccw_device *cdev, enum dev_event dev_event)
 {
-	printk(KERN_EMERG "dev_jumptable[%i][%i] == NULL\n",
-	       cdev->private->state, dev_event);
+	CIO_MSG_EVENT(0, "dev_jumptable[%i][%i] == NULL\n",
+		      cdev->private->state, dev_event);
 	BUG();
 }
 
diff --git a/drivers/s390/cio/device_ops.c b/drivers/s390/cio/device_ops.c
index a5d263f..14eba85 100644
--- a/drivers/s390/cio/device_ops.c
+++ b/drivers/s390/cio/device_ops.c
@@ -288,253 +288,6 @@ ccw_device_get_path_mask(struct ccw_device *cdev)
 		return sch->lpm;
 }
 
-static void
-ccw_device_wake_up(struct ccw_device *cdev, unsigned long ip, struct irb *irb)
-{
-	if (!ip)
-		/* unsolicited interrupt */
-		return;
-
-	/* Abuse intparm for error reporting. */
-	if (IS_ERR(irb))
-		cdev->private->intparm = -EIO;
-	else if (irb->scsw.cc == 1)
-		/* Retry for deferred condition code. */
-		cdev->private->intparm = -EAGAIN;
-	else if ((irb->scsw.dstat !=
-		  (DEV_STAT_CHN_END|DEV_STAT_DEV_END)) ||
-		 (irb->scsw.cstat != 0)) {
-		/*
-		 * We didn't get channel end / device end. Check if path
-		 * verification has been started; we can retry after it has
-		 * finished. We also retry unit checks except for command reject
-		 * or intervention required. Also check for long busy
-		 * conditions.
-		 */
-		 if (cdev->private->flags.doverify ||
-			 cdev->private->state == DEV_STATE_VERIFY)
-			 cdev->private->intparm = -EAGAIN;
-		else if ((irb->scsw.dstat & DEV_STAT_UNIT_CHECK) &&
-			 !(irb->ecw[0] &
-			   (SNS0_CMD_REJECT | SNS0_INTERVENTION_REQ)))
-			cdev->private->intparm = -EAGAIN;
-		else if ((irb->scsw.dstat & DEV_STAT_ATTENTION) &&
-			 (irb->scsw.dstat & DEV_STAT_DEV_END) &&
-			 (irb->scsw.dstat & DEV_STAT_UNIT_EXCEP))
-			cdev->private->intparm = -EAGAIN;
-		 else
-			 cdev->private->intparm = -EIO;
-			 
-	} else
-		cdev->private->intparm = 0;
-	wake_up(&cdev->private->wait_q);
-}
-
-static int
-__ccw_device_retry_loop(struct ccw_device *cdev, struct ccw1 *ccw, long magic, __u8 lpm)
-{
-	int ret;
-	struct subchannel *sch;
-
-	sch = to_subchannel(cdev->dev.parent);
-	do {
-		ccw_device_set_timeout(cdev, 60 * HZ);
-		ret = cio_start (sch, ccw, lpm);
-		if (ret != 0)
-			ccw_device_set_timeout(cdev, 0);
-		if (ret == -EBUSY) {
-			/* Try again later. */
-			spin_unlock_irq(sch->lock);
-			msleep(10);
-			spin_lock_irq(sch->lock);
-			continue;
-		}
-		if (ret != 0)
-			/* Non-retryable error. */
-			break;
-		/* Wait for end of request. */
-		cdev->private->intparm = magic;
-		spin_unlock_irq(sch->lock);
-		wait_event(cdev->private->wait_q,
-			   (cdev->private->intparm == -EIO) ||
-			   (cdev->private->intparm == -EAGAIN) ||
-			   (cdev->private->intparm == 0));
-		spin_lock_irq(sch->lock);
-		/* Check at least for channel end / device end */
-		if (cdev->private->intparm == -EIO) {
-			/* Non-retryable error. */
-			ret = -EIO;
-			break;
-		}
-		if (cdev->private->intparm == 0)
-			/* Success. */
-			break;
-		/* Try again later. */
-		spin_unlock_irq(sch->lock);
-		msleep(10);
-		spin_lock_irq(sch->lock);
-	} while (1);
-
-	return ret;
-}
-
-/**
- * read_dev_chars() - read device characteristics
- * @param cdev   target ccw device
- * @param buffer pointer to buffer for rdc data
- * @param length size of rdc data
- * @returns 0 for success, negative error value on failure
- *
- * Context:
- *   called for online device, lock not held
- **/
-int
-read_dev_chars (struct ccw_device *cdev, void **buffer, int length)
-{
-	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
-	struct subchannel *sch;
-	int ret;
-	struct ccw1 *rdc_ccw;
-
-	if (!cdev)
-		return -ENODEV;
-	if (!buffer || !length)
-		return -EINVAL;
-	sch = to_subchannel(cdev->dev.parent);
-
-	CIO_TRACE_EVENT (4, "rddevch");
-	CIO_TRACE_EVENT (4, sch->dev.bus_id);
-
-	rdc_ccw = kzalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
-	if (!rdc_ccw)
-		return -ENOMEM;
-	rdc_ccw->cmd_code = CCW_CMD_RDC;
-	rdc_ccw->count = length;
-	rdc_ccw->flags = CCW_FLAG_SLI;
-	ret = set_normalized_cda (rdc_ccw, (*buffer));
-	if (ret != 0) {
-		kfree(rdc_ccw);
-		return ret;
-	}
-
-	spin_lock_irq(sch->lock);
-	/* Save interrupt handler. */
-	handler = cdev->handler;
-	/* Temporarily install own handler. */
-	cdev->handler = ccw_device_wake_up;
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		ret = -ENODEV;
-	else if (((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
-		  !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) ||
-		 cdev->private->flags.doverify)
-		ret = -EBUSY;
-	else
-		/* 0x00D9C4C3 == ebcdic "RDC" */
-		ret = __ccw_device_retry_loop(cdev, rdc_ccw, 0x00D9C4C3, 0);
-
-	/* Restore interrupt handler. */
-	cdev->handler = handler;
-	spin_unlock_irq(sch->lock);
-
-	clear_normalized_cda (rdc_ccw);
-	kfree(rdc_ccw);
-
-	return ret;
-}
-
-/*
- *  Read Configuration data using path mask
- */
-int
-read_conf_data_lpm (struct ccw_device *cdev, void **buffer, int *length, __u8 lpm)
-{
-	void (*handler)(struct ccw_device *, unsigned long, struct irb *);
-	struct subchannel *sch;
-	struct ciw *ciw;
-	char *rcd_buf;
-	int ret;
-	struct ccw1 *rcd_ccw;
-
-	if (!cdev)
-		return -ENODEV;
-	if (!buffer || !length)
-		return -EINVAL;
-	sch = to_subchannel(cdev->dev.parent);
-
-	CIO_TRACE_EVENT (4, "rdconf");
-	CIO_TRACE_EVENT (4, sch->dev.bus_id);
-
-	/*
-	 * scan for RCD command in extended SenseID data
-	 */
-	ciw = ccw_device_get_ciw(cdev, CIW_TYPE_RCD);
-	if (!ciw || ciw->cmd == 0)
-		return -EOPNOTSUPP;
-
-	/* Adjust requested path mask to excluded varied off paths. */
-	if (lpm) {
-		lpm &= sch->opm;
-		if (lpm == 0)
-			return -EACCES;
-	}
-
-	rcd_ccw = kzalloc(sizeof(struct ccw1), GFP_KERNEL | GFP_DMA);
-	if (!rcd_ccw)
-		return -ENOMEM;
-	rcd_buf = kzalloc(ciw->count, GFP_KERNEL | GFP_DMA);
- 	if (!rcd_buf) {
-		kfree(rcd_ccw);
-		return -ENOMEM;
-	}
-	rcd_ccw->cmd_code = ciw->cmd;
-	rcd_ccw->cda = (__u32) __pa (rcd_buf);
-	rcd_ccw->count = ciw->count;
-	rcd_ccw->flags = CCW_FLAG_SLI;
-
-	spin_lock_irq(sch->lock);
-	/* Save interrupt handler. */
-	handler = cdev->handler;
-	/* Temporarily install own handler. */
-	cdev->handler = ccw_device_wake_up;
-	if (cdev->private->state != DEV_STATE_ONLINE)
-		ret = -ENODEV;
-	else if (((sch->schib.scsw.stctl & SCSW_STCTL_PRIM_STATUS) &&
-		  !(sch->schib.scsw.stctl & SCSW_STCTL_SEC_STATUS)) ||
-		 cdev->private->flags.doverify)
-		ret = -EBUSY;
-	else
-		/* 0x00D9C3C4 == ebcdic "RCD" */
-		ret = __ccw_device_retry_loop(cdev, rcd_ccw, 0x00D9C3C4, lpm);
-
-	/* Restore interrupt handler. */
-	cdev->handler = handler;
-	spin_unlock_irq(sch->lock);
-
- 	/*
- 	 * on success we update the user input parms
- 	 */
- 	if (ret) {
- 		kfree (rcd_buf);
- 		*buffer = NULL;
- 		*length = 0;
- 	} else {
-		*length = ciw->count;
-		*buffer = rcd_buf;
-	}
-	kfree(rcd_ccw);
-
-	return ret;
-}
-
-/*
- *  Read Configuration data
- */
-int
-read_conf_data (struct ccw_device *cdev, void **buffer, int *length)
-{
-	return read_conf_data_lpm (cdev, buffer, length, 0);
-}
-
 /*
  * Try to break the lock on a boxed device.
  */
@@ -635,12 +388,6 @@ _ccw_device_get_subchannel_number(struct ccw_device *cdev)
 	return cdev->private->schid.sch_no;
 }
 
-int
-_ccw_device_get_device_number(struct ccw_device *cdev)
-{
-	return cdev->private->dev_id.devno;
-}
-
 
 MODULE_LICENSE("GPL");
 EXPORT_SYMBOL(ccw_device_set_options_mask);
@@ -655,9 +402,5 @@ EXPORT_SYMBOL(ccw_device_start_timeout_key);
 EXPORT_SYMBOL(ccw_device_start_key);
 EXPORT_SYMBOL(ccw_device_get_ciw);
 EXPORT_SYMBOL(ccw_device_get_path_mask);
-EXPORT_SYMBOL(read_conf_data);
-EXPORT_SYMBOL(read_dev_chars);
 EXPORT_SYMBOL(_ccw_device_get_subchannel_number);
-EXPORT_SYMBOL(_ccw_device_get_device_number);
 EXPORT_SYMBOL_GPL(ccw_device_get_chp_desc);
-EXPORT_SYMBOL_GPL(read_conf_data_lpm);
diff --git a/include/asm-s390/ccwdev.h b/include/asm-s390/ccwdev.h
index 4c2e171..1aeda27 100644
--- a/include/asm-s390/ccwdev.h
+++ b/include/asm-s390/ccwdev.h
@@ -165,11 +165,6 @@ extern int ccw_device_resume(struct ccw_device *);
 extern int ccw_device_halt(struct ccw_device *, unsigned long);
 extern int ccw_device_clear(struct ccw_device *, unsigned long);
 
-extern int __deprecated read_dev_chars(struct ccw_device *cdev, void **buffer, int length);
-extern int __deprecated read_conf_data(struct ccw_device *cdev, void **buffer, int *length);
-extern int __deprecated read_conf_data_lpm(struct ccw_device *cdev, void **buffer,
-			      int *length, __u8 lpm);
-
 extern int ccw_device_set_online(struct ccw_device *cdev);
 extern int ccw_device_set_offline(struct ccw_device *cdev);
 
diff --git a/include/asm-s390/s390_ext.h b/include/asm-s390/s390_ext.h
index df9b101..1e72362 100644
--- a/include/asm-s390/s390_ext.h
+++ b/include/asm-s390/s390_ext.h
@@ -10,6 +10,8 @@
  *               Martin Schwidefsky (schwidefsky@de.ibm.com)
  */
 
+#include <linux/types.h>
+
 typedef void (*ext_int_handler_t)(__u16 code);
 
 /*
diff --git a/include/asm-s390/smp.h b/include/asm-s390/smp.h
index 76e424f..07708c0 100644
--- a/include/asm-s390/smp.h
+++ b/include/asm-s390/smp.h
@@ -36,8 +36,7 @@ extern void machine_halt_smp(void);
 extern void machine_power_off_smp(void);
 
 extern void smp_setup_cpu_possible_map(void);
-extern int smp_call_function_on(void (*func) (void *info), void *info,
-				int nonatomic, int wait, int cpu);
+
 #define NO_PROC_ID		0xFF		/* No processor magic marker */
 
 /*
@@ -96,14 +95,6 @@ extern int __cpu_up (unsigned int cpu);
 #endif
 
 #ifndef CONFIG_SMP
-static inline int
-smp_call_function_on(void (*func) (void *info), void *info,
-		     int nonatomic, int wait, int cpu)
-{
-	func(info);
-	return 0;
-}
-
 static inline void smp_send_stop(void)
 {
 	/* Disable all interrupts/machine checks */
diff --git a/include/asm-s390/unistd.h b/include/asm-s390/unistd.h
index 790c1c5..f04acb2 100644
--- a/include/asm-s390/unistd.h
+++ b/include/asm-s390/unistd.h
@@ -251,7 +251,7 @@
 #define __NR_getcpu		311
 #define __NR_epoll_pwait	312
 #define __NR_utimes		313
-/* Number 314 is reserved for new sys_fallocate */
+#define __NR_fallocate		314
 #define __NR_utimensat		315
 #define __NR_signalfd		316
 #define __NR_timerfd		317
diff --git a/net/iucv/iucv.c b/net/iucv/iucv.c
index ad5150b..983058d 100644
--- a/net/iucv/iucv.c
+++ b/net/iucv/iucv.c
@@ -479,7 +479,8 @@ static void iucv_setmask_mp(void)
 		/* Enable all cpus with a declared buffer. */
 		if (cpu_isset(cpu, iucv_buffer_cpumask) &&
 		    !cpu_isset(cpu, iucv_irq_cpumask))
-			smp_call_function_on(iucv_allow_cpu, NULL, 0, 1, cpu);
+			smp_call_function_single(cpu, iucv_allow_cpu,
+						 NULL, 0, 1);
 	preempt_enable();
 }
 
@@ -497,7 +498,7 @@ static void iucv_setmask_up(void)
 	cpumask = iucv_irq_cpumask;
 	cpu_clear(first_cpu(iucv_irq_cpumask), cpumask);
 	for_each_cpu_mask(cpu, cpumask)
-		smp_call_function_on(iucv_block_cpu, NULL, 0, 1, cpu);
+		smp_call_function_single(cpu, iucv_block_cpu, NULL, 0, 1);
 }
 
 /**
@@ -522,7 +523,7 @@ static int iucv_enable(void)
 	rc = -EIO;
 	preempt_disable();
 	for_each_online_cpu(cpu)
-		smp_call_function_on(iucv_declare_cpu, NULL, 0, 1, cpu);
+		smp_call_function_single(cpu, iucv_declare_cpu, NULL, 0, 1);
 	preempt_enable();
 	if (cpus_empty(iucv_buffer_cpumask))
 		/* No cpu could declare an iucv buffer. */
@@ -578,7 +579,7 @@ static int __cpuinit iucv_cpu_notify(struct notifier_block *self,
 	case CPU_ONLINE_FROZEN:
 	case CPU_DOWN_FAILED:
 	case CPU_DOWN_FAILED_FROZEN:
-		smp_call_function_on(iucv_declare_cpu, NULL, 0, 1, cpu);
+		smp_call_function_single(cpu, iucv_declare_cpu, NULL, 0, 1);
 		break;
 	case CPU_DOWN_PREPARE:
 	case CPU_DOWN_PREPARE_FROZEN:
@@ -587,10 +588,10 @@ static int __cpuinit iucv_cpu_notify(struct notifier_block *self,
 		if (cpus_empty(cpumask))
 			/* Can't offline last IUCV enabled cpu. */
 			return NOTIFY_BAD;
-		smp_call_function_on(iucv_retrieve_cpu, NULL, 0, 1, cpu);
+		smp_call_function_single(cpu, iucv_retrieve_cpu, NULL, 0, 1);
 		if (cpus_empty(iucv_irq_cpumask))
-			smp_call_function_on(iucv_allow_cpu, NULL, 0, 1,
-					     first_cpu(iucv_buffer_cpumask));
+			smp_call_function_single(first_cpu(iucv_buffer_cpumask),
+						 iucv_allow_cpu, NULL, 0, 1);
 		break;
 	}
 	return NOTIFY_OK;
