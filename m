From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Date: Tue, 04 Jul 2017 05:05:13 +0000
Subject: Re: [PATCH] s390/syscalls: Fix out of bounds arguments access
Message-Id: <20170704070513.59afca22@mschwideX1>
In-Reply-To: <20170703152022.GB16010@krava>
References: <20170703152022.GB16010@krava>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Mon, 3 Jul 2017 17:20:22 +0200
Jiri Olsa <jolsa@redhat.com> wrote:

> On Mon, Jul 03, 2017 at 04:29:37PM +0200, Martin Schwidefsky wrote:
> 
> SNIP
> 
> > > ---
> > >  arch/s390/include/asm/syscall.h | 10 +++++++++-
> > >  1 file changed, 9 insertions(+), 1 deletion(-)  
> > 
> > There are callers of syscall_get_arguments with n=0. And it makes
> > sense to check for this case in the function instead of forcing all
> > callers to check for it.
> >    
> > > diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
> > > index 6ba0bf928909..5f7c11c932fa 100644
> > > --- a/arch/s390/include/asm/syscall.h
> > > +++ b/arch/s390/include/asm/syscall.h
> > > @@ -64,14 +64,22 @@ static inline void syscall_get_arguments(struct task_struct *task,
> > >  {
> > >  	unsigned long mask = -1UL;
> > > 
> > > +	/*
> > > +	 * No arguments for this syscall, there's nothing to do.
> > > +	 */
> > > +	if (!n)
> > > +		return;
> > > +
> > >  	BUG_ON(i + n > 6);  
> > 
> > So yes, for this part of the patch.
> >   
> > >  #ifdef CONFIG_COMPAT
> > >  	if (test_tsk_thread_flag(task, TIF_31BIT))
> > >  		mask = 0xffffffff;
> > >  #endif
> > > -	while (n-- > 0)
> > > +	while (n-- > 0) {
> > >  		if (i + n > 0)
> > >  			args[n] = regs->gprs[2 + i + n] & mask;
> > > +	}
> > > +
> > >  	if (i == 0)
> > >  		args[0] = regs->orig_gpr2 & mask;
> > >  }  
> > 
> > But why the unrelated whitespace damage with the additional { } ?  
> 
> I always get shouted at when I'm not using { } in conditions/loops
> having more than 1 line.. so I tend to add them when I see this
> breakage ;-)

I agree that there should have been { } with the initial patch.
It is just that the cleanup is unrelated to the true bug fix

> feel free to imot that or let me know and I'll send v2

I will strip that part and add a Cc: stable. Thanks.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
