Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 2 Aug 2016 07:36:24 -0400
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [GIT PULL] s390 patches for the 4.8 merge window #2
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20160802073624.05510ed9@mschwide>
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

- Some cleanup for the hugetlbfs pte/pmd conversion functions

- The code to check for the minimum CPU type is converted from
  assembler to C and an informational message is added in case
  the CPU is not new enough to run the kernel

- Bug fixes

Gerald Schaefer (1):
      s390/mm: clean up pte/pmd encoding

Heiko Carstens (7):
      s390/sclp: move uninitialized data to data section
      s390/als: convert architecture level set code to C
      s390/als: print machine type on facility mismatch
      s390/als: print missing facilities on facility mismatch
      s390/facilities: do not generate DWORDS define anymore
      s390/als: fix compile with gcov enabled
      s390/numa: only set possible nodes within node_possible_map

Ingo Tuchscherer (1):
      s390/zcrypt: Fix zcrypt suspend/resume behavior

James Hogan (1):
      s390: Define AT_VECTOR_SIZE_ARCH for ARCH_DLINFO

Jiri Olsa (1):
      s390/ftrace/jprobes: Fix conflict between jprobes and function graph tracing

Sebastian Ott (2):
      s390/cio: convert cfg_lock mutex to spinlock
      s390/cio: fix premature wakeup during chp configure

Wei Yongjun (1):
      s390/zcrypt: fix possible memory leak in ap_module_init()

 arch/s390/boot/compressed/Makefile  |   2 +-
 arch/s390/include/asm/elf.h         |   1 +
 arch/s390/include/asm/pgtable.h     |  20 +++---
 arch/s390/include/uapi/asm/auxvec.h |   2 +
 arch/s390/kernel/Makefile           |  11 +++-
 arch/s390/kernel/als.c              | 124 ++++++++++++++++++++++++++++++++++++
 arch/s390/kernel/entry.h            |   2 +
 arch/s390/kernel/head.S             |  43 ++-----------
 arch/s390/kernel/kprobes.c          |  12 ++++
 arch/s390/kernel/sclp.c             |   5 +-
 arch/s390/mm/hugetlbpage.c          |  52 +++++++++++----
 arch/s390/numa/mode_emu.c           |   4 ++
 arch/s390/numa/numa.c               |   8 ++-
 arch/s390/tools/gen_facilities.c    |   1 -
 drivers/s390/cio/chp.c              |  60 +++++++++++------
 drivers/s390/crypto/ap_bus.c        |  50 +++++++++++++--
 drivers/s390/crypto/ap_bus.h        |   1 +
 drivers/s390/crypto/zcrypt_cex2a.c  |   2 +-
 drivers/s390/crypto/zcrypt_cex4.c   |   2 +-
 drivers/s390/crypto/zcrypt_pcixcc.c |   2 +-
 20 files changed, 305 insertions(+), 99 deletions(-)
 create mode 100644 arch/s390/kernel/als.c

diff --git a/arch/s390/boot/compressed/Makefile b/arch/s390/boot/compressed/Makefile
index 98ec652..13723c3 100644
--- a/arch/s390/boot/compressed/Makefile
+++ b/arch/s390/boot/compressed/Makefile
@@ -18,7 +18,7 @@ KBUILD_CFLAGS += $(call cc-option,-ffreestanding)
 
 GCOV_PROFILE := n
 
-OBJECTS := $(addprefix $(objtree)/arch/s390/kernel/, head.o sclp.o ebcdic.o)
+OBJECTS := $(addprefix $(objtree)/arch/s390/kernel/, head.o sclp.o ebcdic.o als.o)
 OBJECTS += $(obj)/head.o $(obj)/misc.o $(obj)/piggy.o
 
 LDFLAGS_vmlinux := --oformat $(LD_BFD) -e startup -T
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index 563ab9f..1736c7d 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -225,6 +225,7 @@ do {								\
 #define MMAP_ALIGN_MASK	(is_compat_task() ? 0 : 0x7fUL)
 #define STACK_RND_MASK	MMAP_RND_MASK
 
+/* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
 #define ARCH_DLINFO							    \
 do {									    \
 	if (vdso_enabled)						    \
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index ea1533e..48d383a 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -242,8 +242,8 @@ static inline int is_module_addr(void *addr)
  * swap				.11..ttttt.0
  * prot-none, clean, old	.11.xx0000.1
  * prot-none, clean, young	.11.xx0001.1
- * prot-none, dirty, old	.10.xx0010.1
- * prot-none, dirty, young	.10.xx0011.1
+ * prot-none, dirty, old	.11.xx0010.1
+ * prot-none, dirty, young	.11.xx0011.1
  * read-only, clean, old	.11.xx0100.1
  * read-only, clean, young	.01.xx0101.1
  * read-only, dirty, old	.11.xx0110.1
@@ -323,8 +323,8 @@ static inline int is_module_addr(void *addr)
 #define _SEGMENT_ENTRY_DIRTY	0x2000	/* SW segment dirty bit */
 #define _SEGMENT_ENTRY_YOUNG	0x1000	/* SW segment young bit */
 #define _SEGMENT_ENTRY_LARGE	0x0400	/* STE-format control, large page */
-#define _SEGMENT_ENTRY_READ	0x0002	/* SW segment read bit */
-#define _SEGMENT_ENTRY_WRITE	0x0001	/* SW segment write bit */
+#define _SEGMENT_ENTRY_WRITE	0x0002	/* SW segment write bit */
+#define _SEGMENT_ENTRY_READ	0x0001	/* SW segment read bit */
 
 #ifdef CONFIG_MEM_SOFT_DIRTY
 #define _SEGMENT_ENTRY_SOFT_DIRTY 0x4000 /* SW segment soft dirty bit */
@@ -335,15 +335,15 @@ static inline int is_module_addr(void *addr)
 /*
  * Segment table and region3 table entry encoding
  * (R = read-only, I = invalid, y = young bit):
- *				dy..R...I...rw
+ *				dy..R...I...wr
  * prot-none, clean, old	00..1...1...00
  * prot-none, clean, young	01..1...1...00
  * prot-none, dirty, old	10..1...1...00
  * prot-none, dirty, young	11..1...1...00
- * read-only, clean, old	00..1...1...10
- * read-only, clean, young	01..1...0...10
- * read-only, dirty, old	10..1...1...10
- * read-only, dirty, young	11..1...0...10
+ * read-only, clean, old	00..1...1...01
+ * read-only, clean, young	01..1...0...01
+ * read-only, dirty, old	10..1...1...01
+ * read-only, dirty, young	11..1...0...01
  * read-write, clean, old	00..1...1...11
  * read-write, clean, young	01..1...0...11
  * read-write, dirty, old	10..0...1...11
@@ -382,7 +382,7 @@ static inline int is_module_addr(void *addr)
 /*
  * Page protection definitions.
  */
-#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_INVALID)
+#define PAGE_NONE	__pgprot(_PAGE_PRESENT | _PAGE_INVALID | _PAGE_PROTECT)
 #define PAGE_READ	__pgprot(_PAGE_PRESENT | _PAGE_READ | \
 				 _PAGE_INVALID | _PAGE_PROTECT)
 #define PAGE_WRITE	__pgprot(_PAGE_PRESENT | _PAGE_READ | _PAGE_WRITE | \
diff --git a/arch/s390/include/uapi/asm/auxvec.h b/arch/s390/include/uapi/asm/auxvec.h
index a1f153e..c53e084 100644
--- a/arch/s390/include/uapi/asm/auxvec.h
+++ b/arch/s390/include/uapi/asm/auxvec.h
@@ -3,4 +3,6 @@
 
 #define AT_SYSINFO_EHDR		33
 
+#define AT_VECTOR_SIZE_ARCH 1 /* entries in ARCH_DLINFO */
+
 #endif
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index f37be37..3234817 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -4,6 +4,7 @@
 
 KCOV_INSTRUMENT_early.o := n
 KCOV_INSTRUMENT_sclp.o := n
+KCOV_INSTRUMENT_als.o := n
 
 ifdef CONFIG_FUNCTION_TRACER
 # Don't trace early setup code and tracing code
@@ -32,21 +33,25 @@ CFLAGS_ptrace.o		+= -DUTS_MACHINE='"$(UTS_MACHINE)"'
 CFLAGS_sysinfo.o += -w
 
 #
-# Use -march=z900 for sclp.c to be able to print an error message if
-# the kernel is started on a machine which is too old
+# Use -march=z900 for sclp.c and als.c to be able to print an error
+# message if the kernel is started on a machine which is too old
 #
 CFLAGS_REMOVE_sclp.o = $(CC_FLAGS_FTRACE)
+CFLAGS_REMOVE_als.o = $(CC_FLAGS_FTRACE)
 ifneq ($(CC_FLAGS_MARCH),-march=z900)
 CFLAGS_REMOVE_sclp.o	+= $(CC_FLAGS_MARCH)
 CFLAGS_sclp.o		+= -march=z900
+CFLAGS_REMOVE_als.o	+= $(CC_FLAGS_MARCH)
+CFLAGS_als.o		+= -march=z900
 AFLAGS_REMOVE_head.o	+= $(CC_FLAGS_MARCH)
 AFLAGS_head.o		+= -march=z900
 endif
 GCOV_PROFILE_sclp.o := n
+GCOV_PROFILE_als.o := n
 
 obj-y	:= traps.o time.o process.o base.o early.o setup.o idle.o vtime.o
 obj-y	+= processor.o sys_s390.o ptrace.o signal.o cpcmd.o ebcdic.o nmi.o
-obj-y	+= debug.o irq.o ipl.o dis.o diag.o sclp.o vdso.o
+obj-y	+= debug.o irq.o ipl.o dis.o diag.o sclp.o vdso.o als.o
 obj-y	+= sysinfo.o jump_label.o lgr.o os_info.o machine_kexec.o pgm_check.o
 obj-y	+= runtime_instr.o cache.o fpu.o dumpstack.o
 obj-y	+= entry.o reipl.o relocate_kernel.o
diff --git a/arch/s390/kernel/als.c b/arch/s390/kernel/als.c
new file mode 100644
index 0000000..a16e9d1
--- /dev/null
+++ b/arch/s390/kernel/als.c
@@ -0,0 +1,124 @@
+/*
+ *    Copyright IBM Corp. 2016
+ */
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <asm/processor.h>
+#include <asm/facility.h>
+#include <asm/lowcore.h>
+#include <asm/sclp.h>
+#include "entry.h"
+
+/*
+ * The code within this file will be called very early. It may _not_
+ * access anything within the bss section, since that is not cleared
+ * yet and may contain data (e.g. initrd) that must be saved by other
+ * code.
+ * For temporary objects the stack (16k) should be used.
+ */
+
+static unsigned long als[] __initdata = { FACILITIES_ALS };
+
+static void __init u16_to_hex(char *str, u16 val)
+{
+	int i, num;
+
+	for (i = 1; i <= 4; i++) {
+		num = (val >> (16 - 4 * i)) & 0xf;
+		if (num >= 10)
+			num += 7;
+		*str++ = '0' + num;
+	}
+	*str = '\0';
+}
+
+static void __init print_machine_type(void)
+{
+	static char mach_str[80] __initdata = "Detected machine-type number: ";
+	char type_str[5];
+	struct cpuid id;
+
+	get_cpu_id(&id);
+	u16_to_hex(type_str, id.machine);
+	strcat(mach_str, type_str);
+	_sclp_print_early(mach_str);
+}
+
+static void __init u16_to_decimal(char *str, u16 val)
+{
+	int div = 1;
+
+	while (div * 10 <= val)
+		div *= 10;
+	while (div) {
+		*str++ = '0' + val / div;
+		val %= div;
+		div /= 10;
+	}
+	*str = '\0';
+}
+
+static void __init print_missing_facilities(void)
+{
+	static char als_str[80] __initdata = "Missing facilities: ";
+	unsigned long val;
+	char val_str[6];
+	int i, j, first;
+
+	first = 1;
+	for (i = 0; i < ARRAY_SIZE(als); i++) {
+		val = ~S390_lowcore.stfle_fac_list[i] & als[i];
+		for (j = 0; j < BITS_PER_LONG; j++) {
+			if (!(val & (1UL << (BITS_PER_LONG - 1 - j))))
+				continue;
+			if (!first)
+				strcat(als_str, ",");
+			/*
+			 * Make sure we stay within one line. Consider that
+			 * each facility bit adds up to five characters and
+			 * z/VM adds a four character prefix.
+			 */
+			if (strlen(als_str) > 70) {
+				_sclp_print_early(als_str);
+				*als_str = '\0';
+			}
+			u16_to_decimal(val_str, i * BITS_PER_LONG + j);
+			strcat(als_str, val_str);
+			first = 0;
+		}
+	}
+	_sclp_print_early(als_str);
+	_sclp_print_early("See Principles of Operations for facility bits");
+}
+
+static void __init facility_mismatch(void)
+{
+	_sclp_print_early("The Linux kernel requires more recent processor hardware");
+	print_machine_type();
+	print_missing_facilities();
+	disabled_wait(0x8badcccc);
+}
+
+void __init verify_facilities(void)
+{
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(S390_lowcore.stfle_fac_list); i++)
+		S390_lowcore.stfle_fac_list[i] = 0;
+	asm volatile(
+		"	stfl	0(0)\n"
+		: "=m" (S390_lowcore.stfl_fac_list));
+	S390_lowcore.stfle_fac_list[0] = (u64)S390_lowcore.stfl_fac_list << 32;
+	if (S390_lowcore.stfl_fac_list & 0x01000000) {
+		register unsigned long reg0 asm("0") = ARRAY_SIZE(als) - 1;
+
+		asm volatile(".insn s,0xb2b00000,0(%1)" /* stfle */
+			     : "+d" (reg0)
+			     : "a" (&S390_lowcore.stfle_fac_list)
+			     : "memory", "cc");
+	}
+	for (i = 0; i < ARRAY_SIZE(als); i++) {
+		if ((S390_lowcore.stfle_fac_list[i] & als[i]) != als[i])
+			facility_mismatch();
+	}
+}
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index bedd2f5..e79f030 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -79,4 +79,6 @@ long sys_s390_pci_mmio_read(unsigned long, void __user *, size_t);
 
 DECLARE_PER_CPU(u64, mt_cycles[8]);
 
+void verify_facilities(void);
+
 #endif /* _ENTRY_H */
diff --git a/arch/s390/kernel/head.S b/arch/s390/kernel/head.S
index fcaefb0..56e4d82 100644
--- a/arch/s390/kernel/head.S
+++ b/arch/s390/kernel/head.S
@@ -306,49 +306,14 @@ ENTRY(startup_kdump)
 	stck	__LC_LAST_UPDATE_CLOCK
 	spt	6f-.LPG0(%r13)
 	mvc	__LC_LAST_UPDATE_TIMER(8),6f-.LPG0(%r13)
-	stfl	0(%r0)			# store facilities @ __LC_STFL_FAC_LIST
-	mvc	__LC_STFLE_FAC_LIST(4),__LC_STFL_FAC_LIST
-	tm	__LC_STFLE_FAC_LIST,0x01	# stfle available ?
-	jz	0f
-	lghi	%r0,FACILITIES_ALS_DWORDS-1
-	.insn	s,0xb2b00000,__LC_STFLE_FAC_LIST # store facility list extended
-	# verify if all required facilities are supported by the machine
-0:	la	%r1,__LC_STFLE_FAC_LIST
-	la	%r2,3f+8-.LPG0(%r13)
-	lhi	%r3,FACILITIES_ALS_DWORDS
-1:	lg	%r0,0(%r1)
-	ng	%r0,0(%r2)
-	clg	%r0,0(%r2)
-	jne	2f
-	la	%r1,8(%r1)
-	la	%r2,8(%r2)
-	ahi	%r3,-1
-	jnz	1b
-	j	4f
-2:	l	%r15,.Lstack-.LPG0(%r13)
+	l	%r15,.Lstack-.LPG0(%r13)
 	ahi	%r15,-STACK_FRAME_OVERHEAD
-	la	%r2,.Lals_string-.LPG0(%r13)
-	l	%r3,.Lsclp_print-.LPG0(%r13)
-	basr	%r14,%r3
-	lpsw	3f-.LPG0(%r13)		# machine type not good enough, crash
-.Lals_string:
-	.asciz	"The Linux kernel requires more recent processor hardware"
-.Lsclp_print:
-	.long	_sclp_print_early
-.Lstack:
-	.long	0x8000 + (1<<(PAGE_SHIFT+THREAD_ORDER))
-	.align 16
-3:	.long	0x000a0000,0x8badcccc
-
-# List of facilities that are required. If not all facilities are present
-# the kernel will crash.
-
-	.quad FACILITIES_ALS
-
-4:
+	brasl	%r14,verify_facilities
 	/* Continue with startup code in head64.S */
 	jg	startup_continue
 
+.Lstack:
+	.long	0x8000 + (1<<(PAGE_SHIFT+THREAD_ORDER))
 	.align	8
 6:	.long	0x7fffffff,0xffffffff
 
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index 250f597..dd6306c 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -690,6 +690,15 @@ int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
 	stack = (unsigned long) regs->gprs[15];
 
 	memcpy(kcb->jprobes_stack, (void *) stack, MIN_STACK_SIZE(stack));
+
+	/*
+	 * jprobes use jprobe_return() which skips the normal return
+	 * path of the function, and this messes up the accounting of the
+	 * function graph tracer to get messed up.
+	 *
+	 * Pause function graph tracing while performing the jprobe function.
+	 */
+	pause_graph_tracing();
 	return 1;
 }
 NOKPROBE_SYMBOL(setjmp_pre_handler);
@@ -705,6 +714,9 @@ int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 	unsigned long stack;
 
+	/* It's OK to start function graph tracing again */
+	unpause_graph_tracing();
+
 	stack = (unsigned long) kcb->jprobe_saved_regs.gprs[15];
 
 	/* Put the regs back */
diff --git a/arch/s390/kernel/sclp.c b/arch/s390/kernel/sclp.c
index d88db40..f08af67 100644
--- a/arch/s390/kernel/sclp.c
+++ b/arch/s390/kernel/sclp.c
@@ -12,8 +12,9 @@
 #define EVTYP_VT220MSG_MASK	0x00000040
 #define EVTYP_MSG_MASK		0x40000000
 
-static char _sclp_work_area[4096] __aligned(PAGE_SIZE);
-static bool have_vt220, have_linemode;
+static char _sclp_work_area[4096] __aligned(PAGE_SIZE) __section(data);
+static bool have_vt220 __section(data);
+static bool have_linemode __section(data);
 
 static void _sclp_wait_int(void)
 {
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index e19d853..cd404aa 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -11,6 +11,12 @@
 #include <linux/mm.h>
 #include <linux/hugetlb.h>
 
+/*
+ * If the bit selected by single-bit bitmask "a" is set within "x", move
+ * it to the position indicated by single-bit bitmask "b".
+ */
+#define move_set_bit(x, a, b)	(((x) & (a)) >> ilog2(a) << ilog2(b))
+
 static inline unsigned long __pte_to_rste(pte_t pte)
 {
 	unsigned long rste;
@@ -37,13 +43,22 @@ static inline unsigned long __pte_to_rste(pte_t pte)
 	 */
 	if (pte_present(pte)) {
 		rste = pte_val(pte) & PAGE_MASK;
-		rste |= (pte_val(pte) & _PAGE_READ) >> 4;
-		rste |= (pte_val(pte) & _PAGE_WRITE) >> 4;
-		rste |= (pte_val(pte) & _PAGE_INVALID) >> 5;
-		rste |= (pte_val(pte) & _PAGE_PROTECT);
-		rste |= (pte_val(pte) & _PAGE_DIRTY) << 10;
-		rste |= (pte_val(pte) & _PAGE_YOUNG) << 10;
-		rste |= (pte_val(pte) & _PAGE_SOFT_DIRTY) << 13;
+		rste |= move_set_bit(pte_val(pte), _PAGE_READ,
+				     _SEGMENT_ENTRY_READ);
+		rste |= move_set_bit(pte_val(pte), _PAGE_WRITE,
+				     _SEGMENT_ENTRY_WRITE);
+		rste |= move_set_bit(pte_val(pte), _PAGE_INVALID,
+				     _SEGMENT_ENTRY_INVALID);
+		rste |= move_set_bit(pte_val(pte), _PAGE_PROTECT,
+				     _SEGMENT_ENTRY_PROTECT);
+		rste |= move_set_bit(pte_val(pte), _PAGE_DIRTY,
+				     _SEGMENT_ENTRY_DIRTY);
+		rste |= move_set_bit(pte_val(pte), _PAGE_YOUNG,
+				     _SEGMENT_ENTRY_YOUNG);
+#ifdef CONFIG_MEM_SOFT_DIRTY
+		rste |= move_set_bit(pte_val(pte), _PAGE_SOFT_DIRTY,
+				     _SEGMENT_ENTRY_SOFT_DIRTY);
+#endif
 	} else
 		rste = _SEGMENT_ENTRY_INVALID;
 	return rste;
@@ -82,13 +97,22 @@ static inline pte_t __rste_to_pte(unsigned long rste)
 	if (present) {
 		pte_val(pte) = rste & _SEGMENT_ENTRY_ORIGIN_LARGE;
 		pte_val(pte) |= _PAGE_LARGE | _PAGE_PRESENT;
-		pte_val(pte) |= (rste & _SEGMENT_ENTRY_READ) << 4;
-		pte_val(pte) |= (rste & _SEGMENT_ENTRY_WRITE) << 4;
-		pte_val(pte) |= (rste & _SEGMENT_ENTRY_INVALID) << 5;
-		pte_val(pte) |= (rste & _SEGMENT_ENTRY_PROTECT);
-		pte_val(pte) |= (rste & _SEGMENT_ENTRY_DIRTY) >> 10;
-		pte_val(pte) |= (rste & _SEGMENT_ENTRY_YOUNG) >> 10;
-		pte_val(pte) |= (rste & _SEGMENT_ENTRY_SOFT_DIRTY) >> 13;
+		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_READ,
+					     _PAGE_READ);
+		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_WRITE,
+					     _PAGE_WRITE);
+		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_INVALID,
+					     _PAGE_INVALID);
+		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_PROTECT,
+					     _PAGE_PROTECT);
+		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_DIRTY,
+					     _PAGE_DIRTY);
+		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_YOUNG,
+					     _PAGE_YOUNG);
+#ifdef CONFIG_MEM_SOFT_DIRTY
+		pte_val(pte) |= move_set_bit(rste, _SEGMENT_ENTRY_SOFT_DIRTY,
+					     _PAGE_DIRTY);
+#endif
 	} else
 		pte_val(pte) = _PAGE_INVALID;
 	return pte;
diff --git a/arch/s390/numa/mode_emu.c b/arch/s390/numa/mode_emu.c
index fbc394e..37e0bb8 100644
--- a/arch/s390/numa/mode_emu.c
+++ b/arch/s390/numa/mode_emu.c
@@ -482,8 +482,12 @@ static int emu_setup_nodes_adjust(int nodes)
  */
 static void emu_setup(void)
 {
+	int nid;
+
 	emu_size = emu_setup_size_adjust(emu_size);
 	emu_nodes = emu_setup_nodes_adjust(emu_nodes);
+	for (nid = 0; nid < emu_nodes; nid++)
+		node_set(nid, node_possible_map);
 	pr_info("Creating %d nodes with memory stripe size %ld MB\n",
 		emu_nodes, emu_size >> 20);
 }
diff --git a/arch/s390/numa/numa.c b/arch/s390/numa/numa.c
index 2794845..f576f10 100644
--- a/arch/s390/numa/numa.c
+++ b/arch/s390/numa/numa.c
@@ -26,8 +26,14 @@ EXPORT_SYMBOL(node_data);
 cpumask_t node_to_cpumask_map[MAX_NUMNODES];
 EXPORT_SYMBOL(node_to_cpumask_map);
 
+static void plain_setup(void)
+{
+	node_set(0, node_possible_map);
+}
+
 const struct numa_mode numa_mode_plain = {
 	.name = "plain",
+	.setup = plain_setup,
 };
 
 static const struct numa_mode *mode = &numa_mode_plain;
@@ -126,13 +132,13 @@ static void __init numa_setup_memory(void)
 void __init numa_setup(void)
 {
 	pr_info("NUMA mode: %s\n", mode->name);
+	nodes_clear(node_possible_map);
 	if (mode->setup)
 		mode->setup();
 	numa_setup_memory();
 	memblock_dump_all();
 }
 
-
 /*
  * numa_init_early() - Initialization initcall
  *
diff --git a/arch/s390/tools/gen_facilities.c b/arch/s390/tools/gen_facilities.c
index e2660d2..fe4e6c9 100644
--- a/arch/s390/tools/gen_facilities.c
+++ b/arch/s390/tools/gen_facilities.c
@@ -39,7 +39,6 @@ static void print_facility_list(struct facility_def *def)
 	printf("#define %s ", def->name);
 	for (i = 0; i <= high; i++)
 		printf("_AC(0x%016llx,UL)%c", array[i], i < high ? ',' : '\n');
-	printf("#define %s_DWORDS %d\n", def->name, high + 1);
 	free(array);
 }
 
diff --git a/drivers/s390/cio/chp.c b/drivers/s390/cio/chp.c
index e96aced..46be25c 100644
--- a/drivers/s390/cio/chp.c
+++ b/drivers/s390/cio/chp.c
@@ -37,8 +37,7 @@ enum cfg_task_t {
 
 /* Map for pending configure tasks. */
 static enum cfg_task_t chp_cfg_task[__MAX_CSSID + 1][__MAX_CHPID + 1];
-static DEFINE_MUTEX(cfg_lock);
-static int cfg_busy;
+static DEFINE_SPINLOCK(cfg_lock);
 
 /* Map for channel-path status. */
 static struct sclp_chp_info chp_info;
@@ -666,6 +665,20 @@ static void cfg_set_task(struct chp_id chpid, enum cfg_task_t cfg)
 	chp_cfg_task[chpid.cssid][chpid.id] = cfg;
 }
 
+/* Fetch the first configure task. Set chpid accordingly. */
+static enum cfg_task_t chp_cfg_fetch_task(struct chp_id *chpid)
+{
+	enum cfg_task_t t = cfg_none;
+
+	chp_id_for_each(chpid) {
+		t = cfg_get_task(*chpid);
+		if (t != cfg_none)
+			break;
+	}
+
+	return t;
+}
+
 /* Perform one configure/deconfigure request. Reschedule work function until
  * last request. */
 static void cfg_func(struct work_struct *work)
@@ -674,16 +687,9 @@ static void cfg_func(struct work_struct *work)
 	enum cfg_task_t t;
 	int rc;
 
-	mutex_lock(&cfg_lock);
-	t = cfg_none;
-	chp_id_for_each(&chpid) {
-		t = cfg_get_task(chpid);
-		if (t != cfg_none) {
-			cfg_set_task(chpid, cfg_none);
-			break;
-		}
-	}
-	mutex_unlock(&cfg_lock);
+	spin_lock(&cfg_lock);
+	t = chp_cfg_fetch_task(&chpid);
+	spin_unlock(&cfg_lock);
 
 	switch (t) {
 	case cfg_configure:
@@ -709,12 +715,13 @@ static void cfg_func(struct work_struct *work)
 	case cfg_none:
 		/* Get updated information after last change. */
 		info_update();
-		mutex_lock(&cfg_lock);
-		cfg_busy = 0;
-		mutex_unlock(&cfg_lock);
 		wake_up_interruptible(&cfg_wait_queue);
 		return;
 	}
+	spin_lock(&cfg_lock);
+	if (t == cfg_get_task(chpid))
+		cfg_set_task(chpid, cfg_none);
+	spin_unlock(&cfg_lock);
 	schedule_work(&cfg_work);
 }
 
@@ -729,10 +736,9 @@ void chp_cfg_schedule(struct chp_id chpid, int configure)
 {
 	CIO_MSG_EVENT(2, "chp_cfg_sched%x.%02x=%d\n", chpid.cssid, chpid.id,
 		      configure);
-	mutex_lock(&cfg_lock);
+	spin_lock(&cfg_lock);
 	cfg_set_task(chpid, configure ? cfg_configure : cfg_deconfigure);
-	cfg_busy = 1;
-	mutex_unlock(&cfg_lock);
+	spin_unlock(&cfg_lock);
 	schedule_work(&cfg_work);
 }
 
@@ -746,15 +752,27 @@ void chp_cfg_schedule(struct chp_id chpid, int configure)
 void chp_cfg_cancel_deconfigure(struct chp_id chpid)
 {
 	CIO_MSG_EVENT(2, "chp_cfg_cancel:%x.%02x\n", chpid.cssid, chpid.id);
-	mutex_lock(&cfg_lock);
+	spin_lock(&cfg_lock);
 	if (cfg_get_task(chpid) == cfg_deconfigure)
 		cfg_set_task(chpid, cfg_none);
-	mutex_unlock(&cfg_lock);
+	spin_unlock(&cfg_lock);
+}
+
+static bool cfg_idle(void)
+{
+	struct chp_id chpid;
+	enum cfg_task_t t;
+
+	spin_lock(&cfg_lock);
+	t = chp_cfg_fetch_task(&chpid);
+	spin_unlock(&cfg_lock);
+
+	return t == cfg_none;
 }
 
 static int cfg_wait_idle(void)
 {
-	if (wait_event_interruptible(cfg_wait_queue, !cfg_busy))
+	if (wait_event_interruptible(cfg_wait_queue, cfg_idle()))
 		return -ERESTARTSYS;
 	return 0;
 }
diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index 4feb272..ed92fb0 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -468,6 +468,8 @@ int ap_recv(ap_qid_t qid, unsigned long long *psmid, void *msg, size_t length)
 {
 	struct ap_queue_status status;
 
+	if (msg == NULL)
+		return -EINVAL;
 	status = __ap_recv(qid, psmid, msg, length);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
@@ -617,6 +619,8 @@ static enum ap_wait ap_sm_read(struct ap_device *ap_dev)
 {
 	struct ap_queue_status status;
 
+	if (!ap_dev->reply)
+		return AP_WAIT_NONE;
 	status = ap_sm_recv(ap_dev);
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
@@ -638,6 +642,31 @@ static enum ap_wait ap_sm_read(struct ap_device *ap_dev)
 }
 
 /**
+ * ap_sm_suspend_read(): Receive pending reply messages from an AP device
+ * without changing the device state in between. In suspend mode we don't
+ * allow sending new requests, therefore just fetch pending replies.
+ * @ap_dev: pointer to the AP device
+ *
+ * Returns AP_WAIT_NONE or AP_WAIT_AGAIN
+ */
+static enum ap_wait ap_sm_suspend_read(struct ap_device *ap_dev)
+{
+	struct ap_queue_status status;
+
+	if (!ap_dev->reply)
+		return AP_WAIT_NONE;
+	status = ap_sm_recv(ap_dev);
+	switch (status.response_code) {
+	case AP_RESPONSE_NORMAL:
+		if (ap_dev->queue_count > 0)
+			return AP_WAIT_AGAIN;
+		/* fall through */
+	default:
+		return AP_WAIT_NONE;
+	}
+}
+
+/**
  * ap_sm_write(): Send messages from the request queue to an AP device.
  * @ap_dev: pointer to the AP device
  *
@@ -738,7 +767,7 @@ static enum ap_wait ap_sm_reset_wait(struct ap_device *ap_dev)
 	struct ap_queue_status status;
 	unsigned long info;
 
-	if (ap_dev->queue_count > 0)
+	if (ap_dev->queue_count > 0 && ap_dev->reply)
 		/* Try to read a completed message and get the status */
 		status = ap_sm_recv(ap_dev);
 	else
@@ -778,7 +807,7 @@ static enum ap_wait ap_sm_setirq_wait(struct ap_device *ap_dev)
 	struct ap_queue_status status;
 	unsigned long info;
 
-	if (ap_dev->queue_count > 0)
+	if (ap_dev->queue_count > 0 && ap_dev->reply)
 		/* Try to read a completed message and get the status */
 		status = ap_sm_recv(ap_dev);
 	else
@@ -834,7 +863,7 @@ static ap_func_t *ap_jumptable[NR_AP_STATES][NR_AP_EVENTS] = {
 		[AP_EVENT_TIMEOUT] = ap_sm_reset,
 	},
 	[AP_STATE_SUSPEND_WAIT] = {
-		[AP_EVENT_POLL] = ap_sm_read,
+		[AP_EVENT_POLL] = ap_sm_suspend_read,
 		[AP_EVENT_TIMEOUT] = ap_sm_nop,
 	},
 	[AP_STATE_BORKED] = {
@@ -1335,6 +1364,17 @@ static struct bus_type ap_bus_type = {
 	.resume = ap_dev_resume,
 };
 
+void ap_device_init_reply(struct ap_device *ap_dev,
+			  struct ap_message *reply)
+{
+	ap_dev->reply = reply;
+
+	spin_lock_bh(&ap_dev->lock);
+	ap_sm_wait(ap_sm_event(ap_dev, AP_EVENT_POLL));
+	spin_unlock_bh(&ap_dev->lock);
+}
+EXPORT_SYMBOL(ap_device_init_reply);
+
 static int ap_device_probe(struct device *dev)
 {
 	struct ap_device *ap_dev = to_ap_dev(dev);
@@ -1779,7 +1819,8 @@ int __init ap_module_init(void)
 	if (ap_domain_index < -1 || ap_domain_index > max_domain_id) {
 		pr_warn("%d is not a valid cryptographic domain\n",
 			ap_domain_index);
-		return -EINVAL;
+		rc = -EINVAL;
+		goto out_free;
 	}
 	/* In resume callback we need to know if the user had set the domain.
 	 * If so, we can not just reset it.
@@ -1852,6 +1893,7 @@ out:
 	unregister_reset_call(&ap_reset_call);
 	if (ap_using_interrupts())
 		unregister_adapter_interrupt(&ap_airq);
+out_free:
 	kfree(ap_configuration);
 	return rc;
 }
diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
index 6adcbdf..d7fdf5c 100644
--- a/drivers/s390/crypto/ap_bus.h
+++ b/drivers/s390/crypto/ap_bus.h
@@ -262,6 +262,7 @@ void ap_queue_message(struct ap_device *ap_dev, struct ap_message *ap_msg);
 void ap_cancel_message(struct ap_device *ap_dev, struct ap_message *ap_msg);
 void ap_flush_queue(struct ap_device *ap_dev);
 void ap_bus_force_rescan(void);
+void ap_device_init_reply(struct ap_device *ap_dev, struct ap_message *ap_msg);
 
 int ap_module_init(void);
 void ap_module_exit(void);
diff --git a/drivers/s390/crypto/zcrypt_cex2a.c b/drivers/s390/crypto/zcrypt_cex2a.c
index 1e849d6..15104aa 100644
--- a/drivers/s390/crypto/zcrypt_cex2a.c
+++ b/drivers/s390/crypto/zcrypt_cex2a.c
@@ -126,7 +126,7 @@ static int zcrypt_cex2a_probe(struct ap_device *ap_dev)
 					   MSGTYPE50_VARIANT_DEFAULT);
 	zdev->ap_dev = ap_dev;
 	zdev->online = 1;
-	ap_dev->reply = &zdev->reply;
+	ap_device_init_reply(ap_dev, &zdev->reply);
 	ap_dev->private = zdev;
 	rc = zcrypt_device_register(zdev);
 	if (rc) {
diff --git a/drivers/s390/crypto/zcrypt_cex4.c b/drivers/s390/crypto/zcrypt_cex4.c
index bb39088..ccb2e78 100644
--- a/drivers/s390/crypto/zcrypt_cex4.c
+++ b/drivers/s390/crypto/zcrypt_cex4.c
@@ -147,7 +147,7 @@ static int zcrypt_cex4_probe(struct ap_device *ap_dev)
 		return -ENODEV;
 	zdev->ap_dev = ap_dev;
 	zdev->online = 1;
-	ap_dev->reply = &zdev->reply;
+	ap_device_init_reply(ap_dev, &zdev->reply);
 	ap_dev->private = zdev;
 	rc = zcrypt_device_register(zdev);
 	if (rc) {
diff --git a/drivers/s390/crypto/zcrypt_pcixcc.c b/drivers/s390/crypto/zcrypt_pcixcc.c
index f418527..df8f0c4 100644
--- a/drivers/s390/crypto/zcrypt_pcixcc.c
+++ b/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -327,7 +327,7 @@ static int zcrypt_pcixcc_probe(struct ap_device *ap_dev)
 	else
 		zdev->ops = zcrypt_msgtype_request(MSGTYPE06_NAME,
 						   MSGTYPE06_VARIANT_NORNG);
-	ap_dev->reply = &zdev->reply;
+	ap_device_init_reply(ap_dev, &zdev->reply);
 	ap_dev->private = zdev;
 	rc = zcrypt_device_register(zdev);
 	if (rc)
