Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8CA282F31;
	Thu, 28 May 2026 14:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779979290; cv=none; b=mRB/+fzW8gC3bxZrJyDQ6l9vgE0qXaIQlTaIfzuu1T0sK91ffAcMCsoukavpbNURhlAm3Dfz98LuMzY46zH8Fgpc7VHYC4niNHckIlbJ/jptgUlL4VIobw4D98Ru9sHYA2C8VoJOJqLHog65d7pWeDT4Nk7Pwfh0TAOMCqXmNXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779979290; c=relaxed/simple;
	bh=TSVRTbiKtmsRChxTwZ4Nj9VubQsmhf9bW37T6B7ZmGE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WUZz2lDvtgB1s8cfS2fj7uVc7mZFl/e4117ZaGHCJ+Vl6Fvt3pls6rKtDpVuSh2yj0HgZZ8oiBoWykqXCPYUgBwhEAmq6ErpQWBe8E/5nVUdFcDz6awXF5rX5sA2AjzVIZD7Gq4hojWAtLDLE84hKH67if7mFNynuBlyDYNl0A4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJCb4ol3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJCb4ol3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABD221F00A3C;
	Thu, 28 May 2026 14:41:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779979288;
	bh=mMLQXLFxxeMsfws9gx78dbexKuPC66BK1P4wL7v7ehg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lJCb4ol3Y/qYCJYc9E01QRP9NvycEYIutWnhCa21gS66LO6DlwtXZGqpozZCTWlSb
	 5e7QbDhSjmw5KIvFpn7Cnp7XOLppxxD/RK8l9QRECFRtN17LwFpPuyBez3F6W1d475
	 I9jOu6SRCTMhlJsp1/O/btLVf4wc2ERdwBd6E+/NpZOfKFWYm86bVIGb12oTqurgBs
	 tv0GDIfw85Jd/kcHx/FfQvVeTJ8zMmYF1dmDTtvzo11sDEnDl8KzLx2eWpZdIGhezU
	 2043gsee1UKkSZsC8mJChg+1FRvsY1ConFEvCKnff454y+t6VbvA/BSpy57YUwXVRQ
	 0YNe+N4KUyUlA==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id EF45FF40068;
	Thu, 28 May 2026 10:41:25 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-03.internal (MEProxy); Thu, 28 May 2026 10:41:26 -0400
X-ME-Sender: <xms:FVQYatQW0YUFZGH1sVD0mFNeIvzAx3Dmzqu7oVi-EdSAJ7y9HB7Ckg>
    <xme:FVQYarq_a2tfXU6jSn3if5_o4cr2wAWzQ2BjnJm1R1Uzlz9FyNLZqUUmySZeE8vvx
    pY4rRKVKCRK0rjMXXj4SkZm6OwbGZWth3rw13VIHVQu7aJeWxP_>
X-ME-Received: <xmr:FVQYaotUQxb7fbdarOi52k7_BR34cpJDE1z-1DT_sN2rNm5zvreZEQ8nSJkLv9dhm_Fg6Yni1ICIodu2kF0tK9EhhXZ1_6aY>
X-ME-Proxy-Cause: dmFkZTGy8ARkHRG0Nylf8jhBh1OVk8M8OYpjlyP8E9UwASywA+L1PTRKHON1RaUy8t7cYc
    PwGmcGrw3tYDchCND6HPzvaVJ+R+XPMPPxpt220k8uXm/Lg0XQJQVSoYBRcI/cGpSkNPyZ
    1n1oysLjYI2Vh4CpS7Em0mKaFqIGFb5PHKOSsKm6sLscIQzvXADXCglBu+zvVg8oYyQ1yC
    40TU5qUp5ijo8elvLd2b66pKWGAikHDutxq8cdEaJFP+yOhY4QcyFjpS9qFpSObqwc5UQ/
    +DWatDmcSYLIIzQS7ZDGPJxrhD9mX2S7/xZ/J0YjzKDFA+djUt2M4yKzqnCO/8OarABmqj
    ZEqqL8GRyVK3AavIr/mR2G3mv+gUCdSYOc68lqJ7kc1yZw7olF4QmWnK4pg3VIVFedR7FN
    gDv1F3nG1yI3bhFDtoNFDErFfGG9a/qmVJd4xnYC5VaRMMOcqn0UPPQKBmYmIuJNrsC5H5
    yuPwhVG58a3YVrCkjRnEHRoFQk7wck/1lLHatQJ+NafoDo6PBbU8wJzTJtopdDhWmhIIHV
    ySazFtHliy3s8aULkHypwlcXhtAUjK+GXBjxsIA0n6DkBH8SapbhM2D0H2KyfeSVLzGvFK
    KSYZh05J4G3UHwTwUDeGbo43fNJ/ZtNTftJSPrnPlG6xswe0EEsNiXyIIxTQ
X-ME-Proxy: <xmx:FVQYanenYDaZ9vtlmxY1b5OyWE6t4B7ewBW-gqAyYqouXkyHS9_DkQ>
    <xmx:FVQYasmOhFKtgCYj1FqVcx770u-k-AbIQKICkPku8ogr7lxEJQS5jw>
    <xmx:FVQYajHO3ut9oXptJIKaarZrIGHwRLi3uhQmnFz29_u23yzwGFSmdg>
    <xmx:FVQYaqKVqVreUQdYmmgH3wl6m7W91O1EJz2EvByotok1vmZZK7BPNw>
    <xmx:FVQYahvKXXDjIxHHNG9X-lYJI7q5Sek_22S-Z44KDxMZvTONYgBwiI3e>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 10:41:24 -0400 (EDT)
Date: Thu, 28 May 2026 07:41:24 -0700
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
Subject: Re: [PATCH v2 12/12] s390/preempt: Enable
 HAS_SEPARATE_PREEMPT_RESCHED_BITS
Message-ID: <ahhUFPdzboMWbXjn@tardis.local>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-13-boqun@kernel.org>
 <20260528105325.GI343181@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260528105325.GI343181@noisy.programming.kicks-ass.net>

On Thu, May 28, 2026 at 12:53:25PM +0200, Peter Zijlstra wrote:
> On Tue, May 26, 2026 at 08:21:48AM -0700, Boqun Feng wrote:
> > From: Heiko Carstens <hca@linux.ibm.com>
> > 
> > Convert s390's preempt_count to 64 bit, and change the preempt
> > primitives accordingly.
> > 
> > Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > Link: https://patch.msgid.link/20260509181249.16281C67-hca@linux.ibm.com
> > ---
> >  arch/s390/Kconfig               |  1 +
> >  arch/s390/include/asm/lowcore.h | 13 +++++++----
> >  arch/s390/include/asm/preempt.h | 41 +++++++++++++++------------------
> >  3 files changed, 29 insertions(+), 26 deletions(-)
> > 
> > diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> > index ecbcbb781e40..cbbca82f8443 100644
> > --- a/arch/s390/Kconfig
> > +++ b/arch/s390/Kconfig
> > @@ -276,6 +276,7 @@ config S390
> >  	select PCI_MSI			if PCI
> >  	select PCI_MSI_ARCH_FALLBACKS	if PCI_MSI
> >  	select PCI_QUIRKS		if PCI
> > +	select HAS_SEPARATE_PREEMPT_RESCHED_BITS
> >  	select SPARSE_IRQ
> >  	select SWIOTLB
> >  	select SYSCTL_EXCEPTION_TRACE
> > diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
> > index 50ffe75adeb4..0974ab278169 100644
> > --- a/arch/s390/include/asm/lowcore.h
> > +++ b/arch/s390/include/asm/lowcore.h
> > @@ -160,10 +160,15 @@ struct lowcore {
> >  	/* SMP info area */
> >  	__u32	cpu_nr;				/* 0x03a0 */
> >  	__u32	softirq_pending;		/* 0x03a4 */
> > -	__s32	preempt_count;			/* 0x03a8 */
> > -	__u32	spinlock_lockval;		/* 0x03ac */
> > -	__u32	spinlock_index;			/* 0x03b0 */
> > -	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
> > +	union {
> > +		struct {
> > +			__u32	need_resched;	/* 0x03a8 */
> > +			__u32	count;		/* 0x03ac */
> > +		} preempt;
> > +		__u64	preempt_count;		/* 0x03a8 */
> > +	};
> 
> I'm a little confused by this union; afaict it isn't actually used.

(TIL: s390 is big endian)

In preempt_count() the union is used for reading the lower 32bits in an
asm block.

Regards,
Boqun
