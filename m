Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 18 Nov 2015 16:42:25 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for 4.4-rc2
Message-ID: <20151118164225.0c0f4011@mschwide>
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

Assorted bug fixes, the mlock2 system call gets added, and one improvement.
The boot from dasd devices is not possible from a wider range of devices.

Heiko Carstens (4):
      s390/syscalls: remove system call number calculation
      s390: remove g5 elf platform support
      s390: wire up mlock2 system call
      s390: remove SALIPL loader

Martin Schwidefsky (2):
      s390/diag: add a s390 prefix to the diagnose trace point
      s390: avoid cache aliasing under z/VM and KVM

Sascha Silbe (4):
      s390/head: fix error message on unsupported hardware
      s390/zcrypt: Fix kernel crash on systems without AP bus support
      s390/zcrypt: Fix initialisation when zcrypt is built-in
      s390/sclp: _sclp_wait_int(): retain full PSW mask

Sebastian Ott (6):
      s390/cio: simplify css_generate_pgid
      s390/pci_dma: unify label of invalid translation table entries
      s390/pci_dma: handle dma table failures
      s390/pci_dma: improve debugging of errors during dma map
      s390/ipl: fix out of bounds access in scpdata_write
      s390: add support for ipl devices in subchannel sets > 0

 arch/s390/include/asm/cio.h            |  1 +
 arch/s390/include/asm/elf.h            | 13 +++--
 arch/s390/include/asm/ipl.h            |  3 +-
 arch/s390/include/asm/pci_dma.h        |  4 +-
 arch/s390/include/asm/trace/diag.h     |  6 +--
 arch/s390/include/uapi/asm/unistd.h    | 19 +++----
 arch/s390/kernel/compat_wrapper.c      |  1 +
 arch/s390/kernel/diag.c                |  4 +-
 arch/s390/kernel/head.S                | 95 +++++-----------------------------
 arch/s390/kernel/ipl.c                 | 65 +++++++++++++++--------
 arch/s390/kernel/process.c             |  6 +--
 arch/s390/kernel/sclp.c                |  2 +-
 arch/s390/kernel/setup.c               |  3 --
 arch/s390/kernel/syscalls.S            |  1 +
 arch/s390/kernel/trace.c               |  6 +--
 arch/s390/mm/init.c                    | 30 ++---------
 arch/s390/mm/mmap.c                    | 60 ++++-----------------
 arch/s390/pci/pci_dma.c                | 84 ++++++++++++++++++++----------
 drivers/iommu/s390-iommu.c             | 23 +++++++-
 drivers/s390/cio/chsc.c                | 37 ++++++-------
 drivers/s390/cio/chsc.h                | 15 ++++++
 drivers/s390/cio/cio.c                 | 14 +++++
 drivers/s390/cio/css.c                 |  5 --
 drivers/s390/crypto/Makefile           |  7 ++-
 drivers/s390/crypto/ap_bus.c           |  6 +++
 drivers/s390/crypto/zcrypt_api.c       | 10 ++--
 drivers/s390/crypto/zcrypt_api.h       |  1 +
 drivers/s390/crypto/zcrypt_msgtype50.c |  1 +
 drivers/s390/crypto/zcrypt_msgtype6.c  |  3 ++
 29 files changed, 247 insertions(+), 278 deletions(-)

diff --git a/arch/s390/include/asm/cio.h b/arch/s390/include/asm/cio.h
index 0c5d8ee..d1e7b0a 100644
--- a/arch/s390/include/asm/cio.h
+++ b/arch/s390/include/asm/cio.h
@@ -312,6 +312,7 @@ extern void css_schedule_reprobe(void);
 extern void reipl_ccw_dev(struct ccw_dev_id *id);
 
 struct cio_iplinfo {
+	u8 ssid;
 	u16 devno;
 	int is_qdio;
 };
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 3ad48f2..bab6739 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -206,9 +206,16 @@ do {								\
 } while (0)
 #endif /* CONFIG_COMPAT */
 
-extern unsigned long mmap_rnd_mask;
-
-#define STACK_RND_MASK	(test_thread_flag(TIF_31BIT) ? 0x7ff : mmap_rnd_mask)
+/*
+ * Cache aliasing on the latest machines calls for a mapping granularity
+ * of 512KB. For 64-bit processes use a 512KB alignment and a randomization
+ * of up to 1GB. For 31-bit processes the virtual address space is limited,
+ * use no alignment and limit the randomization to 8MB.
+ */
+#define BRK_RND_MASK	(is_32bit_task() ? 0x7ffUL : 0x3ffffUL)
+#define MMAP_RND_MASK	(is_32bit_task() ? 0x7ffUL : 0x3ff80UL)
+#define MMAP_ALIGN_MASK	(is_32bit_task() ? 0 : 0x7fUL)
+#define STACK_RND_MASK	MMAP_RND_MASK
 
 #define ARCH_DLINFO							    \
 do {									    \
diff --git a/arch/s390/include/asm/ipl.h b/arch/s390/include/asm/ipl.h
index 39ae6a3..86634e7 100644
--- a/arch/s390/include/asm/ipl.h
+++ b/arch/s390/include/asm/ipl.h
@@ -64,7 +64,8 @@ struct ipl_block_fcp {
 
 struct ipl_block_ccw {
 	u8  reserved1[84];
-	u8  reserved2[2];
+	u16 reserved2 : 13;
+	u8  ssid : 3;
 	u16 devno;
 	u8  vm_flags;
 	u8  reserved3[3];
diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_dma.h
index 7a7abf1..1aac41e 100644
--- a/arch/s390/include/asm/pci_dma.h
+++ b/arch/s390/include/asm/pci_dma.h
@@ -195,5 +195,7 @@ void zpci_dma_exit_device(struct zpci_dev *);
 void dma_free_seg_table(unsigned long);
 unsigned long *dma_alloc_cpu_table(void);
 void dma_cleanup_tables(unsigned long *);
-void dma_update_cpu_trans(unsigned long *, void *, dma_addr_t, int);
+unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr);
+void dma_update_cpu_trans(unsigned long *entry, void *page_addr, int flags);
+
 #endif
diff --git a/arch/s390/include/asm/trace/diag.h b/arch/s390/include/asm/trace/diag.h
index 776f307..cc6cfe7 100644
--- a/arch/s390/include/asm/trace/diag.h
+++ b/arch/s390/include/asm/trace/diag.h
@@ -19,7 +19,7 @@
 #define TRACE_INCLUDE_PATH asm/trace
 #define TRACE_INCLUDE_FILE diag
 
-TRACE_EVENT(diagnose,
+TRACE_EVENT(s390_diagnose,
 	TP_PROTO(unsigned short nr),
 	TP_ARGS(nr),
 	TP_STRUCT__entry(
@@ -32,9 +32,9 @@ TRACE_EVENT(diagnose,
 );
 
 #ifdef CONFIG_TRACEPOINTS
-void trace_diagnose_norecursion(int diag_nr);
+void trace_s390_diagnose_norecursion(int diag_nr);
 #else
-static inline void trace_diagnose_norecursion(int diag_nr) { }
+static inline void trace_s390_diagnose_norecursion(int diag_nr) { }
 #endif
 
 #endif /* _TRACE_S390_DIAG_H */
diff --git a/arch/s390/include/uapi/asm/unistd.h b/arch/s390/include/uapi/asm/unistd.h
index a848adb..34ec202 100644
--- a/arch/s390/include/uapi/asm/unistd.h
+++ b/arch/s390/include/uapi/asm/unistd.h
@@ -192,14 +192,14 @@
 #define __NR_set_tid_address	252
 #define __NR_fadvise64		253
 #define __NR_timer_create	254
-#define __NR_timer_settime	(__NR_timer_create+1)
-#define __NR_timer_gettime	(__NR_timer_create+2)
-#define __NR_timer_getoverrun	(__NR_timer_create+3)
-#define __NR_timer_delete	(__NR_timer_create+4)
-#define __NR_clock_settime	(__NR_timer_create+5)
-#define __NR_clock_gettime	(__NR_timer_create+6)
-#define __NR_clock_getres	(__NR_timer_create+7)
-#define __NR_clock_nanosleep	(__NR_timer_create+8)
+#define __NR_timer_settime	255
+#define __NR_timer_gettime	256
+#define __NR_timer_getoverrun	257
+#define __NR_timer_delete	258
+#define __NR_clock_settime	259
+#define __NR_clock_gettime	260
+#define __NR_clock_getres	261
+#define __NR_clock_nanosleep	262
 /* Number 263 is reserved for vserver */
 #define __NR_statfs64		265
 #define __NR_fstatfs64		266
@@ -309,7 +309,8 @@
 #define __NR_recvfrom		371
 #define __NR_recvmsg		372
 #define __NR_shutdown		373
-#define NR_syscalls 374
+#define __NR_mlock2		374
+#define NR_syscalls 375
 
 /* 
  * There are some system calls that are not present on 64 bit, some
diff --git a/arch/s390/kernel/compat_wrapper.c b/arch/s390/kernel/compat_wrapper.c
index 09f1940..fac4eed 100644
--- a/arch/s390/kernel/compat_wrapper.c
+++ b/arch/s390/kernel/compat_wrapper.c
@@ -176,3 +176,4 @@ COMPAT_SYSCALL_WRAP4(accept4, int, fd, struct sockaddr __user *, upeer_sockaddr,
 COMPAT_SYSCALL_WRAP3(getsockname, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
 COMPAT_SYSCALL_WRAP3(getpeername, int, fd, struct sockaddr __user *, usockaddr, int __user *, usockaddr_len);
 COMPAT_SYSCALL_WRAP6(sendto, int, fd, void __user *, buff, size_t, len, unsigned int, flags, struct sockaddr __user *, addr, int, addr_len);
+COMPAT_SYSCALL_WRAP3(mlock2, unsigned long, start, size_t, len, int, flags);
diff --git a/arch/s390/kernel/diag.c b/arch/s390/kernel/diag.c
index f98766e..48b37b8 100644
--- a/arch/s390/kernel/diag.c
+++ b/arch/s390/kernel/diag.c
@@ -121,14 +121,14 @@ device_initcall(show_diag_stat_init);
 void diag_stat_inc(enum diag_stat_enum nr)
 {
 	this_cpu_inc(diag_stat.counter[nr]);
-	trace_diagnose(diag_map[nr].code);
+	trace_s390_diagnose(diag_map[nr].code);
 }
 EXPORT_SYMBOL(diag_stat_inc);
 
 void diag_stat_inc_norecursion(enum diag_stat_enum nr)
 {
 	this_cpu_inc(diag_stat.counter[nr]);
-	trace_diagnose_norecursion(diag_map[nr].code);
+	trace_s390_diagnose_norecursion(diag_map[nr].code);
 }
 EXPORT_SYMBOL(diag_stat_inc_norecursion);
 
diff --git a/arch/s390/kernel/head.S b/arch/s390/kernel/head.S
index 1255c6c..301ee9c 100644
--- a/arch/s390/kernel/head.S
+++ b/arch/s390/kernel/head.S
@@ -26,6 +26,7 @@
 #include <asm/asm-offsets.h>
 #include <asm/thread_info.h>
 #include <asm/page.h>
+#include <asm/ptrace.h>
 
 #define ARCH_OFFSET	4
 
@@ -59,19 +60,6 @@ __HEAD
 	.long	0x020006e0,0x20000050
 
 	.org	0x200
-#
-# subroutine to set architecture mode
-#
-.Lsetmode:
-	mvi	__LC_AR_MODE_ID,1	# set esame flag
-	slr	%r0,%r0 		# set cpuid to zero
-	lhi	%r1,2			# mode 2 = esame (dump)
-	sigp	%r1,%r0,0x12		# switch to esame mode
-	bras	%r13,0f
-	.fill	16,4,0x0
-0:	lmh	%r0,%r15,0(%r13)	# clear high-order half of gprs
-	sam31				# switch to 31 bit addressing mode
-	br	%r14
 
 #
 # subroutine to wait for end I/O
@@ -159,7 +147,14 @@ __HEAD
 	.long	0x02200050,0x00000000
 
 iplstart:
-	bas	%r14,.Lsetmode		# Immediately switch to 64 bit mode
+	mvi	__LC_AR_MODE_ID,1	# set esame flag
+	slr	%r0,%r0			# set cpuid to zero
+	lhi	%r1,2			# mode 2 = esame (dump)
+	sigp	%r1,%r0,0x12		# switch to esame mode
+	bras	%r13,0f
+	.fill	16,4,0x0
+0:	lmh	%r0,%r15,0(%r13)	# clear high-order half of gprs
+	sam31				# switch to 31 bit addressing mode
 	lh	%r1,0xb8		# test if subchannel number
 	bct	%r1,.Lnoload		#  is valid
 	l	%r1,0xb8		# load ipl subchannel number
@@ -269,71 +264,6 @@ iplstart:
 .Lcpuid:.fill	8,1,0
 
 #
-# SALIPL loader support. Based on a patch by Rob van der Heij.
-# This entry point is called directly from the SALIPL loader and
-# doesn't need a builtin ipl record.
-#
-	.org	0x800
-ENTRY(start)
-	stm	%r0,%r15,0x07b0		# store registers
-	bas	%r14,.Lsetmode		# Immediately switch to 64 bit mode
-	basr	%r12,%r0
-.base:
-	l	%r11,.parm
-	l	%r8,.cmd		# pointer to command buffer
-
-	ltr	%r9,%r9			# do we have SALIPL parameters?
-	bp	.sk8x8
-
-	mvc	0(64,%r8),0x00b0	# copy saved registers
-	xc	64(240-64,%r8),0(%r8)	# remainder of buffer
-	tr	0(64,%r8),.lowcase
-	b	.gotr
-.sk8x8:
-	mvc	0(240,%r8),0(%r9)	# copy iplparms into buffer
-.gotr:
-	slr	%r0,%r0
-	st	%r0,INITRD_SIZE+ARCH_OFFSET-PARMAREA(%r11)
-	st	%r0,INITRD_START+ARCH_OFFSET-PARMAREA(%r11)
-	j	startup 		# continue with startup
-.cmd:	.long	COMMAND_LINE		# address of command line buffer
-.parm:	.long	PARMAREA
-.lowcase:
-	.byte 0x00,0x01,0x02,0x03,0x04,0x05,0x06,0x07
-	.byte 0x08,0x09,0x0a,0x0b,0x0c,0x0d,0x0e,0x0f
-	.byte 0x10,0x11,0x12,0x13,0x14,0x15,0x16,0x17
-	.byte 0x18,0x19,0x1a,0x1b,0x1c,0x1d,0x1e,0x1f
-	.byte 0x20,0x21,0x22,0x23,0x24,0x25,0x26,0x27
-	.byte 0x28,0x29,0x2a,0x2b,0x2c,0x2d,0x2e,0x2f
-	.byte 0x30,0x31,0x32,0x33,0x34,0x35,0x36,0x37
-	.byte 0x38,0x39,0x3a,0x3b,0x3c,0x3d,0x3e,0x3f
-	.byte 0x40,0x41,0x42,0x43,0x44,0x45,0x46,0x47
-	.byte 0x48,0x49,0x4a,0x4b,0x4c,0x4d,0x4e,0x4f
-	.byte 0x50,0x51,0x52,0x53,0x54,0x55,0x56,0x57
-	.byte 0x58,0x59,0x5a,0x5b,0x5c,0x5d,0x5e,0x5f
-	.byte 0x60,0x61,0x62,0x63,0x64,0x65,0x66,0x67
-	.byte 0x68,0x69,0x6a,0x6b,0x6c,0x6d,0x6e,0x6f
-	.byte 0x70,0x71,0x72,0x73,0x74,0x75,0x76,0x77
-	.byte 0x78,0x79,0x7a,0x7b,0x7c,0x7d,0x7e,0x7f
-
-	.byte 0x80,0x81,0x82,0x83,0x84,0x85,0x86,0x87
-	.byte 0x88,0x89,0x8a,0x8b,0x8c,0x8d,0x8e,0x8f
-	.byte 0x90,0x91,0x92,0x93,0x94,0x95,0x96,0x97
-	.byte 0x98,0x99,0x9a,0x9b,0x9c,0x9d,0x9e,0x9f
-	.byte 0xa0,0xa1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7
-	.byte 0xa8,0xa9,0xaa,0xab,0xac,0xad,0xae,0xaf
-	.byte 0xb0,0xb1,0xb2,0xb3,0xb4,0xb5,0xb6,0xb7
-	.byte 0xb8,0xb9,0xba,0xbb,0xbc,0xbd,0xbe,0xbf
-	.byte 0xc0,0x81,0x82,0x83,0x84,0x85,0x86,0x87	# .abcdefg
-	.byte 0x88,0x89,0xca,0xcb,0xcc,0xcd,0xce,0xcf	# hi
-	.byte 0xd0,0x91,0x92,0x93,0x94,0x95,0x96,0x97	# .jklmnop
-	.byte 0x98,0x99,0xda,0xdb,0xdc,0xdd,0xde,0xdf	# qr
-	.byte 0xe0,0xe1,0xa2,0xa3,0xa4,0xa5,0xa6,0xa7	# ..stuvwx
-	.byte 0xa8,0xa9,0xea,0xeb,0xec,0xed,0xee,0xef	# yz
-	.byte 0xf0,0xf1,0xf2,0xf3,0xf4,0xf5,0xf6,0xf7
-	.byte 0xf8,0xf9,0xfa,0xfb,0xfc,0xfd,0xfe,0xff
-
-#
 # startup-code at 0x10000, running in absolute addressing mode
 # this is called either by the ipl loader or directly by PSW restart
 # or linload or SALIPL
@@ -364,7 +294,7 @@ ENTRY(startup_kdump)
 	bras	%r13,0f
 	.fill	16,4,0x0
 0:	lmh	%r0,%r15,0(%r13)	# clear high-order half of gprs
-	sam31				# switch to 31 bit addressing mode
+	sam64				# switch to 64 bit addressing mode
 	basr	%r13,0			# get base
 .LPG0:
 	xc	0x200(256),0x200	# partially clear lowcore
@@ -395,7 +325,7 @@ ENTRY(startup_kdump)
 	jnz	1b
 	j	4f
 2:	l	%r15,.Lstack-.LPG0(%r13)
-	ahi	%r15,-96
+	ahi	%r15,-STACK_FRAME_OVERHEAD
 	la	%r2,.Lals_string-.LPG0(%r13)
 	l	%r3,.Lsclp_print-.LPG0(%r13)
 	basr	%r14,%r3
@@ -429,8 +359,7 @@ ENTRY(startup_kdump)
 	.long 1, 0xc0000000
 #endif
 4:
-	/* Continue with 64bit startup code in head64.S */
-	sam64				# switch to 64 bit mode
+	/* Continue with startup code in head64.S */
 	jg	startup_continue
 
 	.align	8
diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index f6d8acd..b1f0a90 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -121,6 +121,7 @@ static char *dump_type_str(enum dump_type type)
  * Must be in data section since the bss section
  * is not cleared when these are accessed.
  */
+static u8 ipl_ssid __attribute__((__section__(".data"))) = 0;
 static u16 ipl_devno __attribute__((__section__(".data"))) = 0;
 u32 ipl_flags __attribute__((__section__(".data"))) = 0;
 
@@ -197,6 +198,33 @@ static ssize_t sys_##_prefix##_##_name##_show(struct kobject *kobj,	\
 	return snprintf(page, PAGE_SIZE, _format, ##args);		\
 }
 
+#define IPL_ATTR_CCW_STORE_FN(_prefix, _name, _ipl_blk)			\
+static ssize_t sys_##_prefix##_##_name##_store(struct kobject *kobj,	\
+		struct kobj_attribute *attr,				\
+		const char *buf, size_t len)				\
+{									\
+	unsigned long long ssid, devno;					\
+									\
+	if (sscanf(buf, "0.%llx.%llx\n", &ssid, &devno) != 2)		\
+		return -EINVAL;						\
+									\
+	if (ssid > __MAX_SSID || devno > __MAX_SUBCHANNEL)		\
+		return -EINVAL;						\
+									\
+	_ipl_blk.ssid = ssid;						\
+	_ipl_blk.devno = devno;						\
+	return len;							\
+}
+
+#define DEFINE_IPL_CCW_ATTR_RW(_prefix, _name, _ipl_blk)		\
+IPL_ATTR_SHOW_FN(_prefix, _name, "0.%x.%04x\n",				\
+		 _ipl_blk.ssid, _ipl_blk.devno);			\
+IPL_ATTR_CCW_STORE_FN(_prefix, _name, _ipl_blk);			\
+static struct kobj_attribute sys_##_prefix##_##_name##_attr =		\
+	__ATTR(_name, (S_IRUGO | S_IWUSR),				\
+	       sys_##_prefix##_##_name##_show,				\
+	       sys_##_prefix##_##_name##_store)				\
+
 #define DEFINE_IPL_ATTR_RO(_prefix, _name, _format, _value)		\
 IPL_ATTR_SHOW_FN(_prefix, _name, _format, _value)			\
 static struct kobj_attribute sys_##_prefix##_##_name##_attr =		\
@@ -395,7 +423,7 @@ static ssize_t sys_ipl_device_show(struct kobject *kobj,
 
 	switch (ipl_info.type) {
 	case IPL_TYPE_CCW:
-		return sprintf(page, "0.0.%04x\n", ipl_devno);
+		return sprintf(page, "0.%x.%04x\n", ipl_ssid, ipl_devno);
 	case IPL_TYPE_FCP:
 	case IPL_TYPE_FCP_DUMP:
 		return sprintf(page, "0.0.%04x\n", ipl->ipl_info.fcp.devno);
@@ -687,21 +715,14 @@ static ssize_t reipl_fcp_scpdata_write(struct file *filp, struct kobject *kobj,
 				       struct bin_attribute *attr,
 				       char *buf, loff_t off, size_t count)
 {
+	size_t scpdata_len = count;
 	size_t padding;
-	size_t scpdata_len;
-
-	if (off < 0)
-		return -EINVAL;
 
-	if (off >= DIAG308_SCPDATA_SIZE)
-		return -ENOSPC;
 
-	if (count > DIAG308_SCPDATA_SIZE - off)
-		count = DIAG308_SCPDATA_SIZE - off;
-
-	memcpy(reipl_block_fcp->ipl_info.fcp.scp_data, buf + off, count);
-	scpdata_len = off + count;
+	if (off)
+		return -EINVAL;
 
+	memcpy(reipl_block_fcp->ipl_info.fcp.scp_data, buf, count);
 	if (scpdata_len % 8) {
 		padding = 8 - (scpdata_len % 8);
 		memset(reipl_block_fcp->ipl_info.fcp.scp_data + scpdata_len,
@@ -717,7 +738,7 @@ static ssize_t reipl_fcp_scpdata_write(struct file *filp, struct kobject *kobj,
 }
 static struct bin_attribute sys_reipl_fcp_scp_data_attr =
 	__BIN_ATTR(scp_data, (S_IRUGO | S_IWUSR), reipl_fcp_scpdata_read,
-		   reipl_fcp_scpdata_write, PAGE_SIZE);
+		   reipl_fcp_scpdata_write, DIAG308_SCPDATA_SIZE);
 
 static struct bin_attribute *reipl_fcp_bin_attrs[] = {
 	&sys_reipl_fcp_scp_data_attr,
@@ -814,9 +835,7 @@ static struct attribute_group reipl_fcp_attr_group = {
 };
 
 /* CCW reipl device attributes */
-
-DEFINE_IPL_ATTR_RW(reipl_ccw, device, "0.0.%04llx\n", "0.0.%llx\n",
-	reipl_block_ccw->ipl_info.ccw.devno);
+DEFINE_IPL_CCW_ATTR_RW(reipl_ccw, device, reipl_block_ccw->ipl_info.ccw);
 
 /* NSS wrapper */
 static ssize_t reipl_nss_loadparm_show(struct kobject *kobj,
@@ -1056,8 +1075,8 @@ static void __reipl_run(void *unused)
 
 	switch (reipl_method) {
 	case REIPL_METHOD_CCW_CIO:
+		devid.ssid  = reipl_block_ccw->ipl_info.ccw.ssid;
 		devid.devno = reipl_block_ccw->ipl_info.ccw.devno;
-		devid.ssid  = 0;
 		reipl_ccw_dev(&devid);
 		break;
 	case REIPL_METHOD_CCW_VM:
@@ -1192,6 +1211,7 @@ static int __init reipl_ccw_init(void)
 
 	reipl_block_ccw_init(reipl_block_ccw);
 	if (ipl_info.type == IPL_TYPE_CCW) {
+		reipl_block_ccw->ipl_info.ccw.ssid = ipl_ssid;
 		reipl_block_ccw->ipl_info.ccw.devno = ipl_devno;
 		reipl_block_ccw_fill_parms(reipl_block_ccw);
 	}
@@ -1336,9 +1356,7 @@ static struct attribute_group dump_fcp_attr_group = {
 };
 
 /* CCW dump device attributes */
-
-DEFINE_IPL_ATTR_RW(dump_ccw, device, "0.0.%04llx\n", "0.0.%llx\n",
-		   dump_block_ccw->ipl_info.ccw.devno);
+DEFINE_IPL_CCW_ATTR_RW(dump_ccw, device, dump_block_ccw->ipl_info.ccw);
 
 static struct attribute *dump_ccw_attrs[] = {
 	&sys_dump_ccw_device_attr.attr,
@@ -1418,8 +1436,8 @@ static void __dump_run(void *unused)
 
 	switch (dump_method) {
 	case DUMP_METHOD_CCW_CIO:
+		devid.ssid  = dump_block_ccw->ipl_info.ccw.ssid;
 		devid.devno = dump_block_ccw->ipl_info.ccw.devno;
-		devid.ssid  = 0;
 		reipl_ccw_dev(&devid);
 		break;
 	case DUMP_METHOD_CCW_VM:
@@ -1939,14 +1957,14 @@ void __init setup_ipl(void)
 	ipl_info.type = get_ipl_type();
 	switch (ipl_info.type) {
 	case IPL_TYPE_CCW:
+		ipl_info.data.ccw.dev_id.ssid = ipl_ssid;
 		ipl_info.data.ccw.dev_id.devno = ipl_devno;
-		ipl_info.data.ccw.dev_id.ssid = 0;
 		break;
 	case IPL_TYPE_FCP:
 	case IPL_TYPE_FCP_DUMP:
+		ipl_info.data.fcp.dev_id.ssid = 0;
 		ipl_info.data.fcp.dev_id.devno =
 			IPL_PARMBLOCK_START->ipl_info.fcp.devno;
-		ipl_info.data.fcp.dev_id.ssid = 0;
 		ipl_info.data.fcp.wwpn = IPL_PARMBLOCK_START->ipl_info.fcp.wwpn;
 		ipl_info.data.fcp.lun = IPL_PARMBLOCK_START->ipl_info.fcp.lun;
 		break;
@@ -1978,6 +1996,7 @@ void __init ipl_save_parameters(void)
 	if (cio_get_iplinfo(&iplinfo))
 		return;
 
+	ipl_ssid = iplinfo.ssid;
 	ipl_devno = iplinfo.devno;
 	ipl_flags |= IPL_DEVNO_VALID;
 	if (!iplinfo.is_qdio)
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 688a3aa..114ee8b 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -243,11 +243,7 @@ unsigned long arch_align_stack(unsigned long sp)
 
 static inline unsigned long brk_rnd(void)
 {
-	/* 8MB for 32bit, 1GB for 64bit */
-	if (is_32bit_task())
-		return (get_random_int() & 0x7ffUL) << PAGE_SHIFT;
-	else
-		return (get_random_int() & 0x3ffffUL) << PAGE_SHIFT;
+	return (get_random_int() & BRK_RND_MASK) << PAGE_SHIFT;
 }
 
 unsigned long arch_randomize_brk(struct mm_struct *mm)
diff --git a/arch/s390/kernel/sclp.c b/arch/s390/kernel/sclp.c
index fa0bdff..9fe7781 100644
--- a/arch/s390/kernel/sclp.c
+++ b/arch/s390/kernel/sclp.c
@@ -21,7 +21,7 @@ static void _sclp_wait_int(void)
 	__ctl_load(cr0_new, 0, 0);
 
 	psw_ext_save = S390_lowcore.external_new_psw;
-	psw_mask = __extract_psw() & (PSW_MASK_EA | PSW_MASK_BA);
+	psw_mask = __extract_psw();
 	S390_lowcore.external_new_psw.mask = psw_mask;
 	psw_wait.mask = psw_mask | PSW_MASK_EXT | PSW_MASK_WAIT;
 	S390_lowcore.ext_int_code = 0;
diff --git a/arch/s390/kernel/setup.c b/arch/s390/kernel/setup.c
index ce0cbd6..c837bca 100644
--- a/arch/s390/kernel/setup.c
+++ b/arch/s390/kernel/setup.c
@@ -764,9 +764,6 @@ static int __init setup_hwcaps(void)
 	get_cpu_id(&cpu_id);
 	add_device_randomness(&cpu_id, sizeof(cpu_id));
 	switch (cpu_id.machine) {
-	case 0x9672:
-		strcpy(elf_platform, "g5");
-		break;
 	case 0x2064:
 	case 0x2066:
 	default:	/* Use "z900" as default for 64 bit kernels. */
diff --git a/arch/s390/kernel/syscalls.S b/arch/s390/kernel/syscalls.S
index 8c56929..5378c3e 100644
--- a/arch/s390/kernel/syscalls.S
+++ b/arch/s390/kernel/syscalls.S
@@ -382,3 +382,4 @@ SYSCALL(sys_sendmsg,compat_sys_sendmsg)			/* 370 */
 SYSCALL(sys_recvfrom,compat_sys_recvfrom)
 SYSCALL(sys_recvmsg,compat_sys_recvmsg)
 SYSCALL(sys_shutdown,sys_shutdown)
+SYSCALL(sys_mlock2,compat_sys_mlock2)
diff --git a/arch/s390/kernel/trace.c b/arch/s390/kernel/trace.c
index 73239bb..21a5df9 100644
--- a/arch/s390/kernel/trace.c
+++ b/arch/s390/kernel/trace.c
@@ -9,11 +9,11 @@
 #define CREATE_TRACE_POINTS
 #include <asm/trace/diag.h>
 
-EXPORT_TRACEPOINT_SYMBOL(diagnose);
+EXPORT_TRACEPOINT_SYMBOL(s390_diagnose);
 
 static DEFINE_PER_CPU(unsigned int, diagnose_trace_depth);
 
-void trace_diagnose_norecursion(int diag_nr)
+void trace_s390_diagnose_norecursion(int diag_nr)
 {
 	unsigned long flags;
 	unsigned int *depth;
@@ -22,7 +22,7 @@ void trace_diagnose_norecursion(int diag_nr)
 	depth = this_cpu_ptr(&diagnose_trace_depth);
 	if (*depth == 0) {
 		(*depth)++;
-		trace_diagnose(diag_nr);
+		trace_s390_diagnose(diag_nr);
 		(*depth)--;
 	}
 	local_irq_restore(flags);
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index c3c07d3..c722400 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -48,37 +48,13 @@ EXPORT_SYMBOL(zero_page_mask);
 
 static void __init setup_zero_pages(void)
 {
-	struct cpuid cpu_id;
 	unsigned int order;
 	struct page *page;
 	int i;
 
-	get_cpu_id(&cpu_id);
-	switch (cpu_id.machine) {
-	case 0x9672:	/* g5 */
-	case 0x2064:	/* z900 */
-	case 0x2066:	/* z900 */
-	case 0x2084:	/* z990 */
-	case 0x2086:	/* z990 */
-	case 0x2094:	/* z9-109 */
-	case 0x2096:	/* z9-109 */
-		order = 0;
-		break;
-	case 0x2097:	/* z10 */
-	case 0x2098:	/* z10 */
-	case 0x2817:	/* z196 */
-	case 0x2818:	/* z196 */
-		order = 2;
-		break;
-	case 0x2827:	/* zEC12 */
-	case 0x2828:	/* zEC12 */
-		order = 5;
-		break;
-	case 0x2964:	/* z13 */
-	default:
-		order = 7;
-		break;
-	}
+	/* Latest machines require a mapping granularity of 512KB */
+	order = 7;
+
 	/* Limit number of empty zero pages for small memory sizes */
 	while (order > 2 && (totalram_pages >> 10) < (1UL << order))
 		order--;
diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 6e552af..ea01477 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -31,9 +31,6 @@
 #include <linux/security.h>
 #include <asm/pgalloc.h>
 
-unsigned long mmap_rnd_mask;
-static unsigned long mmap_align_mask;
-
 static unsigned long stack_maxrandom_size(void)
 {
 	if (!(current->flags & PF_RANDOMIZE))
@@ -62,10 +59,7 @@ static inline int mmap_is_legacy(void)
 
 unsigned long arch_mmap_rnd(void)
 {
-	if (is_32bit_task())
-		return (get_random_int() & 0x7ff) << PAGE_SHIFT;
-	else
-		return (get_random_int() & mmap_rnd_mask) << PAGE_SHIFT;
+	return (get_random_int() & MMAP_RND_MASK) << PAGE_SHIFT;
 }
 
 static unsigned long mmap_base_legacy(unsigned long rnd)
@@ -92,7 +86,6 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 	struct mm_struct *mm = current->mm;
 	struct vm_area_struct *vma;
 	struct vm_unmapped_area_info info;
-	int do_color_align;
 
 	if (len > TASK_SIZE - mmap_min_addr)
 		return -ENOMEM;
@@ -108,15 +101,14 @@ arch_get_unmapped_area(struct file *filp, unsigned long addr,
 			return addr;
 	}
 
-	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
-		do_color_align = !is_32bit_task();
-
 	info.flags = 0;
 	info.length = len;
 	info.low_limit = mm->mmap_base;
 	info.high_limit = TASK_SIZE;
-	info.align_mask = do_color_align ? (mmap_align_mask << PAGE_SHIFT) : 0;
+	if (filp || (flags & MAP_SHARED))
+		info.align_mask = MMAP_ALIGN_MASK << PAGE_SHIFT;
+	else
+		info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	return vm_unmapped_area(&info);
 }
@@ -130,7 +122,6 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 	struct mm_struct *mm = current->mm;
 	unsigned long addr = addr0;
 	struct vm_unmapped_area_info info;
-	int do_color_align;
 
 	/* requested length too big for entire address space */
 	if (len > TASK_SIZE - mmap_min_addr)
@@ -148,15 +139,14 @@ arch_get_unmapped_area_topdown(struct file *filp, const unsigned long addr0,
 			return addr;
 	}
 
-	do_color_align = 0;
-	if (filp || (flags & MAP_SHARED))
-		do_color_align = !is_32bit_task();
-
 	info.flags = VM_UNMAPPED_AREA_TOPDOWN;
 	info.length = len;
 	info.low_limit = max(PAGE_SIZE, mmap_min_addr);
 	info.high_limit = mm->mmap_base;
-	info.align_mask = do_color_align ? (mmap_align_mask << PAGE_SHIFT) : 0;
+	if (filp || (flags & MAP_SHARED))
+		info.align_mask = MMAP_ALIGN_MASK << PAGE_SHIFT;
+	else
+		info.align_mask = 0;
 	info.align_offset = pgoff << PAGE_SHIFT;
 	addr = vm_unmapped_area(&info);
 
@@ -254,35 +244,3 @@ void arch_pick_mmap_layout(struct mm_struct *mm)
 		mm->get_unmapped_area = s390_get_unmapped_area_topdown;
 	}
 }
-
-static int __init setup_mmap_rnd(void)
-{
-	struct cpuid cpu_id;
-
-	get_cpu_id(&cpu_id);
-	switch (cpu_id.machine) {
-	case 0x9672:
-	case 0x2064:
-	case 0x2066:
-	case 0x2084:
-	case 0x2086:
-	case 0x2094:
-	case 0x2096:
-	case 0x2097:
-	case 0x2098:
-	case 0x2817:
-	case 0x2818:
-	case 0x2827:
-	case 0x2828:
-		mmap_rnd_mask = 0x7ffUL;
-		mmap_align_mask = 0UL;
-		break;
-	case 0x2964:	/* z13 */
-	default:
-		mmap_rnd_mask = 0x3ff80UL;
-		mmap_align_mask = 0x7fUL;
-		break;
-	}
-	return 0;
-}
-early_initcall(setup_mmap_rnd);
diff --git a/arch/s390/pci/pci_dma.c b/arch/s390/pci/pci_dma.c
index 37d10f7..d348f2c 100644
--- a/arch/s390/pci/pci_dma.c
+++ b/arch/s390/pci/pci_dma.c
@@ -33,7 +33,7 @@ unsigned long *dma_alloc_cpu_table(void)
 		return NULL;
 
 	for (entry = table; entry < table + ZPCI_TABLE_ENTRIES; entry++)
-		*entry = ZPCI_TABLE_INVALID | ZPCI_TABLE_PROTECTED;
+		*entry = ZPCI_TABLE_INVALID;
 	return table;
 }
 
@@ -51,7 +51,7 @@ static unsigned long *dma_alloc_page_table(void)
 		return NULL;
 
 	for (entry = table; entry < table + ZPCI_PT_ENTRIES; entry++)
-		*entry = ZPCI_PTE_INVALID | ZPCI_TABLE_PROTECTED;
+		*entry = ZPCI_PTE_INVALID;
 	return table;
 }
 
@@ -95,7 +95,7 @@ static unsigned long *dma_get_page_table_origin(unsigned long *entry)
 	return pto;
 }
 
-static unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr)
+unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr)
 {
 	unsigned long *sto, *pto;
 	unsigned int rtx, sx, px;
@@ -114,20 +114,10 @@ static unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t dma_addr
 	return &pto[px];
 }
 
-void dma_update_cpu_trans(unsigned long *dma_table, void *page_addr,
-			  dma_addr_t dma_addr, int flags)
+void dma_update_cpu_trans(unsigned long *entry, void *page_addr, int flags)
 {
-	unsigned long *entry;
-
-	entry = dma_walk_cpu_trans(dma_table, dma_addr);
-	if (!entry) {
-		WARN_ON_ONCE(1);
-		return;
-	}
-
 	if (flags & ZPCI_PTE_INVALID) {
 		invalidate_pt_entry(entry);
-		return;
 	} else {
 		set_pt_pfaa(entry, page_addr);
 		validate_pt_entry(entry);
@@ -146,18 +136,25 @@ static int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
 	u8 *page_addr = (u8 *) (pa & PAGE_MASK);
 	dma_addr_t start_dma_addr = dma_addr;
 	unsigned long irq_flags;
+	unsigned long *entry;
 	int i, rc = 0;
 
 	if (!nr_pages)
 		return -EINVAL;
 
 	spin_lock_irqsave(&zdev->dma_table_lock, irq_flags);
-	if (!zdev->dma_table)
+	if (!zdev->dma_table) {
+		rc = -EINVAL;
 		goto no_refresh;
+	}
 
 	for (i = 0; i < nr_pages; i++) {
-		dma_update_cpu_trans(zdev->dma_table, page_addr, dma_addr,
-				     flags);
+		entry = dma_walk_cpu_trans(zdev->dma_table, dma_addr);
+		if (!entry) {
+			rc = -ENOMEM;
+			goto undo_cpu_trans;
+		}
+		dma_update_cpu_trans(entry, page_addr, flags);
 		page_addr += PAGE_SIZE;
 		dma_addr += PAGE_SIZE;
 	}
@@ -176,6 +173,18 @@ static int dma_update_trans(struct zpci_dev *zdev, unsigned long pa,
 
 	rc = zpci_refresh_trans((u64) zdev->fh << 32, start_dma_addr,
 				nr_pages * PAGE_SIZE);
+undo_cpu_trans:
+	if (rc && ((flags & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID)) {
+		flags = ZPCI_PTE_INVALID;
+		while (i-- > 0) {
+			page_addr -= PAGE_SIZE;
+			dma_addr -= PAGE_SIZE;
+			entry = dma_walk_cpu_trans(zdev->dma_table, dma_addr);
+			if (!entry)
+				break;
+			dma_update_cpu_trans(entry, page_addr, flags);
+		}
+	}
 
 no_refresh:
 	spin_unlock_irqrestore(&zdev->dma_table_lock, irq_flags);
@@ -260,6 +269,16 @@ out:
 	spin_unlock_irqrestore(&zdev->iommu_bitmap_lock, flags);
 }
 
+static inline void zpci_err_dma(unsigned long rc, unsigned long addr)
+{
+	struct {
+		unsigned long rc;
+		unsigned long addr;
+	} __packed data = {rc, addr};
+
+	zpci_err_hex(&data, sizeof(data));
+}
+
 static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 				     unsigned long offset, size_t size,
 				     enum dma_data_direction direction,
@@ -270,33 +289,40 @@ static dma_addr_t s390_dma_map_pages(struct device *dev, struct page *page,
 	unsigned long pa = page_to_phys(page) + offset;
 	int flags = ZPCI_PTE_VALID;
 	dma_addr_t dma_addr;
+	int ret;
 
 	/* This rounds up number of pages based on size and offset */
 	nr_pages = iommu_num_pages(pa, size, PAGE_SIZE);
 	iommu_page_index = dma_alloc_iommu(zdev, nr_pages);
-	if (iommu_page_index == -1)
+	if (iommu_page_index == -1) {
+		ret = -ENOSPC;
 		goto out_err;
+	}
 
 	/* Use rounded up size */
 	size = nr_pages * PAGE_SIZE;
 
 	dma_addr = zdev->start_dma + iommu_page_index * PAGE_SIZE;
-	if (dma_addr + size > zdev->end_dma)
+	if (dma_addr + size > zdev->end_dma) {
+		ret = -ERANGE;
 		goto out_free;
+	}
 
 	if (direction == DMA_NONE || direction == DMA_TO_DEVICE)
 		flags |= ZPCI_TABLE_PROTECTED;
 
-	if (!dma_update_trans(zdev, pa, dma_addr, size, flags)) {
-		atomic64_add(nr_pages, &zdev->mapped_pages);
-		return dma_addr + (offset & ~PAGE_MASK);
-	}
+	ret = dma_update_trans(zdev, pa, dma_addr, size, flags);
+	if (ret)
+		goto out_free;
+
+	atomic64_add(nr_pages, &zdev->mapped_pages);
+	return dma_addr + (offset & ~PAGE_MASK);
 
 out_free:
 	dma_free_iommu(zdev, iommu_page_index, nr_pages);
 out_err:
 	zpci_err("map error:\n");
-	zpci_err_hex(&pa, sizeof(pa));
+	zpci_err_dma(ret, pa);
 	return DMA_ERROR_CODE;
 }
 
@@ -306,14 +332,16 @@ static void s390_dma_unmap_pages(struct device *dev, dma_addr_t dma_addr,
 {
 	struct zpci_dev *zdev = to_zpci(to_pci_dev(dev));
 	unsigned long iommu_page_index;
-	int npages;
+	int npages, ret;
 
 	npages = iommu_num_pages(dma_addr, size, PAGE_SIZE);
 	dma_addr = dma_addr & PAGE_MASK;
-	if (dma_update_trans(zdev, 0, dma_addr, npages * PAGE_SIZE,
-			     ZPCI_TABLE_PROTECTED | ZPCI_PTE_INVALID)) {
+	ret = dma_update_trans(zdev, 0, dma_addr, npages * PAGE_SIZE,
+			       ZPCI_PTE_INVALID);
+	if (ret) {
 		zpci_err("unmap error:\n");
-		zpci_err_hex(&dma_addr, sizeof(dma_addr));
+		zpci_err_dma(ret, dma_addr);
+		return;
 	}
 
 	atomic64_add(npages, &zdev->unmapped_pages);
diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
index cbe198c..471ee36 100644
--- a/drivers/iommu/s390-iommu.c
+++ b/drivers/iommu/s390-iommu.c
@@ -216,6 +216,7 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 	u8 *page_addr = (u8 *) (pa & PAGE_MASK);
 	dma_addr_t start_dma_addr = dma_addr;
 	unsigned long irq_flags, nr_pages, i;
+	unsigned long *entry;
 	int rc = 0;
 
 	if (dma_addr < s390_domain->domain.geometry.aperture_start ||
@@ -228,8 +229,12 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 
 	spin_lock_irqsave(&s390_domain->dma_table_lock, irq_flags);
 	for (i = 0; i < nr_pages; i++) {
-		dma_update_cpu_trans(s390_domain->dma_table, page_addr,
-				     dma_addr, flags);
+		entry = dma_walk_cpu_trans(s390_domain->dma_table, dma_addr);
+		if (!entry) {
+			rc = -ENOMEM;
+			goto undo_cpu_trans;
+		}
+		dma_update_cpu_trans(entry, page_addr, flags);
 		page_addr += PAGE_SIZE;
 		dma_addr += PAGE_SIZE;
 	}
@@ -242,6 +247,20 @@ static int s390_iommu_update_trans(struct s390_domain *s390_domain,
 			break;
 	}
 	spin_unlock(&s390_domain->list_lock);
+
+undo_cpu_trans:
+	if (rc && ((flags & ZPCI_PTE_VALID_MASK) == ZPCI_PTE_VALID)) {
+		flags = ZPCI_PTE_INVALID;
+		while (i-- > 0) {
+			page_addr -= PAGE_SIZE;
+			dma_addr -= PAGE_SIZE;
+			entry = dma_walk_cpu_trans(s390_domain->dma_table,
+						   dma_addr);
+			if (!entry)
+				break;
+			dma_update_cpu_trans(entry, page_addr, flags);
+		}
+	}
 	spin_unlock_irqrestore(&s390_domain->dma_table_lock, irq_flags);
 
 	return rc;
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 548a189..a831d18 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1080,28 +1080,10 @@ void __init chsc_init_cleanup(void)
 	free_page((unsigned long)sei_page);
 }
 
-int chsc_enable_facility(int operation_code)
+int __chsc_enable_facility(struct chsc_sda_area *sda_area, int operation_code)
 {
-	unsigned long flags;
 	int ret;
-	struct {
-		struct chsc_header request;
-		u8 reserved1:4;
-		u8 format:4;
-		u8 reserved2;
-		u16 operation_code;
-		u32 reserved3;
-		u32 reserved4;
-		u32 operation_data_area[252];
-		struct chsc_header response;
-		u32 reserved5:4;
-		u32 format2:4;
-		u32 reserved6:24;
-	} __attribute__ ((packed)) *sda_area;
 
-	spin_lock_irqsave(&chsc_page_lock, flags);
-	memset(chsc_page, 0, PAGE_SIZE);
-	sda_area = chsc_page;
 	sda_area->request.length = 0x0400;
 	sda_area->request.code = 0x0031;
 	sda_area->operation_code = operation_code;
@@ -1119,10 +1101,25 @@ int chsc_enable_facility(int operation_code)
 	default:
 		ret = chsc_error_from_response(sda_area->response.code);
 	}
+out:
+	return ret;
+}
+
+int chsc_enable_facility(int operation_code)
+{
+	struct chsc_sda_area *sda_area;
+	unsigned long flags;
+	int ret;
+
+	spin_lock_irqsave(&chsc_page_lock, flags);
+	memset(chsc_page, 0, PAGE_SIZE);
+	sda_area = chsc_page;
+
+	ret = __chsc_enable_facility(sda_area, operation_code);
 	if (ret != 0)
 		CIO_CRW_EVENT(2, "chsc: sda (oc=%x) failed (rc=%04x)\n",
 			      operation_code, sda_area->response.code);
-out:
+
 	spin_unlock_irqrestore(&chsc_page_lock, flags);
 	return ret;
 }
diff --git a/drivers/s390/cio/chsc.h b/drivers/s390/cio/chsc.h
index 76c9b50..0de134c 100644
--- a/drivers/s390/cio/chsc.h
+++ b/drivers/s390/cio/chsc.h
@@ -115,6 +115,20 @@ struct chsc_scpd {
 	u8 data[PAGE_SIZE - 20];
 } __attribute__ ((packed));
 
+struct chsc_sda_area {
+	struct chsc_header request;
+	u8 :4;
+	u8 format:4;
+	u8 :8;
+	u16 operation_code;
+	u32 :32;
+	u32 :32;
+	u32 operation_data_area[252];
+	struct chsc_header response;
+	u32 :4;
+	u32 format2:4;
+	u32 :24;
+} __packed __aligned(PAGE_SIZE);
 
 extern int chsc_get_ssd_info(struct subchannel_id schid,
 			     struct chsc_ssd_info *ssd);
@@ -122,6 +136,7 @@ extern int chsc_determine_css_characteristics(void);
 extern int chsc_init(void);
 extern void chsc_init_cleanup(void);
 
+int __chsc_enable_facility(struct chsc_sda_area *sda_area, int operation_code);
 extern int chsc_enable_facility(int);
 struct channel_subsystem;
 extern int chsc_secm(struct channel_subsystem *, int);
diff --git a/drivers/s390/cio/cio.c b/drivers/s390/cio/cio.c
index b5620e8..690b854 100644
--- a/drivers/s390/cio/cio.c
+++ b/drivers/s390/cio/cio.c
@@ -925,18 +925,32 @@ void reipl_ccw_dev(struct ccw_dev_id *devid)
 
 int __init cio_get_iplinfo(struct cio_iplinfo *iplinfo)
 {
+	static struct chsc_sda_area sda_area __initdata;
 	struct subchannel_id schid;
 	struct schib schib;
 
 	schid = *(struct subchannel_id *)&S390_lowcore.subchannel_id;
 	if (!schid.one)
 		return -ENODEV;
+
+	if (schid.ssid) {
+		/*
+		 * Firmware should have already enabled MSS but whoever started
+		 * the kernel might have initiated a channel subsystem reset.
+		 * Ensure that MSS is enabled.
+		 */
+		memset(&sda_area, 0, sizeof(sda_area));
+		if (__chsc_enable_facility(&sda_area, CHSC_SDA_OC_MSS))
+			return -ENODEV;
+	}
 	if (stsch_err(schid, &schib))
 		return -ENODEV;
 	if (schib.pmcw.st != SUBCHANNEL_TYPE_IO)
 		return -ENODEV;
 	if (!schib.pmcw.dnv)
 		return -ENODEV;
+
+	iplinfo->ssid = schid.ssid;
 	iplinfo->devno = schib.pmcw.dev;
 	iplinfo->is_qdio = schib.pmcw.qf;
 	return 0;
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index 2ee3053..489e703 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -702,17 +702,12 @@ css_generate_pgid(struct channel_subsystem *css, u32 tod_high)
 		css->global_pgid.pgid_high.ext_cssid.version = 0x80;
 		css->global_pgid.pgid_high.ext_cssid.cssid = css->cssid;
 	} else {
-#ifdef CONFIG_SMP
 		css->global_pgid.pgid_high.cpu_addr = stap();
-#else
-		css->global_pgid.pgid_high.cpu_addr = 0;
-#endif
 	}
 	get_cpu_id(&cpu_id);
 	css->global_pgid.cpu_id = cpu_id.ident;
 	css->global_pgid.cpu_model = cpu_id.machine;
 	css->global_pgid.tod_high = tod_high;
-
 }
 
 static void
diff --git a/drivers/s390/crypto/Makefile b/drivers/s390/crypto/Makefile
index 57f710b..b8ab186 100644
--- a/drivers/s390/crypto/Makefile
+++ b/drivers/s390/crypto/Makefile
@@ -3,6 +3,9 @@
 #
 
 ap-objs := ap_bus.o
-obj-$(CONFIG_ZCRYPT) += ap.o zcrypt_api.o zcrypt_pcixcc.o
-obj-$(CONFIG_ZCRYPT) += zcrypt_cex2a.o zcrypt_cex4.o
+# zcrypt_api depends on ap
+obj-$(CONFIG_ZCRYPT) += ap.o zcrypt_api.o
+# msgtype* depend on zcrypt_api
 obj-$(CONFIG_ZCRYPT) += zcrypt_msgtype6.o zcrypt_msgtype50.o
+# adapter drivers depend on ap, zcrypt_api and msgtype*
+obj-$(CONFIG_ZCRYPT) += zcrypt_pcixcc.o zcrypt_cex2a.o zcrypt_cex4.o
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 9cb3dfb..61f7685 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -74,6 +74,7 @@ static struct device *ap_root_device = NULL;
 static struct ap_config_info *ap_configuration;
 static DEFINE_SPINLOCK(ap_device_list_lock);
 static LIST_HEAD(ap_device_list);
+static bool initialised;
 
 /*
  * Workqueue timer for bus rescan.
@@ -1384,6 +1385,9 @@ int ap_driver_register(struct ap_driver *ap_drv, struct module *owner,
 {
 	struct device_driver *drv = &ap_drv->driver;
 
+	if (!initialised)
+		return -ENODEV;
+
 	drv->bus = &ap_bus_type;
 	drv->probe = ap_device_probe;
 	drv->remove = ap_device_remove;
@@ -1808,6 +1812,7 @@ int __init ap_module_init(void)
 		goto out_pm;
 
 	queue_work(system_long_wq, &ap_scan_work);
+	initialised = true;
 
 	return 0;
 
@@ -1837,6 +1842,7 @@ void ap_module_exit(void)
 {
 	int i;
 
+	initialised = false;
 	ap_reset_domain();
 	ap_poll_thread_stop();
 	del_timer_sync(&ap_config_timer);
diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
index a9603eb..9f8fa42 100644
--- a/drivers/s390/crypto/zcrypt_api.c
+++ b/drivers/s390/crypto/zcrypt_api.c
@@ -317,11 +317,9 @@ EXPORT_SYMBOL(zcrypt_device_unregister);
 
 void zcrypt_msgtype_register(struct zcrypt_ops *zops)
 {
-	if (zops->owner) {
-		spin_lock_bh(&zcrypt_ops_list_lock);
-		list_add_tail(&zops->list, &zcrypt_ops_list);
-		spin_unlock_bh(&zcrypt_ops_list_lock);
-	}
+	spin_lock_bh(&zcrypt_ops_list_lock);
+	list_add_tail(&zops->list, &zcrypt_ops_list);
+	spin_unlock_bh(&zcrypt_ops_list_lock);
 }
 EXPORT_SYMBOL(zcrypt_msgtype_register);
 
@@ -342,7 +340,7 @@ struct zcrypt_ops *__ops_lookup(unsigned char *name, int variant)
 	spin_lock_bh(&zcrypt_ops_list_lock);
 	list_for_each_entry(zops, &zcrypt_ops_list, list) {
 		if ((zops->variant == variant) &&
-		    (!strncmp(zops->owner->name, name, MODULE_NAME_LEN))) {
+		    (!strncmp(zops->name, name, sizeof(zops->name)))) {
 			found = 1;
 			break;
 		}
diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
index 7508768..38618f0 100644
--- a/drivers/s390/crypto/zcrypt_api.h
+++ b/drivers/s390/crypto/zcrypt_api.h
@@ -96,6 +96,7 @@ struct zcrypt_ops {
 	struct list_head list;		/* zcrypt ops list. */
 	struct module *owner;
 	int variant;
+	char name[128];
 };
 
 struct zcrypt_device {
diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
index 71ceee9..74edf29 100644
--- a/drivers/s390/crypto/zcrypt_msgtype50.c
+++ b/drivers/s390/crypto/zcrypt_msgtype50.c
@@ -513,6 +513,7 @@ static struct zcrypt_ops zcrypt_msgtype50_ops = {
 	.rsa_modexpo = zcrypt_cex2a_modexpo,
 	.rsa_modexpo_crt = zcrypt_cex2a_modexpo_crt,
 	.owner = THIS_MODULE,
+	.name = MSGTYPE50_NAME,
 	.variant = MSGTYPE50_VARIANT_DEFAULT,
 };
 
diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
index 7476221..9a2dd47 100644
--- a/drivers/s390/crypto/zcrypt_msgtype6.c
+++ b/drivers/s390/crypto/zcrypt_msgtype6.c
@@ -1119,6 +1119,7 @@ static long zcrypt_msgtype6_rng(struct zcrypt_device *zdev,
  */
 static struct zcrypt_ops zcrypt_msgtype6_norng_ops = {
 	.owner = THIS_MODULE,
+	.name = MSGTYPE06_NAME,
 	.variant = MSGTYPE06_VARIANT_NORNG,
 	.rsa_modexpo = zcrypt_msgtype6_modexpo,
 	.rsa_modexpo_crt = zcrypt_msgtype6_modexpo_crt,
@@ -1127,6 +1128,7 @@ static struct zcrypt_ops zcrypt_msgtype6_norng_ops = {
 
 static struct zcrypt_ops zcrypt_msgtype6_ops = {
 	.owner = THIS_MODULE,
+	.name = MSGTYPE06_NAME,
 	.variant = MSGTYPE06_VARIANT_DEFAULT,
 	.rsa_modexpo = zcrypt_msgtype6_modexpo,
 	.rsa_modexpo_crt = zcrypt_msgtype6_modexpo_crt,
@@ -1136,6 +1138,7 @@ static struct zcrypt_ops zcrypt_msgtype6_ops = {
 
 static struct zcrypt_ops zcrypt_msgtype6_ep11_ops = {
 	.owner = THIS_MODULE,
+	.name = MSGTYPE06_NAME,
 	.variant = MSGTYPE06_VARIANT_EP11,
 	.rsa_modexpo = NULL,
 	.rsa_modexpo_crt = NULL,
