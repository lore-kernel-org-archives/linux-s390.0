Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7122F274FD0;
	Thu,  9 Apr 2026 18:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775758520; cv=none; b=sYAlvwvNQDt8lQgj857aoXCpikcnHbGIEsLqtubXu5EW2zX8KRkUXOxlhVR8W8pTwrTnauBoR3KCYNhXvksYlzCLSTKCw9yZtCmUFSGD8j6YThxDUevUC56T0SpWFHlfCbkPeUdbf/gicsL03kpWLDkTiGRQ9kb5yv0GGYdtnuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775758520; c=relaxed/simple;
	bh=HNynC8cBmc0jL9aFnqFOZQVQ/f4svk+RGqIn2KmC7b8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bkelg6lNy9IOE1ffkdrstct+GPXx6tvVua0nUtUl9PGA0J8On7lZjR2Jy52WMxJ0Wuiba9wUkeAb9yQ1HWIxTHp3LCCydaGprQO/bnTXo29ah8CXJ6k5LI5OKwVMriMVC/21DA1YLM4XOdcp/8ATXO3VeFmL8laZ4JFwP0ST93E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEI0hUw2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEI0hUw2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08BD3C4CEF7;
	Thu,  9 Apr 2026 18:15:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775758520;
	bh=HNynC8cBmc0jL9aFnqFOZQVQ/f4svk+RGqIn2KmC7b8=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WEI0hUw25B6qahWXxl/JTvYlCkoXcgX3+BVlTRfTEPMBruGLp5Fw7Ddh3lpqXiW+Y
	 v5t05/maVyfgAZ0vUAEXyP1bCvW1Q7qoS0uGsFcI9xbVt/DzhD1pSmSm/Dr1/epYqX
	 Jx6vB8XbQByaVhfu64H3ihAfYXe0W7L0HRHETV2NS1Z85JcAKRxOjOSLUBnE6tkcAm
	 oGqzDgRA6tI+mKoui/4oX1eDM2e3bL5tITDOFQ0OftlGL017i5XvX9S7sQizfzDb71
	 0M3LF+nm0MleEombcT++3OrCE9wnqktbcyeWSqWTW2kQ57a3OWUNKbBpt03d/wT+/B
	 BZCQsOOnrvA3w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 9FB7ACE0975; Thu,  9 Apr 2026 11:15:19 -0700 (PDT)
Date: Thu, 9 Apr 2026 11:15:19 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Boqun Feng <boqun@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
	Frederic Weisbecker <frederic@kernel.org>,
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Uladzislau Rezki <urezki@gmail.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: BUG: workqueue lockup - SRCU schedules work on not-online CPUs
 during size transition
Message-ID: <3c93fb0c-cac2-49a1-a49b-796f0c92f6d9@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <ttd89ul@ub.hpns>
 <adfhWQr1yFImSM2Q@tardis.local>
 <adfkdRCxmhpRverB@tardis.local>
 <adfmHZfABu64Kv4D@slm.duckdns.org>
 <adfmbO1nxSwHvtHx@slm.duckdns.org>
 <3e18247d-ef19-4963-8257-a0f4494f992a@paulmck-laptop>
 <adfraiVgNw4fvz81@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <adfraiVgNw4fvz81@slm.duckdns.org>

On Thu, Apr 09, 2026 at 08:09:46AM -1000, Tejun Heo wrote:
> On Thu, Apr 09, 2026 at 11:04:09AM -0700, Paul E. McKenney wrote:
> > On Thu, Apr 09, 2026 at 07:48:28AM -1000, Tejun Heo wrote:
> > > On Thu, Apr 09, 2026 at 07:47:09AM -1000, Tejun Heo wrote:
> > > > On Thu, Apr 09, 2026 at 10:40:05AM -0700, Boqun Feng wrote:
> > > > > On Thu, Apr 09, 2026 at 10:26:49AM -0700, Boqun Feng wrote:
> > > > > > On Thu, Apr 09, 2026 at 03:08:45PM +0200, Vasily Gorbik wrote:
> > > > > > > Commit 61bbcfb50514 ("srcu: Push srcu_node allocation to GP when
> > > > > > > non-preemptible") defers srcu_node tree allocation when called under
> > > > > > > raw spinlock, putting SRCU through ~6 transitional grace periods
> > > > > > > (SRCU_SIZE_ALLOC to SRCU_SIZE_BIG). During this transition srcu_gp_end()
> > > > > > > uses mask = ~0, which makes srcu_schedule_cbs_snp() call queue_work_on()
> > > > > > > for every possible CPU. Since rcu_gp_wq is WQ_PERCPU, work targets
> > > > > > > per-CPU pools directly - pools for not-online CPUs have no workers,
> > > > > > 
> > > > > > [Cc workqueue]
> > > > > > 
> > > > > > Hmm.. I thought for offline CPUs the corresponding worker pools become a
> > > > > > unbound one hence there are still workers?
> > > > > > 
> > > > > 
> > > > > Ah, as Paul replied in another email, the problem was because these CPUs
> > > > > had never been onlined, so they don't even have unbound workers?
> > > > 
> > > > Hahaha, we do initialize worker pool for every possible CPU but the
> > > > transition to unbound operation happens in the hot unplug callback. We
> > > > probably need to do some of the hot unplug operation during init if the CPU
> > > > is possible but not online. That said, what kind of machine is it? Is the
> > > > firmware just reporting bogus possible mask? How come the CPUs weren't
> > > > online during boot?
> > > 
> > > Just saw ibm on the cc list. Guess this was on s390?
> > 
> > It was indeed.  What workqueue tricks does s390 play?
> 
> They just come up with genuinely possible but offline CPUs. Most setups
> don't do that. I'll spin up a patch later today.

I would be more than happy for workqueues to be happy to queue and
execute a handler for a never-been-online CPU.  Whatever works!  ;-)

							Thanx, Paul
