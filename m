Return-Path: <luto@amacapital.net>
MIME-Version: 1.0
In-Reply-To: <alpine.LNX.2.00.1604300007070.27368@cbobk.fhfr.pm>
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
From: Andy Lutomirski <luto@amacapital.net>
Date: Fri, 29 Apr 2016 17:09:56 -0700
Message-ID: <CALCETrXC5mVPTKjW7gZG_GGbADbeUPO7X-9ARTOaCVo1icYJkw@mail.gmail.com>
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
Cc: Ingo Molnar <mingo@redhat.com>, Josh Poimboeuf <jpoimboe@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, linuxppc-dev@lists.ozlabs.org, Jessica Yu <jeyu@redhat.com>, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, Vojtech Pavlik <vojtech@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Apr 29, 2016 3:11 PM, "Jiri Kosina" <jikos@kernel.org> wrote:
>
> On Fri, 29 Apr 2016, Andy Lutomirski wrote:
>
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
>

On x86, at least, there will still be pt_regs for the NMI.  For the
interrupted state, though, there might not be pt_regs, as the NMI
might have happened while still populating pt_regs.  In fact, the NMI
stack could overlap task_pt_regs.

For x86_32, there's no guarantee that pt_regs contains sp due to
hardware silliness.  You need to parse it more carefully, as,
!user_mode(regs), then the old sp is just above pt_regs.

--Andy
