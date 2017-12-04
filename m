Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 4/6] s390/uapi: correct whitespace & coding style in asm/ptrace.h
Date: Mon,  4 Dec 2017 10:56:47 +0100
In-Reply-To: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
Message-Id: <1512381409-19775-5-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Correct whitespace and coding style issues in the s390 asm/ptrace.h
uapi header file.  This is preparatory work to copy it to the tools/
directory for inclusion by selftests and perf.

Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
---
 arch/s390/include/uapi/asm/ptrace.h | 118 ++++++++++++++++--------------------
 1 file changed, 52 insertions(+), 66 deletions(-)

diff --git a/arch/s390/include/uapi/asm/ptrace.h b/arch/s390/include/uapi/asm/ptrace.h
index 70f7cb2..543dd70 100644
--- a/arch/s390/include/uapi/asm/ptrace.h
+++ b/arch/s390/include/uapi/asm/ptrace.h
@@ -162,7 +162,7 @@
 #define GPR_SIZE	8
 #define CR_SIZE		8
 
-#define STACK_FRAME_OVERHEAD    160      /* size of minimum stack frame */
+#define STACK_FRAME_OVERHEAD	160	 /* size of minimum stack frame */
 
 #endif /* __s390x__ */
 
@@ -179,17 +179,16 @@
 #define ACR_SIZE	4
 
 
-#define PTRACE_OLDSETOPTIONS         21
+#define PTRACE_OLDSETOPTIONS	     21
 
 #ifndef __ASSEMBLY__
 #include <linux/stddef.h>
 #include <linux/types.h>
 
-typedef union
-{
-	float   f;
-	double  d;
-        __u64   ui;
+typedef union {
+	float	f;
+	double	d;
+	__u64	ui;
 	struct
 	{
 		__u32 hi;
@@ -197,23 +196,21 @@
 	} fp;
 } freg_t;
 
-typedef struct
-{
-	__u32   fpc;
+typedef struct {
+	__u32	fpc;
 	__u32	pad;
-	freg_t  fprs[NUM_FPRS];              
+	freg_t	fprs[NUM_FPRS];
 } s390_fp_regs;
 
-#define FPC_EXCEPTION_MASK      0xF8000000
-#define FPC_FLAGS_MASK          0x00F80000
-#define FPC_DXC_MASK            0x0000FF00
-#define FPC_RM_MASK             0x00000003
+#define FPC_EXCEPTION_MASK	0xF8000000
+#define FPC_FLAGS_MASK		0x00F80000
+#define FPC_DXC_MASK		0x0000FF00
+#define FPC_RM_MASK		0x00000003
 
 /* this typedef defines how a Program Status Word looks like */
-typedef struct 
-{
-        unsigned long mask;
-        unsigned long addr;
+typedef struct {
+	unsigned long mask;
+	unsigned long addr;
 } __attribute__ ((aligned(8))) psw_t;
 
 #ifndef __s390x__
@@ -282,8 +279,7 @@
 /*
  * The s390_regs structure is used to define the elf_gregset_t.
  */
-typedef struct
-{
+typedef struct {
 	psw_t psw;
 	unsigned long gprs[NUM_GPRS];
 	unsigned int  acrs[NUM_ACRS];
@@ -294,8 +290,7 @@
  * The user_pt_regs structure exports the beginning of
  * the in-kernel pt_regs structure to user space.
  */
-typedef struct
-{
+typedef struct {
 	unsigned long args[1];
 	psw_t psw;
 	unsigned long gprs[NUM_GPRS];
@@ -307,19 +302,17 @@
  * touch or even look at it if you don't want to modify the user-space
  * ptrace interface. In particular stay away from it for in-kernel PER.
  */
-typedef struct
-{
+typedef struct {
 	unsigned long cr[NUM_CR_WORDS];
 } per_cr_words;
 
 #define PER_EM_MASK 0xE8000000UL
 
-typedef	struct
-{
+typedef struct {
 #ifdef __s390x__
-	unsigned                       : 32;
+	unsigned		       : 32;
 #endif /* __s390x__ */
-	unsigned em_branching          : 1;
+	unsigned em_branching	       : 1;
 	unsigned em_instruction_fetch  : 1;
 	/*
 	 * Switching on storage alteration automatically fixes
@@ -328,44 +321,41 @@
 	unsigned em_storage_alteration : 1;
 	unsigned em_gpr_alt_unused     : 1;
 	unsigned em_store_real_address : 1;
-	unsigned                       : 3;
+	unsigned		       : 3;
 	unsigned branch_addr_ctl       : 1;
-	unsigned                       : 1;
+	unsigned		       : 1;
 	unsigned storage_alt_space_ctl : 1;
-	unsigned                       : 21;
+	unsigned		       : 21;
 	unsigned long starting_addr;
 	unsigned long ending_addr;
 } per_cr_bits;
 
-typedef struct
-{
+typedef struct {
 	unsigned short perc_atmid;
 	unsigned long address;
 	unsigned char access_id;
 } per_lowcore_words;
 
-typedef struct
-{
-	unsigned perc_branching          : 1;
+typedef struct {
+	unsigned perc_branching		 : 1;
 	unsigned perc_instruction_fetch  : 1;
 	unsigned perc_storage_alteration : 1;
-	unsigned perc_gpr_alt_unused     : 1;
+	unsigned perc_gpr_alt_unused	 : 1;
 	unsigned perc_store_real_address : 1;
-	unsigned                         : 3;
-	unsigned atmid_psw_bit_31        : 1;
-	unsigned atmid_validity_bit      : 1;
-	unsigned atmid_psw_bit_32        : 1;
-	unsigned atmid_psw_bit_5         : 1;
-	unsigned atmid_psw_bit_16        : 1;
-	unsigned atmid_psw_bit_17        : 1;
-	unsigned si                      : 2;
+	unsigned			 : 3;
+	unsigned atmid_psw_bit_31	 : 1;
+	unsigned atmid_validity_bit	 : 1;
+	unsigned atmid_psw_bit_32	 : 1;
+	unsigned atmid_psw_bit_5	 : 1;
+	unsigned atmid_psw_bit_16	 : 1;
+	unsigned atmid_psw_bit_17	 : 1;
+	unsigned si			 : 2;
 	unsigned long address;
-	unsigned                         : 4;
-	unsigned access_id               : 4;
+	unsigned			 : 4;
+	unsigned access_id		 : 4;
 } per_lowcore_bits;
 
-typedef struct
-{
+typedef struct {
 	union {
 		per_cr_words   words;
 		per_cr_bits    bits;
@@ -375,9 +365,9 @@
 	 * the kernel always sets them to zero. To enable single
 	 * stepping use ptrace(PTRACE_SINGLESTEP) instead.
 	 */
-	unsigned  single_step       : 1;
+	unsigned  single_step	    : 1;
 	unsigned  instruction_fetch : 1;
-	unsigned                    : 30;
+	unsigned		    : 30;
 	/*
 	 * These addresses are copied into cr10 & cr11 if single
 	 * stepping is switched off
@@ -387,11 +377,10 @@
 	union {
 		per_lowcore_words words;
 		per_lowcore_bits  bits;
-	} lowcore; 
+	} lowcore;
 } per_struct;
 
-typedef struct
-{
+typedef struct {
 	unsigned int  len;
 	unsigned long kernel_addr;
 	unsigned long process_addr;
@@ -401,12 +390,12 @@
  * S/390 specific non posix ptrace requests. I chose unusual values so
  * they are unlikely to clash with future ptrace definitions.
  */
-#define PTRACE_PEEKUSR_AREA           0x5000
-#define PTRACE_POKEUSR_AREA           0x5001
+#define PTRACE_PEEKUSR_AREA	      0x5000
+#define PTRACE_POKEUSR_AREA	      0x5001
 #define PTRACE_PEEKTEXT_AREA	      0x5002
 #define PTRACE_PEEKDATA_AREA	      0x5003
 #define PTRACE_POKETEXT_AREA	      0x5004
-#define PTRACE_POKEDATA_AREA 	      0x5005
+#define PTRACE_POKEDATA_AREA	      0x5005
 #define PTRACE_GET_LAST_BREAK	      0x5006
 #define PTRACE_PEEK_SYSTEM_CALL       0x5007
 #define PTRACE_POKE_SYSTEM_CALL	      0x5008
@@ -424,21 +413,19 @@
  * PT_PROT definition is loosely based on hppa bsd definition in
  * gdb/hppab-nat.c
  */
-#define PTRACE_PROT                       21
+#define PTRACE_PROT			  21
 
-typedef enum
-{
+typedef enum {
 	ptprot_set_access_watchpoint,
 	ptprot_set_write_watchpoint,
 	ptprot_disable_watchpoint
 } ptprot_flags;
 
-typedef struct
-{
+typedef struct {
 	unsigned long lowaddr;
 	unsigned long hiaddr;
 	ptprot_flags prot;
-} ptprot_area;                     
+} ptprot_area;
 
 /* Sequence of bytes for breakpoint illegal instruction.  */
 #define S390_BREAKPOINT     {0x0,0x1}
@@ -450,8 +437,7 @@
  * The user_regs_struct defines the way the user registers are
  * store on the stack for signal handling.
  */
-struct user_regs_struct
-{
+struct user_regs_struct {
 	psw_t psw;
 	unsigned long gprs[NUM_GPRS];
 	unsigned int  acrs[NUM_ACRS];
-- 
1.8.3.1
