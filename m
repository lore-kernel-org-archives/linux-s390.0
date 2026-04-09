Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 154173B7B66;
	Thu,  9 Apr 2026 17:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775756409; cv=none; b=QguRXUmx4ggIlj7f2mE3SnL3IfTcM2/6ESbE48Sjr44bV1Tgui02jy+TTXeqC4qRPxb/O7xctmN3B1nh45EGbC1K9mGkGN05QiJElNUXOTK+yV52x2rTap2ahXDZEOXDV+ffdCpgj1RkvNj6ZvVhxKvsTS99uW5G39SXwx4helc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775756409; c=relaxed/simple;
	bh=sXsWs0L4SwMppbUntLwaXktLM+Hgy6LJcbFliuLTxCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GLiAGRzvpuNEMf8BA2ASRBm4C870uR4GZocasXxMnRVlYnknM/QT0qkefVs3srnFL9XUPUca1J+OS4LO2FfkS4tw8NgVzb2G05G1uT6IWrtjw/tSyoRzfrkXa22tr7S2mRNNn8LMM1A/Mfa+PAe+jQj1k+jFMZht7pXBGYo/Vcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YvKHXlqH; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YvKHXlqH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48D5FC4AF09;
	Thu,  9 Apr 2026 17:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775756408;
	bh=sXsWs0L4SwMppbUntLwaXktLM+Hgy6LJcbFliuLTxCg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YvKHXlqH0JhJW1H4HFfK8FcqWgqKUz0a/aXeYBK5lyndNo33ToKtl+oonziYG1pvc
	 WrFdD+ey/tiaW5EqyYWpvUIiozJsdQYRb8tZn3PTcjdC3O4EIsDPTE8yQu/JJWxiO7
	 3wvfXR2ON7OPxC9jC/CZt88k2GW7mqzQC2NIA2yfcn6cuRoho5glcTzujarD+fyNfn
	 ck9oOcGbglywuqDgsJSYUXo5hbnxIcod4w9cNKZN34HASkBKatrBOyFqtXIUvj/BoU
	 +ATb4o8FWyJelK1gl5dYjlRDW5YqkwpmamAzmX3+cJ8ZdOvtCadXDKIX9/nHxH+ZHg
	 M6wF+WXS5HmhA==
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfauth.phl.internal (Postfix) with ESMTP id 26633F4007D;
	Thu,  9 Apr 2026 13:40:07 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 09 Apr 2026 13:40:07 -0400
X-ME-Sender: <xms:d-TXaUOyRSkARVuMd4fJzJlpvFzb5NBXQdHgJlS7lY-HbvQq8GO95g>
    <xme:d-TXaRWXA_PEUk3vtwgD6lMdT88l28YQYkTSpxUnea4In5wSmpVXWSGHRM_gqieA2
    GEj7BQKckWOCOo5YyFLekTwGitLUXAYPDMa5Quzj1pNcX86qPZTCw>
X-ME-Received: <xmr:d-TXaXhTkKwuLtGdvQnvO-3iN-cOz_CtzctqLuVwvwtYvvZaaoY1h3jHPC13ClbqS9DcuYYzK9Ww3hHhpCBRNcfZ6opMG0Dx>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjeduudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdortddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhephf
    dugeeivedvtefguefgueetkeefgeekgefgheekudeghefghfehleekfedttedunecuffho
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
X-ME-Proxy: <xmx:d-TXaaj5foxMaMxklWf0MVBRy5gpgiLC8STwiwfNEkZOHyOulkhi9Q>
    <xmx:d-TXaVFHJ1b0Wf5M0Pcw1xpMMQ8qiWXMNsgbSeW1k_nm6CDNBFsBvw>
    <xmx:d-TXaXBvIgNgP14S_EdGw18RmlLzv_2-qj7sk4UhtlVBeWpeX8ztAg>
    <xmx:d-TXabD19ZpnQBlThTZ4Wnrnz9AoPaqg7LS7Zl69N3uGuyYOfP8mYA>
    <xmx:d-TXaVOve7Ewve9RpwFJWrFuyDZdlyzH9l3hWvcYiud-XuFoMiYOL_jk>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 13:40:06 -0400 (EDT)
Date: Thu, 9 Apr 2026 10:40:05 -0700
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
Message-ID: <adfkdRCxmhpRverB@tardis.local>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfhWQr1yFImSM2Q@tardis.local>

On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
> On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > non-preemptible") defers srcu_node tree allocation when called under
> > raw spinlock, putting SRCU through ~6 transitional grace periods
> > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > per-CPU pools directly - pools for not-online CPUs have no workers,
> 
> [Cc workqueue]
> 
> Hmm.. I thought for offline CPUs the corresponding worker pools become a
> unbound one hence there are still workers?
> 

Ah, as Paul replied in another email, the problem was because these CPUs
had never been onlined, so they don't even have unbound workers?

Regards,
Boqun

> Regards,
> Boqun
> 
> > work accumulates, workqueue lockup detector fires.
> > 
> > Before 61bbcfb50514, GFP_ATOMIC allocation went straight to
> > SRCU_SIZE_BIG, the mask = ~0 path was never reached.
> > 
> > Affects systems with convert_to_big active (auto when nr_cpu_ids >= 128)
> > and possible CPUs > online CPUs. Hit on s390 LPAR (76 online, 400 possible),
> > where possible CPUs > online CPUs is the usual case.
> > Also reproducible on x86 KVM --smp 16,maxcpus=255 (CONFIG_NR_CPUS=256)
> > or simply -smp 1,maxcpus=2 with srcutree.convert_to_big=1
> > or --smp 16,maxcpus=64 with srcutree.big_cpu_lim=32 (CONFIG_NR_CPUS=64)
> > 
> > s390 log (76 online CPUs, 400 possible, all pools 76-399 stuck):
> > 
> >   BUG: workqueue lockup - pool cpus=76 node=0 flags=0x4 nice=0 stuck for 1842s!
> >   BUG: workqueue lockup - pool cpus=77 node=0 flags=0x4 nice=0 stuck for 1842s!
> >   ...
> >   BUG: workqueue lockup - pool cpus=399 node=0 flags=0x4 nice=0 stuck for 1842s!
> >   Showing busy workqueues and worker pools:
> >   workqueue rcu_gp: flags=0x108
> >     pwq 306: cpus=76 node=0 flags=0x4 nice=0 active=3 refcnt=4
> >       pending: 3*srcu_invoke_callbacks
> >     pwq 310: cpus=77 node=0 flags=0x4 nice=0 active=3 refcnt=4
> >       pending: 3*srcu_invoke_callbacks
> >     ...
> >     pwq 1598: cpus=399 node=0 flags=0x4 nice=0 active=3 refcnt=4
> >       pending: 3*srcu_invoke_callbacks
> > 
> > Not sure if replacing mask = ~0 with something derived from
> > cpu_online_mask would be racy in that context.
> > 
> > [1] https://lore.kernel.org/rcu/acRho9L4zA2MRuxc@tardis.local
> > [2] https://lore.kernel.org/rcu/fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop
