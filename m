From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Tue, 26 Apr 2016 11:08:43 +0100
Message-ID: <20160426100842.GB8525@e104818-lin.cambridge.arm.com>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
 <20160425172656.GI9614@e104818-lin.cambridge.arm.com>
 <20160425181913.GA30125@yury-N73SV>
 <20160425184740.GA2559@yury-N73SV>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160425184740.GA2559@yury-N73SV>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, arnd@arndb.de, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, joseph@codesourcery.com, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, broonie@kernel.org, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, linux-arm-kernel@lists.infradead.org, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 25, 2016 at 09:47:40PM +0300, Yury Norov wrote:
> On Mon, Apr 25, 2016 at 09:19:13PM +0300, Yury Norov wrote:
> > On Mon, Apr 25, 2016 at 06:26:56PM +0100, Catalin Marinas wrote:
> > > On Wed, Apr 06, 2016 at 01:08:42AM +0300, Yury Norov wrote:
> > > > --- a/arch/arm64/kernel/entry.S
> > > > +++ b/arch/arm64/kernel/entry.S
> > > > @@ -715,9 +715,13 @@ ENDPROC(ret_from_fork)
> > > >   */
> > > >  	.align	6
> > > >  el0_svc:
> > > > -	adrp	stbl, sys_call_table		// load syscall table pointer
> > > >  	uxtw	scno, w8			// syscall number in w8
> > > >  	mov	sc_nr, #__NR_syscalls
> > > > +#ifdef CONFIG_ARM64_ILP32
> > > > +	ldr	x16, [tsk, #TI_FLAGS]
> > > > +	tbnz	x16, #TIF_32BIT_AARCH64, el0_ilp32_svc // We are using ILP32
> > > > +#endif
> > > 
> > > There is another ldr x16, [tsk, #TI_FLAGS] load further down in the
> > > el0_svc_naked block. We should rework these a bit to avoid loading the
> > > same location twice unnecessarily. E.g. move the ldr x16 just before
> > > el0_svc_naked and branch one line after in case of the ILP32 syscall.
> > > 
> > 
> > Yes, I thiks we can refactor it. Thanks for a catch.
> 
> Now it's better, I think
> 
> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index cf4d1ae..21312bb 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -715,16 +715,22 @@ ENDPROC(ret_from_fork)
>   */
>  	.align	6
>  el0_svc:
> -	adrp	stbl, sys_call_table		// load syscall table pointer
>  	uxtw	scno, w8			// syscall number in w8
>  	mov	sc_nr, #__NR_syscalls
> +	ldr	x16, [tsk, #TI_FLAGS]

You can move this higher up for interlocking reasons (though these days
CPUs do a lot of speculative loads).

> +#ifdef CONFIG_ARM64_ILP32
> +	tbz	x16, #TIF_32BIT_AARCH64, el0_lp64_svc // We are using ILP32

	// We are *not* using ILP32

> +	adrp	stbl, sys_call_ilp32_table	// load ilp32 syscall table pointer
> +	b el0_svc_naked
> +el0_lp64_svc:
> +#endif
> +	adrp	stbl, sys_call_table		// load syscall table pointer

You can avoid the branches by using csel, something like this:

	ldr	x16, [tsk, #TI_FLAGS]
	adrp	stbl, sys_call_table
	...
#ifdef CONFIG_ARM64_ILP32
	adrp	x17, sys_call_ilp32_table
	tst	x16, #_TIF_32BIT_AARCH64
	csel	stbl, stbl, x17, eq
#endif
el0_svc_naked:
	...

>  el0_svc_naked:					// compat entry point
>  	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
>  	enable_dbg_and_irq
>  	ct_user_exit 1
>  
> -	ldr	x16, [tsk, #TI_FLAGS]		// check for syscall hooks
> -	tst	x16, #_TIF_SYSCALL_WORK
> +	tst	x16, #_TIF_SYSCALL_WORK		// check for syscall hooks
>  	b.ne	__sys_trace
>  	cmp     scno, sc_nr                     // check upper syscall limit
>  	b.hs	ni_sys

There is el0_svc_compat branching to el0_svc_naked and it won't have x16
set anymore. So you need to add an ldr x16 to el0_svc_compat as well.

-- 
Catalin
