Return-Path: <jpoimboe@redhat.com>
Date: Thu, 23 Jun 2016 13:31:32 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160623183132.oqtl6flnoqtilurs@treble>
References: <20160524022805.sazm456jorfqvdr7@treble>
 <CALCETrVNj2bscRZmSyzq4fMp5s3m0+KqpEFofv_uXsHF_na_=Q@mail.gmail.com>
 <20160622163011.4fjwalehrzk4a32t@treble>
 <CALCETrVJpFYi=x0nVWSVi3n40Xkig43Y5bRNOO2XNmUuC9Wt+g@mail.gmail.com>
 <20160622182245.4u72jgjg2khxracz@treble>
 <CALCETrXR9iMO1veHREumqTOvQuLYYQFH_=VRhQ6oXusXi+NFNg@mail.gmail.com>
 <20160622184042.br7ov37pl6eydr3y@treble>
 <CALCETrWQWhPnFai5_RkLDiNmaxcjVmaYDAGTzQL8fXien8ojSQ@mail.gmail.com>
 <20160623161950.ovwpvhq43tq35u7k@treble>
 <CALCETrWJ8fdttrM3ZwCgeBBzhJOPGc4PEHT8AZzc=eg7K69nfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALCETrWJ8fdttrM3ZwCgeBBzhJOPGc4PEHT8AZzc=eg7K69nfA@mail.gmail.com>
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

On Thu, Jun 23, 2016 at 09:35:29AM -0700, Andy Lutomirski wrote:
> > So which is the least-bad option?  To summarize:
> >
> >   1) task flag(s) for preemption and page faults
> >
> >   2) turn pt_regs into a stack frame
> >
> >   3) annotate all calls from entry code in a table
> >
> >   4) encode rbp on entry
> >
> > They all have their issues, though I'm partial to #2.
> >
> > Any more hare-brained ideas? :-)
> 
> I'll try to take a closer look at #2 and see just how much I dislike
> all the stack frame munging.

Ok.

> Also, in principle, it's only the
> sleeping calls and the calls that make it into real (non-entry) kernel
> code that really want to be unwindable through this mechanism.

Yeah, that's true.  We could modify options 2 or 3 to be less absolute.
Though I think that makes them more prone to future breakage.

> FWIW, I don't care that much about preserving gdb's partial ability to
> unwind through pt_regs, especially because gdb really ought to be able
> to use DWARF, too.

Hm, that's a good point.  I really don't know if there are any other
external tools out there that would care.  Maybe we could try option 4
and then see if anybody complains.

-- 
Josh
