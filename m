From: Will Deacon <will.deacon@arm.com>
Subject: Re: [PATCH v2 1/5] arm64: Fix vDSO clock_getres()
Date: Tue, 16 Apr 2019 18:09:23 +0100
Message-ID: <20190416170923.GD7342@fuggles.cambridge.arm.com>
References: <20190416161434.32691-1-vincenzo.frascino@arm.com>
 <20190416161434.32691-2-vincenzo.frascino@arm.com>
 <20190416162432.GI28994@arrakis.emea.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190416162432.GI28994@arrakis.emea.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, Shuah Khan <shuah@kernel.org>, Vincent Chen <deanbo422@gmail.com>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, Greentime Hu <green.hu@gmail.com>, linux-kselftest@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-ID: <linux-s390.vger.kernel.org>

On Tue, Apr 16, 2019 at 05:24:33PM +0100, Catalin Marinas wrote:
> On Tue, Apr 16, 2019 at 05:14:30PM +0100, Vincenzo Frascino wrote:
> > diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
> > index 2d419006ad43..5f5759d51c33 100644
> > --- a/arch/arm64/kernel/vdso.c
> > +++ b/arch/arm64/kernel/vdso.c
> > @@ -245,6 +245,8 @@ void update_vsyscall(struct timekeeper *tk)
> >  		vdso_data->cs_shift		= tk->tkr_mono.shift;
> >  	}
> >  
> > +	vdso_data->hrtimer_res		= hrtimer_resolution;
> 
> This should be a WRITE_ONCE(), just in case.
> 
> > +
> >  	smp_wmb();
> >  	++vdso_data->tb_seq_count;
> >  }
> > diff --git a/arch/arm64/kernel/vdso/gettimeofday.S b/arch/arm64/kernel/vdso/gettimeofday.S
> > index c39872a7b03c..e2e9dfe9ba4a 100644
> > --- a/arch/arm64/kernel/vdso/gettimeofday.S
> > +++ b/arch/arm64/kernel/vdso/gettimeofday.S
> > @@ -296,32 +296,32 @@ ENDPROC(__kernel_clock_gettime)
> >  /* int __kernel_clock_getres(clockid_t clock_id, struct timespec *res); */
> >  ENTRY(__kernel_clock_getres)
> >  	.cfi_startproc
> > +	adr	vdso_data, _vdso_data
> >  	cmp	w0, #CLOCK_REALTIME
> >  	ccmp	w0, #CLOCK_MONOTONIC, #0x4, ne
> >  	ccmp	w0, #CLOCK_MONOTONIC_RAW, #0x4, ne
> > -	b.ne	1f
> > +	b.ne	2f
> >  
> > -	ldr	x2, 5f
> > -	b	2f
> > -1:
> > +1:	/* Get hrtimer_res */
> > +	ldr	x2, [vdso_data, #CLOCK_REALTIME_RES]
> 
> And here we need an "ldr w2, ..." since hrtimer_res is u32.
> 
> With the above (which Will can fix up):
> 
> Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>

Applied, with the above and a few extra cleanups.

Will
