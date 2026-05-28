Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD12F3C5832;
	Thu, 28 May 2026 10:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965466; cv=none; b=MXbvlYnsCTCoFhuC+PmAFZxm8ttyqY8zohAZQ+RpI0EVboPlplB0e2PmksAyK6kSWrlJRkpnf/g5Q/eSjLPZC1KqytyOChLKLv7MWLS+/aveCC15S4H1xe7/YDXYOcj9dvXepbXWNyluT6QgjC1U0ssszG/5MIHQ/XwN9uF0ORM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965466; c=relaxed/simple;
	bh=jwSiWgOwHW+zI8mC1jh/QizgUmK13AGnojm0POPKZPI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UHyf8QNQTgmQJoZZU6arq2tceWyjiOQ41j4JccPtBhkUCoiEf40/IPZCTIQIsNLHmc9zn2w+U74U1ZtAuOFYLYgFT0eyk9N4t59ZDka+VzyWQEvkdHH6GHh9srfSdGC5/CADIgJ8ylxbVvf+CDEF+SZ8NFIzXo8Re4V0CVkkGLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=QICLpLzw; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="QICLpLzw"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=m2CpDyvpat5lK9iuuqE1iCBMEM1HaPO1xirgUPN4aqQ=; b=QICLpLzweavjCIR8nI+f8O2j60
	bzCjnrBP7OKfckmAS/wBV4qJpZGdIgKmOiohsQXurzSAmI2UQhwfiYplmqn6KvwV4WnN2U039jS0a
	ljGOkJw3Ytez59qoBuq1s2wWgnRT/LSGsDl4NInfBnkzw1YlDrHlNhVtTb9XYDpDRhxAX/c1inPep
	dSVIsAyRTZU77akgDnUrROpqAOgwUqfKjrinNRQonWtaXOYGFUMYbcdr2a2J0l+IU0NaTw5iZ4Iko
	63wD0AOEdMBWKEFNyRede21hM09AoiNLMwC9DMWnSgbiMCJVdqWf+GNWtrrn3bXANyH9bEMv7nvqB
	XtcsMhAw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSYKI-0000000GD8I-23eJ;
	Thu, 28 May 2026 10:50:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 4103B300673; Thu, 28 May 2026 12:50:58 +0200 (CEST)
Date: Thu, 28 May 2026 12:50:58 +0200
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
Subject: Re: [PATCH v2 11/12] arm64: sched/preempt: Enable
 HAS_SEPARATE_PREEMPT_RESCHED_BITS
Message-ID: <20260528105058.GH343181@noisy.programming.kicks-ass.net>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-12-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526152148.30514-12-boqun@kernel.org>

On Tue, May 26, 2026 at 08:21:47AM -0700, Boqun Feng wrote:
> ARM64 already uses 64bit preempt count and the need reschedule bit is
> maintained in a separate 32bit than the preempt count. Therefore preempt
> count has enough bits to represent 16 level of NMI nesting, hence enable
> it for ARM64. This saves a per-CPU variable and additional instructions
> in the NMI path.

Egads, so ARM being load-store gets around the preempt bit scribble by
moving it into a separate word. And while that works, that does *not*
make the preempt_count 64bit.

All of this really only works because the actual preempt count bits
still fit inside a u32. The moment that changes, this comes unstuck :-(

And I suppose this is the reason Mark wanted that name change.

I suppose Power could employ the same scheme..


> Signed-off-by: Boqun Feng <boqun@kernel.org>
> ---
>  arch/arm64/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index fe60738e5943..8178cb857115 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -248,6 +248,7 @@ config ARM64
>  	select PCI_SYSCALL if PCI
>  	select POWER_RESET
>  	select POWER_SUPPLY
> +	select HAS_SEPARATE_PREEMPT_RESCHED_BITS
>  	select SPARSE_IRQ
>  	select SWIOTLB
>  	select SYSCTL_EXCEPTION_TRACE
> -- 
> 2.50.1 (Apple Git-155)
> 
