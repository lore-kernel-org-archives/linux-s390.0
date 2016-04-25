From: Yury Norov <ynorov@caviumnetworks.com>
Subject: Re: [PATCH 20/25] arm64:ilp32: add sys_ilp32.c and a separate table
 (in entry.S) to use it
Date: Mon, 25 Apr 2016 21:19:13 +0300
Message-ID: <20160425181913.GA30125@yury-N73SV>
References: <1459894127-17698-1-git-send-email-ynorov@caviumnetworks.com>
 <1459894127-17698-21-git-send-email-ynorov@caviumnetworks.com>
 <20160425172656.GI9614@e104818-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-path: <linux-arch-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20160425172656.GI9614@e104818-lin.cambridge.arm.com>
Sender: linux-arch-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: arnd@arndb.de, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, pinskia@gmail.com, Prasun.Kapoor@caviumnetworks.com, schwab@suse.de, broonie@kernel.org, linux-doc@vger.kernel.org, heiko.carstens@de.ibm.com, agraf@suse.de, klimov.linux@gmail.com, Andrew Pinski <Andrew.Pinski@caviumnetworks.com>, bamvor.zhangjian@huawei.com, Andrew Pinski <apinski@cavium.com>, schwidefsky@de.ibm.com, Nathan_Lynch@mentor.com, joseph@codesourcery.com, christoph.muellner@theobroma-systems.com
List-ID: <linux-s390.vger.kernel.org>

On Mon, Apr 25, 2016 at 06:26:56PM +0100, Catalin Marinas wrote:
> On Wed, Apr 06, 2016 at 01:08:42AM +0300, Yury Norov wrote:
> > --- a/arch/arm64/kernel/entry.S
> > +++ b/arch/arm64/kernel/entry.S
> > @@ -715,9 +715,13 @@ ENDPROC(ret_from_fork)
> >   */
> >  	.align	6
> >  el0_svc:
> > -	adrp	stbl, sys_call_table		// load syscall table pointer
> >  	uxtw	scno, w8			// syscall number in w8
> >  	mov	sc_nr, #__NR_syscalls
> > +#ifdef CONFIG_ARM64_ILP32
> > +	ldr	x16, [tsk, #TI_FLAGS]
> > +	tbnz	x16, #TIF_32BIT_AARCH64, el0_ilp32_svc // We are using ILP32
> > +#endif
> 
> There is another ldr x16, [tsk, #TI_FLAGS] load further down in the
> el0_svc_naked block. We should rework these a bit to avoid loading the
> same location twice unnecessarily. E.g. move the ldr x16 just before
> el0_svc_naked and branch one line after in case of the ILP32 syscall.
> 

Yes, I thiks we can refactor it. Thanks for a catch.

> > +	adrp	stbl, sys_call_table		// load syscall table pointer
> >  el0_svc_naked:					// compat entry point
> >  	stp	x0, scno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
> >  	enable_dbg_and_irq
> > @@ -737,6 +741,12 @@ ni_sys:
> >  	b	ret_fast_syscall
> >  ENDPROC(el0_svc)
> >  
> > +#ifdef CONFIG_ARM64_ILP32
> > +el0_ilp32_svc:
> > +	adrp	stbl, sys_call_ilp32_table // load syscall table pointer
> > +	b el0_svc_naked
> > +#endif
> > +
> >  	/*
> >  	 * This is the really slow path.  We're going to be doing context
> >  	 * switches, and waiting for our parent to respond.
> 
> -- 
> Catalin
