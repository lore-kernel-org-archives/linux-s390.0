Return-Path: <linux-kernel-owner+w=401wt.eu-S1753640Ab0AEJ0Q@vger.kernel.org>
Date: Tue, 5 Jan 2010 10:26:06 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: Re: s390 && user_enable_single_step() (Was: odd utrace testing
 results on s390x)
Message-ID: <20100105102606.4f223990@mschwide.boeblingen.de.ibm.com>
In-Reply-To: <20100104181412.GA21146@redhat.com>
References: <1503844142.2061111261478093776.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<1257887498.2061171261478252049.JavaMail.root@zmail06.collab.prod.int.phx2.redhat.com>
	<20100104155225.GA16650@redhat.com>
	<20100104171626.22ea2d9c@mschwide.boeblingen.de.ibm.com>
	<20100104181412.GA21146@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: caiqian@redhat.com, Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Kratochvil <jkratoch@redhat.com>, Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, utrace-devel@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, 4 Jan 2010 19:14:12 +0100
Oleg Nesterov <oleg@redhat.com> wrote:

> On 01/04, Martin Schwidefsky wrote:
> > Subject: [PATCH] fix loading of PER control registers for utrace.
> >
> > From: Martin Schwidefsky <schwidefsky@de.ibm.com>
> >
> > If the current task enables / disables PER tracing for itself the
> > PER control registers need to be loaded in FixPerRegisters.
> >
> > Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
> > ---
> >  arch/s390/kernel/ptrace.c |    3 +++
> >  1 file changed, 3 insertions(+)
> >
> > --- a/arch/s390/kernel/ptrace.c
> > +++ b/arch/s390/kernel/ptrace.c
> > @@ -98,6 +98,9 @@ FixPerRegisters(struct task_struct *task
> >  		per_info->control_regs.bits.storage_alt_space_ctl = 1;
> >  	else
> >  		per_info->control_regs.bits.storage_alt_space_ctl = 0;
> > +
> > +	if (task == current)
> > +		__ctl_load(per_info->control_regs.words, 9, 11);
> >  }
> 
> Yes it does fix the problem! Thanks a lot Martin.

Ok, I will add that patch to the git390 queue.

> However. Could you please look at 6580807da14c423f0d0a708108e6df6ebc8bc83d ?
> I am worried, perhaps this commit is not enough for s390. OK, do_single_step()
> tracehook_consider_fatal_signal(), this means the forked thread will not
> be killed by SIGTRAP if it is not auto-attached, but still this may be
> wrong.
> 
> IOW. I think this problem is minor and probably can be ignored, but if
> I remove tracehook_consider_fatal_signal() check from do_single_step(),
> 
> --- a/arch/s390/kernel/traps.c
> +++ b/arch/s390/kernel/traps.c
> @@ -382,8 +382,7 @@ void __kprobes do_single_step(struct pt_
>  					SIGTRAP) == NOTIFY_STOP){
>  		return;
>  	}
> -	if (tracehook_consider_fatal_signal(current, SIGTRAP))
> -		force_sig(SIGTRAP, current);
> +	force_sig(SIGTRAP, current);
>  }
> 
>  static void default_trap_handler(struct pt_regs * regs, long interruption_code)
> -------------------------------------------------------------------
> 
> then the test-case from 6580807da14c423f0d0a708108e6df6ebc8bc83d
> fails. This probably means that copy_process()->user_disable_single_step()
> is not enough to clear the "this task wants single-stepping" copied
> from parent.

user_disable_single_step() does not remove the TIF_SINGLE_STEP bit from the
forked task. Perhaps we should just clear the bit in the function.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
