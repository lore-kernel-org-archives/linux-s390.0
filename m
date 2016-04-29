Return-Path: <jpoimboe@redhat.com>
Date: Fri, 29 Apr 2016 17:57:57 -0500
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160429225757.n7mjjysomnf5ns53@treble>
References: <cover.1461875890.git.jpoimboe@redhat.com>
 <f8816223098569a9b2f478caa5b4a7a0c27dda00.1461875890.git.jpoimboe@redhat.com>
 <CALCETrVjJdPCE92D6NY3B2+0STAdWL0pbNqCBfQUwn-sVWLD5w@mail.gmail.com>
 <20160429201139.pudoged2yathyo64@treble>
 <CALCETrW8G8qCHBkH7GFDTFuH82abJpbVq_-bDaRAdL7U0jLGNQ@mail.gmail.com>
 <20160429202701.yijrohqdsurdxv2a@treble>
 <CALCETrVKt8k11ewSOvGiCNsqgtD5cMaLix8Tf8JJakgodJeLyA@mail.gmail.com>
 <20160429212546.t26mvthtvh7543ff@treble>
 <CALCETrV2wtsEZH-OEDDGzYK-s02EeCWq1MZsYbrdjfyrbU7ugw@mail.gmail.com>
 <alpine.LNX.2.00.1604300007070.27368@cbobk.fhfr.pm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LNX.2.00.1604300007070.27368@cbobk.fhfr.pm>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Jiri Kosina <jikos@kernel.org>
Cc: Andy Lutomirski <luto@amacapital.net>, Jessica Yu <jeyu@redhat.com>, Miroslav Benes <mbenes@suse.cz>, Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, live-patching@vger.kernel.org, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>, linuxppc-dev@lists.ozlabs.org, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Petr Mladek <pmladek@suse.com>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>
List-ID: <linux-s390.vger.kernel.org>

On Sat, Apr 30, 2016 at 12:11:45AM +0200, Jiri Kosina wrote:
> On Fri, 29 Apr 2016, Andy Lutomirski wrote:
> > > NMI, MCE and interrupts aren't a problem because they have dedicated
> > > stacks, which are easy to detect.  If the tasks' stack is on an
> > > exception stack or an irq stack, we consider it unreliable.
> > 
> > Only on x86_64.
> 
> Well, MCEs are more or less x86-specific as well. But otherwise good 
> point, thanks Andy.
> 
> So, how does stack layout generally look like in case when NMI is actually 
> running on proper kernel stack? I thought it's guaranteed to contain 
> pt_regs anyway in all cases. Is that not guaranteed to be the case?

If the NMI were using the normal kernel stack and it interrupted kernel
space, pt_regs would be placed in the "middle" of the stack rather than
the bottom, and there's currently no way to detect that.

However, NMIs don't sleep, and we only consider sleeping tasks for stack
reliability, so it wouldn't be an issue anyway.

-- 
Josh
