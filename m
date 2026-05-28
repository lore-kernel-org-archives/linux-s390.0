Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CEF3D0938;
	Thu, 28 May 2026 10:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965619; cv=none; b=tNe46Am+a/QfOhHEIq6k2+cNeuEG1Rh7cH9Dnh30+Z4VIja0G+MycP4XW+gDrAH3t6GBY1ml3x20c6bxanHvnvFP045aOV0oYdpS2QISaQR6ZzXYErdChhcw4CWLbq9Stjig8LmbKAth2xE/hsgQf6q6FyrpXe5q1iFe3jifHFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965619; c=relaxed/simple;
	bh=sWeSNmVN+2nde1J+pCm611g/wKTC4MV5XvLgG0qca5s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHUhTN6nHOHWctAQTejRpV3ld3A9ol4+Z+MFvJvwLtHKF9mjT9NxOZfUEPi+JXH89shy1/H3yzG/07Q022Asqv8Y2qHZOTatVC8SvkTyvsui+H4QAPMritSQHI6tpNe0THzA/laUpcvX0dp/Uru2ZQbf0D5ieUwwH/nRxgmKO/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=XgDMFSWB; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="XgDMFSWB"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=vmJ0MIxHcu6GywVP98RSuXzH8R1cz6RzvzYzBTXLcWQ=; b=XgDMFSWBz53xKzj7s3tmaiRWSn
	mPrtjimriTrPvI0aWo+sBjxAFnTomEt3sVBc7bhPhi8TaUji6RC3/M/AxkitFgJnujUjKpbpOsXuV
	JeLszzwWLeJTtc3rBqy3//WSZ5GZpQi2vGKpLaRjERAf1BSxkH0cv9Hh6IIfLX1k6ecieoVESsrLu
	3rHb47LamIi2dG8Jz8aPVjJANgIrZlV810yb0CCjJwUmknuK9JiahNzNf384/aO4/o5b7RU6raFPo
	Nc4Nxu5gCpANnSiqIpxHIB2X4HC5U8XqNGcy/PsnJLgQDcW1vphnTMIvfk0MBZ+XNavEAxckssrQ5
	l0N2225g==;
Received: from 2001-1c00-8d85-4b00-266e-96ff-fe07-7dcc.cable.dynamic.v6.ziggo.nl ([2001:1c00:8d85:4b00:266e:96ff:fe07:7dcc] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSYMf-0000000GDSi-2KFs;
	Thu, 28 May 2026 10:53:32 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 556DB300673; Thu, 28 May 2026 12:53:25 +0200 (CEST)
Date: Thu, 28 May 2026 12:53:25 +0200
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
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 12/12] s390/preempt: Enable
 HAS_SEPARATE_PREEMPT_RESCHED_BITS
Message-ID: <20260528105325.GI343181@noisy.programming.kicks-ass.net>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-13-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526152148.30514-13-boqun@kernel.org>

On Tue, May 26, 2026 at 08:21:48AM -0700, Boqun Feng wrote:
> From: Heiko Carstens <hca@linux.ibm.com>
> 
> Convert s390's preempt_count to 64 bit, and change the preempt
> primitives accordingly.
> 
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>
> Link: https://patch.msgid.link/20260509181249.16281C67-hca@linux.ibm.com
> ---
>  arch/s390/Kconfig               |  1 +
>  arch/s390/include/asm/lowcore.h | 13 +++++++----
>  arch/s390/include/asm/preempt.h | 41 +++++++++++++++------------------
>  3 files changed, 29 insertions(+), 26 deletions(-)
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index ecbcbb781e40..cbbca82f8443 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -276,6 +276,7 @@ config S390
>  	select PCI_MSI			if PCI
>  	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
>  	select PCI_QUIRKS		if PCI
> +	select HAS_SEPARATE_PREEMPT_RESCHED_BITS
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

I'm a little confused by this union; afaict it isn't actually used.
