Return-Path: <jpoimboe@redhat.com>
Date: Thu, 23 Jun 2016 15:40:17 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160623204017.df22mljbrgpogeqp@treble>
References: <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
 <20160622163011.4fjwalehrzk4a32t@treble>
 <CALCETrVJpFYi=x0nVWSVi3n40Xkig43Y5bRNOO2XNmUuC9Wt+g@mail.gmail.com>
 <20160622182245.4u72jgjg2khxracz@treble>
 <CALCETrXR9iMO1veHREumqTOvQuLYYQFH_=VRhQ6oXusXi+NFNg@mail.gmail.com>
 <20160622184042.br7ov37pl6eydr3y@treble>
 <CALCETrWQWhPnFai5_RkLDiNmaxcjVmaYDAGTzQL8fXien8ojSQ@mail.gmail.com>
 <20160623161950.ovwpvhq43tq35u7k@treble>
 <CALCETrWJ8fdttrM3ZwCgeBBzhJOPGc4PEHT8AZzc=eg7K69nfA@mail.gmail.com>
 <20160623183132.oqtl6flnoqtilurs@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20160623183132.oqtl6flnoqtilurs@treble>
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

On Thu, Jun 23, 2016 at 01:31:32PM -0500, Josh Poimboeuf wrote:
> On Thu, Jun 23, 2016 at 09:35:29AM -0700, Andy Lutomirski wrote:
> > > So which is the least-bad option?  To summarize:
> > >
> > >   1) task flag(s) for preemption and page faults
> > >
> > >   2) turn pt_regs into a stack frame
> > >
> > >   3) annotate all calls from entry code in a table
> > >
> > >   4) encode rbp on entry
> > >
> > > They all have their issues, though I'm partial to #2.
> > >
> > > Any more hare-brained ideas? :-)
> > 
> > I'll try to take a closer look at #2 and see just how much I dislike
> > all the stack frame munging.
> 
> Ok.
> 
> > Also, in principle, it's only the
> > sleeping calls and the calls that make it into real (non-entry) kernel
> > code that really want to be unwindable through this mechanism.
> 
> Yeah, that's true.  We could modify options 2 or 3 to be less absolute.
> Though I think that makes them more prone to future breakage.
> 
> > FWIW, I don't care that much about preserving gdb's partial ability to
> > unwind through pt_regs, especially because gdb really ought to be able
> > to use DWARF, too.
> 
> Hm, that's a good point.  I really don't know if there are any other
> external tools out there that would care.  Maybe we could try option 4
> and then see if anybody complains.

I'm starting to think hare-brained option 4 is the way to go.  Any
external tooling should really be relying on DWARF anyway.

Here's a sneak preview.  If this general approach looks ok to you, I'll
go ahead and port all the in-tree unwinders and post a proper patch.

Instead of using xor -1 on the pt_regs pointer, I just cleared the
high-order bit.  That makes the unwinding experience much more pleasant
for a human stack walker, and also ensures that anybody trying to
dereference it gets slapped with an oops, at least in the 48-bit address
space era.

diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
index 9a9e588..bf397426 100644
--- a/arch/x86/entry/calling.h
+++ b/arch/x86/entry/calling.h
@@ -201,6 +201,23 @@ For 32-bit we have the following conventions - kernel is built with
 	.byte 0xf1
 	.endm
 
+	/*
+	 * This is a sneaky trick to help the unwinder find pt_regs on the
+	 * stack.  The frame pointer is replaced with an encoded pointer to
+	 * pt_regs.  The encoding is just a clearing of the highest-order bit,
+	 * which makes it an invalid address and is also a signal to the
+	 * unwinder that it's a pt_regs pointer in disguise.
+	 *
+	 * NOTE: This must be called *after* SAVE_EXTRA_REGS because it
+	 * corrupts rbp.
+	 */
+	.macro ENCODE_FRAME_POINTER ptregs_offset=0
+#ifdef CONFIG_FRAME_POINTER
+	leaq \ptregs_offset(%rsp), %rbp
+	btr $63, %rbp
+#endif
+	.endm
+
 #endif /* CONFIG_X86_64 */
 
 /*
diff --git a/arch/x86/entry/entry_64.S b/arch/x86/entry/entry_64.S
index 9ee0da1..eb79652 100644
--- a/arch/x86/entry/entry_64.S
+++ b/arch/x86/entry/entry_64.S
@@ -431,6 +431,7 @@ END(irq_entries_start)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	ENCODE_FRAME_POINTER
 
 	testb	$3, CS(%rsp)
 	jz	1f
@@ -893,6 +894,7 @@ ENTRY(xen_failsafe_callback)
 	ALLOC_PT_GPREGS_ON_STACK
 	SAVE_C_REGS
 	SAVE_EXTRA_REGS
+	ENCODE_FRAME_POINTER
 	jmp	error_exit
 END(xen_failsafe_callback)
 
@@ -936,6 +938,7 @@ ENTRY(paranoid_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	ENCODE_FRAME_POINTER 8
 	movl	$1, %ebx
 	movl	$MSR_GS_BASE, %ecx
 	rdmsr
@@ -983,6 +986,7 @@ ENTRY(error_entry)
 	cld
 	SAVE_C_REGS 8
 	SAVE_EXTRA_REGS 8
+	ENCODE_FRAME_POINTER 8
 	xorl	%ebx, %ebx
 	testb	$3, CS+8(%rsp)
 	jz	.Lerror_kernelspace
@@ -1165,6 +1169,7 @@ ENTRY(nmi)
 	pushq	%r13		/* pt_regs->r13 */
 	pushq	%r14		/* pt_regs->r14 */
 	pushq	%r15		/* pt_regs->r15 */
+	ENCODE_FRAME_POINTER
 
 	/*
 	 * At this point we no longer need to worry about stack damage
@@ -1182,7 +1187,7 @@ ENTRY(nmi)
 	 * do_nmi doesn't modify pt_regs.
 	 */
 	SWAPGS
-	jmp	restore_c_regs_and_iret
+	jmp	restore_regs_and_iret
 
 .Lnmi_from_kernel:
 	/*
