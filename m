Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D6E2E8B82;
	Thu,  9 Apr 2026 20:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775765415; cv=none; b=qAbLUy7MOHVDs9mBQsaejt6A+OpD8QeUXE9cnDBKoGDSMWctWh5W2W7maE+IuSdLHvwtoklppMQfpT+xigZWJksslyVm8zFv69uOmFhTVJGOgBJRR5NfDnpOhNaOFvxCffAS/kM+RSNRKy7SU5+ToL/bfw3KxQhAcqvVVkWy57c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775765415; c=relaxed/simple;
	bh=sprKOr6Ugi38fUkyIw+sY35JPE3B0FidQHBTFGu5a10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkwnubVFYZN36nRB5rZeyBo4q7rrLvcWlLUpNSRr52Yp+FaPC9H89fpkAqgSo7gUtRfoQJNShJ2xQhvZQznCBcZMHIp/FuRRbB0VlyTVAub18c4b0+ofgY666i5O9QpTbRgZPjj6ouPqfteqlysAzNBUbnkbA4I20P8fA68hUxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ph6bfP+x; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ph6bfP+x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1D81C4CEF7;
	Thu,  9 Apr 2026 20:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775765415;
	bh=sprKOr6Ugi38fUkyIw+sY35JPE3B0FidQHBTFGu5a10=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Ph6bfP+xRPxvCODOFxt9F50xJdk5K4Yh/fhAMikBaoaCzQrde4FJPfL2jacztvmwK
	 ybk7H5e8QBvAs0BNUY338v8qYgg4ATL7yWbTSm4ayOjbIUK1OzHQbG1oYrypR3hpNQ
	 xciYiKeqouovukhEdCP/j+0TUFa8WeTJYosQdSApQ8WhsiS1AvxTyjivh9wTUWy0Jv
	 6dPVe2bkiGySsAibk8v5LTHygjiFbshQaE1xiafgAGT3m+7Rgr6MUMR0+DvpXHlpzx
	 5muBS7pBNHin0PJzA9CSXIJU19t+exGrhv9zEhEGGEfGuL/mMAo+wgLPSQ+ldjtFSm
	 5J3h/PMGlKZYg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9167FCE0975; Thu,  9 Apr 2026 13:10:14 -0700 (PDT)
Date: Thu, 9 Apr 2026 13:10:14 -0700
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
Message-ID: <024e1e59-c901-4494-9935-f6871af88b2d@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
 <ttd8que@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ttd8que@ub.hpns>

On Thu, Apr 09, 2026 at 09:15:50PM +0200, Vasily Gorbik wrote:
> On Thu, Apr 09, 2026 at 10:22:00AM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > non-preemptible") defers srcu_node tree allocation when called under
> > > raw spinlock, putting SRCU through ~6 transitional grace periods
> > > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > > per-CPU pools directly - pools for not-online CPUs have no workers,
> > > work accumulates, workqueue lockup detector fires.
> > > 
> > > Before 61bbcfb50514, GFP_ATOMIC allocation went straight to
> > > SRCU_SIZE_BIG, the mask = ~0 path was never reached.
> > > 
> > > Affects systems with convert_to_big active (auto when nr_cpu_ids >= 128)
> > > and possible CPUs > online CPUs. Hit on s390 LPAR (76 online, 400 possible),
> > > where possible CPUs > online CPUs is the usual case.
> > > Also reproducible on x86 KVM --smp 16,maxcpus=255 (CONFIG_NR_CPUS=256)
> > > or simply -smp 1,maxcpus=2 with srcutree.convert_to_big=1
> > > or --smp 16,maxcpus=64 with srcutree.big_cpu_lim=32 (CONFIG_NR_CPUS=64)
> > > 
> > > s390 log (76 online CPUs, 400 possible, all pools 76-399 stuck):
> > > 
> > >   BUG: workqueue lockup - pool cpus=76 node=0 flags=0x4 nice=0 stuck for 1842s!
> > >   BUG: workqueue lockup - pool cpus=77 node=0 flags=0x4 nice=0 stuck for 1842s!
> > >   ...
> > >   BUG: workqueue lockup - pool cpus=399 node=0 flags=0x4 nice=0 stuck for 1842s!
> > >   Showing busy workqueues and worker pools:
> > >   workqueue rcu_gp: flags=0x108
> > >     pwq 306: cpus=76 node=0 flags=0x4 nice=0 active=3 refcnt=4
> > >       pending: 3*srcu_invoke_callbacks
> > >     pwq 310: cpus=77 node=0 flags=0x4 nice=0 active=3 refcnt=4
> > >       pending: 3*srcu_invoke_callbacks
> > >     ...
> > >     pwq 1598: cpus=399 node=0 flags=0x4 nice=0 active=3 refcnt=4
> > >       pending: 3*srcu_invoke_callbacks
> > > 
> > > Not sure if replacing mask = ~0 with something derived from
> > > cpu_online_mask would be racy in that context.
> > > 
> > > [1] https://lore.kernel.org/rcu/acRho9L4zA2MRuxc@tardis.local
> > > [2] https://lore.kernel.org/rcu/fe28d664-3872-40f6-83c6-818627ad5b7d@paulmck-laptop
> > 
> > This was a pre-existing bug, but the change made it much more likely
> > to happen.
> 
> Yes, indeed.
> 
> > Does the alleged (and untested) fix below do the trick?  The theory is
> > that if a given CPU has ever been fully online, it has workqueues set up.
> > Directly checking whether a CPU is currently online is vulnerable to a CPU
> > piling up lots of SRCU callbacks, then going offline.  So we do need to
> > be prepared to invoke SRCU callbacks for CPUs that are currently offline.
> 
> Yes, tested on s390 LPAR (76 online, 400 possible) as well as
> on x86 KVM with --smp 16,maxcpus=255 and CONFIG_NR_CPUS=256
> no more workqueue lockup in both cases.
> 
> Thank you!
> 
> Tested-by: Vasily Gorbik <gor@linux.ibm.com>

Thank you for testing this!

Please see below for an updated patch.  Tejun's patch might obsolete
this one, but just in case he balks at SRCU queueing handlers for CPUs
that are not even in the cpu_possible_mask.  ;-)

							Thanx, Paul

------------------------------------------------------------------------

commit dcc14db7e76af899f1ff4606ec4316580d7b6f88
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Apr 9 11:16:02 2026 -0700

    srcu: Don't queue workqueue handlers to never-online CPUs
    
    While an srcu_struct structure is in the midst of switching from CPU-0
    to all-CPUs state, it can attempt to invoke callbacks for CPUs that
    have never been online.  Worse yet, it can attempt in invoke callbacks
    for CPUs that never will be online due to not being present in the
    cpu_possible_mask.  This can cause hangs on s390, which is not set up to
    deal with workqueue handlers being scheduled on such CPUs.  This commit
    therefore causes Tree SRCU to refrain from queueing workqueue handlers
    on CPUs that have not yet (and might never) come online.
    
    Reported-by: Vasily Gorbik <gor@linux.ibm.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Tested-by: Vasily Gorbik <gor@linux.ibm.com>
    Cc: Tejun Heo <tj@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0d01cd8c4b4a7..a67af44fc0745 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -897,11 +897,9 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
 {
 	int cpu;
 
-	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-		if (!(mask & (1UL << (cpu - snp->grplo))))
-			continue;
-		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
-	}
+	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++)
+		if ((mask & (1UL << (cpu - snp->grplo))) && rcu_cpu_beenfullyonline(cpu))
+			srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
 }
 
 /*
