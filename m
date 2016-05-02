Return-Path: <jikos@kernel.org>
Date: Mon, 2 May 2016 21:54:20 +0200 (CEST)
From: Jiri Kosina <jikos@kernel.org>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
In-Reply-To: <CALCETrUwHc5G37hoNKou3nBO+5RjenOJqXYR4yGaj9yCZwXbZA@mail.gmail.com>
Message-ID: <alpine.LNX.2.00.1605022153290.27942@cbobk.fhfr.pm>
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
 <CALCETrUwHc5G37hoNKou3nBO+5RjenOJqXYR4yGaj9yCZwXbZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, linuxppc-dev@lists.ozlabs.org, Jessica Yu <jeyu@redhat.com>, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, Vojtech Pavlik <vojtech@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, 2 May 2016, Andy Lutomirski wrote:

> FWIW, I just tried this:
> 
> static bool is_entry_text(unsigned long addr)
> {
>     return addr >= (unsigned long)__entry_text_start &&
>         addr < (unsigned long)__entry_text_end;
> }
> 
> it works.  So the entry code is already annotated reasonably well :)
> 
> I just hacked it up here:
> 
> https://git.kernel.org/cgit/linux/kernel/git/luto/linux.git/commit/?h=stack&id=085eacfe0edfc18768e48340084415dba9a6bd21
> 
> and it seems to work, at least for page faults.  A better
> implementation would print out the entire contents of pt_regs so that
> people reading the stack trace will know the registers at the time of
> the exception, which might be helpful.

Sorry for being dense, but how do you distinguish here between a "real" 
kernel entry, that pushes pt_regs, and any "non-entry" function call that 
passes pt_regs around?

-- 
Jiri Kosina
SUSE Labs
