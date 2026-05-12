Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E9039BFF8;
	Tue, 12 May 2026 22:16:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778624215; cv=none; b=OxqaeQWsMcsSY+OmW9AAGblIDT3MnieSCFd52zeZF9Scg8JW4cmdkrqeQhUvildZH2gMqVUVuDPRABacBrb9fFwp+YXhzVOeikcRKwMkR2pxsM32lNCqOWQE389R++fz0to79aP+i42uUI2ajfKBCVId5TXHssUNKhEqdh31uok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778624215; c=relaxed/simple;
	bh=qFgg86vfNYlSBmwjPSiUrMA9vqu5u8ZMpls612yt4yk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m5Y8YDucmq2hlw80VJJyKL4XGYzLmZ5t2ID/LR0fw36UrtQpdpbHV+1iugam6k5/HZ5KS2SBa0jyLollcmdQqErCuGpLd2kLk+wv1pmLmmZfen48n0HyrwElkUh5qhR85/cMC4cxlIU7D8zvAHYzw7+88r35Cr44sDzULip2Wdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aI24+0Q9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aI24+0Q9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48AA9C4AF09;
	Tue, 12 May 2026 22:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778624215;
	bh=qFgg86vfNYlSBmwjPSiUrMA9vqu5u8ZMpls612yt4yk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aI24+0Q9jcy6+u/TPKMhDNSZJHhXpJ8/72gt6JXDmYPIS3K9Ox4hc9zmC7TShhlz0
	 5DJLLNc06iXDkN8llI86CR0QdfQqvRwh0SRHF14bJVKnbvMIJ9dnx7FJLFay6OGVCI
	 xq+4Q/WJ/fsaZnBrtuyPXcxnfSMhUNFR/zdGt6AjyVucU0GPRwTQ6dw5HNdbs3m2c5
	 v6kvoiSNTBZuHDadEUqqzDvS2fc2ub3K6prk5sfljASCHjtWbHfzzHUKqUjqkmEZec
	 RKDIZjQ9mZeq9+W30jDbr9UCe5lxwLyAXKY1Ke9H3mwz7ELr6EbeNNQAzWU6NjL/pz
	 2dA+NHTAl42Dg==
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfauth.phl.internal (Postfix) with ESMTP id 5B59DF40069;
	Tue, 12 May 2026 18:16:52 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Tue, 12 May 2026 18:16:52 -0400
X-ME-Sender: <xms:1KYDav0_8vbBX42T8iRkXCdm5uJzplrP08KzxpJbhRfNWTd6mHLa5g>
    <xme:1KYDahFDfahaWa2tsBdMRBA0f5XSMBWlaE74qoAxZpr2iWbVw2zAMy0LB5rFTi0n5
    ej7N0aog_YdqvdlyXUYNjvuKuKop68QRIA9C18AbM9JK2xRYogCRg>
X-ME-Received: <xmr:1KYDarjWRrXH5HaTwpWgqF-OvG9S-AS3loE_R1KtENN30NAh3AaTe5h9Irvj9I6du60661DaoWjHtRizbHh8WGvK6neunpvc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduvddvleekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhunhcu
    hfgvnhhguceosghoqhhunheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrhhnpe
    dtieegleekgeeggffhffeikeegfffgffeileekjeevgfejfeejtddtteffledugeenucff
    ohhmrghinhepmhhsghhiugdrlhhinhhknecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhn
    rghlihhthidqudeijedtleekgeejuddqudejjeekheehhedvqdgsohhquhhnpeepkhgvrh
    hnvghlrdhorhhgsehfihigmhgvrdhnrghmvgdpnhgspghrtghpthhtohepheekpdhmohgu
    vgepshhmthhpohhuthdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrd
    gtohhmpdhrtghpthhtoheprhhoshhtvgguthesghhoohgumhhishdrohhrghdprhgtphht
    thhopehpvghtvghriiesihhnfhhrrgguvggrugdrohhrghdprhgtphhtthhopegtrghtrg
    hlihhnrdhmrghrihhnrghssegrrhhmrdgtohhmpdhrtghpthhtohepfihilhhlsehkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehjohhnrghssehsohhuthhhphholhgvrdhsvgdprh
    gtphhtthhopehsthgvfhgrnhdrkhhrihhsthhirghnshhsohhnsehsrghunhgrlhgrhhht
    ihdrfhhipdhrtghpthhtohepshhhohhrnhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    ephhgtrgeslhhinhhugidrihgsmhdrtghomh
X-ME-Proxy: <xmx:1KYDajhHepiJeDf0PcgrDtqPaw7ywhmn9zw_yRXK25LyOZRfbLXv3Q>
    <xmx:1KYDagLyzmL6A2qYl29cMMGKyY1nvIDGkyxfmtOj8Y0mbp-z4AAJOQ>
    <xmx:1KYDanOj9FavIsrhFrhD5j0nAwH-yVa5ZsfP4VT0ELCN-oRadUCeSQ>
    <xmx:1KYDaosyPIgGT5Nq3jO6Bx380jIxmyuOC5Xh_-YvveDGXSVspq1c3Q>
    <xmx:1KYDavFzjrlkwabNnZR76aE-U0G04KfLBHMKsFKnrQJU7vyTPpdWLurm>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 12 May 2026 18:16:51 -0400 (EDT)
Date: Tue, 12 May 2026 15:16:50 -0700
From: Boqun Feng <boqun@kernel.org>
To: Joel Fernandes <joelagnelf@nvidia.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
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
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
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
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-arch@vger.kernel.org, rust-for-linux@vger.kernel.org,
	Boqun Feng <boqun.feng@gmail.com>,	Joel Fernandes <joelaf@google.com>
Subject: Re: [PATCH 02/11] preempt: Track NMI nesting to separate per-CPU
 counter
Message-ID: <agOm0iiqrqPWXQPO@tardis.local>
References: <20260508042111.24358-1-boqun@kernel.org>
 <20260508042111.24358-3-boqun@kernel.org>
 <20260512123048.6666343f@gandalf.local.home>
 <6b2a38fb-1828-43bf-8059-fca8f703e179@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b2a38fb-1828-43bf-8059-fca8f703e179@nvidia.com>

On Tue, May 12, 2026 at 03:22:39PM -0400, Joel Fernandes wrote:
> 
> 
> On 5/12/2026 12:30 PM, Steven Rostedt wrote:
> > On Thu,  7 May 2026 21:21:02 -0700
> > Boqun Feng <boqun@kernel.org> wrote:
> > 
> >> From: Joel Fernandes <joelagnelf@nvidia.com>
> >>
> >> Move NMI nesting tracking from the preempt_count bits to a separate per-CPU
> >> counter (nmi_nesting). This is to free up the NMI bits in the preempt_count,
> >> allowing those bits to be repurposed for other uses.  This also has the benefit
> >> of tracking more than 16-levels deep if there is ever a need.
> >>
> >> Reduce multiple bits in preempt_count for NMI tracking. Reduce NMI_BITS
> >> from 3 to 1, using it only to detect if we're in an NMI.
> >>
> >> Suggested-by: Boqun Feng <boqun.feng@gmail.com>
> >> Signed-off-by: Joel Fernandes <joelaf@google.com>
> >> Signed-off-by: Lyude Paul <lyude@redhat.com>
> >> Signed-off-by: Boqun Feng <boqun@kernel.org>
> >> Link: https://patch.msgid.link/20260121223933.1568682-3-lyude@redhat.com
> >> ---
> >>  include/linux/hardirq.h | 16 ++++++++++++----
> >>  include/linux/preempt.h | 13 +++++++++----
> >>  kernel/softirq.c        |  2 ++
> >>  3 files changed, 23 insertions(+), 8 deletions(-)
> >>
> >> diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
> >> index d57cab4d4c06..cc06bda52c3e 100644
> >> --- a/include/linux/hardirq.h
> >> +++ b/include/linux/hardirq.h
> >> @@ -10,6 +10,8 @@
> >>  #include <linux/vtime.h>
> >>  #include <asm/hardirq.h>
> >>  
> >> +DECLARE_PER_CPU(unsigned int, nmi_nesting);
> >> +
> >>  extern void synchronize_irq(unsigned int irq);
> >>  extern bool synchronize_hardirq(unsigned int irq);
> >>  
> >> @@ -102,14 +104,16 @@ void irq_exit_rcu(void);
> >>   */
> >>  
> >>  /*
> >> - * nmi_enter() can nest up to 15 times; see NMI_BITS.
> >> + * nmi_enter() can nest - nesting is tracked in a per-CPU counter.
> >>   */
> >>  #define __nmi_enter()						\
> >>  	do {							\
> >>  		lockdep_off();					\
> >>  		arch_nmi_enter();				\
> >> -		BUG_ON(in_nmi() == NMI_MASK);			\
> >> -		__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);	\
> >> +		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
> > 
> > I think we should keep the max nesting fixed to 15. If this doesn't trigger
> > until UINT_MAX, it may take a long time to see that, and there's no reason
> > NMIs should nest more than 15 anyway.



> > 
> > Just because the counter allows it, doesn't me the system should allow it.
> 
> That's fine with me. Boqun, do you want to make the one-line change to the patch?
> 

Something like this on top of your patch?

diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index cc06bda52c3e..a59a33e0f5ca 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -110,7 +110,8 @@ void irq_exit_rcu(void);
 	do {							\
 		lockdep_off();					\
 		arch_nmi_enter();				\
-		BUG_ON(__this_cpu_read(nmi_nesting) == UINT_MAX);	\
+		/* Maximum NMI nesting is 15 */			\
+		BUG_ON(__this_cpu_read(nmi_nesting) == 15);	\
 		__this_cpu_inc(nmi_nesting);			\
 		__preempt_count_add(HARDIRQ_OFFSET);		\
 		preempt_count_set(preempt_count() | NMI_MASK);	\

I will need to adjust this in patch #10 as well, but shouldn't be hard.

Regards,
Boqun

> Thanks.
> 
