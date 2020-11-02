Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 2 Nov 2020 14:08:07 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 5/9] kprobes/ftrace: Add recursion protection to the
 ftrace callback
Message-Id: <20201102140807.05ca1c9e33a96b34d3fffd35@kernel.org>
In-Reply-To: <20201029094001.0cfab7aa@gandalf.local.home>
References: <20201028115244.995788961@goodmis.org>
        <20201028115613.140212174@goodmis.org>
        <20201029165803.5f6b401e5bccca4e57c70181@kernel.org>
        <20201029094001.0cfab7aa@gandalf.local.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
List-ID: <linux-s390.vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Guo Ren <guoren@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

On Thu, 29 Oct 2020 09:40:01 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 29 Oct 2020 16:58:03 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > Hi Steve,
> > 
> > On Wed, 28 Oct 2020 07:52:49 -0400
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>
> > > 
> > > If a ftrace callback does not supply its own recursion protection and
> > > does not set the RECURSION_SAFE flag in its ftrace_ops, then ftrace will
> > > make a helper trampoline to do so before calling the callback instead of
> > > just calling the callback directly.  
> > 
> > So in that case the handlers will be called without preempt disabled?
> > 
> > 
> > > The default for ftrace_ops is going to assume recursion protection unless
> > > otherwise specified.  
> > 
> > This seems to skip entier handler if ftrace finds recursion.
> > I would like to increment the missed counter even in that case.
> 
> Note, this code does not change the functionality at this point, because
> without having the FL_RECURSION flag set (which kprobes does not even in
> this patch), it always gets called from the helper function that does this:
> 
> 	bit = trace_test_and_set_recursion(TRACE_LIST_START, TRACE_LIST_MAX);
> 	if (bit < 0)
> 		return;
> 
> 	preempt_disable_notrace();
> 
> 	op->func(ip, parent_ip, op, regs);
> 
> 	preempt_enable_notrace();
> 	trace_clear_recursion(bit);
> 
> Where this function gets called by op->func().
> 
> In other words, you don't get that count anyway, and I don't think you want
> it. Because it means you traced something that your callback calls.

Got it. So nmissed count increment will be an improvement.

> 
> That bit check is basically a nop, because the last patch in this series
> will make the default that everything has recursion protection, but at this
> patch the test does this:
> 
> 	/* A previous recursion check was made */
> 	if ((val & TRACE_CONTEXT_MASK) > max)
> 		return 0;
> 
> Which would always return true, because this function is called via the
> helper that already did the trace_test_and_set_recursion() which, if it
> made it this far, the val would always be greater than max.

OK, let me check the last patch too.

> 
> > 
> > [...]
> > e.g.
> > 
> > > diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
> > > index 5264763d05be..5eb2604fdf71 100644
> > > --- a/arch/csky/kernel/probes/ftrace.c
> > > +++ b/arch/csky/kernel/probes/ftrace.c
> > > @@ -13,16 +13,21 @@ int arch_check_ftrace_location(struct kprobe *p)
> > >  void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
> > >  			   struct ftrace_ops *ops, struct pt_regs *regs)
> > >  {
> > > +	int bit;
> > >  	bool lr_saver = false;
> > >  	struct kprobe *p;
> > >  	struct kprobe_ctlblk *kcb;
> > >  
> > > -	/* Preempt is disabled by ftrace */
> > > +	bit = ftrace_test_recursion_trylock();  
> > 
> > > +
> > > +	preempt_disable_notrace();
> > >  	p = get_kprobe((kprobe_opcode_t *)ip);
> > >  	if (!p) {
> > >  		p = get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
> > >  		if (unlikely(!p) || kprobe_disabled(p))
> > > -			return;
> > > +			goto out;
> > >  		lr_saver = true;
> > >  	}  
> > 
> > 	if (bit < 0) {
> > 		kprobes_inc_nmissed_count(p);
> > 		goto out;
> > 	}
> 
> If anything called in get_kprobe() or kprobes_inc_nmissed_count() gets
> traced here, you have zero recursion protection, and this will crash the
> machine with a likely reboot (triple fault).

Oops, ok, those can be traced. 

> 
> Note, the recursion handles interrupts and wont stop them. bit < 0 only
> happens if you recurse because this function called something that ends up
> calling itself. Really, why would you care about missing a kprobe on the
> same kprobe?

Usually, sw-breakpoint based kprobes will count that case. Moreover, kprobes
shares one ftrace_ops among all kprobes. I guess in that case any kprobes
in kprobes (e.g. recursive call inside kprobe pre_handlers) will be skipped
by ftrace_test_recursion_trylock(), is that correct?

Thank you,

> 
> -- Steve


-- 
Masami Hiramatsu <mhiramat@kernel.org>
