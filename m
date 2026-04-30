Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F02F1632DD;
	Thu, 30 Apr 2026 16:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565111; cv=none; b=kOxdh4UUgpOOkWMW7H/p9q2NHi4IIgsVA9cBJM9toYTUKalVULxHLCE9tKaj9D3cMiUdjyu1GmrRRZGXWLUIN2RowiuHNpxv3pVqWbWdUYVmMKNyGpJy/8iTQmwEN2wo/3FnOA+rZq2PmhsFjKzpzVdRItuxW1Fbzx9Bh0lzbqc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565111; c=relaxed/simple;
	bh=8K7tuciLFA2olFZ21d9KKbfQk/y+E65/Gkp3fBg7ThE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cWvJZPQFm85JmA/53N7hs2dAEL4qsugvhO8UY3ei8Rkcv4SwX0jzrMZvlK3+Vr6OcZKTGqIAW/YUbkIHvAHU8MOLVzkH8DGmWeJop1cXvyKgq8GO0yv9zcesPZ5H7IdjfOVozcCEY6DKKvL+y0e3NVUGwDvsUN8bQzJvAxste9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bplpg/Pe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bplpg/Pe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C5BAC2BCB3;
	Thu, 30 Apr 2026 16:05:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777565111;
	bh=8K7tuciLFA2olFZ21d9KKbfQk/y+E65/Gkp3fBg7ThE=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Bplpg/PeBCDm/DkvNj9FWBlGBOA8EfcKxBL/4iWLf/qhNtJkoCcD7vO27Vop9FRV9
	 u7006gzoJ+1D7Nqka/K83oTMmdlXjMukv0mJkHoggYtsYjVy8Ti0Anhx374lz+JuOS
	 YBzelB3oq3PtXybsroqDZ3XkK9ftvn5ml/5EUEMoaRG8k+yj+BffrIcxkPRWvFP8H4
	 rj4Fqv6aklpcoAiV3Ge1SqvnxwphUNIrW8W1lshBiLp7lIOXENEbocJv/Jq3aW9jBh
	 jvlxxOF2ZaF7+ZEZ3e1SBHRIR7UyC2HLERlI1IBP28+OLKgAiMyLI1ra0WS0mXmn48
	 x7JjD5cTnRE3Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 611D6CE0712; Thu, 30 Apr 2026 09:05:10 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:05:10 -0700
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
Message-ID: <4fa26f2e-e01b-4525-a23e-df393fdb72a5@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local>
 <adlHKowvhn8AGXCc@slm.duckdns.org>
 <afIdFgDD9w2U6hZy@linux.ibm.com>
 <tte9m9z@ub.hpns>
 <3b1563df-b1aa-40b9-b83e-650d967df09c@paulmck-laptop>
 <3f6d1123-6e1a-4566-8be7-ce95efe0609c@linux.ibm.com>
 <7b5665b4-ddd0-404a-8314-fd0a170db458@paulmck-laptop>
 <868cbc25-45a9-4476-b77e-7f878f1cd42c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <868cbc25-45a9-4476-b77e-7f878f1cd42c@linux.ibm.com>

On Thu, Apr 30, 2026 at 12:38:16PM +0530, Shrikanth Hegde wrote:
> Hi Paul.
> 
> On 4/29/26 11:31 PM, Paul E. McKenney wrote:
> 
> > > That mask = ~0 is really looks uncomfortable to me. What does it mean?
> > > It might end up even sending to non possible CPUs without proper checks.
> > > 
> > > It should use either cpumask_setall? or use cpu_online_mask?
> > > 
> > > Your current patch rcu_cpu_beenfullyonline indicates that code around
> > > srcu_schedule_cbs_sdp handles hotplug already right?
> > > in that case, just setting mask = cpu_online_mask would work?
> > 
> > Agreed.  Which is why I have this commit queued:
> > 
> > f8d5aaaf90f8 ("srcu: Don't queue workqueue handlers to never-online CPUs")
> > 
> > This is currently slated for the upcoming merge window, but if you
> > need it sooner, please let us know.  Please see the end of this email
> > for the full commit.
> > 
> > 
> > 							Thanx, Paul
> > 
> > > > /**
> > > >    * queue_work_on - queue work on specific cpu
> > > >    * @cpu: CPU number to execute work on
> > > >    * @wq: workqueue to use
> > > >    * @work: work to queue
> > > >    *
> > > >    * We queue the work to a specific CPU, the caller must ensure it
> > > >    * can't go away.  Callers that fail to ensure that the specified
> > > >    * CPU cannot go away will execute on a randomly chosen CPU.
> > > >    * But note well that callers specifying a CPU that never has been
> > > >    * online will get a splat.
> > > >    *
> > > >    * Return: %false if @work was already on a queue, %true otherwise.
> > > >    */
> > > 
> > > 
> > > In that case, making offline CPUs have a unbound workqueue is wrong. no?
> > > 
> > > It might encourage more users to abuse queue_work_on interface to
> > > send to offline CPUs without any checks and onus now falls onto
> > > workqueue to disaptch to unbound wqs.
> > > 
> > > So I think it is better to put the guardrails in SRCU instead of any change in
> > > workqueue.
> > 
> > ------------------------------------------------------------------------
> > 
> > commit f8d5aaaf90f8294890802ce8dccbafd9850ac5f9
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Apr 9 11:16:02 2026 -0700
> > 
> >      srcu: Don't queue workqueue handlers to never-online CPUs
> >      While an srcu_struct structure is in the midst of switching from CPU-0
> >      to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> >      have never been online.  Worse yet, it can attempt in invoke callbacks
> >      for CPUs that never will be online due to not being present in the
> 
> for CPUs that never will be online due to being present in the cpu_possible_mask?
> 
> >      cpu_possible_mask.  This can cause hangs on s390, which is not set up to
> >      deal with workqueue handlers being scheduled on such CPUs.  This commit
> >      therefore causes Tree SRCU to refrain from queueing workqueue handlers
> >      on CPUs that have not yet (and might never) come online.
> >      Because callbacks are not invoked on CPUs that have not been
> >      online, it is an error to invoke call_srcu(), synchronize_srcu(), or
> >      synchronize_srcu_expedited() on a CPU that is not yet fully online.
> >      However, it turns out to be less code to redirect the callbacks
> >      from too-early invocations of call_srcu() than to warn about such
> >      invocations.  This commit therefore also redirects callbacks queued on
> >      not-yet-fully-online CPUs to the boot CPU.
> >      Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >      Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> >      Cc: Tejun Heo <tj@kernel.org>
> > 
> > diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
> > index 0d01cd8c4b4a7b..7c2f7cc131f7ae 100644
> > --- a/kernel/rcu/srcutree.c
> > +++ b/kernel/rcu/srcutree.c
> > @@ -897,11 +897,9 @@ static void srcu_schedule_cbs_snp(struct srcu_struct *ssp, struct srcu_node *snp
> >   {
> >   	int cpu;
> > -	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
> > -		if (!(mask & (1UL << (cpu - snp->grplo))))
> > -			continue;
> > -		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> > -	}
> > +	for (cpu = snp->grplo; cpu <= snp->grphi; cpu++)
> > +		if ((mask & (1UL << (cpu - snp->grplo))) && rcu_cpu_beenfullyonline(cpu))
> > +			srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, cpu), delay);
> >   }
> >   /*
> > @@ -1322,7 +1320,9 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
> >   	 */
> >   	idx = __srcu_read_lock_nmisafe(ssp);
> >   	ss_state = smp_load_acquire(&ssp->srcu_sup->srcu_size_state);
> > -	if (ss_state < SRCU_SIZE_WAIT_CALL)
> > +	// If !rcu_cpu_beenfullyonline(), interrupts are still disabled,
> > +	// so no migration is possible in either direction from this CPU.
> > +	if (ss_state < SRCU_SIZE_WAIT_CALL || !rcu_cpu_beenfullyonline(raw_smp_processor_id()))
> 
> How can this happen? To get a CPU offline in raw_smp_processor_id() you need to run on the offline
> CPU.

CPUs run for a surprisingly long time before they get around to marking
themselves online.  If a CPU invokes call_srcu() during this time,
this code really will be running on a CPU that is marked as offline.

Now, my initial thought was to instead splat if this happened, but it
turned out to require more code to reliably splat than to just handle
the situation correctly.  So here we are!  ;-)

							Thanx, Paul

> >   		sdp = per_cpu_ptr(ssp->sda, get_boot_cpu_id());
> >   	else
> >   		sdp = raw_cpu_ptr(ssp->sda);
> 
