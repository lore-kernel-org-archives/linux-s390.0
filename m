Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160622182245.4u72jgjg2khxracz@treble>
References: <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrWkd1dtSZzrT1gj43frXPYEBFRhY-ToWoMSsdLOROMKcA@mail.gmail.com>
 <20160524022805.sazm456jorfqvdr7@treble>
 <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
 <20160622163011.4fjwalehrzk4a32t@treble>
 <CALCETrVJpFYi=x0nVWSVi3n40Xkig43Y5bRNOO2XNmUuC9Wt+g@mail.gmail.com>
 <20160622182245.4u72jgjg2khxracz@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 22 Jun 2016 11:26:21 -0700
Message-ID: <CALCETrXR9iMO1veHREumqTOvQuLYYQFH_=VRhQ6oXusXi+NFNg@mail.gmail.com>
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

On Wed, Jun 22, 2016 at 11:22 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Wed, Jun 22, 2016 at 10:59:23AM -0700, Andy Lutomirski wrote:
>> > So I got a chance to look at this some more.  I'm thinking that to make
>> > this feature more consistently useful, we shouldn't only annotate
>> > pt_regs frames for calls to handlers; other calls should be annotated as
>> > well: preempt_schedule_irq, CALL_enter_from_user_mode,
>> > prepare_exit_to_usermode, SWAPGS, TRACE_IRQS_OFF, DISABLE_INTERRUPTS,
>> > etc.  That way, the unwinder will always be able to find pt_regs from an
>> > interrupt/exception, even if starting from one of these other calls.
>> >
>> > But then, things get ugly.  You have to either setup and tear down the
>> > frame for every possible call, or do a higher-level setup/teardown
>> > across multiple calls, which invalidates several assumptions in the
>> > entry code about the location of pt_regs on the stack.
>> >
>> > Also problematic is that several of the macros (like TRACE_IRQS_IRETQ)
>> > make assumptions about the location of pt_regs.  And they're used by
>> > both syscall and interrupt code.  So if we didn't create a frame pointer
>> > header for syscalls, we'd basically need two versions of the macros: one
>> > for irqs/exceptions and one for syscalls.
>> >
>> > So I think the cleanest way to handle this is to always allocate two
>> > extra registers on the stack in ALLOC_PT_GPREGS_ON_STACK.  Then all
>> > entry code can assume that pt_regs is at a constant location, and all
>> > the above problems go away.  Another benefit is that we'd only need two
>> > saves instead of three -- the pointer to pt_regs is no longer needed
>> > since pt_regs is always immediately after the frame header.
>> >
>> > I worked up a patch to implement this -- see below.  It writes the frame
>> > pointer in all entry paths, including syscalls.  This helps keep the
>> > code simple.
>> >
>> > The downside is a small performance penalty: with getppid()-in-a-loop on
>> > my laptop, the average syscall went from 52ns to 53ns, which is about a
>> > 2% slowdown.  But I doubt it would be measurable in a real-world
>> > workload.
>> >
>> > It looks like about half the slowdown is due to the extra stack
>> > allocation (which presumably adds a little d-cache pressure on the stack
>> > memory) and the other half is due to the stack writes.
>> >
>> > I could remove the writes from the syscall path but it would only save
>> > about half a ns, and it would make the code less robust.  Plus it's nice
>> > to have the consistency of having *all* pt_regs frames annotated.
>>
>> This is a bit messy, and I'm not really sure that the entry code
>> should be have to operate under constraints like this.  Also,
>> convincing myself this works for NMI sounds unpleasant.
>>
>> Maybe we should go back to my idea of just listing the call sites in a table.
>
> So are you suggesting something like:
>
>         .macro ENTRY_CALL func pt_regs_offset=0
>         call \func
> 1:      .pushsection .entry_calls, "a"
>         .long 1b - .
>         .long \pt_regs_offset
>         .popsection
>         .endm
>
> and then change every call in the entry code to ENTRY_CALL?

Yes, exactly, modulo whether the section name is good.  hpa is
probably the authority on that.

--Andy
