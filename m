Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 790B83BAD99;
	Thu,  9 Apr 2026 18:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775758208; cv=none; b=P17sDqfbtPiZGn/i4WizIkMuXPzUTaQY35Vvh3ynbis5w3wkR1IgnYC+57vh5J3FTL1q3Bsrcge2lk1lSik5NAfQkmtSlIrLn1qCwWLIcba9BJBtT4R8fG3jHt1fdvzMYSXWDRTX2f9BLza9gR8xNwohwgFPXiqo03pJ/82kryE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775758208; c=relaxed/simple;
	bh=CtfqzlOD7/pl+KIKEg0TbRVtWWMtG24r2x6PsPNJW7s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WSYqQxnrR0T7lpR5RAnhM8Tq45MkSLlqB0g2onL4r4rMADyk5L+DiVE0s/DEMex2eeBoUEV49nIc22cbA98ZiwD4AY6gMrd17b4ZfOaxAiJY7DgnPG0wQ2BmHMq73dgobUKeiSBlbHu2s+pNFoBvHSVwZ+LzCvL9dS+/1XgduyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts3c/aVj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ts3c/aVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0E69C4CEF7;
	Thu,  9 Apr 2026 18:10:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775758208;
	bh=CtfqzlOD7/pl+KIKEg0TbRVtWWMtG24r2x6PsPNJW7s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ts3c/aVjQd33dV3RA7Io2morKt/xz0NdQnkru++6e16C7pVMVZvFGdV2xMzCObzmj
	 ICC8YoVXM7BQICOVMIiigC061RCYB3J+EgCWV/BY6VvKRy96q5d7I5DAd5xVbtC8a6
	 yRyiLYIv1QukyMYFLhzFw1m7nFn8rWylnik0J/hj2OOjsrZ3QPb4GrakICTU6/NM/M
	 CmV/7TRMGkiFnpc3xSBCHG5tKpZmC/2QJq1I/Rt/E5rFFM0laEd/KZ7PppmuV3+rh6
	 zXSVpj+yi5ATHACJ7UHVilCws/S5/PQ9ZDv9ZhweReQMxR9krTSVTrrTAlDiqB6nGt
	 6AUhZWuscpaEw==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 92BDCF40080;
	Thu,  9 Apr 2026 14:10:06 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Thu, 09 Apr 2026 14:10:06 -0400
X-ME-Sender: <xms:fuvXaVZYNflWrponCnv30BfVb6ImBhClaEmfGqYnsdVrXIVwbOVeVA>
    <xme:fuvXaSxfxl4iyFT0sFzSOpbOwHwIpHqCTZMTpF9gn86Yzq0qxV4UtOW_iEXKW_cdV
    B9dFxwBoCx1X2jHmaQOt8hA8HWUM3rMN1oAfSbdeTfmqOmbeFa5Gg>
X-ME-Received: <xmr:fuvXaUMvePU-7XafPl9Sn1-G34mYMaGSkfITFkFUdln3aG7smzVtU4vFPZBCF2yggNnUEXeqB2AFP2sj4k28aJFhcgH_tt_F>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddvjedujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhnucfh
    vghnghcuoegsohhquhhnsehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnheple
    euheethfdttdfgjedvjeeuhefhkeetveeuueeukeegteeigeeghedvffehhffhnecuffho
    mhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgruhhthhhpvghrshhonhgr
    lhhithihqdduieejtdelkeegjeduqddujeejkeehheehvddqsghoqhhunheppehkvghrnh
    gvlhdrohhrghesfhhigihmvgdrnhgrmhgvpdhnsggprhgtphhtthhopeduvddpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepthhjsehkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehgohhrsehlihhnuhigrdhisghmrdgtohhmpdhrtghpthhtohepphgruhhlmhgtkhes
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepfhhrvgguvghrihgtsehkvghrnhgvlhdroh
    hrghdprhgtphhtthhopehnvggvrhgrjhdruhhprgguhhihrgihsehkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohgvlhgrghhnvghlfhesnhhvihguihgrrdgtohhmpdhrtghpth
    htohepuhhrvgiikhhisehgmhgrihhlrdgtohhmpdhrtghpthhtoheprhgtuhesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvg
    hrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:fuvXaRfx0488Lp7oVAcUi64yl2ZCCMD-XEGcSAHN6-pA7kbgRmnrQw>
    <xmx:fuvXaZRb9nMvUZWHqibbSmSWlkBdurn5PaZbavMqMX39QRQO-ER70A>
    <xmx:fuvXafdBRoj8yoR_2SE0WT3BDxTs4KSGSPO-6KOUysfRo8k-XtsQCg>
    <xmx:fuvXaSvjz6CVa0UPbxN3QSO9W9IqAyWXF6tAMJvFcP1_VkIqi6pg-g>
    <xmx:fuvXabJOBpKHdoYEtpFwRjFF_GSeaMbMmhIS8-UPeM9lP6u5vrYSZoDI>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 9 Apr 2026 14:10:05 -0400 (EDT)
Date: Thu, 9 Apr 2026 11:10:04 -0700
From: Boqun Feng <boqun@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <adfrfJGrglg0bGw_@tardis.local>
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfmHZfABu64Kv4D@slm.duckdns.org>

On Thu, Apr 09, 2026 at 07:47:09AM -1000, Tejun Heo wrote:
> On Thu, Apr 09, 2026 at 10:40:05AM -0700, Boqun Feng wrote:
> > On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
> > > On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > > > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > > non-preemptible") defers srcu_node tree allocation when called under
> > > > raw spinlock, putting SRCU through ~6 transitional grace periods
> > > > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > > > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > > > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > > > per-CPU pools directly - pools for not-online CPUs have no workers,
> > > 
> > > [Cc workqueue]
> > > 
> > > Hmm.. I thought for offline CPUs the corresponding worker pools become a
> > > unbound one hence there are still workers?
> > > 
> > 
> > Ah, as Paul replied in another email, the problem was because these CPUs
> > had never been onlined, so they don't even have unbound workers?
> 
> Hahaha, we do initialize worker pool for every possible CPU but the
> transition to unbound operation happens in the hot unplug callback. We

;-) ;-) ;-)

> probably need to do some of the hot unplug operation during init if the CPU

Seems that we (mostly Paul) have our own trick to track whether a CPU
has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
used it in his fix [1]. And I think it won't be that hard to copy it
into workqueue and let queue_work_on() use it so that if the user queues
a work on a never-onlined CPU, it can detect it (with a warning?) and do
something?

[1]: https://lore.kernel.org/rcu/073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop/

Regards,
Boqun

> is possible but not online. That said, what kind of machine is it? Is the
> firmware just reporting bogus possible mask? How come the CPUs weren't
> online during boot?
> 
> Thanks.
> 
> -- 
> tejun
