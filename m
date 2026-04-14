Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8351FCFFC;
	Tue, 14 Apr 2026 19:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776194653; cv=none; b=CAakYdi60z8/7LQ5D5ONpb1g447rmMVHRjv/K+UFFgVkJzfS1CwILc69Yw2kCIT2xFmusbabcMsF9tpGr0czx/vz6xMQWQ8LKGCC3Yz+Xb9fhg69Y43XgFHXdpCYZWz6fGAMJObVqSb+YqHqbAAtCQeYR7wKz3oTItg0w5LH7Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776194653; c=relaxed/simple;
	bh=aDx51eWkl9y3VAY2COmcvqMPdgLQJOyfCPlqyd64yMY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uW+4LEpC32NhGPTZaW2kxqzAu14hlGgcWYRnB2MXrSzQNTAllFhWHSDn3Ews5ZSTeRzh5Q8k53yutoGmoffMGiTOYsGDuvEYbcb8CoU+j4PayOrleXdhnz4YABHsWYOagRQfsnpeoODzo3kVAazJI+sGklcyZjkw7ms+RZNRmlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bjZhP5vE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bjZhP5vE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CBAFC19425;
	Tue, 14 Apr 2026 19:24:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776194653;
	bh=aDx51eWkl9y3VAY2COmcvqMPdgLQJOyfCPlqyd64yMY=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=bjZhP5vEE+0Ae/Q8H1Pftj2Uw+aSYMEvqifkgrZtne5K/HlWv77TpXQL2nEg3vMjD
	 F0xItzpbGT4aFXTAOwyxi2nzl1rJwm+8uAiTNy9hrvSxVxZgFp7kb4f+dE8nIWIJan
	 K5j6ni57M2S+lNP4E6GA61i8DLVkIXLf5cTEiXbsGYOqvUhnQ1yhRH8Ki1B8zRbOo3
	 9HeHTSYVNk/eaiNhtRlzr0aziij0k9feSRFI5m9YnpIdxYDwrlLtd7h35J0lqv5+5d
	 tzqXmuKj/gCVzHvl7dq8PoN1ZNOVTdTEp6fD6Gul188OEvN+7zsrtpKmF9UY2mqvMJ
	 nLw+CMQLmNXiQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 032ACCE0F1B; Tue, 14 Apr 2026 12:24:13 -0700 (PDT)
Date: Tue, 14 Apr 2026 12:24:12 -0700
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
Message-ID: <ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <073abb55-197a-4519-b177-f9f776624fed@paulmck-laptop>
 <ttd8que@ub.hpns>
 <024e1e59-c901-4494-9935-f6871af88b2d@paulmck-laptop>
 <2157a59f-a1d3-4007-b8ce-3a7b0e0b9057@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2157a59f-a1d3-4007-b8ce-3a7b0e0b9057@paulmck-laptop>

On Thu, Apr 09, 2026 at 09:03:26PM -0700, Paul E. McKenney wrote:
> On Thu, Apr 09, 2026 at 01:10:14PM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 09, 2026 at 09:15:50PM +0200, Vasily Gorbik wrote:
> 
> [ . . . ]
> 
> > > Yes, tested on s390 LPAR (76 online, 400 possible) as well as
> > > on x86 KVM with --smp 16,maxcpus=255 and CONFIG_NR_CPUS=256
> > > no more workqueue lockup in both cases.
> > > 
> > > Thank you!
> > > 
> > > Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> > 
> > Thank you for testing this!
> > 
> > Please see below for an updated patch.  Tejun's patch might obsolete
> > this one, but just in case he balks at SRCU queueing handlers for CPUs
> > that are not even in the cpu_possible_mask.  ;-)
> 
> And because we don't invoke SRCU callbacks on CPUs that are not yet fully
> online, such CPUs had better not invoke call_srcu(), synchronize_srcu(),
> or synchronize_srcu_expedited() on a CPU that is not yet fully online.
> I am therefore adding the warning shown below.
> 
> Better paranoid late than paranoid not at all.  ;-)

Except that to make that check actually work, additional code is needed.
So much so that it is easier to make call_srcu() from not-yet-onlined
CPUs work properly, the trick being to queue the callback onto the boot
CPU's callback queue.  That way, there is no need to invoke callbacks
queued on CPUs that cannot yet run workqueue handlers.

Please see below for the full patch, including refraining from queueing
workqueue handlers on not-yet-online CPUs and diverting SRCU callbacks
from not-yet-fully-online CPUs to the boot CPU's callback queue.

Thoughts?

							Thanx, Paul

------------------------------------------------------------------------

commit ce533a60b2ef29a9b516cc717e77c6b679bc09c0
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
index 0d01cd8c4b4a7..7c2f7cc131f7a 100644
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
