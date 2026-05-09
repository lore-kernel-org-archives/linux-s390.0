Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC6A397682;
	Sat,  9 May 2026 18:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778350919; cv=none; b=FzoG+NR6uJx4SG0E+AYhf/KzF94+RCgRO3n8Mf19yZHIZ2l6fDzU2tvixDH6u75HXld7dPHlW3ME2wTHFAXHT44myYIZPGxDMvnuC0Vh2bIeq/johqpvS9JHgFohJCNLN1TGQ8wGegkXwoKA7P3e5HP6Ix05XpST4cZDQ8z6zOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778350919; c=relaxed/simple;
	bh=HG3wDCtpxPKc6vCCw5mcp+pHxj5nhx8B1xIc9NO7M4o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkh9Y0UrtFeWmZA5oW8Y1Sllx2YCL1tcHn8sxZ9BM+3/cd8Yz+voZGssNZg1vJPbK9v1wdu/Lcs3o83WCPWU5gmD+0iGMcbE8D2vsOhs7HT0teNLimny7TN709eLYGozVSTfLmO6Ehl7tt497ZpTwd+vFUgUEiioP1WbcFPL3rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n20/xFK8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n20/xFK8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23E0EC4AF09;
	Sat,  9 May 2026 18:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778350918;
	bh=HG3wDCtpxPKc6vCCw5mcp+pHxj5nhx8B1xIc9NO7M4o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=n20/xFK8b7sJ6P+B+656HDGZUN4r7BYXxOt+aIJKcoH9xFpwi/sk570l7LD+sj1Md
	 Fx9+BGRve1ob8sdnYSLsWd4FHyHIGrE3NSYU2ZAQwtjERXnFoKrAnv62BjfugNWg/O
	 1+EyRPYy+U6BcA/pHDmsz2eCMZ0aMPZwkwy1gENPmbIUHDDy1SbXF2kRGr2VP45fz5
	 NpYDNsuC64M+wRz6TQmxm2dPf41CkbQVdi5+O544AO1ZiqnS6NF4S0E2MPzNtQ853M
	 WDfo4anM9ACd83aBznBdYa5tcTcLDyRRBqrFP5Z2nPxfYd5x1d8iR5NWVy/L5u0arM
	 rba2Kd7KeHWuQ==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 24C60F40071;
	Sat,  9 May 2026 14:21:56 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Sat, 09 May 2026 14:21:56 -0400
X-ME-Sender: <xms:RHv_aUjpp3Wm6kP6wok634yKJgzzFplmWxAD4C4gIQbVfDHDhinG3w>
    <xme:RHv_aS7DunLGF2xyq3kdWtkBYIdIsYw2CGZ6-VCz-II41_WAjzGX9JfyKUzzMmsVJ
    rRrGN57rzNFIiyEwo_FJRmUPrcg8bqsfEFzgzQJTBQy5-h16UneXQ>
X-ME-Received: <xmr:RHv_aeiOEBMR-Ti5mOZSHSrP827G-63KuYpP4vcVblZ7auaSnTDPM7UjPJlkKLH9pp4YHdsRUskGh96Pg1wj8y22URAUNLrB>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudefleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    elueehtefhtddtgfejvdejueehhfekteevueeuueekgeetieeggeehvdffhefhhfenucff
    ohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheeipdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehhtggrsehlihhnuhigrdhisghmrdgtohhmpd
    hrtghpthhtohepphgvthgvrhiisehinhhfrhgruggvrggurdhorhhgpdhrtghpthhtohep
    tggrthgrlhhinhdrmhgrrhhinhgrshesrghrmhdrtghomhdprhgtphhtthhopeifihhllh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhonhgrshesshhouhhthhhpohhlvgdr
    shgvpdhrtghpthhtohepshhtvghfrghnrdhkrhhishhtihgrnhhsshhonhesshgruhhnrg
    hlrghhthhirdhfihdprhgtphhtthhopehshhhorhhnvgesghhmrghilhdrtghomhdprhgt
    phhtthhopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtoheprghgohhrug
    gvvghvsehlihhnuhigrdhisghmrdgtohhm
X-ME-Proxy: <xmx:RHv_aWYOpiXZAh3IhlGMby2FssSYApWBE03-HpIS9cQYn2m5ToaiUg>
    <xmx:RHv_aSETG2Uw5mTLSLWYd_cLYcNVptHhgHdihGdv69MBquvJtWnixQ>
    <xmx:RHv_aQ5gqJMhglZSnw81icBslts4XhQNh9tsjFG1FiqZSyRAo1248Q>
    <xmx:RHv_aVJyR6MP2xBHvEaNRs9TSIzTpLz2kUoMlMe5dhC-clurVAF3Yw>
    <xmx:RHv_aW813Ln_UeUPy2ftTOrxS71oQxZPd1M0jHnW1jSsNq90Y2vyuzRS>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 14:21:55 -0400 (EDT)
Date: Sat, 9 May 2026 11:21:54 -0700
From: Boqun Feng <boqun@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
 Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
 Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Ada Couprie Diaz <ada.coupriediaz@arm.com>,
	Lyude Paul <lyude@redhat.com>, Sohil Mehta <sohil.mehta@intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Sean Christopherson <seanjc@google.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 00/11] Refcounted interrupt disable and SpinLockIrq for
 rust (Part 1)
Message-ID: <af97QqnT5JaSVSOt@tardis.local>
References: <20260508042111.24358-1-boqun@kernel.org>
 <20260509181249.16281C67-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260509181249.16281C67-hca@linux.ibm.com>

On Sat, May 09, 2026 at 08:12:49PM +0200, Heiko Carstens wrote:
> On Thu, May 07, 2026 at 09:21:00PM -0700, Boqun Feng wrote:
> > Hi Peter,
> > 
> > This is a follow-up for Lyude's work [1]. Per your feedback at [2], I
> > did some digging and turned out that ARM64 already kinda did this. The
> > basic idea is based on:
> > 
> > 1) preempt_count() previously mask our NEED_RESCHED bit, so the
> >    effective bits is 31bits
> > 2) with a 64bit preempt count implementation (as in your PREEMPT_LONG
> >    proposal), the effective bits that record "whether we CAN preempt or
> >    not" still fit in 32bit (i.e. an int)
> > 
> > as a result, I don't think we need to change the existing
> > preempt_count() API, but rather keep "32bit vs 64bit" as an
> > implementation detail. This saves us the need to change the printk code
> > for preempt_count().
> > 
> > For people who have reviewed the previous version, patch 8-11 are new,
> > please take a look.
> > 
> > The patchset passed the build and booting tests and also a "perf record"
> > test on x86 for NMI code path.
> > 
> > I would like to target this changes for 7.2 if possible.
> > 
> > [1]: https://lore.kernel.org/all/20260121223933.1568682-1-lyude@redhat.com/
> > [2]: https://lore.kernel.org/all/20260204111234.GA3031506@noisy.programming.kicks-ass.net/
> > 
> > Regards,
> > Boqun
> > 
> > Boqun Feng (8):
> >   preempt: Introduce HARDIRQ_DISABLE_BITS
> >   preempt: Introduce __preempt_count_{sub, add}_return()
> >   irq & spin_lock: Add counted interrupt disabling/enabling
> >   locking: Switch to _irq_{disable,enable}() variants in cleanup guards
> >   sched: Remove the unused preempt_offset parameter of __cant_sleep()
> >   sched: Avoid signed comparison of preempt_count() in __cant_migrate()
> >   preempt: Introduce PREEMPT_COUNT_64BIT
> >   arm64: sched/preempt: Enable PREEMPT_COUNT_64BIT
> 
> The below is the s390 conversion to PREEMPT_COUNT_64BIT (or whatever the
> future name might be). I'd appreciate if you would add that to your series.
> 

Thanks a lot! Yeah, I will include it in the next version.

Regards,
Boqun

> From 827629e68ad67919f8c825d118863664badd227a Mon Sep 17 00:00:00 2001
> From: Heiko Carstens <hca@linux.ibm.com>
> Date: Sat, 9 May 2026 19:23:08 +0200
> Subject: [PATCH] s390/preempt: Enable PREEMPT_COUNT_64BIT
> 
> Convert s390's preempt_count to 64 bit, and change
> the preempt primitives accordingly.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig               |  1 +
>  arch/s390/include/asm/lowcore.h | 13 +++++++----
>  arch/s390/include/asm/preempt.h | 41 +++++++++++++++------------------
>  3 files changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40..efa52667b5d4 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -276,6 +276,7 @@ config S390
>  	select PCI_MSI			if PCI
>  	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
>  	select PCI_QUIRKS		if PCI
> +	select PREEMPT_COUNT_64BIT
>  	select SPARSE_IRQ
>  	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
> diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> index 50ffe75adeb4..0974ab278169 100644
> --- a/arch/s390/include/asm/lowcore.h
> +++ b/arch/s390/include/asm/lowcore.h
> @@ -160,10 +160,15 @@ struct lowcore {
>  	/* SMP info area */
>  	__u32	cpu_nr;				/* 0x03a0 */
>  	__u32	softirq_pending;		/* 0x03a4 */
> -	__s32	preempt_count;			/* 0x03a8 */
> -	__u32	spinlock_lockval;		/* 0x03ac */
> -	__u32	spinlock_index;			/* 0x03b0 */
> -	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
> +	union {
> +		struct {
> +			__u32	need_resched;	/* 0x03a8 */
> +			__u32	count;		/* 0x03ac */
> +		} preempt;
> +		__u64	preempt_count;		/* 0x03a8 */
> +	};
> +	__u32	spinlock_lockval;		/* 0x03b0 */
> +	__u32	spinlock_index;			/* 0x03b4 */
>  	__u64	percpu_offset;			/* 0x03b8 */
>  	__u8	pad_0x03c0[0x0400-0x03c0];	/* 0x03c0 */
>  
> diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
> index 0a25d4648b4c..1d5e4d7e9e1b 100644
> --- a/arch/s390/include/asm/preempt.h
> +++ b/arch/s390/include/asm/preempt.h
> @@ -8,11 +8,8 @@
>  #include <asm/cmpxchg.h>
>  #include <asm/march.h>
>  
> -/*
> - * Use MSB so it is possible to read preempt_count with LLGT which
> - * reads the least significant 31 bits with a single instruction.
> - */
> -#define PREEMPT_NEED_RESCHED	0x80000000
> +/* Use MSB for PREEMPT_NEED_RESCHED mostly because it is available. */
> +#define PREEMPT_NEED_RESCHED	0x8000000000000000UL
>  
>  /*
>   * We use the PREEMPT_NEED_RESCHED bit as an inverted NEED_RESCHED such
> @@ -26,25 +23,25 @@
>   */
>  static __always_inline int preempt_count(void)
>  {
> -	unsigned long lc_preempt, count;
> +	unsigned long lc_preempt;
> +	int count;
>  
> -	BUILD_BUG_ON(sizeof_field(struct lowcore, preempt_count) != sizeof(int));
> -	lc_preempt = offsetof(struct lowcore, preempt_count);
> +	lc_preempt = offsetof(struct lowcore, preempt.count);
>  	/* READ_ONCE(get_lowcore()->preempt_count) & ~PREEMPT_NEED_RESCHED */
>  	asm_inline(
> -		ALTERNATIVE("llgt	%[count],%[offzero](%%r0)\n",
> -			    "llgt	%[count],%[offalt](%%r0)\n",
> +		ALTERNATIVE("ly		%[count],%[offzero](%%r0)\n",
> +			    "ly		%[count],%[offalt](%%r0)\n",
>  			    ALT_FEATURE(MFEATURE_LOWCORE))
>  		: [count] "=d" (count)
>  		: [offzero] "i" (lc_preempt),
>  		  [offalt] "i" (lc_preempt + LOWCORE_ALT_ADDRESS),
> -		  "m" (((struct lowcore *)0)->preempt_count));
> +		  "m" (((struct lowcore *)0)->preempt.count));
>  	return count;
>  }
>  
> -static __always_inline void preempt_count_set(int pc)
> +static __always_inline void preempt_count_set(unsigned long pc)
>  {
> -	int old, new;
> +	unsigned long old, new;
>  
>  	old = READ_ONCE(get_lowcore()->preempt_count);
>  	do {
> @@ -63,12 +60,12 @@ static __always_inline void preempt_count_set(int pc)
>  
>  static __always_inline void set_preempt_need_resched(void)
>  {
> -	__atomic_and(~PREEMPT_NEED_RESCHED, &get_lowcore()->preempt_count);
> +	__atomic64_and(~PREEMPT_NEED_RESCHED, (long *)&get_lowcore()->preempt_count);
>  }
>  
>  static __always_inline void clear_preempt_need_resched(void)
>  {
> -	__atomic_or(PREEMPT_NEED_RESCHED, &get_lowcore()->preempt_count);
> +	__atomic64_or(PREEMPT_NEED_RESCHED, (long *)&get_lowcore()->preempt_count);
>  }
>  
>  static __always_inline bool test_preempt_need_resched(void)
> @@ -88,8 +85,8 @@ static __always_inline void __preempt_count_add(int val)
>  
>  			lc_preempt = offsetof(struct lowcore, preempt_count);
>  			asm_inline(
> -				ALTERNATIVE("asi	%[offzero](%%r0),%[val]\n",
> -					    "asi	%[offalt](%%r0),%[val]\n",
> +				ALTERNATIVE("agsi	%[offzero](%%r0),%[val]\n",
> +					    "agsi	%[offalt](%%r0),%[val]\n",
>  					    ALT_FEATURE(MFEATURE_LOWCORE))
>  				: "+m" (((struct lowcore *)0)->preempt_count)
>  				: [offzero] "i" (lc_preempt), [val] "i" (val),
> @@ -98,7 +95,7 @@ static __always_inline void __preempt_count_add(int val)
>  			return;
>  		}
>  	}
> -	__atomic_add(val, &get_lowcore()->preempt_count);
> +	__atomic64_add(val, (long *)&get_lowcore()->preempt_count);
>  }
>  
>  static __always_inline void __preempt_count_sub(int val)
> @@ -119,15 +116,15 @@ static __always_inline bool __preempt_count_dec_and_test(void)
>  
>  	lc_preempt = offsetof(struct lowcore, preempt_count);
>  	asm_inline(
> -		ALTERNATIVE("alsi	%[offzero](%%r0),%[val]\n",
> -			    "alsi	%[offalt](%%r0),%[val]\n",
> +		ALTERNATIVE("algsi	%[offzero](%%r0),%[val]\n",
> +			    "algsi	%[offalt](%%r0),%[val]\n",
>  			    ALT_FEATURE(MFEATURE_LOWCORE))
>  		: "=@cc" (cc), "+m" (((struct lowcore *)0)->preempt_count)
>  		: [offzero] "i" (lc_preempt), [val] "i" (-1),
>  		[offalt] "i" (lc_preempt + LOWCORE_ALT_ADDRESS));
>  	return (cc == 0) || (cc == 2);
>  #else
> -	return __atomic_add_const_and_test(-1, &get_lowcore()->preempt_count);
> +	return __atomic64_add_const_and_test(-1, (long *)&get_lowcore()->preempt_count);
>  #endif
>  }
>  
> @@ -141,7 +138,7 @@ static __always_inline bool should_resched(int preempt_offset)
>  
>  static __always_inline int __preempt_count_add_return(int val)
>  {
> -	return val + __atomic_add(val, &get_lowcore()->preempt_count);
> +	return val + __atomic64_add(val, (long *)&get_lowcore()->preempt_count);
>  }
>  
>  static __always_inline int __preempt_count_sub_return(int val)
> -- 
> 2.51.0
> 
