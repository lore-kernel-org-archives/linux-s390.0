Return-Path: <jpoimboe@redhat.com>
Date: Mon, 19 Dec 2016 11:25:49 -0600
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: Re: [PATCH v3 01/15] stacktrace/x86: add function for detecting
 reliable stack traces
Message-ID: <20161219172549.mjm4c2midvkumqxb@treble>
References: <cover.1481220077.git.jpoimboe@redhat.com>
 <0315b36c08c104d56a4b43537fb300d200418996.1481220077.git.jpoimboe@redhat.com>
 <alpine.LSU.2.20.1612191712530.6638@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <alpine.LSU.2.20.1612191712530.6638@pobox.suse.cz>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Jessica Yu <jeyu@redhat.com>, Jiri Kosina <jikos@kernel.org>, Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org, live-patching@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Heiko Carstens <heiko.carstens@de.ibm.com>, x86@kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, Vojtech Pavlik <vojtech@suse.com>, Jiri Slaby <jslaby@suse.cz>, Chris J Arges <chris.j.arges@canonical.com>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Dec 19, 2016 at 05:25:19PM +0100, Miroslav Benes wrote:
> On Thu, 8 Dec 2016, Josh Poimboeuf wrote:
> 
> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> > index 215612c..b4a6663 100644
> > --- a/arch/x86/Kconfig
> > +++ b/arch/x86/Kconfig
> > @@ -155,6 +155,7 @@ config X86
> >  	select HAVE_PERF_REGS
> >  	select HAVE_PERF_USER_STACK_DUMP
> >  	select HAVE_REGS_AND_STACK_ACCESS_API
> > +	select HAVE_RELIABLE_STACKTRACE		if X86_64 && FRAME_POINTER && STACK_VALIDATION
> 
> Tests to measure possible performance penalty of frame pointers were done 
> by Mel Gorman. The outcome was quite clear. There IS a measurable 
> impact. The percentage depends on the workflow but I think it is safe to 
> say that FP usually takes 5-10 percents.
> 
> If my understanding is correct there is no single culprit. Register 
> pressure is definitely not a problem. We ran simple benchmarks while 
> taking a register away from GCC (RBP or a common one). The impact is a 
> combination of more cacheline pressure, more memory accesses and the fact 
> that the kernel contains a lot of small functions.
> 
> Thus, I think that DWARF should be the way to go here.
> 
> Other than that the patch looks good to me.

I agree that DWARF is generally a good idea, and I'm working toward it.
However there's still quite a bit of work to get there.

For this consistency model to work with DWARF on x86, we would need:

1) a reliable x86 DWARF unwinder with Linus's blessing
2) objtool DWARF support (I'm working on this at the moment)
3) probably some kind of runtime NMI stack checking feature to
   complement objtool, along with a lot of burn time to ensure there are
   no issues, particularly in entry code
4) port save_stack_trace_tsk_reliable() to work with DWARF

DWARF will be nice to have, but it's definitely not required before
merging this consistency model.

Also I doubt we'll ever be able to drop frame pointer support
completely.  Some embedded systems may not want the overhead of the
DWARF metadata.

-- 
Josh
