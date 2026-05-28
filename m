Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F783B585F;
	Thu, 28 May 2026 10:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965028; cv=none; b=MlhXJFwPtSjFxrk38yNPoTxOJggsYZNBx7xJXr8/QH3bKrD1qOyrOiASuZU5qoKPlzMDIXMbm9hQwZp9vf97wU9uKNATWugQNuo/mNFfxcUtzY1c3rZzvxDxBpuwkkstdR7jF4Wdn9123n3rALUXWj2XtnZLX8nI/jer9R/1L2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965028; c=relaxed/simple;
	bh=u0aRxM6DUow2LEF0COnOp/ciM9e5CqyqG3ckcIj5TdQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YO4kAQkoQlKihCMDwja/jkYJue/f36cckVFgKL+P4LEExVWKrA/W6POvJHzG377MOxI1NohesoYIkTKwzsVVNxDWd0+E9jUP1JxrvBu7L3W0tWATB7yIukWt71TtChsi3Q7JnaEYDvJTVXuAY/RxF17RPm6iBaoqdDYdLIwj+Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=RcLkjF7V; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RcLkjF7V"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=QNGyN387Cp9R9r4L3A3EkBe0+Z04BA1d59VcVSxY2qg=; b=RcLkjF7VAWEi/WJ42Gg3mP0vkN
	e7YrUtYqNm8uy8PlEB50BEvOpn2kA6AGr3MDbry26s0J3mLybsXpqWKg+zfyt/3Dmjj60uAhiee/A
	/4b5PyHJzcXRUHu5VXPnwJVwQRzMTs9lmt3f/Ij1oEpEb6DrC5yAANizMKcNGD2idE/k6HeNiAKbi
	Zq/hQyT23mQGKm/MsesQKMmUw0AhXDh6gugvxiMh6g2XqzT6pJbP3dsHXd8IgwkowlO/7wDSIponU
	KQlyeAE6B9XXHbM9PTLAFj5KFcoJntNHYFlziFHrNeSBxGc2HSfUy9wKVzBFH9MW85oH+jfLcIK7c
	ktsVWEmw==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSYCx-0000000GCDI-3Iqm;
	Thu, 28 May 2026 10:43:24 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 9CB74300673; Thu, 28 May 2026 12:43:22 +0200 (CEST)
Date: Thu, 28 May 2026 12:43:22 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>, Shuah Khan <shuah@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Jinjie Ruan <ruanjinjie@huawei.com>, Lyude Paul <lyude@redhat.com>,
	Thomas Huth <thuth@redhat.com>, Sohil Mehta <sohil.mehta@intel.com>,
	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,
	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org, linux-arch@vger.kernel.org,
	bpf@vger.kernel.org, linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v2 05/12] irq & spin_lock: Add counted interrupt
 disabling/enabling
Message-ID: <20260528104322.GF343181@noisy.programming.kicks-ass.net>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-6-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526152148.30514-6-boqun@kernel.org>

On Tue, May 26, 2026 at 08:21:41AM -0700, Boqun Feng wrote:

> diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> index e2d3079d3f5f..33fc4c814a9f 100644
> --- a/include/linux/preempt.h
> +++ b/include/linux/preempt.h
> @@ -151,6 +151,10 @@ static __always_inline unsigned char interrupt_context_level(void)
>  #define in_softirq()		(softirq_count())
>  #define in_interrupt()		(irq_count())
>  
> +#define hardirq_disable_count()	((preempt_count() & HARDIRQ_DISABLE_MASK) >> HARDIRQ_DISABLE_SHIFT)
> +#define hardirq_disable_enter()	__preempt_count_add_return(HARDIRQ_DISABLE_OFFSET)
> +#define hardirq_disable_exit()	__preempt_count_sub_return(HARDIRQ_DISABLE_OFFSET)
> +
>  /*
>   * The preempt_count offset after preempt_disable();
>   */

> diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
> new file mode 100644
> index 000000000000..868f32524a87
> --- /dev/null
> +++ b/include/linux/interrupt_rc.h
> @@ -0,0 +1,65 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +/*
> + * include/linux/interrupt_rc.h - refcounted local processor interrupt
> + * management.
> + *
> + * Since the implementation of this API currently depends on
> + * local_irq_save()/local_irq_restore(), we split this into it's own header to
> + * make it easier to include without hitting circular header dependencies.
> + */
> +
> +#ifndef __LINUX_INTERRUPT_RC_H
> +#define __LINUX_INTERRUPT_RC_H
> +
> +#include <linux/irqflags.h>
> +#include <asm/processor.h>
> +#ifdef CONFIG_SMP
> +#include <asm/smp.h>
> +#endif
> +
> +/* Per-cpu interrupt disabling state for local_interrupt_{disable,enable}() */
> +struct interrupt_disable_state {
> +	unsigned long flags;
> +};
> +
> +DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
> +
> +static inline void local_interrupt_disable(void)
> +{
> +	unsigned long flags;
> +	int new_count;
> +
> +	new_count = hardirq_disable_enter();
> +
> +	/* Interrupts can happen here, but it's OK, see __irq_exit_rcu(). */
> +
> +	if ((new_count & HARDIRQ_DISABLE_MASK) == HARDIRQ_DISABLE_OFFSET) {
> +		local_irq_save(flags);
> +		raw_cpu_write(local_interrupt_disable_state.flags, flags);
> +	}
> +}
> +
> +static inline void local_interrupt_enable(void)
> +{
> +	int new_count;
> +
> +	new_count = hardirq_disable_exit();
> +
> +	if ((new_count & HARDIRQ_DISABLE_MASK) == 0) {
> +		unsigned long flags;
> +
> +		flags = raw_cpu_read(local_interrupt_disable_state.flags);
> +		local_irq_restore(flags);
> +		/*
> +		 * TODO: re-read preempt count can be avoided, but it needs
> +		 * should_resched() taking another parameter as the current
> +		 * preempt count
> +		 */
> +#ifdef CONFIG_PREEMPTION
> +		if (should_resched(0))
> +			__preempt_schedule();

I'm not sure why you bother with should_resched() at this point, can't
you simply write:

		if (!new_count)
			__preempt_schedule();

> +#endif
> +	}
> +}
> +
> +#endif /* !__LINUX_INTERRUPT_RC_H */
