Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907A941B352;
	Wed, 29 Apr 2026 18:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777485689; cv=none; b=LjaF7QVHFY8476QUaSJix+C9BiGDY4ycpRYitIIA+/kUbWAqbZDvX2LkVkqI+I1LshzRTA1byUVu8APfBkzCro7dPsnDvfuj0xbAqCCdAfEHuFNKZXqSX0UUG8KM4AHZeG/1mdOjuXFcrAgBKW74HzeuoEVLTvhnnOKkjMLZ9yU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777485689; c=relaxed/simple;
	bh=H2l3YSZlbAAUYfYQ4+Tau6+T6Tcf07YITbeaXqfZ8SE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rscsqiDnhKhmVwEnlDFO60gYHMemadNPyM/khmhTye839pcEGbmBA5wG/ctEPUJ9MF7FRWbRODsjWpOPosLEiPg/M5UkeXrKO2wFy6NAlgejp6aRxefhdwcmdqcw+Hjhsw0up1ntZLKS6Mq4vTgfEVfvUVJVNFP5aNUF8SbEugU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lAQkUwaO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lAQkUwaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FE01C19425;
	Wed, 29 Apr 2026 18:01:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777485689;
	bh=H2l3YSZlbAAUYfYQ4+Tau6+T6Tcf07YITbeaXqfZ8SE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=lAQkUwaOTbjHr3VTRjKYUTnybx+BA7ldHtcT7+spEQS9iVIfqhKgxFNUp803MpDki
	 TXV7viL95R25vkm74zFLkWS6a0/R54ZJzd9+hF3cUxwoCSkkp+CdchJ220S23GK4yO
	 QlGDKSzgpa5BRkbOk0jS3eQE65SWBqQ2m2oWhj5f4HlyL7TfBEBzgVMrOMYBBCZrom
	 L+A+XDFGce+Bb7SVw5Xxg7yW/7H/Ng4iZ7I+964hF2Ov/7bDFL4NUZjj26h+pkMibj
	 sbRVPy52eTyMgQ6BIvGNnE5vyLKZLXIwCQ/aEJyyJ7lUFjZmLldJK+ZcFFhw8CsU94
	 SfUQnQuaD4o4Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B9320CE0442; Wed, 29 Apr 2026 11:01:28 -0700 (PDT)
Date: Wed, 29 Apr 2026 11:01:28 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Tejun Heo <tj@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Srikar Dronamraju <srikar@linux.ibm.com>,
	Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>, samir@linux.ibm.com
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <7b5665b4-ddd0-404a-8314-fd0a170db458@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local>
 <adlHKowvhn8AGXCc@slm.duckdns.org>
 <afIdFgDD9w2U6hZy@linux.ibm.com>
 <tte9m9z@ub.hpns>
 <3b1563df-b1aa-40b9-b83e-650d967df09c@paulmck-laptop>
 <3f6d1123-6e1a-4566-8be7-ce95efe0609c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3f6d1123-6e1a-4566-8be7-ce95efe0609c@linux.ibm.com>

On Wed, Apr 29, 2026 at 11:14:56PM +0530, Shrikanth Hegde wrote:
> 
> I have limited understanding in rcu or workqueues, but my two cents.
> 
> On 4/29/26 10:48 PM, Paul E. McKenney wrote:
> > On Wed, Apr 29, 2026 at 07:08:23PM +0200, Vasily Gorbik wrote:
> > > On Wed, Apr 29, 2026 at 08:30:38PM +0530, Srikar Dronamraju wrote:
> > > > * Tejun Heo <tj@kernel.org> [2026-04-10 08:53:30]:
> > > > > Hello,
> > > > > 
> > > > > > Seems that we (mostly Paul) have our own trick to track whether a CPU
> > > > > > has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
> > > > > > used it in his fix [1]. And I think it won't be that hard to copy it
> > > > > > into workqueue and let queue_work_on() use it so that if the user queues
> > > > > > a work on a never-onlined CPU, it can detect it (with a warning?) and do
> > > > > > something?
> > > > > 
> > > > > The easiest way to do this is just creating the initial workers for all
> > > > > possible pools. Please see below. However, the downside is that it's going
> > > > > to create all workers for all possible cpus. This isn't a problem for
> > > > > anybody else but these IBM mainframes often come up with a lot of possible
> > > > > but not-yet-or-ever-online CPUs for capacity management, so the cost may not
> > > > > be negligible on some configurations.
> > > > > 
> > > > > IBM folks, is that okay?
> > > > 
> > > > Even on PowerPC LPARS, its not uncommon to have possible cpus != online cpus
> > > > at boot.  However your approach will work.
> > > > 
> > > > And Samir has already tested the same too and reported here
> > > > https://lkml.kernel.org/r/1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com
> > > > 
> > > > > From: Tejun Heo <tj@kernel.org>
> > > > > Subject: workqueue: Create workers for all possible CPUs on init
> > > > > 
> > > > > Per-CPU worker pools are initialized for every possible CPU during early boot,
> > > > > but workqueue_init() only creates initial workers for online CPUs. On systems
> > > > > where possible CPUs outnumber online CPUs (e.g. s390 LPARs with 76 online and
> > > > > 400 possible CPUs), the pools for never-onlined CPUs have POOL_DISASSOCIATED
> > > > > set but no workers. Any work item queued on such a CPU hangs indefinitely.
> > > > > 
> > > > > This was exposed by 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > > > non-preemptible") which made SRCU schedule callbacks on all possible CPUs
> > > > > during size transitions, triggering workqueue lockup warnings for all
> > > > > never-onlined CPUs.
> > > > > 
> > > > > Create workers for all possible CPUs during init, not just online ones. For
> > > > > online CPUs, the behavior is unchanged - POOL_DISASSOCIATED is cleared and the
> > > > > worker is bound to the CPU. For not-yet-online CPUs, POOL_DISASSOCIATED
> > > > > remains set, so worker_attach_to_pool() marks the worker UNBOUND and it can
> > > > > execute on any CPU. When the CPU later comes online, rebind_workers() handles
> > > > > the transition to associated operation as usual.
> > > > > 
> > > > 
> > > > With these patch, if a CPU has been onlined once, it's should be ok to queue
> > > > the work on that CPU even if its offline now.
> > > 
> > > That already seems to hold without this patch, what this patch newly
> > > covers is queueing on CPUs that have never been online.
> > > 
> > > Do we actually need to create workers for every possible CPU at boot?
> > > On the s390 LPAR in question (76 online / 400 possible) that's a few
> > > hundred extra kthreads kept around for the life of the system.
> > > That's probably the same on PowerPC.
> > > 
> > > Wouldn't Paul's SRCU-side fix [1] alone be enough here for PowerPC
> > > as well? I retested it on s390 (76/400) and on x86 KVM with
> > > --smp 16,maxcpus=255 and the lockup didn't reproduce in either case.
> > > 
> > > [1] https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop/
> > 
> > Just to emphasize that SRCU really was buggy before my fix.  The
> > queue_work_on() kernel-doc header clearly states the rules.  The bug
> > is even more embarrassing given just who it was that wrote those two
> > sentences.  ;-)
> 
> That mask = ~0 is really looks uncomfortable to me. What does it mean?
> It might end up even sending to non possible CPUs without proper checks.
> 
> It should use either cpumask_setall? or use cpu_online_mask?
> 
> Your current patch rcu_cpu_beenfullyonline indicates that code around
> srcu_schedule_cbs_sdp handles hotplug already right?
> in that case, just setting mask = cpu_online_mask would work?

Agreed.  Which is why I have this commit queued:

f8d5aaaf90f8 ("srcu: Don't queue workqueue handlers to never-online CPUs")

This is currently slated for the upcoming merge window, but if you
need it sooner, please let us know.  Please see the end of this email
for the full commit.


							Thanx, Paul

> > /**
> >   * queue_work_on - queue work on specific cpu
> >   * @cpu: CPU number to execute work on
> >   * @wq: workqueue to use
> >   * @work: work to queue
> >   *
> >   * We queue the work to a specific CPU, the caller must ensure it
> >   * can't go away.  Callers that fail to ensure that the specified
> >   * CPU cannot go away will execute on a randomly chosen CPU.
> >   * But note well that callers specifying a CPU that never has been
> >   * online will get a splat.
> >   *
> >   * Return: %false if @work was already on a queue, %true otherwise.
> >   */
> 
> 
> In that case, making offline CPUs have a unbound workqueue is wrong. no?
> 
> It might encourage more users to abuse queue_work_on interface to
> send to offline CPUs without any checks and onus now falls onto
> workqueue to disaptch to unbound wqs.
> 
> So I think it is better to put the guardrails in SRCU instead of any change in
> workqueue.

------------------------------------------------------------------------

commit f8d5aaaf90f8294890802ce8dccbafd9850ac5f9
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
    
    Because callbacks are not invoked on CPUs that have not been
    online, it is an error to invoke call_srcu(), synchronize_srcu(), or
    synchronize_srcu_expedited() on a CPU that is not yet fully online.
    However, it turns out to be less code to redirect the callbacks
    from too-early invocations of call_srcu() than to warn about such
    invocations.  This commit therefore also redirects callbacks queued on
    not-yet-fully-online CPUs to the boot CPU.
    
    Reported-by: Vasily Gorbik <gor@linux.ibm.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
    Tested-by: Vasily Gorbik <gor@linux.ibm.com>
    Cc: Tejun Heo <tj@kernel.org>

diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index 0d01cd8c4b4a7b..7c2f7cc131f7ae 100644
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
@@ -1322,7 +1320,9 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	 */
 	idx = __srcu_read_lock_nmisafe(ssp);
 	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
-	if (ss_state < SRCU_SIZE_WAIT_CALL)
+	// If !rcu_cpu_beenfullyonline(), interrupts are still disabled,
+	// so no migration is possible in either direction from this CPU.
+	if (ss_state < SRCU_SIZE_WAIT_CALL || !rcu_cpu_beenfullyonline(raw_smp_processor_id()))
 		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
 	else
 		sdp = raw_cpu_ptr(ssp->sda);
