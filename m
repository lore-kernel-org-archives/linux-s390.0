Return-Path: <jpoimboe@redhat.com>
Date: Fri, 20 May 2016 09:05:13 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160520140513.dsgfb5sei52qge3w@treble>
References: <20160429202701.yijrohqdsurdxv2a@treble>
 <CALCETrVKt8k11ewSOvGiCNsqgtD5cMaLix8Tf8JJakgodJeLyA@mail.gmail.com>
 <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrXMyssjtX0RJJRzzAJ2-5fygsmWutb2-rnzbCjSDwSxxg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALCETrXMyssjtX0RJJRzzAJ2-5fygsmWutb2-rnzbCjSDwSxxg@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, linuxppc-dev@lists.ozlabs.org, Jessica Yu <jeyu@redhat.com>, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, Vojtech Pavlik <vojtech@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 19, 2016 at 04:39:51PM -0700, Andy Lutomirski wrote:
> On Thu, May 19, 2016 at 4:15 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > Note this example is with today's unwinder.  It could be made smarter to
> > get the RIP from the pt_regs so the '?' could be removed from
> > copy_page_to_iter().
> >
> > Thoughts?
> 
> I think we should do that.  The silly sample patch I sent you (or at
> least that I think I sent you) did that, and it worked nicely.

Yeah, we can certainly do something similar to make the unwinder
smarter.  It should be very simple with this approach: if it finds the
pt_regs() function on the stack, the (struct pt_regs *) pointer will be
right after it.

> > diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> > index 9a9e588..f54886a 100644
> > --- a/arch/x86/entry/calling.h
> > +++ b/arch/x86/entry/calling.h
> > @@ -201,6 +201,32 @@ For 32-bit we have the following conventions - kernel is built with
> >         .byte 0xf1
> >         .endm
> >
> > +       /*
> > +        * Create a stack frame for the saved pt_regs.  This allows frame
> > +        * pointer based unwinders to find pt_regs on the stack.
> > +        */
> > +       .macro CREATE_PT_REGS_FRAME regs=%rsp
> > +#ifdef CONFIG_FRAME_POINTER
> > +       pushq   \regs
> > +       pushq   $pt_regs+1
> > +       pushq   %rbp
> > +       movq    %rsp, %rbp
> > +#endif
> > +       .endm
> 
> I don't love this part.  It's going to hurt performance, and, given
> that we need to change the unwinder anyway to make it useful, let's
> just emit a table somewhere in .rodata and use it directly.

I'm not sure about the idea of a table.  I get the feeling it would add
more complexity to both the entry code and the unwinder.  How would you
specify the pt_regs location when it's on a different stack?  (See the
interrupt macro: non-nested interrupts will place pt_regs on the task
stack before switching to the irq stack.)

If you're worried about performance, I can remove the syscall
annotations.  They're optional anyway, since the pt_regs is always at
the same place on the stack for syscalls.

I think three extra pushes wouldn't be a performance issue for
interrupts/exceptions.  And they'll go away when we finally bury
CONFIG_FRAME_POINTER.

Here's the same patch without syscall annotations:


diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9a9e588..f54886a 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -201,6 +201,32 @@ For 32-bit we have the following conventions - kernel is built with
 	.byte 0xf1
 	.endm
 
+	/*
+	 * Create a stack frame for the saved pt_regs.  This allows frame
+	 * pointer based unwinders to find pt_regs on the stack.
+	 */
+	.macro CREATE_PT_REGS_FRAME regs=%rsp
+#ifdef CONFIG_FRAME_POINTER
+	pushq	\regs
+	pushq	$pt_regs+1
+	pushq	%rbp
+	movq	%rsp, %rbp
+#endif
+	.endm
+
+	.macro REMOVE_PT_REGS_FRAME
+#ifdef CONFIG_FRAME_POINTER
+	popq	%rbp
+	addq	$0x10, %rsp
+#endif
+	.endm
+
+	.macro CALL_HANDLER handler regs=%rsp
+	CREATE_PT_REGS_FRAME \regs
+	call	\handler
+	REMOVE_PT_REGS_FRAME
+	.endm
+
 #endif /* CONFIG_X86_64 */
 
 /*
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9ee0da1..93bc8f0 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -468,7 +468,7 @@ END(irq_entries_start)
 	/* We entered an interrupt context - irqs are off: */
 	TRACE_IRQS_OFF
 
-	call	\func	/* rdi points to pt_regs */
+	CALL_HANDLER \func regs=%rdi
 	.endm
 
 	/*
@@ -495,7 +495,7 @@ ret_from_intr:
 	/* Interrupt came from user space */
 GLOBAL(retint_user)
 	mov	%rsp,%rdi
-	call	prepare_exit_to_usermode
+	CALL_HANDLER prepare_exit_to_usermode
 	TRACE_IRQS_IRETQ
 	SWAPGS
 	jmp	restore_regs_and_iret
@@ -509,7 +509,7 @@ retint_kernel:
 	jnc	1f
 0:	cmpl	$0, PER_CPU_VAR(__preempt_count)
 	jnz	1f
-	call	preempt_schedule_irq
+	CALL_HANDLER preempt_schedule_irq
 	jmp	0b
 1:
 #endif
@@ -688,8 +688,6 @@ ENTRY(\sym)
 	.endif
 	.endif
 
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
 	.if \has_error_code
 	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
 	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
@@ -701,7 +699,8 @@ ENTRY(\sym)
 	subq	$EXCEPTION_STKSZ, CPU_TSS_IST(\shift_ist)
 	.endif
 
-	call	\do_sym
+	movq	%rsp, %rdi			/* pt_regs pointer */
+	CALL_HANDLER \do_sym
 
 	.if \shift_ist != -1
 	addq	$EXCEPTION_STKSZ, CPU_TSS_IST(\shift_ist)
@@ -728,8 +727,6 @@ ENTRY(\sym)
 	call	sync_regs
 	movq	%rax, %rsp			/* switch stack */
 
-	movq	%rsp, %rdi			/* pt_regs pointer */
-
 	.if \has_error_code
 	movq	ORIG_RAX(%rsp), %rsi		/* get error code */
 	movq	$-1, ORIG_RAX(%rsp)		/* no syscall to restart */
@@ -737,7 +734,8 @@ ENTRY(\sym)
 	xorl	%esi, %esi			/* no error code */
 	.endif
 
-	call	\do_sym
+	movq	%rsp, %rdi			/* pt_regs pointer */
+	CALL_HANDLER \do_sym
 
 	jmp	error_exit			/* %ebx: no swapgs flag */
 	.endif
@@ -1174,7 +1172,7 @@ ENTRY(nmi)
 
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-	call	do_nmi
+	CALL_HANDLER do_nmi
 
 	/*
 	 * Return back to user mode.  We must *not* do the normal exit
@@ -1387,7 +1385,7 @@ end_repeat_nmi:
 	/* paranoidentry do_nmi, 0; without TRACE_IRQS_OFF */
 	movq	%rsp, %rdi
 	movq	$-1, %rsi
-	call	do_nmi
+	CALL_HANDLER do_nmi
 
 	testl	%ebx, %ebx			/* swapgs needed? */
 	jnz	nmi_restore
@@ -1423,3 +1421,11 @@ ENTRY(ignore_sysret)
 	mov	$-ENOSYS, %eax
 	sysret
 END(ignore_sysret)
+
+/* fake function which allows stack unwinders to detect pt_regs frames */
+#ifdef CONFIG_FRAME_POINTER
+ENTRY(pt_regs)
+	nop
+	nop
+ENDPROC(pt_regs)
+#endif /* CONFIG_FRAME_POINTER */
