Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 01/18] x86/asm/head: clean up initial stack variable
Date: Thu, 28 Apr 2016 15:44:32 -0500
Message-Id: <0c0ab06535c7d742acf728abfb8fef15da2d3192.1461875890.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1461875890.git.jpoimboe@redhat.com>
References: <cover.1461875890.git.jpoimboe@redhat.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: live-patching@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

The stack_start variable is similar in usage to initial_code and
initial_gs: they're all stored in head_64.S and they're all updated by
SMP and suspend/resume before starting a CPU.

Rename stack_start to initial_stack to be more consistent with the
others.

Also do a few other related cleanups:

- Remove the unused init_rsp variable declaration.

- Remove the ".word 0" statement after the initial_stack definition
  because it has no apparent function.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/include/asm/realmode.h |  2 +-
 arch/x86/include/asm/smp.h      |  3 ---
 arch/x86/kernel/acpi/sleep.c    |  2 +-
 arch/x86/kernel/head_32.S       |  8 ++++----
 arch/x86/kernel/head_64.S       | 10 ++++------
 arch/x86/kernel/smpboot.c       |  2 +-
 6 files changed, 11 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/realmode.h b/arch/x86/include/asm/realmode.h
index 9c6b890..677a671 100644
--- a/arch/x86/include/asm/realmode.h
+++ b/arch/x86/include/asm/realmode.h
@@ -44,9 +44,9 @@ struct trampoline_header {
 extern struct real_mode_header *real_mode_header;
 extern unsigned char real_mode_blob_end[];
 
-extern unsigned long init_rsp;
 extern unsigned long initial_code;
 extern unsigned long initial_gs;
+extern unsigned long initial_stack;
 
 extern unsigned char real_mode_blob[];
 extern unsigned char real_mode_relocs[];
diff --git a/arch/x86/include/asm/smp.h b/arch/x86/include/asm/smp.h
index 66b0573..a9ac31b 100644
--- a/arch/x86/include/asm/smp.h
+++ b/arch/x86/include/asm/smp.h
@@ -38,9 +38,6 @@ DECLARE_EARLY_PER_CPU_READ_MOSTLY(u16, x86_bios_cpu_apicid);
 DECLARE_EARLY_PER_CPU_READ_MOSTLY(int, x86_cpu_to_logical_apicid);
 #endif
 
-/* Static state in head.S used to set up a CPU */
-extern unsigned long stack_start; /* Initial stack pointer address */
-
 struct task_struct;
 
 struct smp_ops {
diff --git a/arch/x86/kernel/acpi/sleep.c b/arch/x86/kernel/acpi/sleep.c
index adb3eaf..4858733 100644
--- a/arch/x86/kernel/acpi/sleep.c
+++ b/arch/x86/kernel/acpi/sleep.c
@@ -99,7 +99,7 @@ int x86_acpi_suspend_lowlevel(void)
 	saved_magic = 0x12345678;
 #else /* CONFIG_64BIT */
 #ifdef CONFIG_SMP
-	stack_start = (unsigned long)temp_stack + sizeof(temp_stack);
+	initial_stack = (unsigned long)temp_stack + sizeof(temp_stack);
 	early_gdt_descr.address =
 			(unsigned long)get_cpu_gdt_table(smp_processor_id());
 	initial_gs = per_cpu_offset(smp_processor_id());
diff --git a/arch/x86/kernel/head_32.S b/arch/x86/kernel/head_32.S
index 6770865..da840be 100644
--- a/arch/x86/kernel/head_32.S
+++ b/arch/x86/kernel/head_32.S
@@ -94,7 +94,7 @@ RESERVE_BRK(pagetables, INIT_MAP_SIZE)
  */
 __HEAD
 ENTRY(startup_32)
-	movl pa(stack_start),%ecx
+	movl pa(initial_stack),%ecx
 	
 	/* test KEEP_SEGMENTS flag to see if the bootloader is asking
 		us to not reload segments */
@@ -286,7 +286,7 @@ num_subarch_entries = (. - subarch_entries) / 4
  * start_secondary().
  */
 ENTRY(start_cpu0)
-	movl stack_start, %ecx
+	movl initial_stack, %ecx
 	movl %ecx, %esp
 	jmp  *(initial_code)
 ENDPROC(start_cpu0)
@@ -307,7 +307,7 @@ ENTRY(startup_32_smp)
 	movl %eax,%es
 	movl %eax,%fs
 	movl %eax,%gs
-	movl pa(stack_start),%ecx
+	movl pa(initial_stack),%ecx
 	movl %eax,%ss
 	leal -__PAGE_OFFSET(%ecx),%esp
 
@@ -709,7 +709,7 @@ ENTRY(initial_page_table)
 
 .data
 .balign 4
-ENTRY(stack_start)
+ENTRY(initial_stack)
 	.long init_thread_union+THREAD_SIZE
 
 __INITRODATA
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 5df831e..792c3bb 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -226,7 +226,7 @@ ENTRY(secondary_startup_64)
 	movq	%rax, %cr0
 
 	/* Setup a boot time stack */
-	movq stack_start(%rip), %rsp
+	movq initial_stack(%rip), %rsp
 
 	/* zero EFLAGS after setting rsp */
 	pushq $0
@@ -309,7 +309,7 @@ ENTRY(secondary_startup_64)
  * start_secondary().
  */
 ENTRY(start_cpu0)
-	movq stack_start(%rip),%rsp
+	movq initial_stack(%rip),%rsp
 	movq	initial_code(%rip),%rax
 	pushq	$0		# fake return address to stop unwinder
 	pushq	$__KERNEL_CS	# set correct cs
@@ -318,17 +318,15 @@ ENTRY(start_cpu0)
 ENDPROC(start_cpu0)
 #endif
 
-	/* SMP bootup changes these two */
+	/* SMP bootup changes these variables */
 	__REFDATA
 	.balign	8
 	GLOBAL(initial_code)
 	.quad	x86_64_start_kernel
 	GLOBAL(initial_gs)
 	.quad	INIT_PER_CPU_VAR(irq_stack_union)
-
-	GLOBAL(stack_start)
+	GLOBAL(initial_stack)
 	.quad  init_thread_union+THREAD_SIZE-8
-	.word  0
 	__FINITDATA
 
 bad_address:
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 1fe4130..503682a 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -950,7 +950,7 @@ static int do_boot_cpu(int apicid, int cpu, struct task_struct *idle)
 
 	early_gdt_descr.address = (unsigned long)get_cpu_gdt_table(cpu);
 	initial_code = (unsigned long)start_secondary;
-	stack_start  = idle->thread.sp;
+	initial_stack  = idle->thread.sp;
 
 	/*
 	 * Enable the espfix hack for this CPU
-- 
2.4.11
