Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160502173148.zsg6alhknczzozb5@treble>
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
 <20160502173148.zsg6alhknczzozb5@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 2 May 2016 11:12:39 -0700
Message-ID: <CALCETrUwHc5G37hoNKou3nBO+5RjenOJqXYR4yGaj9yCZwXbZA@mail.gmail.com>
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

On Mon, May 2, 2016 at 10:31 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
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
>
> Yeah, that's about what I had in mind.

FWIW, I just tried this:

static bool is_entry_text(unsigned long addr)
{
    return addr >= (unsigned long)__entry_text_start &&
        addr < (unsigned long)__entry_text_end;
}

it works.  So the entry code is already annotated reasonably well :)

I just hacked it up here:

https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/commit/?h=stack&id=085eacfe0edfc18768e48340084415dba9a6bd21

and it seems to work, at least for page faults.  A better
implementation would print out the entire contents of pt_regs so that
people reading the stack trace will know the registers at the time of
the exception, which might be helpful.

>
>> I think I like this, except that, if it used a separate section, it
>> could potentially be faster, as, for each actual entry type, the
>> offset from the C handler frame to pt_regs is a foregone conclusion.
>
> Hm, this I don't really follow.  It's true that the unwinder can easily
> find RIP from pt_regs, which will always be a known offset from the
> kernel_entry pointer on the stack.  But why would having the entry code
> in a separate section make that faster?

It doesn't make the unwinder faster -- it makes the entry code faster.

>
>> But this is pretty simple and performance is already abysmal in most
>> handlers.
>>
>> There's an added benefit to using a separate section, though: we could
>> also annotate the calls with what type of entry they were so the
>> unwinder could print it out nicely.
>
> Yeah, that could be a nice feature... but doesn't printing the name of
> the C handler pretty much already give that information?
>
> In any case, once we have a working DWARF unwinder, I think it will show
> the name of the idt entry anyway.

True.  And it'll automatically follow pt_regs.

>
>> >> Have you looked at my vdso unwinding test at all?  If we could do
>> >> something similar for the kernel, IMO it would make testing much more
>> >> pleasant.
>> >
>> > I found it, but I'm not sure what it would mean to do something similar
>> > for the kernel.  Do you mean doing something like an NMI sampling-based
>> > approach where we periodically do a random stack sanity check?
>>
>> I was imagining something a little more strict: single-step
>> interesting parts of the kernel and make sure that each step unwinds
>> correctly.  That could detect missing frames and similar.
>
> Interesting idea, though I wonder how hard it would be to reliably
> distinguish a missing frame from the case where gcc decides to inline a
> function.
>
> Another idea to detect missing frames: for each return address on the
> stack, ensure there's a corresponding "call <func>" instruction
> immediately preceding the return location, where <func> matches what's
> on the stack.

Hmm, interesting.

I hope your plans include rewriting the current stack unwinder
completely.  The thing in print_context_stack is (a)
hard-to-understand and hard-to-modify crap and (b) is called in a loop
from another file using totally ridiculous conventions.

--Andy
