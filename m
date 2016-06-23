Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160623161950.ovwpvhq43tq35u7k@treble>
References: <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrWkd1dtSZzrT1gj43frXPYEBFRhY-ToWoMSsdLOROMKcA@mail.gmail.com>
 <20160524022805.sazm456jorfqvdr7@treble>
 <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
 <20160622163011.4fjwalehrzk4a32t@treble>
 <CALCETrVJpFYi=x0nVWSVi3n40Xkig43Y5bRNOO2XNmUuC9Wt+g@mail.gmail.com>
 <20160622182245.4u72jgjg2khxracz@treble>
 <CALCETrXR9iMO1veHREumqTOvQuLYYQFH_=VRhQ6oXusXi+NFNg@mail.gmail.com>
 <20160622184042.br7ov37pl6eydr3y@treble>
 <CALCETrWQWhPnFai5_RkLDiNmaxcjVmaYDAGTzQL8fXien8ojSQ@mail.gmail.com>
 <20160623161950.ovwpvhq43tq35u7k@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 23 Jun 2016 09:35:29 -0700
Message-ID: <CALCETrWJ8fdttrM3ZwCgeBBzhJOPGc4PEHT8AZzc=eg7K69nfA@mail.gmail.com>
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

On Thu, Jun 23, 2016 at 9:19 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Wed, Jun 22, 2016 at 12:17:25PM -0700, Andy Lutomirski wrote:
>> On Wed, Jun 22, 2016 at 11:40 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
>> > On Wed, Jun 22, 2016 at 11:26:21AM -0700, Andy Lutomirski wrote:
>> >> >
>> >> > So are you suggesting something like:
>> >> >
>> >> >         .macro ENTRY_CALL func pt_regs_offset=0
>> >> >         call \func
>> >> > 1:      .pushsection .entry_calls, "a"
>> >> >         .long 1b - .
>> >> >         .long \pt_regs_offset
>> >> >         .popsection
>> >> >         .endm
>> >> >
>> >> > and then change every call in the entry code to ENTRY_CALL?
>> >>
>> >> Yes, exactly, modulo whether the section name is good.  hpa is
>> >> probably the authority on that.
>> >
>> > Well, as you probably know, I don't really like peppering ENTRY_CALL
>> > everywhere. :-/
>>
>> Me neither.  But at least it's less constraining on the
>> already-fairly-hairy code.
>>
>> >
>> > Also I wonder how we could annotate the hypercalls, for example
>> > DISABLE_INTERRUPTS actually wraps the call in a push/pop pair.
>>
>> Oh, yuck.  But forcing all the DISABLE_INTERRUPTS and
>> ENABLE_INTERRUPTS invocations to be in frame pointer regions isn't so
>> great either.
>
> Hm, I don't follow this statement.  Why not?  The more frame pointer
> coverage, the better, especially if it doesn't add any additional
> overhead.

Less flexibility, and it's IMO annoying to make the Xen case have
extra constraints.  It also makes it very awkward or impossible to
take advantage of the sti interrupt window, although admittedly that
doesn't work on Xen either, so maybe that's moot.

>
>> DWARF solves this problem completely and IMO fairly cleanly.  Maybe we
>> should add your task flag and then consider removing it again when
>> DWARF happens.
>
> I tend to doubt we'd be able to remove it later.  As you said before,
> many embedded platforms probably won't be able to switch to DWARF, and
> they'll want to do live patching too.
>
> So which is the least-bad option?  To summarize:
>
>   1) task flag(s) for preemption and page faults
>
>   2) turn pt_regs into a stack frame
>
>   3) annotate all calls from entry code in a table
>
>   4) encode rbp on entry
>
> They all have their issues, though I'm partial to #2.
>
> Any more hare-brained ideas? :-)

I'll try to take a closer look at #2 and see just how much I dislike
all the stack frame munging.  Also, in principle, it's only the
sleeping calls and the calls that make it into real (non-entry) kernel
code that really want to be unwindable through this mechanism.

FWIW, I don't care that much about preserving gdb's partial ability to
unwind through pt_regs, especially because gdb really ought to be able
to use DWARF, too.

--Andy
