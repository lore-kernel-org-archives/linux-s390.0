Return-Path: <jpoimboe@redhat.com>
Date: Mon, 2 May 2016 08:52:43 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160502135243.jkbnonaesv7zfios@treble>
References: <f8816223098569a9b2f478caa5b4a7a0c27dda00.1461875890.git.jpoimboe@redhat.com>
 <CALCETrVjJdPCE92D6NY3B2+0STAdWL0pbNqCBfQUwn-sVWLD5w@mail.gmail.com>
 <20160429201139.pudoged2yathyo64@treble>
 <CALCETrW8G8qCHBkH7GFDTFuH82abJpbVq_-bDaRAdL7U0jLGNQ@mail.gmail.com>
 <20160429202701.yijrohqdsurdxv2a@treble>
 <CALCETrVKt8k11ewSOvGiCNsqgtD5cMaLix8Tf8JJakgodJeLyA@mail.gmail.com>
 <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <20160429224112.kl3jlk7ccvfceg2r@treble>
 <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <CALCETrUvRKYpF5MuhYuHSxd1QFnzSNKdXUQp+3to6rzKzQjQSw@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, linuxppc-dev@lists.ozlabs.org, Jessica Yu <jeyu@redhat.com>, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, Vojtech Pavlik <vojtech@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Fri, Apr 29, 2016 at 05:08:50PM -0700, Andy Lutomirski wrote:
> On Apr 29, 2016 3:41 PM, "Josh Poimboeuf" <jpoimboe@redhat.com> wrote:
> >
> > On Fri, Apr 29, 2016 at 02:37:41PM -0700, Andy Lutomirski wrote:
> > > On Fri, Apr 29, 2016 at 2:25 PM, Josh Poimboeuf <jpoimboe@redhat.com> wrote:
> > > >> I suppose we could try to rejigger the code so that rbp points to
> > > >> pt_regs or similar.
> > > >
> > > > I think we should avoid doing something like that because it would break
> > > > gdb and all the other unwinders who don't know about it.
> > >
> > > How so?
> > >
> > > Currently, rbp in the entry code is meaningless.  I'm suggesting that,
> > > when we do, for example, 'call \do_sym' in idtentry, we point rbp to
> > > the pt_regs.  Currently it points to something stale (which the
> > > dump_stack code might be relying on.  Hmm.)  But it's probably also
> > > safe to assume that if you unwind to the 'call \do_sym', then pt_regs
> > > is the next thing on the stack, so just doing the section thing would
> > > work.
> >
> > Yes, rbp is meaningless on the entry from user space.  But if an
> > in-kernel interrupt occurs (e.g. page fault, preemption) and you have
> > nested entry, rbp keeps its old value, right?  So the unwinder can walk
> > past the nested entry frame and keep going until it gets to the original
> > entry.
> 
> Yes.
> 
> It would be nice if we could do better, though, and actually notice
> the pt_regs and identify the entry.  For example, I'd love to see
> "page fault, RIP=xyz" printed in the middle of a stack dump on a
> crash.
>
> Also, I think that just following rbp links will lose the
> actual function that took the page fault (or whatever function
> pt_regs->ip actually points to).

Hm.  I think we could fix all that in a more standard way.  Whenever a
new pt_regs frame gets saved on entry, we could also create a new stack
frame which points to a fake kernel_entry() function.  That would tell
the unwinder there's a pt_regs frame without otherwise breaking frame
pointers across the frame.

Then I guess we wouldn't need my other solution of putting the idt
entries in a special section.

How does that sound?

> Have you looked at my vdso unwinding test at all?  If we could do
> something similar for the kernel, IMO it would make testing much more
> pleasant.

I found it, but I'm not sure what it would mean to do something similar
for the kernel.  Do you mean doing something like an NMI sampling-based
approach where we periodically do a random stack sanity check?

(If so, I do have something like that planned.)

-- 
Josh
