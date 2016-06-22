Return-Path: <jpoimboe@redhat.com>
Date: Wed, 22 Jun 2016 11:30:11 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160622163011.4fjwalehrzk4a32t@treble>
References: <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrWkd1dtSZzrT1gj43frXPYEBFRhY-ToWoMSsdLOROMKcA@mail.gmail.com>
 <20160524022805.sazm456jorfqvdr7@treble>
 <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.com>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 23, 2016 at 08:52:12PM -0700, Andy Lutomirski wrote:
> On May 23, 2016 7:28 PM, "Josh Poimboeuf" <jpoimboe@redhat.com> wrote:
> > > Maybe I'm coming around to liking this idea.
> >
> > Ok, good :-)
> >
> > > In an ideal world (DWARF support, high-quality unwinder, nice pretty
> > > printer, etc), unwinding across a kernel exception would look like:
> > >
> > >  - some_func
> > >  - some_other_func
> > >  - do_page_fault
> > >  - page_fault
> > >
> > > After page_fault, the next unwind step takes us to the faulting RIP
> > > (faulting_func) and reports that all GPRs are known.  It should
> > > probably learn this fact from DWARF if DWARF is available, instead of
> > > directly decoding pt_regs, due to a few funny cases in which pt_regs
> > > may be incomplete.  A nice pretty printer could now print all the
> > > regs.
> > >
> > >  - faulting_func
> > >  - etc.
> > >
> > > For this to work, we don't actually need the unwinder to explicitly
> > > know where pt_regs is.
> >
> > That's true (but only for DWARF).
> >
> > > Food for thought, though: if user code does SYSENTER with TF set,
> > > you'll end up with partial pt_regs.  There's nothing the kernel can do
> > > about it.  DWARF will handle it without any fanfare, but I don't know
> > > if it's going to cause trouble for you pre-DWARF.
> >
> > In this case it should see the stack pointer is past the pt_regs offset,
> > so it would just report it as an empty stack.
> 
> OK
> 
> >
> > > I'm also not sure it makes sense to apply this before the unwinder
> > > that can consume it is ready.  Maybe, if it would be consistent with
> > > your plans, it would make sense to rewrite the unwinder first, then
> > > apply this and teach live patching to use the new unwinder, and *then*
> > > add DWARF support?
> >
> > For the purposes of livepatch, the reliable unwinder needs to detect
> > whether an interrupt/exception pt_regs frame exists on a sleeping task
> > (or current).  This patch would allow us to do that.
> >
> > So my preferred order of doing things would be:
> >
> > 1) Brian Gerst's switch_to() cleanup and any related unwinder fixes
> > 2) this patch for annotating pt_regs stack frames
> > 3) reliable unwinder, similar to what I already posted, except it relies
> >    on this patch instead of PF_PREEMPT_IRQ, and knows how to deal with
> >    the new inactive task frame format of #1
> > 4) livepatch consistency model which uses the reliable unwinder
> > 5) rewrite unwinder, and port all users to the new interface
> > 6) add DWARF unwinder
> >
> > 1-4 are pretty much already written, whereas 5 and 6 will take
> > considerably more work.
> 
> Fair enough.
> 
> >
> > > > +       /*
> > > > +        * Create a stack frame for the saved pt_regs.  This allows frame
> > > > +        * pointer based unwinders to find pt_regs on the stack.
> > > > +        */
> > > > +       .macro CREATE_PT_REGS_FRAME regs=%rsp
> > > > +#ifdef CONFIG_FRAME_POINTER
> > > > +       pushq   \regs
> > > > +       pushq   $pt_regs+1
> > >
> > > Why the +1?
> >
> > Some unwinders like gdb are smart enough to report the function which
> > contains the instruction *before* the return address.  Without the +1,
> > they would show the wrong function.
> 
> Lovely.  Want to add a comment?
> 
> >
> > > > +       pushq   %rbp
> > > > +       movq    %rsp, %rbp
> > > > +#endif
> > > > +       .endm
> > >
> > > I keep wanting this to be only two pushes and to fudge rbp to make it
> > > work, but I don't see a good way.  But let's call it
> > > CREATE_NESTED_ENTRY_FRAME or something, and let's rename pt_regs to
> > > nested_frame or similar.
> >
> > Or, if we aren't going to annotate syscall pt_regs, we could give it a
> > more specific name.  CREATE_INTERRUPT_FRAME and interrupt_frame()?
> 
> CREATE_INTERRUPT_FRAME is confusing because it applies to idtentry,
> too.  CREATE_PT_REGS_FRAME is probably fine.
> 
> > > > +
> > > > +/* fake function which allows stack unwinders to detect pt_regs frames */
> > > > +#ifdef CONFIG_FRAME_POINTER
> > > > +ENTRY(pt_regs)
> > > > +       nop
> > > > +       nop
> > > > +ENDPROC(pt_regs)
> > > > +#endif /* CONFIG_FRAME_POINTER */
> > >
> > > Why is this two bytes long?  Is there some reason it has to be more
> > > than one byte?
> >
> > Similar to above, this is related to the need to support various
> > unwinders.  Whether the unwinder displays the ret_addr or the
> > instruction preceding it, either way the instruction needs to be inside
> > the function for the function to be reported.
> 
> OK.

Andy,

So I got a chance to look at this some more.  I'm thinking that to make
this feature more consistently useful, we shouldn't only annotate
pt_regs frames for calls to handlers; other calls should be annotated as
well: preempt_schedule_irq, CALL_enter_from_user_mode,
prepare_exit_to_usermode, SWAPGS, TRACE_IRQS_OFF, DISABLE_INTERRUPTS,
etc.  That way, the unwinder will always be able to find pt_regs from an
interrupt/exception, even if starting from one of these other calls.

But then, things get ugly.  You have to either setup and tear down the
frame for every possible call, or do a higher-level setup/teardown
across multiple calls, which invalidates several assumptions in the
entry code about the location of pt_regs on the stack.

Also problematic is that several of the macros (like TRACE_IRQS_IRETQ)
make assumptions about the location of pt_regs.  And they're used by
both syscall and interrupt code.  So if we didn't create a frame pointer
header for syscalls, we'd basically need two versions of the macros: one
for irqs/exceptions and one for syscalls.

So I think the cleanest way to handle this is to always allocate two
extra registers on the stack in ALLOC_PT_GPREGS_ON_STACK.  Then all
entry code can assume that pt_regs is at a constant location, and all
the above problems go away.  Another benefit is that we'd only need two
saves instead of three -- the pointer to pt_regs is no longer needed
since pt_regs is always immediately after the frame header.

I worked up a patch to implement this -- see below.  It writes the frame
pointer in all entry paths, including syscalls.  This helps keep the
code simple.

The downside is a small performance penalty: with getppid()-in-a-loop on
my laptop, the average syscall went from 52ns to 53ns, which is about a
2% slowdown.  But I doubt it would be measurable in a real-world
workload.

It looks like about half the slowdown is due to the extra stack
allocation (which presumably adds a little d-cache pressure on the stack
memory) and the other half is due to the stack writes.

I could remove the writes from the syscall path but it would only save
about half a ns, and it would make the code less robust.  Plus it's nice
to have the consistency of having *all* pt_regs frames annotated.

Thoughts?

----

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9a9e588..0f6ccfc 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -88,30 +88,69 @@ For 32-bit we have the following conventions - kernel is built with
 #define RSP		19*8
 #define SS		20*8
 
-#define SIZEOF_PTREGS	21*8
 
-	.macro ALLOC_PT_GPREGS_ON_STACK addskip=0
-	addq	$-(15*8+\addskip), %rsp
+#ifdef CONFIG_FRAME_POINTER
+
+#define PT_REGS_OFFSET 2*8
+
+	/*
+	 * Create an entry stack frame pointer header which corresponds to the
+	 * saved pt_regs.  This allows frame pointer based unwinders to find
+	 * pt_regs on the stack.  The frame pointer and the return address of a
+	 * fake function are stored immediately before the pt_regs.
+	 */
+	.macro SAVE_ENTRY_FRAME_POINTER
+	movq	%rbp,			0*8(%rsp)
+	movq	$entry_frame_ret,	1*8(%rsp)
+	movq	%rsp, %rbp
+	.endm
+
+	.macro RESTORE_ENTRY_FRAME_POINTER
+	movq	(%rsp), %rbp
+	.endm
+
+	.macro ALLOC_AND_SAVE_ENTRY_FRAME_POINTER
+	subq	$PT_REGS_OFFSET, %rsp
+	SAVE_ENTRY_FRAME_POINTER
+	.endm
+
+#else /* !CONFIG_FRAME_POINTER */
+
+#define PT_REGS_OFFSET 0
+#define SAVE_ENTRY_FRAME_POINTER
+#define RESTORE_ENTRY_FRAME_POINTER
+#define ALLOC_AND_SAVE_ENTRY_FRAME_POINTER
+
+#endif /* CONFIG_FRAME_POINTER */
+
+#define PT_REGS_SIZE		21*8
+#define ENTRY_FRAME_SIZE	(PT_REGS_OFFSET+PT_REGS_SIZE)
+
+#define TI_FLAGS(rsp) ASM_THREAD_INFO(TI_flags, rsp, ENTRY_FRAME_SIZE)
+#define PT_REGS(reg) reg+PT_REGS_OFFSET(%rsp)
+
+	.macro ALLOC_ENTRY_FRAME addskip=0
+	addq	$-(15*8+PT_REGS_OFFSET+\addskip), %rsp
 	.endm
 
 	.macro SAVE_C_REGS_HELPER offset=0 rax=1 rcx=1 r8910=1 r11=1
 	.if \r11
-	movq %r11, 6*8+\offset(%rsp)
+	movq %r11, 6*8+PT_REGS_OFFSET+\offset(%rsp)
 	.endif
 	.if \r8910
-	movq %r10, 7*8+\offset(%rsp)
-	movq %r9,  8*8+\offset(%rsp)
-	movq %r8,  9*8+\offset(%rsp)
+	movq %r10, 7*8+PT_REGS_OFFSET+\offset(%rsp)
+	movq %r9,  8*8+PT_REGS_OFFSET+\offset(%rsp)
+	movq %r8,  9*8+PT_REGS_OFFSET+\offset(%rsp)
 	.endif
 	.if \rax
-	movq %rax, 10*8+\offset(%rsp)
+	movq %rax, 10*8+PT_REGS_OFFSET+\offset(%rsp)
 	.endif
 	.if \rcx
-	movq %rcx, 11*8+\offset(%rsp)
+	movq %rcx, 11*8+PT_REGS_OFFSET+\offset(%rsp)
 	.endif
-	movq %rdx, 12*8+\offset(%rsp)
-	movq %rsi, 13*8+\offset(%rsp)
-	movq %rdi, 14*8+\offset(%rsp)
+	movq %rdx, 12*8+PT_REGS_OFFSET+\offset(%rsp)
+	movq %rsi, 13*8+PT_REGS_OFFSET+\offset(%rsp)
+	movq %rdi, 14*8+PT_REGS_OFFSET+\offset(%rsp)
 	.endm
 	.macro SAVE_C_REGS offset=0
 	SAVE_C_REGS_HELPER \offset, 1, 1, 1, 1
@@ -128,23 +167,39 @@ For 32-bit we have the following conventions - kernel is built with
 	.macro SAVE_C_REGS_EXCEPT_RAX_RCX_R11
 	SAVE_C_REGS_HELPER 0, 0, 0, 1, 0
 	.endm
+	.macro SAVE_C_REGS_EXCEPT_RAX
+	SAVE_C_REGS_HELPER rax=0
+	.endm
+
+	.macro SAVE_EXTRA_REGS offset=0 rbx=1
+	movq %r15, 0*8+PT_REGS_OFFSET+\offset(%rsp)
+	movq %r14, 1*8+PT_REGS_OFFSET+\offset(%rsp)
+	movq %r13, 2*8+PT_REGS_OFFSET+\offset(%rsp)
+	movq %r12, 3*8+PT_REGS_OFFSET+\offset(%rsp)
+#ifdef CONFIG_FRAME_POINTER
+	/* copy rbp value from entry frame header */
+	movq \offset(%rsp), %rbp
+	movq %rbp, 4*8+PT_REGS_OFFSET+\offset(%rsp)
+	leaq \offset(%rsp), %rbp
+#else
+	movq %rbp, 4*8+PT_REGS_OFFSET+\offset(%rsp)
+#endif
+	.if \rbx
+	movq %rbx, 5*8+PT_REGS_OFFSET+\offset(%rsp)
+	.endif
+	.endm
 
-	.macro SAVE_EXTRA_REGS offset=0
-	movq %r15, 0*8+\offset(%rsp)
-	movq %r14, 1*8+\offset(%rsp)
-	movq %r13, 2*8+\offset(%rsp)
-	movq %r12, 3*8+\offset(%rsp)
-	movq %rbp, 4*8+\offset(%rsp)
-	movq %rbx, 5*8+\offset(%rsp)
+	.macro SAVE_EXTRA_REGS_EXCEPT_RBX
+	SAVE_EXTRA_REGS rbx=0
 	.endm
 
 	.macro RESTORE_EXTRA_REGS offset=0
-	movq 0*8+\offset(%rsp), %r15
-	movq 1*8+\offset(%rsp), %r14
-	movq 2*8+\offset(%rsp), %r13
-	movq 3*8+\offset(%rsp), %r12
-	movq 4*8+\offset(%rsp), %rbp
-	movq 5*8+\offset(%rsp), %rbx
+	movq 0*8+PT_REGS_OFFSET+\offset(%rsp), %r15
+	movq 1*8+PT_REGS_OFFSET+\offset(%rsp), %r14
+	movq 2*8+PT_REGS_OFFSET+\offset(%rsp), %r13
+	movq 3*8+PT_REGS_OFFSET+\offset(%rsp), %r12
+	movq 4*8+PT_REGS_OFFSET+\offset(%rsp), %rbp
+	movq 5*8+PT_REGS_OFFSET+\offset(%rsp), %rbx
 	.endm
 
 	.macro ZERO_EXTRA_REGS
@@ -158,24 +213,24 @@ For 32-bit we have the following conventions - kernel is built with
 
 	.macro RESTORE_C_REGS_HELPER rstor_rax=1, rstor_rcx=1, rstor_r11=1, rstor_r8910=1, rstor_rdx=1
 	.if \rstor_r11
-	movq 6*8(%rsp), %r11
+	movq 6*8+PT_REGS_OFFSET(%rsp), %r11
 	.endif
 	.if \rstor_r8910
-	movq 7*8(%rsp), %r10
-	movq 8*8(%rsp), %r9
-	movq 9*8(%rsp), %r8
+	movq 7*8+PT_REGS_OFFSET(%rsp), %r10
+	movq 8*8+PT_REGS_OFFSET(%rsp), %r9
+	movq 9*8+PT_REGS_OFFSET(%rsp), %r8
 	.endif
 	.if \rstor_rax
-	movq 10*8(%rsp), %rax
+	movq 10*8+PT_REGS_OFFSET(%rsp), %rax
 	.endif
 	.if \rstor_rcx
-	movq 11*8(%rsp), %rcx
+	movq 11*8+PT_REGS_OFFSET(%rsp), %rcx
 	.endif
 	.if \rstor_rdx
-	movq 12*8(%rsp), %rdx
+	movq 12*8+PT_REGS_OFFSET(%rsp), %rdx
 	.endif
-	movq 13*8(%rsp), %rsi
-	movq 14*8(%rsp), %rdi
+	movq 13*8+PT_REGS_OFFSET(%rsp), %rsi
+	movq 14*8+PT_REGS_OFFSET(%rsp), %rdi
 	.endm
 	.macro RESTORE_C_REGS
 	RESTORE_C_REGS_HELPER 1,1,1,1,1
@@ -193,8 +248,8 @@ For 32-bit we have the following conventions - kernel is built with
 	RESTORE_C_REGS_HELPER 1,0,0,1,1
 	.endm
 
-	.macro REMOVE_PT_GPREGS_FROM_STACK addskip=0
-	subq $-(15*8+\addskip), %rsp
+	.macro FREE_ENTRY_FRAME addskip=0
+	subq $-(15*8+PT_REGS_OFFSET+\addskip), %rsp
 	.endm
 
 	.macro icebp
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 23e764c..ff92759 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -55,7 +55,7 @@ ENDPROC(native_usergs_sysret64)
 
 .macro TRACE_IRQS_IRETQ
 #ifdef CONFIG_TRACE_IRQFLAGS
-	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
+	bt	$9, PT_REGS(EFLAGS)		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON
 1:
@@ -88,7 +88,7 @@ ENDPROC(native_usergs_sysret64)
 .endm
 
 .macro TRACE_IRQS_IRETQ_DEBUG
-	bt	$9, EFLAGS(%rsp)		/* interrupts off? */
+	bt	$9, PT_REGS(EFLAGS)		/* interrupts off? */
 	jnc	1f
 	TRACE_IRQS_ON_DEBUG
 1:
@@ -164,22 +164,17 @@ GLOBAL(entry_SYSCALL_64_after_swapgs)
 	pushq	$__USER_CS			/* pt_regs->cs */
 	pushq	%rcx				/* pt_regs->ip */
 	pushq	%rax				/* pt_regs->orig_ax */
-	pushq	%rdi				/* pt_regs->di */
-	pushq	%rsi				/* pt_regs->si */
-	pushq	%rdx				/* pt_regs->dx */
-	pushq	%rcx				/* pt_regs->cx */
-	pushq	$-ENOSYS			/* pt_regs->ax */
-	pushq	%r8				/* pt_regs->r8 */
-	pushq	%r9				/* pt_regs->r9 */
-	pushq	%r10				/* pt_regs->r10 */
-	pushq	%r11				/* pt_regs->r11 */
-	sub	$(6*8), %rsp			/* pt_regs->bp, bx, r12-15 not saved */
+
+	ALLOC_ENTRY_FRAME
+	SAVE_ENTRY_FRAME_POINTER
+	SAVE_C_REGS_EXCEPT_RAX
+	movq	$-ENOSYS, PT_REGS(RAX)
 
 	/*
 	 * If we need to do entry work or if we guess we'll need to do
 	 * exit work, go straight to the slow path.
 	 */
-	testl	$_TIF_WORK_SYSCALL_ENTRY|_TIF_ALLWORK_MASK, ASM_THREAD_INFO(TI_flags, %rsp, SIZEOF_PTREGS)
+	testl	$_TIF_WORK_SYSCALL_ENTRY|_TIF_ALLWORK_MASK, TI_FLAGS(%rsp)
 	jnz	entry_SYSCALL64_slow_path
 
 entry_SYSCALL_64_fastpath:
@@ -207,7 +202,7 @@ entry_SYSCALL_64_fastpath:
 	call	*sys_call_table(, %rax, 8)
 .Lentry_SYSCALL_64_after_fastpath_call:
 
-	movq	%rax, RAX(%rsp)
+	movq	%rax, PT_REGS(RAX)
 1:
 
 	/*
@@ -217,15 +212,16 @@ entry_SYSCALL_64_fastpath:
 	 */
 	DISABLE_INTERRUPTS(CLBR_NONE)
 	TRACE_IRQS_OFF
-	testl	$_TIF_ALLWORK_MASK, ASM_THREAD_INFO(TI_flags, %rsp, SIZEOF_PTREGS)
+	testl	$_TIF_ALLWORK_MASK, TI_FLAGS(%rsp)
 	jnz	1f
 
 	LOCKDEP_SYS_EXIT
 	TRACE_IRQS_ON		/* user mode is traced as IRQs on */
-	movq	RIP(%rsp), %rcx
-	movq	EFLAGS(%rsp), %r11
+	movq	PT_REGS(RIP), %rcx
+	movq	PT_REGS(EFLAGS), %r11
 	RESTORE_C_REGS_EXCEPT_RCX_R11
-	movq	RSP(%rsp), %rsp
+	RESTORE_ENTRY_FRAME_POINTER
+	movq	PT_REGS(RSP), %rsp
 	USERGS_SYSRET64
 
 1:
@@ -237,14 +233,14 @@ entry_SYSCALL_64_fastpath:
 	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS(CLBR_NONE)
 	SAVE_EXTRA_REGS
-	movq	%rsp, %rdi
+	leaq	PT_REGS_OFFSET(%rsp), %rdi
 	call	syscall_return_slowpath	/* returns with IRQs disabled */
 	jmp	return_from_SYSCALL_64
 
 entry_SYSCALL64_slow_path:
 	/* IRQs are off. */
 	SAVE_EXTRA_REGS
-	movq	%rsp, %rdi
+	leaq	PT_REGS_OFFSET(%rsp), %rdi
 	call	do_syscall_64		/* returns with IRQs disabled */
 
 return_from_SYSCALL_64:
@@ -255,8 +251,8 @@ return_from_SYSCALL_64:
 	 * Try to use SYSRET instead of IRET if we're returning to
 	 * a completely clean 64-bit userspace context.
 	 */
-	movq	RCX(%rsp), %rcx
-	movq	RIP(%rsp), %r11
+	movq	PT_REGS(RCX), %rcx
+	movq	PT_REGS(RIP), %r11
 	cmpq	%rcx, %r11			/* RCX == RIP */
 	jne	opportunistic_sysret_failed
 
@@ -283,8 +279,8 @@ return_from_SYSCALL_64:
 	cmpq	$__USER_CS, CS(%rsp)		/* CS must match SYSRET */
 	jne	opportunistic_sysret_failed
 
-	movq	R11(%rsp), %r11
-	cmpq	%r11, EFLAGS(%rsp)		/* R11 == RFLAGS */
+	movq	PT_REGS(R11), %r11
+	cmpq	%r11, PT_REGS(EFLAGS)		/* R11 == RFLAGS */
 	jne	opportunistic_sysret_failed
 
 	/*
@@ -306,7 +302,7 @@ return_from_SYSCALL_64:
 
 	/* nothing to check for RSP */
 
-	cmpq	$__USER_DS, SS(%rsp)		/* SS must match SYSRET */
+	cmpq	$__USER_DS, PT_REGS(SS)		/* SS must match SYSRET */
 	jne	opportunistic_sysret_failed
 
 	/*
@@ -316,7 +312,7 @@ return_from_SYSCALL_64:
 syscall_return_via_sysret:
 	/* rcx and r11 are already restored (see code above) */
 	RESTORE_C_REGS_EXCEPT_RCX_R11
-	movq	RSP(%rsp), %rsp
+	movq	PT_REGS(RSP), %rsp
 	USERGS_SYSRET64
 
 opportunistic_sysret_failed:
@@ -408,6 +404,7 @@ END(__switch_to_asm)
  * r12: kernel thread arg
  */
 ENTRY(ret_from_fork)
+	ALLOC_AND_SAVE_ENTRY_FRAME_POINTER
 	movq	%rax, %rdi
 	call	schedule_tail			/* rdi: 'prev' task parameter */
 
@@ -415,7 +412,7 @@ ENTRY(ret_from_fork)
 	jnz	1f
 
 2:
-	movq	%rsp, %rdi
+	leaq	PT_REGS_OFFSET(%rsp), %rdi
 	call	syscall_return_slowpath	/* returns with IRQs disabled */
 	TRACE_IRQS_ON			/* user mode is traced as IRQS on */
 	SWAPGS
@@ -430,7 +427,7 @@ ENTRY(ret_from_fork)
 	 * calling do_execve().  Exit to userspace to complete the execve()
 	 * syscall.
 	 */
-	movq	$0, RAX(%rsp)
+	movq	$0, PT_REGS(RAX)
 	jmp	2b
 END(ret_from_fork)
 
@@ -460,11 +457,12 @@ END(irq_entries_start)
 /* 0(%rsp): ~(interrupt number) */
 	.macro interrupt func
 	cld
-	ALLOC_PT_GPREGS_ON_STACK
+	ALLOC_ENTRY_FRAME
+	SAVE_ENTRY_FRAME_POINTER
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
 
-	testb	$3, CS(%rsp)
+	testb	$3, PT_REGS(CS)
 	jz	1f
 
 	/*
@@ -500,6 +498,7 @@ END(irq_entries_start)
 	/* We entered an interrupt context - irqs are off: */
 	TRACE_IRQS_OFF
 
+	addq	$PT_REGS_OFFSET, %rdi
 	call	\func	/* rdi points to pt_regs */
 	.endm
 
@@ -521,12 +520,12 @@ ret_from_intr:
 	/* Restore saved previous stack */
 	popq	%rsp
 
-	testb	$3, CS(%rsp)
+	testb	$3, PT_REGS(CS)
 	jz	retint_kernel
 
 	/* Interrupt came from user space */
 GLOBAL(retint_user)
-	mov	%rsp,%rdi
+	leaq	PT_REGS_OFFSET(%rsp), %rdi
 	call	prepare_exit_to_usermode
 	TRACE_IRQS_IRETQ
 	SWAPGS
@@ -537,7 +536,7 @@ retint_kernel:
 #ifdef CONFIG_PREEMPT
 	/* Interrupts are off */
 	/* Check if we need preemption */
-	bt	$9, EFLAGS(%rsp)		/* were interrupts off? */
+	bt	$9, PT_REGS(EFLAGS)		/* were interrupts off? */
 	jnc	1f
 0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	1f
@@ -558,7 +557,7 @@ GLOBAL(restore_regs_and_iret)
 	RESTORE_EXTRA_REGS
 restore_c_regs_and_iret:
 	RESTORE_C_REGS
-	REMOVE_PT_GPREGS_FROM_STACK 8
+	FREE_ENTRY_FRAME 8
 	INTERRUPT_RETURN
 
 ENTRY(native_iret)
@@ -699,11 +698,12 @@ ENTRY(\sym)
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
 	.endif
 
-	ALLOC_PT_GPREGS_ON_STACK
+	ALLOC_ENTRY_FRAME
+	SAVE_ENTRY_FRAME_POINTER
 
 	.if \paranoid
 	.if \paranoid == 1
-	testb	$3, CS(%rsp)			/* If coming from userspace, switch stacks */
+	testb	$3, PT_REGS(CS)			/* If coming from userspace, switch stacks */
 	jnz	1f
 	.endif
 	call	paranoid_entry
@@ -720,11 +720,11 @@ ENTRY(\sym)
 	.endif
 	.endif
 
-	movq	%rsp, %rdi			/* pt_regs pointer */
+	leaq	PT_REGS_OFFSET(%rsp), %rdi	/* pt_regs pointer */
 
 	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
+	movq	PT_REGS(ORIG_RAX), %rsi		/* get error code */
+	movq	$-1, PT_REGS(ORIG_RAX)		/* no syscall to restart */
 	.else
 	xorl	%esi, %esi			/* no error code */
 	.endif
@@ -755,16 +755,15 @@ ENTRY(\sym)
 1:
 	call	error_entry
 
-
-	movq	%rsp, %rdi			/* pt_regs pointer */
-	call	sync_regs
+	movq	%rsp, %rdi			/* stack frame + pt_regs */
+	call	sync_entry_frame
 	movq	%rax, %rsp			/* switch stack */
 
-	movq	%rsp, %rdi			/* pt_regs pointer */
+	leaq	PT_REGS_OFFSET(%rsp), %rdi	/* pt_regs pointer */
 
 	.if \has_error_code
-	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
-	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
+	movq	PT_REGS(ORIG_RAX), %rsi		/* get error code */
+	movq	$-1, PT_REGS(ORIG_RAX)		/* no syscall to restart */
 	.else
 	xorl	%esi, %esi			/* no error code */
 	.endif
@@ -922,7 +921,8 @@ ENTRY(xen_failsafe_callback)
 	movq	8(%rsp), %r11
 	addq	$0x30, %rsp
 	pushq	$-1 /* orig_ax = -1 => not a system call */
-	ALLOC_PT_GPREGS_ON_STACK
+	ALLOC_ENTRY_FRAME
+	SAVE_ENTRY_FRAME_POINTER
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
 	jmp	error_exit
@@ -1003,7 +1003,7 @@ paranoid_exit_no_swapgs:
 paranoid_exit_restore:
 	RESTORE_EXTRA_REGS
 	RESTORE_C_REGS
-	REMOVE_PT_GPREGS_FROM_STACK 8
+	FREE_ENTRY_FRAME 8
 	INTERRUPT_RETURN
 END(paranoid_exit)
 
@@ -1016,7 +1016,7 @@ ENTRY(error_entry)
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
 	xorl	%ebx, %ebx
-	testb	$3, CS+8(%rsp)
+	testb	$3, CS+8+PT_REGS_OFFSET(%rsp)
 	jz	.Lerror_kernelspace
 
 .Lerror_entry_from_usermode_swapgs:
@@ -1049,12 +1049,12 @@ ENTRY(error_entry)
 .Lerror_kernelspace:
 	incl	%ebx
 	leaq	native_irq_return_iret(%rip), %rcx
-	cmpq	%rcx, RIP+8(%rsp)
+	cmpq	%rcx, RIP+8+PT_REGS_OFFSET(%rsp)
 	je	.Lerror_bad_iret
 	movl	%ecx, %eax			/* zero extend */
-	cmpq	%rax, RIP+8(%rsp)
+	cmpq	%rax, RIP+8+PT_REGS_OFFSET(%rsp)
 	je	.Lbstep_iret
-	cmpq	$.Lgs_change, RIP+8(%rsp)
+	cmpq	$.Lgs_change, RIP+8+PT_REGS_OFFSET(%rsp)
 	jne	.Lerror_entry_done
 
 	/*
@@ -1066,7 +1066,7 @@ ENTRY(error_entry)
 
 .Lbstep_iret:
 	/* Fix truncated RIP */
-	movq	%rcx, RIP+8(%rsp)
+	movq	%rcx, RIP+8+PT_REGS_OFFSET(%rsp)
 	/* fall through */
 
 .Lerror_bad_iret:
@@ -1182,29 +1182,20 @@ ENTRY(nmi)
 	pushq	2*8(%rdx)	/* pt_regs->cs */
 	pushq	1*8(%rdx)	/* pt_regs->rip */
 	pushq   $-1		/* pt_regs->orig_ax */
-	pushq   %rdi		/* pt_regs->di */
-	pushq   %rsi		/* pt_regs->si */
-	pushq   (%rdx)		/* pt_regs->dx */
-	pushq   %rcx		/* pt_regs->cx */
-	pushq   %rax		/* pt_regs->ax */
-	pushq   %r8		/* pt_regs->r8 */
-	pushq   %r9		/* pt_regs->r9 */
-	pushq   %r10		/* pt_regs->r10 */
-	pushq   %r11		/* pt_regs->r11 */
-	pushq	%rbx		/* pt_regs->rbx */
-	pushq	%rbp		/* pt_regs->rbp */
-	pushq	%r12		/* pt_regs->r12 */
-	pushq	%r13		/* pt_regs->r13 */
-	pushq	%r14		/* pt_regs->r14 */
-	pushq	%r15		/* pt_regs->r15 */
 
-	/*
+	ALLOC_ENTRY_FRAME
+	SAVE_ENTRY_FRAME_POINTER
+	movq	(%rdx), %rdx
+	SAVE_C_REGS
+	SAVE_EXTRA_REGS
+
+/*
 	 * At this point we no longer need to worry about stack damage
 	 * due to nesting -- we're on the normal thread stack and we're
 	 * done with the NMI stack.
 	 */
 
-	movq	%rsp, %rdi
+	leaq	PT_REGS_OFFSET(%rsp), %rdi
 	movq	$-1, %rsi
 	call	do_nmi
 
@@ -1214,6 +1205,7 @@ ENTRY(nmi)
 	 * do_nmi doesn't modify pt_regs.
 	 */
 	SWAPGS
+	RESTORE_ENTRY_FRAME_POINTER
 	jmp	restore_c_regs_and_iret
 
 .Lnmi_from_kernel:
@@ -1405,7 +1397,8 @@ end_repeat_nmi:
 	 * frame to point back to repeat_nmi.
 	 */
 	pushq	$-1				/* ORIG_RAX: no syscall to restart */
-	ALLOC_PT_GPREGS_ON_STACK
+	ALLOC_ENTRY_FRAME
+	SAVE_ENTRY_FRAME_POINTER
 
 	/*
 	 * Use paranoid_entry to handle SWAPGS, but no need to use paranoid_exit
@@ -1417,7 +1410,7 @@ end_repeat_nmi:
 	call	paranoid_entry
 
 	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
-	movq	%rsp, %rdi
+	leaq	PT_REGS_OFFSET(%rsp), %rdi
 	movq	$-1, %rsi
 	call	do_nmi
 
@@ -1430,7 +1423,7 @@ nmi_restore:
 	RESTORE_C_REGS
 
 	/* Point RSP at the "iret" frame. */
-	REMOVE_PT_GPREGS_FROM_STACK 6*8
+	FREE_ENTRY_FRAME 6*8
 
 	/*
 	 * Clear "NMI executing".  Set DF first so that we can easily
@@ -1455,3 +1448,22 @@ ENTRY(ignore_sysret)
 	mov	$-ENOSYS, %eax
 	sysret
 END(ignore_sysret)
+
+#ifdef CONFIG_FRAME_POINTER
+/*
+ * This is a fake function which allows stack unwinders to detect entry stack
+ * frames.  The entry_frame_ret return address is stored on the stack after the
+ * frame pointer, immediately before pt_regs.
+ *
+ * Some unwinders like gdb are smart enough to report the function which
+ * contains the instruction *before* the return address on the stack.  More
+ * primitive unwinders like the kernel's will report the function containing
+ * the return address itself.  So the address needs to be in the middle of the
+ * function in order to satisfy them both.
+ */
+ENTRY(entry_frame)
+	nop
+GLOBAL(entry_frame_ret)
+	nop
+ENDPROC(entry_frame)
+#endif /* CONFIG_FRAME_POINTER */
diff --git a/arch/x86/entry/entry_64_compat.S b/arch/x86/entry/entry_64_compat.S
index e1721da..31b4f63c 100644
--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -309,21 +309,16 @@ ENTRY(entry_INT80_compat)
 
 	/* Construct struct pt_regs on stack (iret frame is already on stack) */
 	pushq	%rax			/* pt_regs->orig_ax */
-	pushq	%rdi			/* pt_regs->di */
-	pushq	%rsi			/* pt_regs->si */
-	pushq	%rdx			/* pt_regs->dx */
-	pushq	%rcx			/* pt_regs->cx */
-	pushq	$-ENOSYS		/* pt_regs->ax */
-	pushq   $0			/* pt_regs->r8  = 0 */
-	pushq   $0			/* pt_regs->r9  = 0 */
-	pushq   $0			/* pt_regs->r10 = 0 */
-	pushq   $0			/* pt_regs->r11 = 0 */
-	pushq   %rbx                    /* pt_regs->rbx */
-	pushq   %rbp                    /* pt_regs->rbp */
-	pushq   %r12                    /* pt_regs->r12 */
-	pushq   %r13                    /* pt_regs->r13 */
-	pushq   %r14                    /* pt_regs->r14 */
-	pushq   %r15                    /* pt_regs->r15 */
+	ALLOC_ENTRY_FRAME
+	SAVE_ENTRY_FRAME_POINTER
+	movq	$-ENOSYS, %rax
+	xorq	%r8, %r8
+	xorq	%r9, %r9
+	xorq	%r10, %r10
+	xorq	%r11, %r11
+	SAVE_C_REGS
+	SAVE_EXTRA_REGS
+
 	cld
 
 	/*
@@ -332,7 +327,7 @@ ENTRY(entry_INT80_compat)
 	 */
 	TRACE_IRQS_OFF
 
-	movq	%rsp, %rdi
+	leaq	PT_REGS_OFFSET(%rsp), %rdi
 	call	do_int80_syscall_32
 .Lsyscall_32_done:
 
diff --git a/arch/x86/include/asm/traps.h b/arch/x86/include/asm/traps.h
index c3496619..bba7ece 100644
--- a/arch/x86/include/asm/traps.h
+++ b/arch/x86/include/asm/traps.h
@@ -70,7 +70,6 @@ dotraplinkage void do_segment_not_present(struct pt_regs *, long);
 dotraplinkage void do_stack_segment(struct pt_regs *, long);
 #ifdef CONFIG_X86_64
 dotraplinkage void do_double_fault(struct pt_regs *, long);
-asmlinkage struct pt_regs *sync_regs(struct pt_regs *);
 #endif
 dotraplinkage void do_general_protection(struct pt_regs *, long);
 dotraplinkage void do_page_fault(struct pt_regs *, unsigned long);
diff --git a/arch/x86/kernel/head_64.S b/arch/x86/kernel/head_64.S
index 5df831e..f3c7922 100644
--- a/arch/x86/kernel/head_64.S
+++ b/arch/x86/kernel/head_64.S
@@ -362,24 +362,15 @@ early_idt_handler_common:
 	incl early_recursion_flag(%rip)
 
 	/* The vector number is currently in the pt_regs->di slot. */
-	pushq %rsi				/* pt_regs->si */
-	movq 8(%rsp), %rsi			/* RSI = vector number */
-	movq %rdi, 8(%rsp)			/* pt_regs->di = RDI */
-	pushq %rdx				/* pt_regs->dx */
-	pushq %rcx				/* pt_regs->cx */
-	pushq %rax				/* pt_regs->ax */
-	pushq %r8				/* pt_regs->r8 */
-	pushq %r9				/* pt_regs->r9 */
-	pushq %r10				/* pt_regs->r10 */
-	pushq %r11				/* pt_regs->r11 */
-	pushq %rbx				/* pt_regs->bx */
-	pushq %rbp				/* pt_regs->bp */
-	pushq %r12				/* pt_regs->r12 */
-	pushq %r13				/* pt_regs->r13 */
-	pushq %r14				/* pt_regs->r14 */
-	pushq %r15				/* pt_regs->r15 */
-
-	cmpq $14,%rsi		/* Page fault? */
+	ALLOC_ENTRY_FRAME addskip=-8
+	SAVE_ENTRY_FRAME_POINTER
+	movq %rbx, PT_REGS(RBX)	/* save rbx */
+	movq PT_REGS(RDI), %rbx	/* rbx = vector number */
+
+	SAVE_C_REGS
+	SAVE_EXTRA_REGS_EXCEPT_RBX
+
+	cmpq $14, %rbx		/* page fault? */
 	jnz 10f
 	GET_CR2_INTO(%rdi)	/* Can clobber any volatile register if pv */
 	call early_make_pgtable
@@ -387,7 +378,9 @@ early_idt_handler_common:
 	jz 20f			/* All good */
 
 10:
-	movq %rsp,%rdi		/* RDI = pt_regs; RSI is already trapnr */
+	movq %rsp, %rdi
+	addq $PT_REGS_OFFSET, %rdi /* rdi = pt_regs */
+	movq %rbx, %rsi		   /* rsi = vector number */
 	call early_fixup_exception
 
 20:
diff --git a/arch/x86/kernel/traps.c b/arch/x86/kernel/traps.c
index 00f03d8..6954e74 100644
--- a/arch/x86/kernel/traps.c
+++ b/arch/x86/kernel/traps.c
@@ -514,22 +514,34 @@ exit:
 NOKPROBE_SYMBOL(do_int3);
 
 #ifdef CONFIG_X86_64
+
+struct entry_frame {
+#ifdef CONFIG_FRAME_POINTER
+	void *fp;
+	void *ret_addr;
+#endif
+	struct pt_regs regs;
+};
+
 /*
  * Help handler running on IST stack to switch off the IST stack if the
  * interrupted code was in user mode. The actual stack switch is done in
  * entry_64.S
  */
-asmlinkage __visible notrace struct pt_regs *sync_regs(struct pt_regs *eregs)
+asmlinkage __visible notrace
+struct entry_frame *sync_entry_frame(struct entry_frame *old)
 {
-	struct pt_regs *regs = task_pt_regs(current);
-	*regs = *eregs;
-	return regs;
+	struct entry_frame *new = container_of(task_pt_regs(current),
+					       struct entry_frame, regs);
+
+	*new = *old;
+	return new;
 }
-NOKPROBE_SYMBOL(sync_regs);
+NOKPROBE_SYMBOL(sync_entry_frame);
 
 struct bad_iret_stack {
 	void *error_entry_ret;
-	struct pt_regs regs;
+	struct entry_frame frame;
 };
 
 asmlinkage __visible notrace
@@ -544,15 +556,15 @@ struct bad_iret_stack *fixup_bad_iret(struct bad_iret_stack *s)
 	 */
 	struct bad_iret_stack *new_stack =
 		container_of(task_pt_regs(current),
-			     struct bad_iret_stack, regs);
+			     struct bad_iret_stack, frame.regs);
 
 	/* Copy the IRET target to the new stack. */
-	memmove(&new_stack->regs.ip, (void *)s->regs.sp, 5*8);
+	memmove(&new_stack->frame.regs.ip, (void *)s->frame.regs.sp, 5*8);
 
 	/* Copy the remainder of the stack from the current stack. */
-	memmove(new_stack, s, offsetof(struct bad_iret_stack, regs.ip));
+	memmove(new_stack, s, offsetof(struct bad_iret_stack, frame.regs.ip));
 
-	BUG_ON(!user_mode(&new_stack->regs));
+	BUG_ON(!user_mode(&new_stack->frame.regs));
 	return new_stack;
 }
 NOKPROBE_SYMBOL(fixup_bad_iret);
