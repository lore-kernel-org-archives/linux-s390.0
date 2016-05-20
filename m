Return-Path: <jpoimboe@redhat.com>
Date: Fri, 20 May 2016 12:49:01 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160520174901.vf57s7drotlxd4gx@treble>
References: <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrXMyssjtX0RJJRzzAJ2-5fygsmWutb2-rnzbCjSDwSxxg@mail.gmail.com>
 <20160520140513.dsgfb5sei52qge3w@treble>
 <CALCETrUHgw4sMAB_hqa8O3_AaOWBpd=DbB=nv9J9qLfq+=n9uQ@mail.gmail.com>
 <20160520164128.4rypa3pnkkyq6jvz@treble>
 <CALCETrUcHGkB_uQVYM_UZxM-tG1DqtUZY9T3=G0g9QKD-Xn=Sg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALCETrUcHGkB_uQVYM_UZxM-tG1DqtUZY9T3=G0g9QKD-Xn=Sg@mail.gmail.com>
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

On Fri, May 20, 2016 at 09:59:38AM -0700, Andy Lutomirski wrote:
> On Fri, May 20, 2016 at 9:41 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > On Fri, May 20, 2016 at 08:41:00AM -0700, Andy Lutomirski wrote:
> >> On Fri, May 20, 2016 at 7:05 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >> > On Thu, May 19, 2016 at 04:39:51PM -0700, Andy Lutomirski wrote:
> >> >> On Thu, May 19, 2016 at 4:15 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> >> >> > Note this example is with today's unwinder.  It could be made smarter to
> >> >> > get the RIP from the pt_regs so the '?' could be removed from
> >> >> > copy_page_to_iter().
> >> >> >
> >> >> > Thoughts?
> >> >>
> >> >> I think we should do that.  The silly sample patch I sent you (or at
> >> >> least that I think I sent you) did that, and it worked nicely.
> >> >
> >> > Yeah, we can certainly do something similar to make the unwinder
> >> > smarter.  It should be very simple with this approach: if it finds the
> >> > pt_regs() function on the stack, the (struct pt_regs *) pointer will be
> >> > right after it.
> >>
> >> That seems barely easier than checking if it finds a function in
> >> .entry that's marked on the stack,
> >
> > Don't forget you'd also have to look up the function's pt_regs offset in
> > the table.
> >
> >> and the latter has no runtime cost.
> >
> > Well, I had been assuming the three extra pushes and one extra pop for
> > interrupts would be negligible, but I'm definitely no expert there.  Any
> > idea how I can measure it?
> 
> I think it would be negligible, at least for interrupts, since
> interrupts are already extremely expensive.  But I don't love adding
> assembly code that makes them even slower.

I just don't find that very convincing :-)  If the performance impact is
negligible, we should ignore it.  We should instead be focusing on
finding the simplest solution.

> The real thing I dislike about this approach is that it's not a normal
> stack frame, so you need code in the unwinder to unwind through it
> correctly, which makes me think that you're not saving much complexity
> by adding the pushes.  But maybe I'm wrong.

Hm, I view it differently.  Sure the stack frame is a bit unusual, but
as far as unwinders go, it _is_ normal.  So even a stock unwinder can
show the user that a pt_regs() -- or interrupt_frame() or whatever we
call it -- function was called.  Just knowing that an interrupt occurred
could be useful information, even without the contents of RIP.

> >> > I'm not sure about the idea of a table.  I get the feeling it would add
> >> > more complexity to both the entry code and the unwinder.  How would you
> >> > specify the pt_regs location when it's on a different stack?  (See the
> >> > interrupt macro: non-nested interrupts will place pt_regs on the task
> >> > stack before switching to the irq stack.)
> >>
> >> Hmm.  I need to think about the interrupt stack case a bit.  Although
> >> the actual top of the interrupt stack has a nearly fixed format, and I
> >> have old patches to clean it up and make it actually be fixed.  I'll
> >> try to dust those off and resend them soon.
> >
> > How would that solve the problem?  Would pt_regs be moved or copied to
> > the irq stack?
> 
> Hmm.
> 
> Maybe the right way would be to unwind off the IRQ stack in two steps.
> Step one would be to figure out that you're on the IRQ stack and pop
> your way off it.  Step two would be to find pt_regs.
> 
> But that could be rather nasty to implement.  Maybe what we actually
> want to do is this:
> 
> First, apply this thing:
> 
> https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/commit/?h=x86/entry_ist&id=2231ec7e0bcc1a2bc94a17081511ab54cc6badd1
> 
> that gives us a common format for the IRQ stack.
> 
> Second, use my idea of making a table of offsets to pt_regs, so we'd
> have, roughly:
> 
> ENTER_IRQ_STACK old_rsp=%r11
> call __do_softirq
> ANNOTATE_IRQSTACK_PTREGS_CALL offset=0
> LEAVE_IRQ_STACK
> 
> the idea here is that offset=0 means that there is no offset beyond
> that implied by ENTER_IRQ_STACK.  What actually gets written to the
> table is offset 8, because ENTER_IRQ_STACK itself does one push.
> 
> So far, this has no runtime overhead at all.
> 
> Then, in the unwinder, the logic becomes:
> 
> If the return address is annotated in the ptregs entry table, look up
> the offset.  If the offset is in bounds, then use it.  If the offset
> is out of bounds and we're on the IRQ stack, then unwind the
> ENTER_IRQ_STACK as well.
> 
> Does that seem reasonable?  I can try to implement it and see what it
> looks like.

To be honest I'm not crazy about it.  The ANNOTATE_IRQSTACK_PTREGS_CALL
macro needs knowledge about the implementation of ENTER_IRQ_STACK and
how many pushes it does.  I think that makes the entry code more complex
and harder to understand than my patch.

Also the unwinders would need to be quite a bit more complex, and would
need to know more of the intimate details of the irq stack.  That's
probably a less important consideration than entry code complexity, but
it's still significant when you consider the fact that the kernel has
many unwinders, both in-kernel and out-of-kernel.

-- 
Josh
