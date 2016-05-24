Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160524022805.sazm456jorfqvdr7@treble>
References: <20160429202701.yijrohqdsurdxv2a@treble>
 <CALCETrVKt8k11ewSOvGiCNsqgtD5cMaLix8Tf8JJakgodJeLyA@mail.gmail.com>
 <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrWkd1dtSZzrT1gj43frXPYEBFRhY-ToWoMSsdLOROMKcA@mail.gmail.com>
 <20160524022805.sazm456jorfqvdr7@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 23 May 2016 20:52:12 -0700
Message-ID: <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
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
Cc: Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, Jessica Yu <jeyu@redhat.com>, linuxppc-dev@lists.ozlabs.org, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.com>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On May 23, 2016 7:28 PM, "Josh Poimboeuf" <jpoimboe@redhat.com> wrote:
> > Maybe I'm coming around to liking this idea.
>
> Ok, good :-)
>
> > In an ideal world (DWARF support, high-quality unwinder, nice pretty
> > printer, etc), unwinding across a kernel exception would look like:
> >
> >  - some_func
> >  - some_other_func
> >  - do_page_fault
> >  - page_fault
> >
> > After page_fault, the next unwind step takes us to the faulting RIP
> > (faulting_func) and reports that all GPRs are known.  It should
> > probably learn this fact from DWARF if DWARF is available, instead of
> > directly decoding pt_regs, due to a few funny cases in which pt_regs
> > may be incomplete.  A nice pretty printer could now print all the
> > regs.
> >
> >  - faulting_func
> >  - etc.
> >
> > For this to work, we don't actually need the unwinder to explicitly
> > know where pt_regs is.
>
> That's true (but only for DWARF).
>
> > Food for thought, though: if user code does SYSENTER with TF set,
> > you'll end up with partial pt_regs.  There's nothing the kernel can do
> > about it.  DWARF will handle it without any fanfare, but I don't know
> > if it's going to cause trouble for you pre-DWARF.
>
> In this case it should see the stack pointer is past the pt_regs offset,
> so it would just report it as an empty stack.

OK

>
> > I'm also not sure it makes sense to apply this before the unwinder
> > that can consume it is ready.  Maybe, if it would be consistent with
> > your plans, it would make sense to rewrite the unwinder first, then
> > apply this and teach live patching to use the new unwinder, and *then*
> > add DWARF support?
>
> For the purposes of livepatch, the reliable unwinder needs to detect
> whether an interrupt/exception pt_regs frame exists on a sleeping task
> (or current).  This patch would allow us to do that.
>
> So my preferred order of doing things would be:
>
> 1) Brian Gerst's switch_to() cleanup and any related unwinder fixes
> 2) this patch for annotating pt_regs stack frames
> 3) reliable unwinder, similar to what I already posted, except it relies
>    on this patch instead of PF_PREEMPT_IRQ, and knows how to deal with
>    the new inactive task frame format of #1
> 4) livepatch consistency model which uses the reliable unwinder
> 5) rewrite unwinder, and port all users to the new interface
> 6) add DWARF unwinder
>
> 1-4 are pretty much already written, whereas 5 and 6 will take
> considerably more work.

Fair enough.

>
> > > +       /*
> > > +        * Create a stack frame for the saved pt_regs.  This allows frame
> > > +        * pointer based unwinders to find pt_regs on the stack.
> > > +        */
> > > +       .macro CREATE_PT_REGS_FRAME regs=%rsp
> > > +#ifdef CONFIG_FRAME_POINTER
> > > +       pushq   \regs
> > > +       pushq   $pt_regs+1
> >
> > Why the +1?
>
> Some unwinders like gdb are smart enough to report the function which
> contains the instruction *before* the return address.  Without the +1,
> they would show the wrong function.

Lovely.  Want to add a comment?

>
> > > +       pushq   %rbp
> > > +       movq    %rsp, %rbp
> > > +#endif
> > > +       .endm
> >
> > I keep wanting this to be only two pushes and to fudge rbp to make it
> > work, but I don't see a good way.  But let's call it
> > CREATE_NESTED_ENTRY_FRAME or something, and let's rename pt_regs to
> > nested_frame or similar.
>
> Or, if we aren't going to annotate syscall pt_regs, we could give it a
> more specific name.  CREATE_INTERRUPT_FRAME and interrupt_frame()?

CREATE_INTERRUPT_FRAME is confusing because it applies to idtentry,
too.  CREATE_PT_REGS_FRAME is probably fine.

> > > +
> > > +/* fake function which allows stack unwinders to detect pt_regs frames */
> > > +#ifdef CONFIG_FRAME_POINTER
> > > +ENTRY(pt_regs)
> > > +       nop
> > > +       nop
> > > +ENDPROC(pt_regs)
> > > +#endif /* CONFIG_FRAME_POINTER */
> >
> > Why is this two bytes long?  Is there some reason it has to be more
> > than one byte?
>
> Similar to above, this is related to the need to support various
> unwinders.  Whether the unwinder displays the ret_addr or the
> instruction preceding it, either way the instruction needs to be inside
> the function for the function to be reported.

OK.

--Andy
