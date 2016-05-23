Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160519231546.yvtqz5wacxvykvn2@treble>
References: <20160429201139.pudoged2yathyo64@treble>
 <CALCETrW8G8qCHBkH7GFDTFuH82abJpbVq_-bDaRAdL7U0jLGNQ@mail.gmail.com>
 <20160429202701.yijrohqdsurdxv2a@treble>
 <CALCETrVKt8k11ewSOvGiCNsqgtD5cMaLix8Tf8JJakgodJeLyA@mail.gmail.com>
 <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 23 May 2016 14:34:56 -0700
Message-ID: <CALCETrWkd1dtSZzrT1gj43frXPYEBFRhY-ToWoMSsdLOROMKcA@mail.gmail.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Content-Type: text/plain; charset=UTF-8
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, linuxppc-dev@lists.ozlabs.org, Jessica Yu <jeyu@redhat.com>, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, Vojtech Pavlik <vojtech@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Thu, May 19, 2016 at 4:15 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Mon, May 02, 2016 at 08:52:41AM -0700, Andy Lutomirski wrote:
>> On Mon, May 2, 2016 at 6:52 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> > On Fri, Apr 29, 2016 at 05:08:50PM -0700, Andy Lutomirski wrote:
>> >> On Apr 29, 2016 3:41 PM, "Josh Poimboeuf" <jpoimboe@redhat.com> wrote:
>> >> >
>> >> > On Fri, Apr 29, 2016 at 02:37:41PM -0700, Andy Lutomirski wrote:
>> >> > > On Fri, Apr 29, 2016 at 2:25 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> >> > > >> I suppose we could try to rejigger the code so that rbp points to
>> >> > > >> pt_regs or similar.
>> >> > > >
>> >> > > > I think we should avoid doing something like that because it would break
>> >> > > > gdb and all the other unwinders who don't know about it.
>> >> > >
>> >> > > How so?
>> >> > >
>> >> > > Currently, rbp in the entry code is meaningless.  I'm suggesting that,
>> >> > > when we do, for example, 'call \do_sym' in idtentry, we point rbp to
>> >> > > the pt_regs.  Currently it points to something stale (which the
>> >> > > dump_stack code might be relying on.  Hmm.)  But it's probably also
>> >> > > safe to assume that if you unwind to the 'call \do_sym', then pt_regs
>> >> > > is the next thing on the stack, so just doing the section thing would
>> >> > > work.
>> >> >
>> >> > Yes, rbp is meaningless on the entry from user space.  But if an
>> >> > in-kernel interrupt occurs (e.g. page fault, preemption) and you have
>> >> > nested entry, rbp keeps its old value, right?  So the unwinder can walk
>> >> > past the nested entry frame and keep going until it gets to the original
>> >> > entry.
>> >>
>> >> Yes.
>> >>
>> >> It would be nice if we could do better, though, and actually notice
>> >> the pt_regs and identify the entry.  For example, I'd love to see
>> >> "page fault, RIP=xyz" printed in the middle of a stack dump on a
>> >> crash.
>> >>
>> >> Also, I think that just following rbp links will lose the
>> >> actual function that took the page fault (or whatever function
>> >> pt_regs->ip actually points to).
>> >
>> > Hm.  I think we could fix all that in a more standard way.  Whenever a
>> > new pt_regs frame gets saved on entry, we could also create a new stack
>> > frame which points to a fake kernel_entry() function.  That would tell
>> > the unwinder there's a pt_regs frame without otherwise breaking frame
>> > pointers across the frame.
>> >
>> > Then I guess we wouldn't need my other solution of putting the idt
>> > entries in a special section.
>> >
>> > How does that sound?
>>
>> Let me try to understand.
>>
>> The normal call sequence is call; push %rbp; mov %rsp, %rbp.  So rbp
>> points to (prev rbp, prev rip) on the stack, and you can follow the
>> chain back.  Right now, on a user access page fault or similar, we
>> have rbp (probably) pointing to the interrupted frame, and the
>> interrupted rip isn't saved anywhere that a naive unwinder can find
>> it.  (It's in pt_regs, but the rbp chain skips right over that.)
>>
>> We could change the entry code so that an interrupt / idtentry does:
>>
>> push pt_regs
>> push kernel_entry
>> push %rbp
>> mov %rsp, %rbp
>> call handler
>> pop %rbp
>> addq $8, %rsp
>>
>> or similar.  That would make it appear that the actual C handler was
>> caused by a dummy function "kernel_entry".  Now the unwinder would get
>> to kernel_entry, but it *still* wouldn't find its way to the calling
>> frame, which only solves part of the problem.  We could at least teach
>> the unwinder how kernel_entry works and let it decode pt_regs to
>> continue unwinding.  This would be nice, and I think it could work.
>>
>> I think I like this, except that, if it used a separate section, it
>> could potentially be faster, as, for each actual entry type, the
>> offset from the C handler frame to pt_regs is a foregone conclusion.
>> But this is pretty simple and performance is already abysmal in most
>> handlers.
>>
>> There's an added benefit to using a separate section, though: we could
>> also annotate the calls with what type of entry they were so the
>> unwinder could print it out nicely.
>>
>> I could be convinced either way.
>
> Ok, I took a stab at this.  See the patch below.
>
> In addition to annotating interrupt/exception pt_regs frames, I also
> annotated all the syscall pt_regs, for consistency.
>
> As you mentioned, it will affect performance a bit, but I think it will
> be insignificant.
>
> I think I like this approach better than putting the
> interrupt/idtentry's in a special section, because this is much more
> precise.  Especially now that I'm annotating pt_regs syscalls.
>
> Also I think with a few minor changes we could implement your idea of
> annotating the calls with what type of entry they are.  But I don't
> think that's really needed, because the name of the interrupt/idtentry
> is already on the stack trace.
>
> Before:
>
>   [<ffffffff8143c243>] dump_stack+0x85/0xc2
>   [<ffffffff81073596>] __do_page_fault+0x576/0x5a0
>   [<ffffffff8107369c>] trace_do_page_fault+0x5c/0x2e0
>   [<ffffffff8106d83c>] do_async_page_fault+0x2c/0xa0
>   [<ffffffff81887058>] async_page_fault+0x28/0x30
>   [<ffffffff81451560>] ? copy_page_to_iter+0x70/0x440
>   [<ffffffff811ebeac>] ? pagecache_get_page+0x2c/0x290
>   [<ffffffff811edaeb>] generic_file_read_iter+0x26b/0x770
>   [<ffffffff81285e32>] __vfs_read+0xe2/0x140
>   [<ffffffff81286378>] vfs_read+0x98/0x140
>   [<ffffffff812878c8>] SyS_read+0x58/0xc0
>   [<ffffffff81884dbc>] entry_SYSCALL_64_fastpath+0x1f/0xbd
>
> After:
>
>   [<ffffffff8143c243>] dump_stack+0x85/0xc2
>   [<ffffffff81073596>] __do_page_fault+0x576/0x5a0
>   [<ffffffff8107369c>] trace_do_page_fault+0x5c/0x2e0
>   [<ffffffff8106d83c>] do_async_page_fault+0x2c/0xa0
>   [<ffffffff81887422>] async_page_fault+0x32/0x40
>   [<ffffffff81887861>] pt_regs+0x1/0x10
>   [<ffffffff81451560>] ? copy_page_to_iter+0x70/0x440
>   [<ffffffff811ebeac>] ? pagecache_get_page+0x2c/0x290
>   [<ffffffff811edaeb>] generic_file_read_iter+0x26b/0x770
>   [<ffffffff81285e32>] __vfs_read+0xe2/0x140
>   [<ffffffff81286378>] vfs_read+0x98/0x140
>   [<ffffffff812878c8>] SyS_read+0x58/0xc0
>   [<ffffffff81884dc6>] entry_SYSCALL_64_fastpath+0x29/0xdb
>   [<ffffffff81887861>] pt_regs+0x1/0x10
>
> Note this example is with today's unwinder.  It could be made smarter to
> get the RIP from the pt_regs so the '?' could be removed from
> copy_page_to_iter().
>
> Thoughts?

Maybe I'm coming around to liking this idea.

In an ideal world (DWARF support, high-quality unwinder, nice pretty
printer, etc), unwinding across a kernel exception would look like:

 - some_func
 - some_other_func
 - do_page_fault
 - page_fault

After page_fault, the next unwind step takes us to the faulting RIP
(faulting_func) and reports that all GPRs are known.  It should
probably learn this fact from DWARF if DWARF is available, instead of
directly decoding pt_regs, due to a few funny cases in which pt_regs
may be incomplete.  A nice pretty printer could now print all the
regs.

 - faulting_func
 - etc.

For this to work, we don't actually need the unwinder to explicitly
know where pt_regs is.

Food for thought, though: if user code does SYSENTER with TF set,
you'll end up with partial pt_regs.  There's nothing the kernel can do
about it.  DWARF will handle it without any fanfare, but I don't know
if it's going to cause trouble for you pre-DWARF.

I'm also not sure it makes sense to apply this before the unwinder
that can consume it is ready.  Maybe, if it would be consistent with
your plans, it would make sense to rewrite the unwinder first, then
apply this and teach live patching to use the new unwinder, and *then*
add DWARF support?


>
> +       /*
> +        * Create a stack frame for the saved pt_regs.  This allows frame
> +        * pointer based unwinders to find pt_regs on the stack.
> +        */
> +       .macro CREATE_PT_REGS_FRAME regs=%rsp
> +#ifdef CONFIG_FRAME_POINTER
> +       pushq   \regs
> +       pushq   $pt_regs+1

Why the +1?

> +       pushq   %rbp
> +       movq    %rsp, %rbp
> +#endif
> +       .endm

I keep wanting this to be only two pushes and to fudge rbp to make it
work, but I don't see a good way.  But let's call it
CREATE_NESTED_ENTRY_FRAME or something, and let's rename pt_regs to
nested_frame or similar.

> +
> +       .macro CALL_HANDLER handler regs=%rsp
> +       CREATE_PT_REGS_FRAME \regs
> +       call    \handler
> +       REMOVE_PT_REGS_FRAME
> +       .endm

I think I'd rather open-code this everywhere.  It'll make it clearer
what's going on.

> @@ -199,6 +199,7 @@ entry_SYSCALL_64_fastpath:
>         ja      1f                              /* return -ENOSYS (already in pt_regs->ax) */
>         movq    %r10, %rcx
>
> +       CREATE_PT_REGS_FRAME
>         /*
>          * This call instruction is handled specially in stub_ptregs_64.
>          * It might end up jumping to the slow path.  If it jumps, RAX
> @@ -207,6 +208,8 @@ entry_SYSCALL_64_fastpath:
>         call    *sys_call_table(, %rax, 8)
>  .Lentry_SYSCALL_64_after_fastpath_call:
>
> +       REMOVE_PT_REGS_FRAME
> +

As discussed, let's get rid of this bit.

>         movq    %rax, RAX(%rsp)
>  1:
>
> @@ -238,14 +241,14 @@ entry_SYSCALL_64_fastpath:
>         ENABLE_INTERRUPTS(CLBR_NONE)
>         SAVE_EXTRA_REGS
>         movq    %rsp, %rdi
> -       call    syscall_return_slowpath /* returns with IRQs disabled */
> +       CALL_HANDLER syscall_return_slowpath    /* returns with IRQs disabled */

and this.

>         jmp     return_from_SYSCALL_64
>
>  entry_SYSCALL64_slow_path:
>         /* IRQs are off. */
>         SAVE_EXTRA_REGS
>         movq    %rsp, %rdi
> -       call    do_syscall_64           /* returns with IRQs disabled */
> +       CALL_HANDLER do_syscall_64      /* returns with IRQs disabled */
>
>  return_from_SYSCALL_64:
>         RESTORE_EXTRA_REGS
> @@ -344,6 +347,7 @@ ENTRY(stub_ptregs_64)
>         DISABLE_INTERRUPTS(CLBR_NONE)
>         TRACE_IRQS_OFF
>         popq    %rax
> +       REMOVE_PT_REGS_FRAME

This will be less mysterious if you open-code the macros.  Also, I
think you have to, some return_from_SYSCALL_64 needs to be directly
after the actual call instruction.  (But if you get rid of the hunks
above, I think this goes away too, so this may be moot.)

>  1:
> @@ -372,7 +376,7 @@ END(ptregs_\func)
>  ENTRY(ret_from_fork)
>         LOCK ; btr $TIF_FORK, TI_flags(%r8)
>
> -       call    schedule_tail                   /* rdi: 'prev' task parameter */
> +       CALL_HANDLER schedule_tail              /* rdi: 'prev' task parameter */
>

If you end up making the unwinder smart enough to notice that rsp is
just below pt_regs, then this can go away.  It's harmless, though.

>         testb   $3, CS(%rsp)                    /* from kernel_thread? */
>         jnz     1f
> @@ -385,8 +389,9 @@ ENTRY(ret_from_fork)
>          * parameter to be passed in RBP.  The called function is permitted
>          * to call do_execve and thereby jump to user mode.
>          */
> +       movq    RBX(%rsp), %rbx
>         movq    RBP(%rsp), %rdi
> -       call    *RBX(%rsp)
> +       CALL_HANDLER *%rbx

Does using a register like this actually save any code size?
Admittedly, it's a bit cleaner.

> +
> +/* fake function which allows stack unwinders to detect pt_regs frames */
> +#ifdef CONFIG_FRAME_POINTER
> +ENTRY(pt_regs)
> +       nop
> +       nop
> +ENDPROC(pt_regs)
> +#endif /* CONFIG_FRAME_POINTER */

Why is this two bytes long?  Is there some reason it has to be more
than one byte?

--Andy
