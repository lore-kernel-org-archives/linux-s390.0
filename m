Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C9F2877F4
	for <linux-s390@vger.kernel.org>; Thu, 28 May 2026 14:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779978676; cv=none; b=IKGWEXMSM6oZvf7XeS9ngT9NNI8/QA4fjmyGi4z4qasEIOgUl3oR/s8HMf7dU/g+BHs1ybm71EXzAWy4s1yAxpU183NXdeBfJsmrUHKBRiC7CWpBRSmkk0Vckqg56eu31oeq+tVKbbrdF+FgljDt5YjcnEnziB1f0I5Xy8qdoRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779978676; c=relaxed/simple;
	bh=HyG3NhA74udUzGo9m8hVndsOjCW8hLVkkXqs8g+WHWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f5hRu9K+8RkpVAOb6H6YiKq87IrwN0IP6tZ/Y03YWgsqRKZPlr/nF3ds8W0lV5QNe/KRY6q41Mlq0OcAEK2ZderasUCMb0ydRUinXkW4ZB7CArqwT7FnqUSMieDk7XDSOYZvjJS4RRRyWRh53/HdhaQS2ytT5M7s1uIp3z4hNe4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oin1mPok; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oin1mPok"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5E8B1F000E9;
	Thu, 28 May 2026 14:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779978675;
	bh=1DVdNYWfBcGfeuR0GBfeFu8IJ/Pnixr7g+Fqa3nO+H0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=oin1mPok6UGYJl/Etw15mrDHA3DQp8pKz3i7jzWvx3AfkQT8Zw5/N8ZyaSjRfPP25
	 Sw4zgD3K+/tFZQI1gDr4+JQwOFufGd7mTmoM4vbiLF0y+vry8FuM8j1mMJdfdOM/1M
	 Si6a6WlKSfSp7Tqq0T7Dow5ku1Bs6PYHQFpXCAzowhJ29xp0G6FgoG1fn8RK/p/VYa
	 2qCfXQUN710eTVbmcveoo3/dLt9lQyF5tqNPmjX9+N8fCW5IL9k+O2Axe4aPBar1SR
	 q5b16m8D4iaUFA5V4ORaTp8n1yGAJi/BbpWK8DCwN7ocj90RECiZOCrJ/HZJPTS2gf
	 Qpt32kDD8pr/g==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id DF885F40070;
	Thu, 28 May 2026 10:31:12 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 28 May 2026 10:31:12 -0400
X-ME-Sender: <xms:sFEYas06c8fanc58SaynFXa_pbY32f8GTEwFKxp02B4BwGYuazBoBQ>
    <xme:sFEYamq_QXoIbMw8Bd3vVSEn7b6nV-xiwt4AqnfTaz8GlDwKyYnz7yUQYXPzkZo48
    HqXuWS0OlGSYg0yTFB2S4IqP3g9N5azi44-Rro61S64RrK86WpxZA>
X-ME-Received: <xmr:sFEYaoo2-Jk9IpH8xu6ELasFPvQakM3lLfvkwkTwTZzBz2ikDTYpFdbBxDQhd31lRjXRjA_zlbHkgFIrIs7gOT43wVF573Ai>
X-ME-Proxy-Cause: dmFkZTGmOu92/emQ6/8NtZxrb8FuF/kXoQFx4FVQajYdCwtwrfJNzuKxPiWQpBvD6lzT7m
    u5kMCl+R3sw5frRhPe4eyROj7Ohh/pSoh5xUNqsY8aaPmxoqiDL1FvoZKkvizys5jRD7P1
    YVFb7crsifvSyqsMmsbNzMiL3QulZpbP+zTU9yBNghgl4U89nlXECmGRd2skBS10v3HBI6
    zoZTZ6Cj8CZJ8dP6EH8kjdUFN++7KJlzHgvyw3XD8g/LivVXd66XX27qMANKiUMOWBKqlz
    k/6WBw5B7NC5SMyAxv3fmFVerHhVO8RbL7VasgSoEzxAOYOkLaY1zXQt5E41VyuVGgPGS/
    U9k4HG09llWC3TKqt0uX+iNNHZqi6eYXlwY08ew1wkHPB26PjjtUaiGNZxhvXYUIO+ISfL
    nXWnb+o7TmHyKz4QTOdNYxfye7/gMXfBtXwa54u5chLEBCuk7QtnZOblv0XXuTuEB438i8
    93IFRdj0buZ1EQYXRj68KCw90y9Q3VwtcOuiUEwt2gU/aEghKVnFpzaYWTHscOwOq9X987
    b0+KPVCpmCD6bstECL3QZrhomIXetmSaSy8sBWCllnh7c8lU/26XcziHKDSBgbFkndVOHH
    qk0DrWzdsrEc7qU9hVqkUE+Jb53cnhpqm+P5V0TpVJnit+UUigQLQiz9hnzA
X-ME-Proxy: <xmx:sFEYaqRrCIDGd1tRt-HAeAl46bpsjZz15oBDq4F8fZFGr2g40NRNrA>
    <xmx:sFEYanqjXSKZAkHmiuGVrKDa6uCJu1atoJFQmE317ByC4StxQU4UTw>
    <xmx:sFEYatxPpaYQgPbfpJ2MeDt3fOspMNWEJfA1HYj3E_MKuPcpubWrMQ>
    <xmx:sFEYapqHBrKIiIrK8ERRwi1lGVodWYYycnmcVEKMmIvtJzi3b36qgQ>
    <xmx:sFEYaqIFfnhMvOOGXpNQNCFV8b08j6au5VzeISO4JJT9YnSgkQdVjbS7>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 10:31:11 -0400 (EDT)
Date: Thu, 28 May 2026 07:31:10 -0700
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
 Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
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
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,	Song Liu <song@kernel.org>,
 Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
 Shuah Khan <shuah@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
 Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
 Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
 Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
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
Message-ID: <ahhRrmxQvbe4E8sR@tardis.local>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-6-boqun@kernel.org>
 <20260528104322.GF343181@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528104322.GF343181@noisy.programming.kicks-ass.net>

On Thu, May 28, 2026 at 12:43:22PM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2026 at 08:21:41AM -0700, Boqun Feng wrote:
> 
> > diff --git a/include/linux/preempt.h b/include/linux/preempt.h
> > index e2d3079d3f5f..33fc4c814a9f 100644
> > --- a/include/linux/preempt.h
> > +++ b/include/linux/preempt.h
> > @@ -151,6 +151,10 @@ static __always_inline unsigned char interrupt_context_level(void)
> >  #define in_softirq()		(softirq_count())
> >  #define in_interrupt()		(irq_count())
> >  
> > +#define hardirq_disable_count()	((preempt_count() & HARDIRQ_DISABLE_MASK) >> HARDIRQ_DISABLE_SHIFT)
> > +#define hardirq_disable_enter()	__preempt_count_add_return(HARDIRQ_DISABLE_OFFSET)
> > +#define hardirq_disable_exit()	__preempt_count_sub_return(HARDIRQ_DISABLE_OFFSET)
> > +
> >  /*
> >   * The preempt_count offset after preempt_disable();
> >   */
> 
> > diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
> > new file mode 100644
> > index 000000000000..868f32524a87
> > --- /dev/null
> > +++ b/include/linux/interrupt_rc.h
> > @@ -0,0 +1,65 @@
> > +/* SPDX-License-Identifier: GPL-2.0 */
> > +/*
> > + * include/linux/interrupt_rc.h - refcounted local processor interrupt
> > + * management.
> > + *
> > + * Since the implementation of this API currently depends on
> > + * local_irq_save()/local_irq_restore(), we split this into it's own header to
> > + * make it easier to include without hitting circular header dependencies.
> > + */
> > +
> > +#ifndef __LINUX_INTERRUPT_RC_H
> > +#define __LINUX_INTERRUPT_RC_H
> > +
> > +#include <linux/irqflags.h>
> > +#include <asm/processor.h>
> > +#ifdef CONFIG_SMP
> > +#include <asm/smp.h>
> > +#endif
> > +
> > +/* Per-cpu interrupt disabling state for local_interrupt_{disable,enable}() */
> > +struct interrupt_disable_state {
> > +	unsigned long flags;
> > +};
> > +
> > +DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
> > +
> > +static inline void local_interrupt_disable(void)
> > +{
> > +	unsigned long flags;
> > +	int new_count;
> > +
> > +	new_count = hardirq_disable_enter();
> > +
> > +	/* Interrupts can happen here, but it's OK, see __irq_exit_rcu(). */
> > +
> > +	if ((new_count & HARDIRQ_DISABLE_MASK) == HARDIRQ_DISABLE_OFFSET) {
> > +		local_irq_save(flags);
> > +		raw_cpu_write(local_interrupt_disable_state.flags, flags);
> > +	}
> > +}
> > +
> > +static inline void local_interrupt_enable(void)
> > +{
> > +	int new_count;
> > +
> > +	new_count = hardirq_disable_exit();
> > +
> > +	if ((new_count & HARDIRQ_DISABLE_MASK) == 0) {
> > +		unsigned long flags;
> > +
> > +		flags = raw_cpu_read(local_interrupt_disable_state.flags);
> > +		local_irq_restore(flags);
> > +		/*
> > +		 * TODO: re-read preempt count can be avoided, but it needs
> > +		 * should_resched() taking another parameter as the current
> > +		 * preempt count
> > +		 */
> > +#ifdef CONFIG_PREEMPTION
> > +		if (should_resched(0))
> > +			__preempt_schedule();
> 
> I'm not sure why you bother with should_resched() at this point, can't
> you simply write:
> 
> 		if (!new_count)
> 			__preempt_schedule();
> 

I was trying to not re-invent the wheel for "checking whether we can
preempt" (because the definition of preempt condition might be changed
in the future?), but yes I think directly using new_count should be fine
here. Although I think I need to check tif_need_resched() for other
architectures?

Regards,
Boqun

> > +#endif
> > +	}
> > +}
> > +
> > +#endif /* !__LINUX_INTERRUPT_RC_H */
