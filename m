Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7591B3DD531;
	Wed, 27 May 2026 16:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779898737; cv=none; b=HRtYHrudCKUbUvgb/XyjjzaipNFLEyFJAtlikFhJgENqXTM1Pf4XAGbzVFjCNNGPW9pS3dzUGLgaRDWW9sCuULtrCIHEpxO+gPeOfcS7cOo/r5RBGjPYx7HOr01eIgmOKIfGpzWPMA5AxwzIVeHvl1h7ozHd3TPzjz2jZOTu5R0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779898737; c=relaxed/simple;
	bh=4DAyd/GzqcemDK6zg4iwqVWuOPppTjZluFU8wqRNiKo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kAR3ytot0AQ6QU2TMYuMFYNsKwT0loyIm+nC3KaL7GvCaf10jvicyDy0/FspqdALN4SUcwDUUe8AlB/vVX6Qj++/OcJxDCZjKjx6pCltJu85lmsx+B+mqvHijJCBvhD0ZKPiNqjVnXfEbrQaoBfdFflHjGmLxpuSnzXAFOD/CJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Zq4W9XPv; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Zq4W9XPv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=hYaRrphnaRA6o4Jy4ywiOltVwIEnnSPRCMUmgPOwnaE=; b=Zq4W9XPvSOJBWtRlh+QNr3t9Di
	bScgKAb5GnQzy0TlNiwt/IkFao9VfbDcVrCTRrQWiLP71G3DRXumxGczrZPzZ4D8ufaFzKZYduEwc
	0ucZgyPjl+9avElWP3K5JsMRj7DMznF4wN1yTI9KxYIBWwiA6L2bK9/OeyAy5AQYW77hbkp4fZJES
	GAxIYttaGMqrp4dvPTMquyZCNjdgIEumWJBBMXgevMBGKPn+8LD8TmTTzScMPBHsuDRPpqZ0vStSa
	zOnBI10pnmBIR3fn0AQSKpShM3JR3DwuaS6z/zaXi4A/9QMrqJPs+9SPDnjU3jIySuU9gUr7a2Nik
	xHNYlgtA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSGxx-00000002wLj-2aWJ;
	Wed, 27 May 2026 16:18:45 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 82A90300CB5; Wed, 27 May 2026 18:18:44 +0200 (CEST)
Date: Wed, 27 May 2026 18:18:44 +0200
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
Subject: Re: [PATCH v2 00/12] Refcounted interrupt disable and SpinLockIrq
 for rust (Part 1)
Message-ID: <20260527161844.GG3102624@noisy.programming.kicks-ass.net>
References: <20260526152148.30514-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526152148.30514-1-boqun@kernel.org>

On Tue, May 26, 2026 at 08:21:36AM -0700, Boqun Feng wrote:
> Hi Peter,
> 
> This is a follow-up for Lyude's work [1]. After learning the current
> preempt_count() usage and how ARM64 handle this, I came up with this
> series that could resolve your feedback [2]. The basic idea is based on:
> 
> 1) preempt_count() previously already masks our NEED_RESCHED bit, so the
>    effective bits is 31bits
> 2) with a 64bit preempt count implementation (as in your PREEMPT_LONG
>    proposal), the effective bits that record "whether we CAN preempt or
>    not" still fit in 32bit (i.e. an int)
> 
> as a result, I don't think we need to change the existing
> preempt_count() API, but rather keep "32bit vs 64bit" as an
> implementation detail. This saves us the need to change the printk code
> for preempt_count().

> 
> v1: https://lore.kernel.org/rust-for-linux/20260508042111.24358-1-boqun@kernel.org/
> 
> Changes since v1:
> 
> * Rename PREEMPT_COUNT_64BIT to HAS_SEPARATE_PREEMPT_RESCHED_BITS per
>   Mark Rutland.

Blergh, so I really don't like that new name. It isn't that
PREEMPT_RESCHED is separate, it really is a 64bit preempt count.

Shashiko has a few fits, but its mostly being stupid. Although I think
it might be useful to perhaps put a WARN_ON_ONCE(in_nmi()) in
local_interrupt_disable().

Anyway, I'll re-read things again tomorrow, but I suppose this will do.

