Return-Path: <linux-kernel-owner+w=401wt.eu-S1758432AbYFJIXN@vger.kernel.org>
Subject: Please pull git390 'for-linus' branch
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reply-To: schwidefsky@de.ibm.com
Content-Type: text/plain
Date: Tue, 10 Jun 2008 10:21:56 +0200
Message-Id: <1213086116.396.0.camel@localhost>
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

 arch/s390/Kconfig              |    1 +
 arch/s390/kernel/smp.c         |    2 +-
 arch/s390/mm/vmem.c            |    2 +-
 drivers/s390/char/sclp_vt220.c |    1 +
 drivers/s390/char/tape_3590.c  |    2 +-
 drivers/s390/cio/blacklist.c   |    6 +++---
 drivers/s390/cio/cio.c         |   20 +++++++++++---------
 include/asm-s390/system.h      |    8 ++++----
 8 files changed, 23 insertions(+), 19 deletions(-)

Carsten Otte (1):
      [S390] vt220 console, initialize list head before use

Cornelia Huck (2):
      [S390] cio: Fix sparse warnings in blacklist.c.
      [S390] cio: Fix inverted isc priorities.

Heiko Carstens (2):
      [S390] sparsemem: use SPARSEMEM_STATIC if !64BIT.
      [S390] vmemmap: fix off-by-one bug.

Julia Lawall (1):
      [S390] tape_3590.c: introduce missing kfree

Martin Schwidefsky (1):
      [S390] Fix __ctl_load/__ctl_store inline assembly constraints

Segher Boessenkool (1):
      [S390] Fix build failure in __cpu_up()

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 93acb3c..107e492 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -304,6 +304,7 @@ config ARCH_SPARSEMEM_ENABLE
 	def_bool y
 	select SPARSEMEM_VMEMMAP_ENABLE
 	select SPARSEMEM_VMEMMAP
+	select SPARSEMEM_STATIC if !64BIT
 
 config ARCH_SPARSEMEM_DEFAULT
 	def_bool y
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 42b1d12..5d4fa4b 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -711,7 +711,7 @@ int __cpuinit __cpu_up(unsigned int cpu)
 	memset(sf, 0, sizeof(struct stack_frame));
 	sf->gprs[9] = (unsigned long) sf;
 	cpu_lowcore->save_area[15] = (unsigned long) sf;
-	__ctl_store(cpu_lowcore->cregs_save_area[0], 0, 15);
+	__ctl_store(cpu_lowcore->cregs_save_area, 0, 15);
 	asm volatile(
 		"	stam	0,15,0(%0)"
 		: : "a" (&cpu_lowcore->access_regs_save_area) : "memory");
diff --git a/arch/s390/mm/vmem.c b/arch/s390/mm/vmem.c
index f591188..e4868bf 100644
--- a/arch/s390/mm/vmem.c
+++ b/arch/s390/mm/vmem.c
@@ -236,7 +236,7 @@ static int insert_memory_segment(struct memory_segment *seg)
 {
 	struct memory_segment *tmp;
 
-	if (seg->start + seg->size >= VMEM_MAX_PHYS ||
+	if (seg->start + seg->size > VMEM_MAX_PHYS ||
 	    seg->start + seg->size < seg->start)
 		return -ERANGE;
 
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 62576af..3e577f6 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -773,6 +773,7 @@ sclp_vt220_con_init(void)
 {
 	int rc;
 
+	INIT_LIST_HEAD(&sclp_vt220_register.list);
 	if (!CONSOLE_IS_SCLP)
 		return 0;
 	rc = __sclp_vt220_init();
diff --git a/drivers/s390/char/tape_3590.c b/drivers/s390/char/tape_3590.c
index 8246ef3..42ce791 100644
--- a/drivers/s390/char/tape_3590.c
+++ b/drivers/s390/char/tape_3590.c
@@ -1598,7 +1598,7 @@ tape_3590_setup_device(struct tape_device *device)
 	rc = tape_3590_read_dev_chars(device, rdc_data);
 	if (rc) {
 		DBF_LH(3, "Read device characteristics failed!\n");
-		goto fail_kmalloc;
+		goto fail_rdc_data;
 	}
 	rc = tape_std_assign(device);
 	if (rc)
diff --git a/drivers/s390/cio/blacklist.c b/drivers/s390/cio/blacklist.c
index a4a5f2e..0bfcbbe 100644
--- a/drivers/s390/cio/blacklist.c
+++ b/drivers/s390/cio/blacklist.c
@@ -97,8 +97,8 @@ static int pure_hex(char **cp, unsigned int *val, int min_digit,
 	return 0;
 }
 
-static int parse_busid(char *str, int *cssid, int *ssid, int *devno,
-		       int msgtrigger)
+static int parse_busid(char *str, unsigned int *cssid, unsigned int *ssid,
+		       unsigned int *devno, int msgtrigger)
 {
 	char *str_work;
 	int val, rc, ret;
@@ -148,7 +148,7 @@ out:
 static int blacklist_parse_parameters(char *str, range_action action,
 				      int msgtrigger)
 {
-	int from_cssid, to_cssid, from_ssid, to_ssid, from, to;
+	unsigned int from_cssid, to_cssid, from_ssid, to_ssid, from, to;
 	int rc, totalrc;
 	char *parm;
 	range_action ra;
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index 82c6a2d..b32d7eb 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -576,12 +576,14 @@ cio_validate_subchannel (struct subchannel *sch, struct subchannel_id schid)
 		err = -ENODEV;
 		goto out;
 	}
-	if (cio_is_console(sch->schid))
+	if (cio_is_console(sch->schid)) {
 		sch->opm = 0xff;
-	else
+		sch->isc = 1;
+	} else {
 		sch->opm = chp_get_sch_opm(sch);
+		sch->isc = 3;
+	}
 	sch->lpm = sch->schib.pmcw.pam & sch->opm;
-	sch->isc = 3;
 
 	CIO_MSG_EVENT(6, "Detected device %04x on subchannel 0.%x.%04X "
 		      "- PIM = %02X, PAM = %02X, POM = %02X\n",
@@ -704,9 +706,9 @@ void wait_cons_dev(void)
 	if (!console_subchannel_in_use)
 		return;
 
-	/* disable all but isc 7 (console device) */
+	/* disable all but isc 1 (console device) */
 	__ctl_store (save_cr6, 6, 6);
-	cr6 = 0x01000000;
+	cr6 = 0x40000000;
 	__ctl_load (cr6, 6, 6);
 
 	do {
@@ -788,11 +790,11 @@ cio_probe_console(void)
 	}
 
 	/*
-	 * enable console I/O-interrupt subclass 7
+	 * enable console I/O-interrupt subclass 1
 	 */
-	ctl_set_bit(6, 24);
-	console_subchannel.isc = 7;
-	console_subchannel.schib.pmcw.isc = 7;
+	ctl_set_bit(6, 30);
+	console_subchannel.isc = 1;
+	console_subchannel.schib.pmcw.isc = 1;
 	console_subchannel.schib.pmcw.intparm =
 		(u32)(addr_t)&console_subchannel;
 	ret = cio_modify(&console_subchannel);
diff --git a/include/asm-s390/system.h b/include/asm-s390/system.h
index e0d4500..819e7d9 100644
--- a/include/asm-s390/system.h
+++ b/include/asm-s390/system.h
@@ -315,14 +315,14 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 	asm volatile(						\
 		"	lctlg	%1,%2,0(%0)\n"			\
 		: : "a" (&array), "i" (low), "i" (high),	\
-		    "m" (*(addrtype *)(array)));		\
+		    "m" (*(addrtype *)(&array)));		\
 	})
 
 #define __ctl_store(array, low, high) ({			\
 	typedef struct { char _[sizeof(array)]; } addrtype;	\
 	asm volatile(						\
 		"	stctg	%2,%3,0(%1)\n"			\
-		: "=m" (*(addrtype *)(array))			\
+		: "=m" (*(addrtype *)(&array))			\
 		: "a" (&array), "i" (low), "i" (high));		\
 	})
 
@@ -333,14 +333,14 @@ __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 	asm volatile(						\
 		"	lctl	%1,%2,0(%0)\n"			\
 		: : "a" (&array), "i" (low), "i" (high),	\
-		    "m" (*(addrtype *)(array)));		\
+		    "m" (*(addrtype *)(&array)));		\
 })
 
 #define __ctl_store(array, low, high) ({			\
 	typedef struct { char _[sizeof(array)]; } addrtype;	\
 	asm volatile(						\
 		"	stctl	%2,%3,0(%1)\n"			\
-		: "=m" (*(addrtype *)(array))			\
+		: "=m" (*(addrtype *)(&array))			\
 		: "a" (&array), "i" (low), "i" (high));		\
 	})
 
