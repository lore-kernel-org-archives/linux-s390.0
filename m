Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9D33C4545;
	Thu, 28 May 2026 10:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779965135; cv=none; b=Pya9iLbNL67A1V/PeYf4xTv+7LASuFVdUGHCgRQ1H5u1Dr2D2Uh9VdtcWjRTyIGOs+uzqinPBVgYOUT216SGtxaxN4t6OrE9hteU9p5WRcveXXFDz8yJAyFU5yZs1rDAA8Hrdq7IrXhB6R1Y4SmYTEr6uSkeatqZTweYsSrmvuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779965135; c=relaxed/simple;
	bh=KZ5zJjod0pdwnIHb2DAiIP0b5ZwKt2aV+cqV0XTBoVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FvLm6DC+WsMqt4jctAREN0+ib1YztHWFCz1MoE4uxvlNLzwiXNoYyqMOHNN90QS7dbKeF0U5JaAc5JlZwZ287AZ9H94IcJxK1+6ys3Y5Ua83GqqsJYNNXeWMtT4Ja2pg/FzyU87DXiXGb3f5DjppLgM+B+KFnptcArKJhbhuRJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=UzSArhsl; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="UzSArhsl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=YWN8ydJ9aNkFl/9gR6sbvxWg3Nwr1Jm+hdQmUobZG2g=; b=UzSArhsli6ZTpULMXT9jS2V8cw
	c8iAh8AIjDKnxRvsipxKtHqggllfIweVL5EZS21OSCsTrOum8ZWWYusMz2aDd+IIP0G4Gq4Au7S7C
	2iCHFebu1g00u+FKN62bjMjCC8J5KgliHLD6AALsEO8XvEaVB/RyOR+44CwJfCxXIYsVdEEhoN836
	+h/SYC730ZEyExytREsqXVR4xuTVpNp9hBK19Yzv7DouQRIRm64vgKDY6vEJkDk9jnCxhsZynGoKT
	+tEFXVExGelZR08+GBJ2xQf5L31QmATsiVEpBf48UhvnFg9S85wPCF8MOJ8wQ1gsiRlDe7s1pmxMY
	hLuodulw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wSYEz-0000000GCPr-1aam;
	Thu, 28 May 2026 10:45:29 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 1CBA9300673; Thu, 28 May 2026 12:45:29 +0200 (CEST)
Date: Thu, 28 May 2026 12:45:29 +0200
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
Subject: Re: [PATCH v2 07/12] locking: Switch to _irq_{disable,enable}()
 variants in cleanup guards
Message-ID: <20260528104529.GG343181@noisy.programming.kicks-ass.net>
References: <20260526152148.30514-1-boqun@kernel.org>
 <20260526152148.30514-8-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260526152148.30514-8-boqun@kernel.org>

On Tue, May 26, 2026 at 08:21:43AM -0700, Boqun Feng wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> The semantics of various irq disabling guards match what
> *_irq_{disable,enable}() provide, i.e. the interrupt disabling is
> properly nested, therefore it's OK to switch to use
> *_irq_{disable,enable}() primitives.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Signed-off-by: Boqun Feng <boqun@kernel.org>

You really need them both? ;-)
