Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <20160429224112.kl3jlk7ccvfceg2r@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <f8816223098569a9b2f478caa5b4a7a0c27dda00.1461875890.git.jpoimboe@redhat.com>
 <CALCETrVjJdPCE92D6NY3B2+0STAdWL0pbNqCBfQUwn-sVWLD5w@mail.gmail.com>
 <20160429201139.pudoged2yathyo64@treble>
 <CALCETrW8G8qCHBkH7GFDTFuH82abJpbVq_-bDaRAdL7U0jLGNQ@mail.gmail.com>
 <20160429202701.yijrohqdsurdxv2a@treble>
 <CALCETrVKt8k11ewSOvGiCNsqgtD5cMaLix8Tf8JJakgodJeLyA@mail.gmail.com>
 <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <20160429224112.kl3jlk7ccvfceg2r@treble>
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 29 Apr 2016 17:08:50 -0700
Message-ID: <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
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

On Apr 29, 2016 3:41 PM, "Josh Poimboeuf" <jpoimboe@redhat.com> wrote:
>
> On Fri, Apr 29, 2016 at 02:37:41PM -0700, Andy Lutomirski wrote:
> > On Fri, Apr 29, 2016 at 2:25 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > I think the easiest way to make it work would be to modify the idtentry
> > > macro to put all the idt entries in a dedicated section.  Then the
> > > unwinder could easily detect any calls from that code.
> >
> > That would work.  Would it make sense to do the same for the irq entries?
>
> Yes, I think so.
>
> > >> I suppose we could try to rejigger the code so that rbp points to
> > >> pt_regs or similar.
> > >
> > > I think we should avoid doing something like that because it would break
> > > gdb and all the other unwinders who don't know about it.
> >
> > How so?
> >
> > Currently, rbp in the entry code is meaningless.  I'm suggesting that,
> > when we do, for example, 'call \do_sym' in idtentry, we point rbp to
> > the pt_regs.  Currently it points to something stale (which the
> > dump_stack code might be relying on.  Hmm.)  But it's probably also
> > safe to assume that if you unwind to the 'call \do_sym', then pt_regs
> > is the next thing on the stack, so just doing the section thing would
> > work.
>
> Yes, rbp is meaningless on the entry from user space.  But if an
> in-kernel interrupt occurs (e.g. page fault, preemption) and you have
> nested entry, rbp keeps its old value, right?  So the unwinder can walk
> past the nested entry frame and keep going until it gets to the original
> entry.

Yes.

It would be nice if we could do better, though, and actually notice
the pt_regs and identify the entry.  For example, I'd love to see
"page fault, RIP=xyz" printed in the middle of a stack dump on a
crash.  Also, I think that just following rbp links will lose the
actual function that took the page fault (or whatever function
pt_regs->ip actually points to).

>
> > We should really re-add DWARF some day.
>
> Working on it :-)

Excellent.

Have you looked at my vdso unwinding test at all?  If we could do
something similar for the kernel, IMO it would make testing much more
pleasant.

--Andy
