Return-Path: <mingo.kernel.org@gmail.com>
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Mon, 2 May 2016 20:34:29 +0200
From: Ingo Molnar <mingo@kernel.org>
Subject: Re: [RFC PATCH v2 05/18] sched: add task flag for preempt IRQ tracking
Message-ID: <20160502183429.GB16100@gmail.com>
References: <20160429202701.yijrohqdsurdxv2a@treble>
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
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CALCETrUwHc5G37hoNKou3nBO+5RjenOJqXYR4yGaj9yCZwXbZA@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>, Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Chris J Arges <chris.j.arges@canonical.com>, linuxppc-dev@lists.ozlabs.org, Jessica Yu <jeyu@redhat.com>, Petr Mladek <pmladek@suse.com>, Jiri Slaby <jslaby@suse.cz>, Vojtech Pavlik <vojtech@suse.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Miroslav Benes <mbenes@suse.cz>, Peter Zijlstra <peterz@infradead.org>, =?iso-8859-1?Q?Fr=E9d=E9ric?= Weisbecker <fweisbec@gmail.com>
List-ID: <linux-s390.vger.kernel.org>


* Andy Lutomirski <luto@amacapital.net> wrote:

> > Another idea to detect missing frames: for each return address on the stack, 
> > ensure there's a corresponding "call <func>" instruction immediately preceding 
> > the return location, where <func> matches what's on the stack.
> 
> Hmm, interesting.
> 
> I hope your plans include rewriting the current stack unwinder completely.  The 
> thing in print_context_stack is (a) hard-to-understand and hard-to-modify crap 
> and (b) is called in a loop from another file using totally ridiculous 
> conventions.

So we had several attempts at making it better, any further improvements 
(including radical rewrites) are more than welcome!

The generalization between the various stack walking methods certainly didn't make 
things easier to read - we might want to eliminate that by using better primitives 
to iterate over the stack frame.

Thanks,

	Ingo
