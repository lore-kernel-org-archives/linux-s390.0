Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 098C4367F28;
	Tue, 17 Mar 2026 10:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773745133; cv=none; b=o9D5eJQxkEWLU8h3onemG0GLrMiGFm4hKDRt4OOKvVXS5TVcAIdXNkNl0KPIS6M8Ti8fuEHPH06z+JjWxsrXAr38qRJbjd54yvufGD5YpSwD3rM8/PziklKuLCHoHM8O7XD3yjPQIeeM9gFyafV/7KaxN4DQCL3RRUmPLQwgATQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773745133; c=relaxed/simple;
	bh=ALJW+MzngJRBkH704bJXjyUFE5onbGjmmTa9DDthDyU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BaOiDO1BsN7AgDAW3GI+EfXHIpbY2OdoUjIhh3qTqGnpyZlvqr9mbSStqMWoAgbjI9ROjEmPjgQQpffimh8qZBimLg3/Xu9PBmNJpMUQhbfsuHts6E8V1Kc9faugxWQWclaFmspXHladsa4s/nVK+h08GyJ6CsfWkFPeoA9QA/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XIpBnS0X; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XIpBnS0X"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=pIH1Welsu4HqhnTP7lYnsI/LP0oXaXAice9C+T5Btc4=; b=XIpBnS0XrumAQLad7nXrxYPsNG
	DrhOIO+9E/9U7yy0y3e+GulTFpaz385rk4DjhCECTtpO44c37ADSCFeO97mXy6D7fGCugyil66Z26
	D32Y4u48Dxj5rWpmqq9A3eEqiiTSc5U6AOsZ1QSs2uPx6ojuNEGRMm+wEICEqoCwBlxTP1r+pasTt
	cHDop5YXHhdkKf92867iZbx9f6/t4NlUIQ2qWPd4OC8NAXXUEqaO4OeUAyNkbWZCO/nwLbXQcpv/2
	Ym8RPrT1oXCXeV+q8UjV5l2SHjkGKdnA+HN67BtikxXLRBpk0I7DKt5lM7zx+JqnnLrN2FEiZQfjO
	KuqBp3UA==;
Received: from 2001-1c00-8d85-5700-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:5700:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w2S8P-00000002ZKz-17NG;
	Tue, 17 Mar 2026 10:58:49 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id B64BB303244; Tue, 17 Mar 2026 11:58:48 +0100 (CET)
Date: Tue, 17 Mar 2026 11:58:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: catalin.marinas@arm.com, will@kernel.org, oleg@redhat.com,
	chenhuacai@kernel.org, kernel@xen0n.name, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, tglx@kernel.org,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	hpa@zytor.com, arnd@arndb.de, luto@kernel.org, shuah@kernel.org,
	kees@kernel.org, wad@chromium.org, kevin.brodsky@arm.com,
	deller@gmx.de, macro@orcam.me.uk, akpm@linux-foundation.org,
	ldv@strace.io, anshuman.khandual@arm.com, ryan.roberts@arm.com,
	mark.rutland@arm.com, thuth@redhat.com, song@kernel.org,
	ada.coupriediaz@arm.com, linusw@kernel.org, broonie@kernel.org,
	pengcan@kylinos.cn, liqiang01@kylinos.cn, ziyao@disroot.org,
	guanwentao@uniontech.com, guoren@kernel.org,
	schuster.simon@siemens-energy.com, jremus@linux.ibm.com,
	david@kernel.org, mathieu.desnoyers@efficios.com,
	edumazet@google.com, kmal@cock.li, dvyukov@google.com,
	reddybalavignesh9979@gmail.com, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v13 RESEND 09/14] arm64: entry: Convert to generic entry
Message-ID: <20260317105848.GD3738010@noisy.programming.kicks-ass.net>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
 <20260317082020.737779-10-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317082020.737779-10-ruanjinjie@huawei.com>

On Tue, Mar 17, 2026 at 04:20:15PM +0800, Jinjie Ruan wrote:

>  include/linux/irq-entry-common.h      |   8 --
>  include/linux/rseq_entry.h            |  18 ---
>  11 files changed, 127 insertions(+), 209 deletions(-)

Excellent,

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

> diff --git a/include/linux/irq-entry-common.h b/include/linux/irq-entry-common.h
> index d26d1b1bcbfb..6519b4a30dc1 100644
> --- a/include/linux/irq-entry-common.h
> +++ b/include/linux/irq-entry-common.h
> @@ -236,14 +236,6 @@ static __always_inline void __exit_to_user_mode_validate(void)
>  	lockdep_sys_exit();
>  }
>  
> -/* Temporary workaround to keep ARM64 alive */
> -static __always_inline void exit_to_user_mode_prepare_legacy(struct pt_regs *regs)
> -{
> -	__exit_to_user_mode_prepare(regs);
> -	rseq_exit_to_user_mode_legacy();
> -	__exit_to_user_mode_validate();
> -}
> -
>  /**
>   * syscall_exit_to_user_mode_prepare - call exit_to_user_mode_loop() if required
>   * @regs:	Pointer to pt_regs on entry stack
> diff --git a/include/linux/rseq_entry.h b/include/linux/rseq_entry.h
> index c6831c93cd6e..e9c4108ac514 100644
> --- a/include/linux/rseq_entry.h
> +++ b/include/linux/rseq_entry.h
> @@ -743,24 +743,6 @@ static __always_inline void rseq_irqentry_exit_to_user_mode(void)
>  	ev->events = 0;
>  }
>  
> -/* Required to keep ARM64 working */
> -static __always_inline void rseq_exit_to_user_mode_legacy(void)
> -{
> -	struct rseq_event *ev = &current->rseq.event;
> -
> -	rseq_stat_inc(rseq_stats.exit);
> -
> -	if (static_branch_unlikely(&rseq_debug_enabled))
> -		WARN_ON_ONCE(ev->sched_switch);
> -
> -	/*
> -	 * Ensure that event (especially user_irq) is cleared when the
> -	 * interrupt did not result in a schedule and therefore the
> -	 * rseq processing did not clear it.
> -	 */
> -	ev->events = 0;
> -}
> -
>  void __rseq_debug_syscall_return(struct pt_regs *regs);
>  
>  static __always_inline void rseq_debug_syscall_return(struct pt_regs *regs)
> -- 
> 2.34.1
> 
