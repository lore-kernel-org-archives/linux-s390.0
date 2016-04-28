Return-Path: <jpoimboe@redhat.com>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [RFC PATCH v2 02/18] x86/asm/head: use a common function for starting
 CPUs
Date: Thu, 28 Apr 2016 15:44:33 -0500
Message-Id: <b46dd8fdf547a678be2e4c2a5f29d4054e177972.1461875890.git.jpoimboe@redhat.com>
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

There are two different pieces of code for starting a CPU: start_cpu0()
and the end of secondary_startup_64().  They're identical except for the
stack setup.  Combine the common parts into a shared start_cpu()
function.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 arch/x86/kernel/head_64.S | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 792c3bb..6dbd2c0 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -264,13 +264,15 @@ ENTRY(secondary_startup_64)
 	movl	$MSR_GS_BASE,%ecx
 	movl	initial_gs(%rip),%eax
 	movl	initial_gs+4(%rip),%edx
-	wrmsr	
+	wrmsr
 
 	/* rsi is pointer to real mode structure with interesting info.
 	   pass it to C */
 	movq	%rsi, %rdi
-	
-	/* Finally jump to run C code and to be on real kernel address
+
+ENTRY(start_cpu)
+	/*
+	 * Jump to run C code and to be on a real kernel address.
 	 * Since we are running on identity-mapped space we have to jump
 	 * to the full 64bit address, this is only possible as indirect
 	 * jump.  In addition we need to ensure %cs is set so we make this
@@ -299,6 +301,7 @@ ENTRY(secondary_startup_64)
 	pushq	$__KERNEL_CS	# set correct cs
 	pushq	%rax		# target address in negative space
 	lretq
+ENDPROC(start_cpu)
 
 #include "verify_cpu.S"
 
@@ -306,15 +309,11 @@ ENTRY(secondary_startup_64)
 /*
  * Boot CPU0 entry point. It's called from play_dead(). Everything has been set
  * up already except stack. We just set up stack here. Then call
- * start_secondary().
+ * start_secondary() via start_cpu().
  */
 ENTRY(start_cpu0)
-	movq initial_stack(%rip),%rsp
-	movq	initial_code(%rip),%rax
-	pushq	$0		# fake return address to stop unwinder
-	pushq	$__KERNEL_CS	# set correct cs
-	pushq	%rax		# target address in negative space
-	lretq
+	movq	initial_stack(%rip), %rsp
+	jmp	start_cpu
 ENDPROC(start_cpu0)
 #endif
 
-- 
2.4.11
