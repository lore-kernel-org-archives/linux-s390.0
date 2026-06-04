Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D9253A5E89;
	Thu,  4 Jun 2026 12:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780576844; cv=none; b=Skes5YCuElk4Hyu/oNh/5sSalQDzPtpCD6u9XQMoyUffhgAFTH3ijAQutUcqdVAUlivGUVYjJlLQAvJ47ZQk+8/5oL9t64pWR75QvL9gtTRTYgRT71WTMde4ey6NGimEEYRmjL8IHNwzMyHfy5b+5PwcrUAzZPoFV1GfcLlykps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780576844; c=relaxed/simple;
	bh=3motd/Kk9tEcEy98c5ncAGr3nNkb1fzwM1uTOGz4Qus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KAVGqEsQqFBvIfHaD01KJdfq6MfSaMT+/yB+cloAYXLcZBEqebiSjsuWaaEhLJ7tXXkUliKxyugyGhdgWcZGc4OKCwMF1y1NaL+fFd0oHFvlbGwF6DIkX/7N5uwUxOHC4RVVNMuptmLU2GQjIXMPMdt0bpjxegBHJp8icG41uIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=daq4p9mT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="daq4p9mT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBDC31F00899;
	Thu,  4 Jun 2026 12:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780576843;
	bh=GnOm+v7F1LKSbVaBQReSZi8hz25Kzy0nepO4bxrUVcs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=daq4p9mTxZM6hg5qQa/qHACfQnQNHHJBfDXDZldcF2oHlB3rhT2K9WeXrV8DpICBQ
	 ChETc4cbkLuTEfQQomffF4ZDXoOkbJlShcZp+gaRwsU03Ob6jh4vxRpGgmIybx7MiS
	 0Q6kTXsQaMMkiRlLva0vqHO8zJAZ25fV2lo4Iwm7JCR2aKboyZBL5lVEITHft9qxX0
	 GkQdYzIUJ5P8y31MMiUfphTTGDChzuxN8Hs86+X2QhDQOpjt8UdnXhaxci7Ao2eogs
	 lUnPqgL3gvZxrYqDe7AeVTZYhdiIepM/Oxx/uFb99h7xH99KiZewhfCg5FOfUIFW0e
	 /X2zv2MBvrBtg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id F3A80F40084;
	Thu,  4 Jun 2026 08:40:40 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 04 Jun 2026 08:40:41 -0400
X-ME-Sender: <xms:SHIhakSnCrdg9gx5m4iHzTicKaK_DQbZUK11E3bhlG_5yYmLh4HVcA>
    <xme:SHIhamrf8l8qqXn5spEz_3zIQSqGxPGzydYKiqYC1Ad9mQIGDEO2BI-tVRzQTjo8L
    N8dPE-jHh3R_hm5kGq61j-lWA9098jHtcxIXHtK6lSOM5b04J8>
X-ME-Received: <xmr:SHIhanvyg3DUTUpzz1Tr6mmNDYVvEMOWhgBEhBREpTYdxxCkkBVJjshxDdQ>
X-ME-Proxy-Cause: dmFkZTF1BaCWatKURocL+NpcgGk8YfcgR1XBShgJesrvsvC2cG3vlDNwoRLKuuKWvI9wgr
    KG4Un6Q8MLsUhJ7qUby0lAaArhUaGksZuyniOIcFRF3jBJfW9luEJSa356GyMvadHeAIUB
    F7Fsk6uIaYS9/XUo/AHbvEW2iTXW7UQHwAiD96JBraglfj5eFgrMXQqkhBFZpo5fmGG/eI
    AQb5l6O4b5u+PthGYCRYvuYPUJXdmWKqj7KOhX79C+va6qRUJSnqWA/slW9fvEtsxZflmn
    cZYxt7SIfaZSY+71gr8mRZqSZhlvD3ofSHh//MmWZCDH7C7YuX5/Ca4yauFP5gCXu8R5e8
    ATuCazD5w14RyGhUDf8kJ2nnJlgWRO3UwgsRWPcouZeOlihQh5D8nnxfIJXtuCyTTW3jlv
    7TsEq+dkGy+hPVqy5gzBhzu74DPvX0twDJI7dlB6ID2+z1ZSG+J1UYSs61b9WIUb4ttyzS
    TjZSEePWTPWlDNq9PoUQQWqdzHgd48jCUCsvE2SpVwPE7xmxBMRNl9jVOmXJglehoDpXd9
    z7WWsk64xF+a6MwNoBsFE/yKMv6OSIpaAByuh/5HYUXC1C2pht/LVhYAvicEDOwXVeAMyN
    6QHhq6XTEBwnqHjw+vWgmxJE8KWrktttFqSpXIHL+Ldl3JEWwh3FcBx1FKuw
X-ME-Proxy: <xmx:SHIhaqeGCWvoTr6Zf4A7VuqQKHMJAl9R7ARuuX7SWO3hikB0EABGqw>
    <xmx:SHIhajm2MNfjagJxh9VKB7kVOB1FHuJFe5pi_tBuhyOPef0APhlWJA>
    <xmx:SHIhauE42o8acVl_EkD0i90rEiqekyJ5wDDuuU7N0Uc-cMcHHEKKFA>
    <xmx:SHIhapIi0Aj_i8f5RMMHTUFMJs_gmylfCV5Mpk-2TVrJhlM3iZONJw>
    <xmx:SHIhaktsp0bNSEQQ_zMYZ1h3aUBSoUkTxD9FkfVknP1rAqe0eaUb8bXA>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 08:40:40 -0400 (EDT)
Date: Thu, 4 Jun 2026 05:40:39 -0700
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
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: Re: [PATCH v2 10/12] preempt: Introduce
 HAS_SEPARATE_PREEMPT_RESCHED_BITS
Message-ID: <aiFyR-9rSGx38tWi@tardis-2.local>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-11-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526152148.30514-11-boqun@kernel.org>

On Tue, May 26, 2026 at 08:21:46AM -0700, Boqun Feng wrote:
[...]
> +#ifdef CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS
> +static __always_inline void __preempt_count_nmi_enter(void)
> +{
> +	__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);
> +}
> +
> +static __always_inline void __preempt_count_nmi_exit(void)
> +{
> +	__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);
> +}
> +#else
> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
> +
> +#define __preempt_count_nmi_enter()				\
> +	do {							\
> +		unsigned int _o = NMI_MASK + HARDIRQ_OFFSET;	\
> +		/* Maximum NMI nesting is 15. */		\
> +		BUG_ON(__this_cpu_read(nmi_nesting) >= 15);	\
> +		__this_cpu_inc(nmi_nesting);			\
> +		_o -= (preempt_count() & NMI_MASK);		\
> +		__preempt_count_add(_o);			\
> +	} while (0)
> +
> +#define __preempt_count_nmi_exit()				\
> +	do {							\
> +		unsigned int _o = HARDIRQ_OFFSET;		\
> +		if (!__this_cpu_dec_return(nmi_nesting))	\
> +			_o += NMI_MASK;				\
> +		__preempt_count_sub(_o);			\
> +	} while (0)

This needs to be:

#define __preempt_count_nmi_exit()				\
	do {							\
		__preempt_count_sub(HARDIRQ_OFFSET);		\
		if (!__this_cpu_dec_return(nmi_nesting))	\
			preempt_count_set(preempt_count() & ~NMI_MASK); \
	} while (0)

otherwise we would have an underflow issue if an NMI happen between
the "if" being true and __preempt_count_sub(_o);

Regards,
Boqun

> +
> +#endif
> +
> +
[...]
