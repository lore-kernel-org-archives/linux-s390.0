Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7372727281D;
	Thu,  9 Apr 2026 17:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775755321; cv=none; b=qyssNKE7okiJd4JP90iwXx7IlYmO9fXFcE5Hd12htIdWNaMJHPsXl+Qv338x40x4lAjO7Q1zdSLZuhm9MDs4wuJ56z+aNJGudkkPbiyxFFrjimEWLIlZ+uZ9RFrEUnN1xv9/+vFh7xx8IEDGgpMIsA+GHQ0oClHhoFRL7oV+kFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775755321; c=relaxed/simple;
	bh=0O0ON2EuzAahw9wX3tGhIpHeapkB+3W8JPIynlB7p6M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qrzf2sZIyd7ZRRG39WSo4U/4QiNSY4PA00AAtblhI+HaKgpcjeEmpT1KF1vGbzqswDCUxb6LgHqxr0GremdYjW6Rq81h3eAebhZjWaM4fhOZkr6vnUv52qa3EaLx3N6v0GFKrP+72KxbEC2Isg9hpeiDISgG4Mk4npqLljOOBJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X6Epb2/p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X6Epb2/p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15D1AC4CEF7;
	Thu,  9 Apr 2026 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775755321;
	bh=0O0ON2EuzAahw9wX3tGhIpHeapkB+3W8JPIynlB7p6M=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=X6Epb2/pf0Oybh+SVbeOv/wB7BEpfC/cteQuqBHWuXFERgdttSTGAy0OGRtPmnnb1
	 gMX9rs0GcMRwc85+vper6mtxX3RvWQjXq0ctl3hKP7RGa2jyuVzcuO6iYkRIMSwB1w
	 z5nAazzbP+ddOfo6RE8LIGIC3ncoB7YrUPTPp3FJKsr6mnsWgf/FqqZ2kC0U0XXEDW
	 V7BIUhCwIJ0rwcq+jidSOFLcxMXNVI63zbSNaQcs9JJBpA1abSgBEdON2plq0gMU+i
	 bwRKzljNklQ3csAgvUnNx7oHzoK/owdCWi+pSNKQ2He6Wn5hqcGqcbSheOb0OhT5zo
	 C6K9716Oj21eg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id A0B9DCE0975; Thu,  9 Apr 2026 10:22:00 -0700 (PDT)
Date: Thu, 9 Apr 2026 10:22:00 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
Reply-To: paulmck@kernel.org
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

First, thank you for the bug report and apologies for the hassle!
This was a pre-existing bug, but the change made it much more likely
to happen.

Does the alleged (and untested) fix below do the trick?  The theory is
that if a given CPU has ever been fully online, it has workqueues set up.
Directly checking whether a CPU is currently online is vulnerable to a CPU
piling up lots of SRCU callbacks, then going offline.  So we do need to
be prepared to invoke SRCU callbacks for CPUs that are currently offline.

In the meantime, I will start up some tests.  Not that they saw the
bug in the first place, so it is your tests that matter here.

							Thanx, Paul

------------------------------------------------------------------------

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0d01cd8c4b4a7..e68ee7f69e1fc 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -898,7 +898,7 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
 	int cpu;
 
 	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-		if (!(mask & (1UL << (cpu - snp->grplo))))
+		if (!(mask & (1UL << (cpu - snp->grplo))) || !rcu_cpu_beenfullyonline(cpu))
 			continue;
 		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
 	}
