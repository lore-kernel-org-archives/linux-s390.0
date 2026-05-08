Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA3E3C73DE
	for <linux-s390@vger.kernel.org>; Fri,  8 May 2026 14:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251718; cv=none; b=YqMChoS6MjSt7tGx8mq9i4w+2yzwwVRW/IqiqTVGW2Ge5yzVjagTxc6Rv14gWuAVKcNIIoHtrGWp2czuFnhpCJlEXlzrcMgiOBRluUeacUbFi/f9EwT0ViyNnroOhvND1ySoAbD8n4Gzu9VY7cFWzfo+6VThBnBnvi1rXNClioA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251718; c=relaxed/simple;
	bh=cgN7A1X7T0cojU2T2uSFT+6vqQbWtR5/P5UyiMggOKg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9cyU2aQsc+aFXLjlS8RGxnJjmtfJ9JTCE6582v7PlFcXgfTvLWwiZ1IEQylZ11HFomJajME2F9wh099JjR+GkOfLzW8MJ3cFAlPW8FqES38IqG5tVwxhB70Y3aZYi/qO/J0WWSzFN/Pjthjn2/PNSb49QjMmRg5q3HbNGwRddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JFlyKRcp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JFlyKRcp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EBEAC2BCB0;
	Fri,  8 May 2026 14:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778251718;
	bh=cgN7A1X7T0cojU2T2uSFT+6vqQbWtR5/P5UyiMggOKg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JFlyKRcpvlD/bPMRtFzjnSRf/xPrUdavMyRgaXwDWvTkhWFW3Wy/zhihMQfrgvtyK
	 8pQE/DEp04tWidhWuD+3OUwblCKpyltcoPrQ0itzhLLLoeMCPIxtue7b6fGAbp1OSO
	 E0GEil1PvkDWjpyU77Bulfu6GuAaWfnhpKh+sGQdzLYlhY7bpaFrnB427zt2SsK/Ir
	 lNLmTB6f/J0r77EnM3CyBHxxH0PIlIDEtQCTffT/D6eteRigUB3A2dpYtVUxYS/dqJ
	 fX5krC/8FhTakbq1VKqs7Tbi8Dhn/KqQAe5NrMXzb1+bj/b7Ffx84OwuaDdDcMJTb/
	 6jqNiyJ6W0/7Q==
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfauth.phl.internal (Postfix) with ESMTP id 68CAEF40071;
	Fri,  8 May 2026 10:48:36 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Fri, 08 May 2026 10:48:36 -0400
X-ME-Sender: <xms:xPf9acOfuYU0lGUlWUFxgRlwtXOonYDb2Jzd4suBZm6azQLCEem0cw>
    <xme:xPf9aYwUeZugIxSEf8iSoqrAeZDEwEFhOXRsPAMTnme8ICYe2vzvtCkaBuOKPUS1r
    qyaR3zZPaUPG4qXl_cslrr2Rq8tLzfVADoZ1XPcRmQnppdoFxw1VQ>
X-ME-Received: <xmr:xPf9aYWaKFaWMenMNxUYVc1uSp4eVybh9FIWnxSfcFf_BVCzaC5icjOoqFqb_u_jBKbRCvyMqmSeMC1NWhZN7KRJS2pf9_-I>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduuddtieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    ekgffhhfeuheelhfekteeuffejveetjeefffettedtteegfefftdduteduudfgleenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnod
    hmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduieejtdelkeegjeduqddujeej
    keehheehvddqsghoqhhunheppehkvghrnhgvlhdrohhrghesfhhigihmvgdrnhgrmhgvpd
    hnsggprhgtphhtthhopeehjedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepmhgr
    rhhkrdhruhhtlhgrnhgusegrrhhmrdgtohhmpdhrtghpthhtohepphgvthgvrhiisehinh
    hfrhgruggvrggurdhorhhgpdhrtghpthhtoheptggrthgrlhhinhdrmhgrrhhinhgrshes
    rghrmhdrtghomhdprhgtphhtthhopeifihhllheskhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepjhhonhgrshesshhouhhthhhpohhlvgdrshgvpdhrtghpthhtohepshhtvghfrghn
    rdhkrhhishhtihgrnhhsshhonhesshgruhhnrghlrghhthhirdhfihdprhgtphhtthhope
    hshhhorhhnvgesghhmrghilhdrtghomhdprhgtphhtthhopehhtggrsehlihhnuhigrdhi
    sghmrdgtohhmpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:xPf9aTtPViALwsR-GBUDqdJRZ7UgaSYbpbVi3tp27kMrsUzEj4eZug>
    <xmx:xPf9aeuU6kdXUI9aDuKfL8Ep1pzFR1YRqNDp_odvfBe9GS4asRVZ2w>
    <xmx:xPf9aQEtkgzjCi2KdPqwXU7pdtFeY5kgRWO1xvUPSUkbilYxloK_4w>
    <xmx:xPf9aVj9kvhtECnLEc9FWYLHLm3MSrBP28JD4FD9tHdOC69YRWjYgQ>
    <xmx:xPf9adCk8T09C4oXlmfuG0CR9eb0TB_w-nWGPRAORtupUYAbOELiad2W>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 8 May 2026 10:48:35 -0400 (EDT)
Date: Fri, 8 May 2026 07:48:34 -0700
From: Boqun Feng <boqun@kernel.org>
To: Mark Rutland <mark.rutland@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
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
Subject: Re: [PATCH 11/11] arm64: sched/preempt: Enable PREEMPT_COUNT_64BIT
Message-ID: <af33wq5R09HWVE84@tardis.local>
References: <20260508042111.24358-1-boqun@kernel.org>
 <20260508042111.24358-12-boqun@kernel.org>
 <af2dPMW97tNOWuGF@J2N7QTR9R3>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <af2dPMW97tNOWuGF@J2N7QTR9R3>

On Fri, May 08, 2026 at 09:22:20AM +0100, Mark Rutland wrote:
> Hi Boqun,
> 
> I have a question at the end, with some context for other reviewers
> before that.
> 

Thank you for adding the context.

> On Thu, May 07, 2026 at 09:21:11PM -0700, Boqun Feng wrote:
> > ARM64 already uses 64bit preempt count and the need reschedule bit is
> > maintained in a separate 32bit than the preempt count. 
> 
> For the benefit of those reading the list, arm64 has a separate 32-bit
> count and a 32-bit field for need_resched, which are unioned together as
> a composite 64-bit value:
> 
> 	union {
> 		u64             preempt_count;  /* 0 => preemptible, <0 => bug */
> 		struct {
> 			u32     count;
> 			u32     need_resched;
> 		} preempt;
> 	};
> 
> All of our "count" operations work on the 32-bit count, e.g.
> 
> 	static inline int preempt_count(void)
> 	{
> 		return READ_ONCE(current_thread_info()->preempt.count);
> 	}
> 
> 
> 	static inline void __preempt_count_add(int val)
> 	{
> 		u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> 		pc += val;
> 		WRITE_ONCE(current_thread_info()->preempt.count, pc);
> 	}
> 
> 	static inline void __preempt_count_sub(int val)
> 	{
> 		u32 pc = READ_ONCE(current_thread_info()->preempt.count);
> 		pc -= val;
> 		WRITE_ONCE(current_thread_info()->preempt.count, pc);
> 	}
> 
> ... but some operations use the 64-bit 'preempt_count' field from the union, e.g.
> 
> 	static inline bool should_resched(int preempt_offset)
> 	{
> 		u64 pc = READ_ONCE(current_thread_info()->preempt_count);
> 		return pc == preempt_offset;
> 	}	
> 
> > Therefore preempt count has enough bits to represent 16 level of NMI
> > nesting, hence enable it for ARM64. This saves a per-CPU variable and
> > additional instructions in the NMI path.
> 
> This might be true, but I think the name "PREEMPT_COUNT_64BIT" is
> misleading given the above. What exactly does PREEMPT_COUNT_64BIT tell
> core code it can do?

It tells the core code that all 32bit of preempt_count() can be used.

> 
> If this is just telling core code that it doesn't need ot reserve space
> in preempt_count for the resched bits, can this be called something
> else, e.g. HAS_SEPARATE_PREEMPT_RESCHED_BITS?

You are right on that the resched bit detail is a major difference
between PREEMPT_COUNT_64BIT=y or n. I haven't gone that far to resolve
the #1 difficult issue in programming (i.e. naming) ;-)
HAS_SEPARATE_PREEMPT_RESCHED_BITS seems reasonable, I will use it if no
other better ideas. Thanks!

Regards,
Boqun

> 
> Mark.
> 
> > 
> > Signed-off-by: Boqun Feng <boqun@kernel.org>
> > ---
> >  arch/arm64/Kconfig | 1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index fe60738e5943..1ed5173872fc 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -248,6 +248,7 @@ config ARM64
> >  	select PCI_SYSCALL if PCI
> >  	select POWER_RESET
> >  	select POWER_SUPPLY
> > +	select PREEMPT_COUNT_64BIT
> >  	select SPARSE_IRQ
> >  	select SWIOTLB
> >  	select SYSCTL_EXCEPTION_TRACE
> > -- 
> > 2.50.1 (Apple Git-155)
> > 
> > 
