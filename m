Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160520140513.dsgfb5sei52qge3w@treble>
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
 <20160520140513.dsgfb5sei52qge3w@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 20 May 2016 08:41:00 -0700
Message-ID: <CALCETrUHgw4sMAB_hqa8O3_AaOWBpd=DbB=nv9J9qLfq+=n9uQ@mail.gmail.com>
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

On Fri, May 20, 2016 at 7:05 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, May 19, 2016 at 04:39:51PM -0700, Andy Lutomirski wrote:
>> On Thu, May 19, 2016 at 4:15 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> > Note this example is with today's unwinder.  It could be made smarter to
>> > get the RIP from the pt_regs so the '?' could be removed from
>> > copy_page_to_iter().
>> >
>> > Thoughts?
>>
>> I think we should do that.  The silly sample patch I sent you (or at
>> least that I think I sent you) did that, and it worked nicely.
>
> Yeah, we can certainly do something similar to make the unwinder
> smarter.  It should be very simple with this approach: if it finds the
> pt_regs() function on the stack, the (struct pt_regs *) pointer will be
> right after it.

That seems barely easier than checking if it finds a function in
.entry that's marked on the stack, and the latter has no runtime cost.

>
>> > diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
>> > index 9a9e588..f54886a 100644
>> > --- a/arch/x86/entry/calling.h
>> > +++ b/arch/x86/entry/calling.h
>> > @@ -201,6 +201,32 @@ For 32-bit we have the following conventions - kernel is built with
>> >         .byte 0xf1
>> >         .endm
>> >
>> > +       /*
>> > +        * Create a stack frame for the saved pt_regs.  This allows frame
>> > +        * pointer based unwinders to find pt_regs on the stack.
>> > +        */
>> > +       .macro CREATE_PT_REGS_FRAME regs=%rsp
>> > +#ifdef CONFIG_FRAME_POINTER
>> > +       pushq   \regs
>> > +       pushq   $pt_regs+1
>> > +       pushq   %rbp
>> > +       movq    %rsp, %rbp
>> > +#endif
>> > +       .endm
>>
>> I don't love this part.  It's going to hurt performance, and, given
>> that we need to change the unwinder anyway to make it useful, let's
>> just emit a table somewhere in .rodata and use it directly.
>
> I'm not sure about the idea of a table.  I get the feeling it would add
> more complexity to both the entry code and the unwinder.  How would you
> specify the pt_regs location when it's on a different stack?  (See the
> interrupt macro: non-nested interrupts will place pt_regs on the task
> stack before switching to the irq stack.)

Hmm.  I need to think about the interrupt stack case a bit.  Although
the actual top of the interrupt stack has a nearly fixed format, and I
have old patches to clean it up and make it actually be fixed.  I'll
try to dust those off and resend them soon.

>
> If you're worried about performance, I can remove the syscall
> annotations.  They're optional anyway, since the pt_regs is always at
> the same place on the stack for syscalls.
>
> I think three extra pushes wouldn't be a performance issue for
> interrupts/exceptions.  And they'll go away when we finally bury
> CONFIG_FRAME_POINTER.

I bet we'll always need to support CONFIG_FRAME_POINTER for some
embedded systems.

I'll play with this a bit.

--Andy
