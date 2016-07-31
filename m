Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sun, 31 Jul 2016 14:21:14 +0200
From: Jiri Olsa <jolsa@redhat.com>
Subject: Re: [PATCH] ftrace/jprobes/s390: Fix conflict between jprobes and
 function graph tracing
Message-ID: <20160731122114.GC12673@krava>
References: <1468848401-8091-1-git-send-email-jolsa@kernel.org>
 <20160728143933.1a2abc97@gandalf.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20160728143933.1a2abc97@gandalf.local.home>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Jiri Olsa <jolsa@kernel.org>, lkml <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>, Michael Grundy <grundym@us.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Masami Hiramatsu <masami.hiramatsu.pt@hitachi.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jul 28, 2016 at 02:39:33PM -0400, Steven Rostedt wrote:
> On Mon, 18 Jul 2016 15:26:41 +0200
> Jiri Olsa <jolsa@kernel.org> wrote:
> 
> > This fixes the same issue Steven already fixed for x86
> > in following commit:
> > 
> >   237d28db036e ftrace/jprobes/x86: Fix conflict between jprobes and function graph tracing
> > 
> > It fixes the crash, that happens when function graph tracing
> > and jprobes are used simultaneously. Please refer to above
> > commit for details.
> 
> I'm guessing that this should go in via the s390 tree.

oops, I forgot to CC s390 mailing list.. CC-ing now

I can repost if needed

thanks,
jirka

> 
> Acked-by: Steven Rostedt <rostedt@goodmis.org>
> 
> -- Steve
> 
> > 
> > Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> > ---
> >  arch/s390/kernel/kprobes.c | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
> > index 250f5972536a..dd6306c51bd6 100644
> > --- a/arch/s390/kernel/kprobes.c
> > +++ b/arch/s390/kernel/kprobes.c
> > @@ -690,6 +690,15 @@ int setjmp_pre_handler(struct kprobe *p, struct pt_regs *regs)
> >  	stack = (unsigned long) regs->gprs[15];
> >  
> >  	memcpy(kcb->jprobes_stack, (void *) stack, MIN_STACK_SIZE(stack));
> > +
> > +	/*
> > +	 * jprobes use jprobe_return() which skips the normal return
> > +	 * path of the function, and this messes up the accounting of the
> > +	 * function graph tracer to get messed up.
> > +	 *
> > +	 * Pause function graph tracing while performing the jprobe function.
> > +	 */
> > +	pause_graph_tracing();
> >  	return 1;
> >  }
> >  NOKPROBE_SYMBOL(setjmp_pre_handler);
> > @@ -705,6 +714,9 @@ int longjmp_break_handler(struct kprobe *p, struct pt_regs *regs)
> >  	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
> >  	unsigned long stack;
> >  
> > +	/* It's OK to start function graph tracing again */
> > +	unpause_graph_tracing();
> > +
> >  	stack = (unsigned long) kcb->jprobe_saved_regs.gprs[15];
> >  
> >  	/* Put the regs back */
> 
