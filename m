Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1605240101030.31937@cbobk.fhfr.pm>
References: <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
 <20160502135243.jkbnonaesv7zfios@treble>
 <CALCETrWc5VFyo9tE5fQGKfijqCjguSSci71HSe58Z1_AL1ZHmQ@mail.gmail.com>
 <20160519231546.yvtqz5wacxvykvn2@treble>
 <CALCETrXMyssjtX0RJJRzzAJ2-5fygsmWutb2-rnzbCjSDwSxxg@mail.gmail.com>
 <20160520140513.dsgfb5sei52qge3w@treble>
 <CALCETrUHgw4sMAB_hqa8O3_AaOWBpd=DbB=nv9J9qLfq+=n9uQ@mail.gmail.com>
 <20160520164128.4rypa3pnkkyq6jvz@treble>
 <CALCETrUcHGkB_uQVYM_UZxM-tG1DqtUZY9T3=G0g9QKD-Xn=Sg@mail.gmail.com>
 <alpine.LNX.2.00.1605240101030.31937@cbobk.fhfr.pm>
From: Andy Lutomirski <luto@amacapital.net>
Date: Mon, 23 May 2016 18:42:49 -0700
Message-ID: <CALCETrX=c4BeUA7MzWcg6fLsTggUOaC4mDVDVxYOYDBCe0F2oQ@mail.gmail.com>
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
To: Jiri Kosina <jikos@kernel.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, linuxppc-dev@lists.ozlabs.org, Jessica Yu <jeyu@redhat.com>, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, Vojtech Pavlik <vojtech@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, May 23, 2016 at 4:02 PM, Jiri Kosina <jikos@kernel.org> wrote:
> On Fri, 20 May 2016, Andy Lutomirski wrote:
>
>> I think it would be negligible, at least for interrupts, since
>> interrupts are already extremely expensive.  But I don't love adding
>> assembly code that makes them even slower.  The real thing I dislike
>> about this approach is that it's not a normal stack frame, so you need
>> code in the unwinder to unwind through it correctly, which makes me
>> think that you're not saving much complexity by adding the pushes.
>
> I fail to see what is so special about the stack frame; it's in fact
> pretty normal.
>
> It has added semantic value for "those who know", but the others will
> (pretty much correctly) consider it to be a stackframe from a function
> call, and be done with it.
>
> What am I missing?

In Josh's code, the stack looks like:

...
interrupted frame
pt_regs
pointer to pt_regs
address of pt_regs dummy function
rbp
handler frame

A naive unwinder won't unwind this correctly, as there's no link back
to the interrupted frame's RIP.  If the layout changed to:


...
interrupted frame
pt_regs
interrupted RIP
rbp
handler frame

then I think it would unwind correctly, but the pt_regs would be
invisible, which is IMO a bit unfortunate.  It could also be (I
think):


...
interrupted frame
pt_regs
interrupted rbp
interrupted RIP
pointer to pt_regs
address of pt_regs dummy function
pointer to "interrupted RIP" stack slot
handler frame

but now this is *five* pushes for the dummy frame, which I think is
getting a bit out of hand.

--Andy
