Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973A23B2FC0;
	Thu,  9 Apr 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755612; cv=none; b=WHbMKZFCdrAmh3fNQuf0IHN7dwTkeODRe/JQBbOR1DCpMbQpy0FkXZxiJy6kJZNH5/GLkC/Lio/3Y29CnjXdpCFWG40jMqwBTDQkQpHYEnOs6UksB9BKkAboZqYFcpLMZfAJUKUDupz1BTxsykv1recHKkXso4XGA+7z0tsYbKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755612; c=relaxed/simple;
	bh=1eQ9IomCBoXeMWGvHYlE/O6b2ox7gxUKIG+Mu/bKJPg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lA3XVl6QZ9RuA+of/zfAUHifC++Xn6Viud4xY2Wzq4BrzeJQVCiTfsbrxB0cq4kbYC3Pq0/9GoJjVphEEFR5F/5jMy8k7JvtCCbTqUdJpyamAo5v99WJyb/uahbhydU2d9XsFQRBDN3UNes5Spm4JJ0HZFWu2KR+SCqOsGXZtT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOWVKpWH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOWVKpWH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0104BC4CEF7;
	Thu,  9 Apr 2026 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775755612;
	bh=1eQ9IomCBoXeMWGvHYlE/O6b2ox7gxUKIG+Mu/bKJPg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iOWVKpWH29UXjVMuISohgAK9YnNPPQPFHk0vLHCt77bqF1BEKZKDAvI+P0OBUAxZI
	 p1VNeTivrig2anuX3jjvT2/SA42hn5WlDJcUu0T6CVjqtHORk6m+weCKbkME9aMEVf
	 UeD09JKBhF04sG4tr83cqS6LDJ1cjJ73YDoxDVNwgzyddkzIwmbceJUYLLEzpPmQ0z
	 QShXrlO32d1iaFWifZIVKX38JHCxjAlKlQUzOsE+AaOCNVgXeJKjnyrxEaPwy214aw
	 0w9NqMoMf+b3AIOklBwP9z57ebFtZ+ce0hS/7HRr9GFFvQP+5L0Zif4katIPn5euqr
	 Y3LUDgdlfwCWA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id EEB51F40079;
	Thu,  9 Apr 2026 13:26:50 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 13:26:50 -0400
X-ME-Sender: <xms:WuHXabtY4cKf1vet0l6mOstA5rVaFUo4yVA1inlnq5F5kfBWM5vQnw>
    <xme:WuHXaS1IebjpNppdzufVzdKLurqC_aL4ifaw341fzE9XXrKoqgR2ntS5j20BKYi8s
    wjmV9EoZtEE0q93NjMnSauJdGQ1PSXJmh_GGskrbtjYlqU2g8SztA>
X-ME-Received: <xmr:WuHXabBK6I6ys36B9Qc5eIcWYgsPt370EVAd5qgpOUyRdtaTQeHfH47cYKQCLCJ8FZ5GX4i1Cbyi3K0gMxwILVXunnmTxBDP>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedtlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnheple
    euheethfdttdfgjedvjeeuhefhkeetveeuueeukeegteeigeeghedvffehhffhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdduieejtdelkeegjeduqddujeejkeehheehvddqsghoqhhunheppehkvghrnh
    gvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhorheslhhinhhugidrihgsmhdrtghomhdprh
    gtphhtthhopehprghulhhmtghksehkvghrnhgvlhdrohhrghdprhgtphhtthhopehfrhgv
    uggvrhhitgeskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepnhgvvghrrghjrdhuphgrug
    hhhigrhieskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovghlrghgnhgvlhhfsehn
    vhhiughirgdrtghomhdprhgtphhtthhopehurhgviihkihesghhmrghilhdrtghomhdprh
    gtphhtthhopehrtghusehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhi
    nhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplh
    hinhhugidqshefledtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:WuHXaYCMr2sel-bkWNr4ql3ERwQUaQWnFDgurNmD-Evdt-eB4-ztlA>
    <xmx:WuHXaUnd47B6Ra59ezLagsa2e2wOO3DAG9e3yZInQsJR5VOBsRKFdg>
    <xmx:WuHXaQgay2Sa-H9OH2TvoDvuNtadlW-bxQPqvTkbG9O5739a2U3q6A>
    <xmx:WuHXaWgoK8269_OII3xa6LOdzayNTehFJadrVfRtLTpWYHTKrbCgRw>
    <xmx:WuHXaauXUy83pBzaoBepOjKrlZs_shpgVimpRT5geKPgm52kMaKFAUiO>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 13:26:50 -0400 (EDT)
Date: Thu, 9 Apr 2026 10:26:49 -0700
From: Boqun Feng <boqun@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <adfhWQr1yFImSM2Q@tardis.local>
References: <ttd89ul@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ttd89ul@ub.hpns>

On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> non-preemptible") defers srcu_node tree allocation when called under
> raw spinlock, putting SRCU through ~6 transitional grace periods
> (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> per-CPU pools directly - pools for not-online CPUs have no workers,

[Cc workqueue]

Hmm.. I thought for offline CPUs the corresponding worker pools become a
unbound one hence there are still workers?

Regards,
Boqun

> work accumulates, workqueue lockup detector fires.
> 
> Before 61bbcfb50514, GFP_ATOMIC allocation went straight to
> SRCU_SIZE_BIG, the mask = ~0 path was never reached.
> 
> Affects systems with convert_to_big active (auto when nr_cpu_ids >= 128)
> and possible CPUs > online CPUs. Hit on s390 LPAR (76 online, 400 possible),
> where possible CPUs > online CPUs is the usual case.
> Also reproducible on x86 KVM --smp 16,maxcpus=255 (CONFIG_NR_CPUS=256)
> or simply -smp 1,maxcpus=2 with srcutree.convert_to_big=1
> or --smp 16,maxcpus=64 with srcutree.big_cpu_lim=32 (CONFIG_NR_CPUS=64)
> 
> s390 log (76 online CPUs, 400 possible, all pools 76-399 stuck):
> 
>   BUG: workqueue lockup - pool cpus=76 node=0 flags=0x4 nice=0 stuck for 1842s!
>   BUG: workqueue lockup - pool cpus=77 node=0 flags=0x4 nice=0 stuck for 1842s!
>   ...
>   BUG: workqueue lockup - pool cpus=399 node=0 flags=0x4 nice=0 stuck for 1842s!
>   Showing busy workqueues and worker pools:
>   workqueue rcu_gp: flags=0x108
>     pwq 306: cpus=76 node=0 flags=0x4 nice=0 active=3 refcnt=4
>       pending: 3*srcu_invoke_callbacks
>     pwq 310: cpus=77 node=0 flags=0x4 nice=0 active=3 refcnt=4
>       pending: 3*srcu_invoke_callbacks
>     ...
>     pwq 1598: cpus=399 node=0 flags=0x4 nice=0 active=3 refcnt=4
>       pending: 3*srcu_invoke_callbacks
> 
> Not sure if replacing mask = ~0 with something derived from
> cpu_online_mask would be racy in that context.
> 
> [1] https://lore.kernel.org/rcu/acRho9L4zA2MRuxc@tardis.local
> [2] https://lore.kernel.org/rcu/fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop
