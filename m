Return-Path: <jpoimboe@redhat.com>
Date: Thu, 23 Jun 2016 10:55:31 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160623155531.i2kbnokosskimvmf@treble>
References: <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrWkd1dtSZzrT1gj43frXPYEBFRhY-ToWoMSsdLOROMKcA@mail.gmail.com>
 <20160524022805.sazm456jorfqvdr7@treble>
 <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
 <20160622163011.4fjwalehrzk4a32t@treble>
 <CALCETrWs4TNWnVbT=3ksuLNZC_UoymSv8uQw7ynGtoO7-6gXjA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALCETrWs4TNWnVbT=3ksuLNZC_UoymSv8uQw7ynGtoO7-6gXjA@mail.gmail.com>
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

On Wed, Jun 22, 2016 at 05:09:11PM -0700, Andy Lutomirski wrote:
> On Wed, Jun 22, 2016 at 9:30 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > Andy,
> >
> > So I got a chance to look at this some more.  I'm thinking that to make
> > this feature more consistently useful, we shouldn't only annotate
> > pt_regs frames for calls to handlers; other calls should be annotated as
> > well: preempt_schedule_irq, CALL_enter_from_user_mode,
> > prepare_exit_to_usermode, SWAPGS, TRACE_IRQS_OFF, DISABLE_INTERRUPTS,
> > etc.  That way, the unwinder will always be able to find pt_regs from an
> > interrupt/exception, even if starting from one of these other calls.
> >
> > But then, things get ugly.  You have to either setup and tear down the
> > frame for every possible call, or do a higher-level setup/teardown
> > across multiple calls, which invalidates several assumptions in the
> > entry code about the location of pt_regs on the stack.
> >
> 
> Here's yet another harebrained idea.  Maybe it works better than my
> previous harebrained ideas :)
> 
> Your patch is already creating a somewhat nonstandard stack frame:
> 
> +       movq    %rbp,                   0*8(%rsp)
> +       movq    $entry_frame_ret,       1*8(%rsp)
> +       movq    %rsp, %rbp
> 
> It's kind of a normal stack frame, but rbp points at something odd,
> and to unwind it fully correctly, the unwinder needs to know about it.
> 
> What if we made it even more special, along the lines of:
> 
> leaq offset_to_ptregs(%rsp), %rbp
> xorq $-1, %rbp
> 
> IOW, don't write anything to the stack at all, and just put a special
> value into RBP that says "the next frame is pt_regs at such-and-such
> address".  Do this once on entry and make sure to restore RBP (from
> pt_regs) on exit.  Now the unwinder can notice that RBP has the high
> bits clear *and* that the negation of it points to the stack, and it
> can figure out what's going on.
> 
> What do you think?  Am I nuts or could this work?
> 
> It had better not have much risk of breaking things worse than they
> currently are, given that current kernel allow user code to stick any
> value it likes into the very last element of the RBP chain.

I think it's a good idea, and it could work... BUT it would break
external unwinders like gdb for the in-kernel entry case.

For interrupts and exceptions in kernel mode, rbp *is* valid.  Sure, it
doesn't tell you the interrupted function, but it does tell you its
caller.  A generic frame pointer unwinder skips the interrupted
function, but at least it keeps going.  If we encoded rbp on entry, that
would break.

-- 
Josh
