Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160623204017.df22mljbrgpogeqp@treble>
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
 <20160623204017.df22mljbrgpogeqp@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Thu, 23 Jun 2016 15:00:40 -0700
Message-ID: <CALCETrXq-uZvxZ4xxLWcHVKx4unjJTe=Gqh0V0rkLz+-6su4gg@mail.gmail.com>
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

On Thu, Jun 23, 2016 at 1:40 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Thu, Jun 23, 2016 at 01:31:32PM -0500, Josh Poimboeuf wrote:
>> On Thu, Jun 23, 2016 at 09:35:29AM -0700, Andy Lutomirski wrote:
>> > > So which is the least-bad option?  To summarize:
>> > >
>> > >   1) task flag(s) for preemption and page faults
>> > >
>> > >   2) turn pt_regs into a stack frame
>> > >
>> > >   3) annotate all calls from entry code in a table
>> > >
>> > >   4) encode rbp on entry
>> > >
>> > > They all have their issues, though I'm partial to #2.
>> > >
>> > > Any more hare-brained ideas? :-)
>> >
>> > I'll try to take a closer look at #2 and see just how much I dislike
>> > all the stack frame munging.
>>
>> Ok.
>>
>> > Also, in principle, it's only the
>> > sleeping calls and the calls that make it into real (non-entry) kernel
>> > code that really want to be unwindable through this mechanism.
>>
>> Yeah, that's true.  We could modify options 2 or 3 to be less absolute.
>> Though I think that makes them more prone to future breakage.
>>
>> > FWIW, I don't care that much about preserving gdb's partial ability to
>> > unwind through pt_regs, especially because gdb really ought to be able
>> > to use DWARF, too.
>>
>> Hm, that's a good point.  I really don't know if there are any other
>> external tools out there that would care.  Maybe we could try option 4
>> and then see if anybody complains.
>
> I'm starting to think hare-brained option 4 is the way to go.  Any
> external tooling should really be relying on DWARF anyway.
>
> Here's a sneak preview.  If this general approach looks ok to you, I'll
> go ahead and port all the in-tree unwinders and post a proper patch.
>
> Instead of using xor -1 on the pt_regs pointer, I just cleared the
> high-order bit.  That makes the unwinding experience much more pleasant
> for a human stack walker, and also ensures that anybody trying to
> dereference it gets slapped with an oops, at least in the 48-bit address
> space era.
>
> diff --git a/arch/x86/entry/calling.h b/arch/x86/entry/calling.h
> index 9a9e588..bf397426 100644
> --- a/arch/x86/entry/calling.h
> +++ b/arch/x86/entry/calling.h
> @@ -201,6 +201,23 @@ For 32-bit we have the following conventions - kernel is built with
>         .byte 0xf1
>         .endm
>
> +       /*
> +        * This is a sneaky trick to help the unwinder find pt_regs on the
> +        * stack.  The frame pointer is replaced with an encoded pointer to
> +        * pt_regs.  The encoding is just a clearing of the highest-order bit,
> +        * which makes it an invalid address and is also a signal to the
> +        * unwinder that it's a pt_regs pointer in disguise.
> +        *
> +        * NOTE: This must be called *after* SAVE_EXTRA_REGS because it
> +        * corrupts rbp.
> +        */
> +       .macro ENCODE_FRAME_POINTER ptregs_offset=0
> +#ifdef CONFIG_FRAME_POINTER
> +       leaq \ptregs_offset(%rsp), %rbp
> +       btr $63, %rbp
> +#endif
> +       .endm
> +

Maybe optimize slightly:

.ifeq \ptregs_offset
mov %rsp, %rbp
.else
leaq \ptregs_offset(%rsp), %rbp
.endif
