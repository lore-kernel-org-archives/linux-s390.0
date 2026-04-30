Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CAF428466;
	Thu, 30 Apr 2026 16:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777565425; cv=none; b=XwWWIRbNBPythtqPMzuDGoClqZjFrIWiuAd91lGsOAXJv5uM/cEfIOtBh5okjmyNC/2Xgs6+wsQdXRjr6trj4ZiTP1opc2V9P+Ugaxf5u4sPlG8lxJ0VD6nhsXARPzCpWQOnPms2LjJJK98b4BsrJzw3fhosY+iykE6FVusWfzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777565425; c=relaxed/simple;
	bh=QdgE57g6+6+hFttnEXOHpTlvJqhdbsn/S9w+uyH+S1c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lZu8ZfNgrwaXAEvY1WSg7cOKuhdUUFvbLWozXsZX+tRm71a1FbTJyvuygZzkMhwbteck/secoahk2Yhh7sRPVNOfbpn6HX7LAA/etKJeduRZFSThN2GpSk6gZM/bARuPxSiiZ7nqlaxPZCkxj12cSw44jE3DUHtcqtVJSFCBtaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EvhFPh3F; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EvhFPh3F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C404EC2BCB3;
	Thu, 30 Apr 2026 16:10:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777565424;
	bh=QdgE57g6+6+hFttnEXOHpTlvJqhdbsn/S9w+uyH+S1c=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=EvhFPh3FrK8EeatVv76smg/5O4TuFjDOXzhiFjwRatqOcrVlcbjtUl8YvOiCKSRSW
	 AoC8e6w3gy/q50xcCcA9IR3isgLkGyxP0M1MguF8v4sdIizwy6IrODCF6S1m8N8whm
	 zK9fA0I+yzNDnByOVU0hBzjXATXsrhO2A4eUc19G8WbYKjkdEyG0sP8CjT5fdl3iRc
	 wP1WlApWxw1h3uRyt/VQMWLrUrkI/3HouLHmvsbHOV+WOeseUPIiboSa0dR6eOgID7
	 pIFKcaWHcZnCY7swjcUxbgWhoDtzbWxT1Hci//3wc5LhnaVFPB/+E9zy3ur+WH/jeB
	 wtVrkvtOBs3Vw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3E3D9CE0712; Thu, 30 Apr 2026 09:10:24 -0700 (PDT)
Date: Thu, 30 Apr 2026 09:10:24 -0700
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
Message-ID: <c62502b6-642d-487d-a8a2-4ed7f9c7d858@paulmck-laptop>
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

[ . . . ]

Sorry, missed one...

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

Exactly.

Just because a CPU is in cpu_possible_mask doesn't mean that it will
ever actually come online.  For example, for single-threaded performance
reasons, a given system might choose to bring online only one CPU from
each hypertheaded core.  In that case, the other CPU in each hyperthreaded
core could be in the cpu_possible_mask, but would never come online.

							Thanx, Paul

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
