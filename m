Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160622184042.br7ov37pl6eydr3y@treble>
References: <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrWkd1dtSZzrT1gj43frXPYEBFRhY-ToWoMSsdLOROMKcA@mail.gmail.com>
 <20160524022805.sazm456jorfqvdr7@treble>
 <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
 <20160622163011.4fjwalehrzk4a32t@treble>
 <CALCETrVJpFYi=x0nVWSVi3n40Xkig43Y5bRNOO2XNmUuC9Wt+g@mail.gmail.com>
 <20160622182245.4u72jgjg2khxracz@treble>
 <CALCETrXR9iMO1veHREumqTOvQuLYYQFH_=VRhQ6oXusXi+NFNg@mail.gmail.com>
 <20160622184042.br7ov37pl6eydr3y@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Wed, 22 Jun 2016 12:17:25 -0700
Message-ID: <CALCETrWQWhPnFai5_RkLDiNmaxcjVmaYDAGTzQL8fXien8ojSQ@mail.gmail.com>
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

On Wed, Jun 22, 2016 at 11:40 AM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> On Wed, Jun 22, 2016 at 11:26:21AM -0700, Andy Lutomirski wrote:
>> >
>> > So are you suggesting something like:
>> >
>> >         .macro ENTRY_CALL func pt_regs_offset=0
>> >         call \func
>> > 1:      .pushsection .entry_calls, "a"
>> >         .long 1b - .
>> >         .long \pt_regs_offset
>> >         .popsection
>> >         .endm
>> >
>> > and then change every call in the entry code to ENTRY_CALL?
>>
>> Yes, exactly, modulo whether the section name is good.  hpa is
>> probably the authority on that.
>
> Well, as you probably know, I don't really like peppering ENTRY_CALL
> everywhere. :-/

Me neither.  But at least it's less constraining on the
already-fairly-hairy code.

>
> Also I wonder how we could annotate the hypercalls, for example
> DISABLE_INTERRUPTS actually wraps the call in a push/pop pair.

Oh, yuck.  But forcing all the DISABLE_INTERRUPTS and
ENABLE_INTERRUPTS invocations to be in frame pointer regions isn't so
great either.

DWARF solves this problem completely and IMO fairly cleanly.  Maybe we
should add your task flag and then consider removing it again when
DWARF happens.
