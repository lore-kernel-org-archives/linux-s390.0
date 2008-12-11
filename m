From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Thu, 11 Dec 2008 13:06:17 +0000
Subject: Re: [PATCH] audit: get s390 ret_from_fork in sync with other
Message-Id: <20081211130617.GA6264@osiris.boeblingen.de.ibm.com>
In-Reply-To: <20081211062943.GO28946@ZenIV.linux.org.uk>
References: <20081211062943.GO28946@ZenIV.linux.org.uk>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Dec 11, 2008 at 06:29:43AM +0000, Al Viro wrote:
> 	On s390 we have ret_from_fork jump not to the "do all work we
> normally do on return from syscall" as on x86, ppc, etc., but to the
> "do all such work except audit".  Historical reasons - the codepath
> triggered when we have AUDIT process flag set is separated from the
> normall one and they converge at sysc_return, which is the common
> part of post-syscall work.  And does not include calling audit_syscall_exit() -
> that's done in the end of sysc_tracesys path, just before that path jumps
> to sysc_return.
> 
> 	IOW, the child returning from fork()/clone()/vfork() doesn't
> call audit_syscall_exit() at all, so no matter what we do with its
> audit context, we are not going to see the audit entry.
> 
> 	The fix is simple: have ret_from_fork go to the point just past
> the call of sys_.... in the 'we have AUDIT flag set' path.  There we
> have (64bit variant; for 31bit the situation is the same):
> sysc_tracenogo:
>         tm      __TI_flags+7(%r9),(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT)
>         jz      sysc_return
>         la      %r2,SP_PTREGS(%r15)     # load pt_regs
>         larl    %r14,sysc_return        # return point is sysc_return
>         jg      do_syscall_trace_exit
> which is precisely what we need - check the flag, bugger off to sysc_return
> if not set, otherwise call do_syscall_trace_exit() and bugger off to
> sysc_return.  r9 has just been properly set by ret_from_fork itself,
> so we are fine.
> 
> 	Tested on s390x, seems to work fine.  WARNING: it's been about
> 16 years since my last contact with 3X0 assembler[1], so additional
> review would be very welcome.  I don't think I've managed to screw it
> up, but...

Your patch looks fine. I added it to Martin's patch queue.

Thanks!
