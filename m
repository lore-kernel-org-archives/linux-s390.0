Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA9D351C2E;
	Wed, 29 Apr 2026 17:18:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483099; cv=none; b=LdajZ0Pqg3iZ4qBR/SC9lKUTWfejZDbpc8B/HnwzqNgqniLjG/t9oKbmmE10vWWs274UwId+aC2xu0zryq+pDGCLN6d+0i7Z6R3E+DRVV+QXlksT9lXvB0SxUGWbK1hMavZQla1uprFdiqxNOtEZA49J0vwOzLOXicZAx/Ni45I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483099; c=relaxed/simple;
	bh=XFL2FMM6PrSGv8Lb5KPGcWeN6EYoFxXVJgOqJfDZAkU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M34yJA7RzgwFp5YMAF5s/Dr9NybfurAN6RstpLJfem7FbONi932bKg2zSbiMqUyLpZkKdiyrPZx7BMwVj8NwL8wlfw/5SNqwxi7DD9U8gWYJuDNRKhUvEcZWzS9/EVYK4ieQPsu/jwTXzmhIR2dXtEAWHHq3Nv+ayk0QqhlBZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ojup0EBn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ojup0EBn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9ABCC19425;
	Wed, 29 Apr 2026 17:18:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777483098;
	bh=XFL2FMM6PrSGv8Lb5KPGcWeN6EYoFxXVJgOqJfDZAkU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=ojup0EBnK+4hwDGbXUmgQOMWIMjX8xK1wLgCMhjDO5TEKo/y7c6h2xUaSikoT45ww
	 hACqx4XlrtBSJuEzlyKPz5lx9jDqvXXev1yO/8zV9t/E3h1dRLtYghBdQuLAxRUkuJ
	 1szznoHtXxwDf4zzv2of9aKtiGHZ1c4jgt0YCagFoW/qcjNMRhWLob4dXk66n4qTVQ
	 MciILW9Y69HGtMo8KGPesjGdRsV6addjU1T7pCNjwgK34M9Ko5VCIwWZX4wD6pSDQm
	 77otKDlLhvX7VHo+KIzjUc9oyaBWofd32kKGTN6Kk9U4Bc6v33H1O7LBWszV9r3TF6
	 pYhPu7o8I/gjA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3ACE7CE0442; Wed, 29 Apr 2026 10:18:18 -0700 (PDT)
Date: Wed, 29 Apr 2026 10:18:18 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Vasily Gorbik <gor@linux.ibm.com>
Cc: Srikar Dronamraju <srikar@linux.ibm.com>, Tejun Heo <tj@kernel.org>,
	Boqun Feng <boqun@kernel.org>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>, samir@linux.ibm.com
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <3b1563df-b1aa-40b9-b83e-650d967df09c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfrfJGrglg0bGw_@tardis.local>
 <adlHKowvhn8AGXCc@slm.duckdns.org>
 <afIdFgDD9w2U6hZy@linux.ibm.com>
 <tte9m9z@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tte9m9z@ub.hpns>

On Wed, Apr 29, 2026 at 07:08:23PM +0200, Vasily Gorbik wrote:
> On Wed, Apr 29, 2026 at 08:30:38PM +0530, Srikar Dronamraju wrote:
> > * Tejun Heo <tj@kernel.org> [2026-04-10 08:53:30]:
> > > Hello,
> > > 
> > > > Seems that we (mostly Paul) have our own trick to track whether a CPU
> > > > has ever been onlined in RCU, see rcu_cpu_beenfullyonline(). Paul also
> > > > used it in his fix [1]. And I think it won't be that hard to copy it
> > > > into workqueue and let queue_work_on() use it so that if the user queues
> > > > a work on a never-onlined CPU, it can detect it (with a warning?) and do
> > > > something?
> > > 
> > > The easiest way to do this is just creating the initial workers for all
> > > possible pools. Please see below. However, the downside is that it's going
> > > to create all workers for all possible cpus. This isn't a problem for
> > > anybody else but these IBM mainframes often come up with a lot of possible
> > > but not-yet-or-ever-online CPUs for capacity management, so the cost may not
> > > be negligible on some configurations.
> > > 
> > > IBM folks, is that okay?
> > 
> > Even on PowerPC LPARS, its not uncommon to have possible cpus != online cpus
> > at boot.  However your approach will work.
> > 
> > And Samir has already tested the same too and reported here
> > https://lkml.kernel.org/r/1b89c25b-7c1d-4ed8-adf3-ac504b6f086a@linux.ibm.com
> > 
> > > From: Tejun Heo <tj@kernel.org>
> > > Subject: workqueue: Create workers for all possible CPUs on init
> > > 
> > > Per-CPU worker pools are initialized for every possible CPU during early boot,
> > > but workqueue_init() only creates initial workers for online CPUs. On systems
> > > where possible CPUs outnumber online CPUs (e.g. s390 LPARs with 76 online and
> > > 400 possible CPUs), the pools for never-onlined CPUs have POOL_DISASSOCIATED
> > > set but no workers. Any work item queued on such a CPU hangs indefinitely.
> > > 
> > > This was exposed by 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > non-preemptible") which made SRCU schedule callbacks on all possible CPUs
> > > during size transitions, triggering workqueue lockup warnings for all
> > > never-onlined CPUs.
> > > 
> > > Create workers for all possible CPUs during init, not just online ones. For
> > > online CPUs, the behavior is unchanged - POOL_DISASSOCIATED is cleared and the
> > > worker is bound to the CPU. For not-yet-online CPUs, POOL_DISASSOCIATED
> > > remains set, so worker_attach_to_pool() marks the worker UNBOUND and it can
> > > execute on any CPU. When the CPU later comes online, rebind_workers() handles
> > > the transition to associated operation as usual.
> > > 
> > 
> > With these patch, if a CPU has been onlined once, it's should be ok to queue
> > the work on that CPU even if its offline now.
> 
> That already seems to hold without this patch, what this patch newly
> covers is queueing on CPUs that have never been online.
> 
> Do we actually need to create workers for every possible CPU at boot?
> On the s390 LPAR in question (76 online / 400 possible) that's a few
> hundred extra kthreads kept around for the life of the system.
> That's probably the same on PowerPC.
> 
> Wouldn't Paul's SRCU-side fix [1] alone be enough here for PowerPC
> as well? I retested it on s390 (76/400) and on x86 KVM with
> --smp 16,maxcpus=255 and the lockup didn't reproduce in either case.
> 
> [1] https://lore.kernel.org/rcu/ed1fa6cd-7343-4ca3-8b9d-d699ca496f83@paulmck-laptop/

Just to emphasize that SRCU really was buggy before my fix.  The
queue_work_on() kernel-doc header clearly states the rules.  The bug
is even more embarrassing given just who it was that wrote those two
sentences.  ;-)

							Thanx, Paul

/**
 * queue_work_on - queue work on specific cpu
 * @cpu: CPU number to execute work on
 * @wq: workqueue to use
 * @work: work to queue
 *
 * We queue the work to a specific CPU, the caller must ensure it
 * can't go away.  Callers that fail to ensure that the specified
 * CPU cannot go away will execute on a randomly chosen CPU.
 * But note well that callers specifying a CPU that never has been
 * online will get a splat.
 *
 * Return: %false if @work was already on a queue, %true otherwise.
 */
