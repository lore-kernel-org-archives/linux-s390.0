Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CC32238D52;
	Fri,  1 May 2026 14:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777644052; cv=none; b=tK/hPD2ikVyL/k1BSBrCbG3OXQDTq+ZwRkbN28LJhstL0024TWB5h4abLMMgwfz0T1S2zPfoGCEAxhU4fkfrW3qfGSvLgf3I1j+dQdVhP+3xwdAmTiFM8Wp4KSs32x19Hz4Rwl64Ur0DH5Vlhw8zMj7tdDXbGBm855/0TzII2KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777644052; c=relaxed/simple;
	bh=0C+u+OHwp58GS7EoMihanvjt74oSxkELYE6UC8z6rtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qXtyBdVIIn+ctz9EmqfAvY0XUcpfFtrUDDr0tn8f0gmTaBiknzLr9p93vazdr/J40wtmExxPZwlqgnHSmKeNg3HCTZgAMzhhwtvEBopEqYvXfh0VjPx+NT0nBeJjfnNuk5ZKstQ6Q93bqWkPTOC1c75Stuiu/PolMu94H/u9a0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hBzjuk+i; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hBzjuk+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C88A7C2BCB4;
	Fri,  1 May 2026 14:00:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777644051;
	bh=0C+u+OHwp58GS7EoMihanvjt74oSxkELYE6UC8z6rtQ=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=hBzjuk+i5KrQtj4GqVz7UcQj9JLi8I1+aAvIoXcsXLjEMHfBUXRUrRjdQeKdkG/Ht
	 bVGHu6m5eUUzTcMJWZzrrhrZZji1mqQJGAa5GsiTH9W0Qv3UDkRsSFEkzIV8V+UhOO
	 sBSxMkcikdkGpli336fSgvbPsSQKOCwoyCu0vgK0G6g5madTR6DblFW7qo7+SObtbT
	 +d6KTs/GQG4tUB/00ul3/U6vJdKifTdA7I65eNnwETNZYrjwqit2fij8jbK1uDJcKM
	 UFVxXmkhQVas+Y0ElJQMJurhSk57c+WgEnKy7K62oVL7Dxl/pGLETL4+wyNaAcSELV
	 CTXaDcJoM9+AA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 59FF8CE0A70; Fri,  1 May 2026 07:00:51 -0700 (PDT)
Date: Fri, 1 May 2026 07:00:51 -0700
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
Message-ID: <268b3c60-d8ff-4cb8-a0b8-52e5dae143e1@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <adfrfJGrglg0bGw_@tardis.local>
 <adlHKowvhn8AGXCc@slm.duckdns.org>
 <afIdFgDD9w2U6hZy@linux.ibm.com>
 <tte9m9z@ub.hpns>
 <3b1563df-b1aa-40b9-b83e-650d967df09c@paulmck-laptop>
 <3f6d1123-6e1a-4566-8be7-ce95efe0609c@linux.ibm.com>
 <7b5665b4-ddd0-404a-8314-fd0a170db458@paulmck-laptop>
 <868cbc25-45a9-4476-b77e-7f878f1cd42c@linux.ibm.com>
 <c62502b6-642d-487d-a8a2-4ed7f9c7d858@paulmck-laptop>
 <981f0de4-fd65-475e-a626-ed7cd3594d3f@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <981f0de4-fd65-475e-a626-ed7cd3594d3f@linux.ibm.com>

On Fri, May 01, 2026 at 06:47:55PM +0530, Shrikanth Hegde wrote:
> Hi Paul.
> 
> On 4/30/26 9:40 PM, Paul E. McKenney wrote:
> > On Thu, Apr 30, 2026 at 12:38:16PM +0530, Shrikanth Hegde wrote:
> > > Hi Paul.
> > > 
> > > On 4/29/26 11:31 PM, Paul E. McKenney wrote:
> > 
> > [ . . . ]
> > 
> > Sorry, missed one...
> > 
> > > > ------------------------------------------------------------------------
> > > > 
> > > > commit f8d5aaaf90f8294890802ce8dccbafd9850ac5f9
> > > > Author: Paul E. McKenney <paulmck@kernel.org>
> > > > Date:   Thu Apr 9 11:16:02 2026 -0700
> > > > 
> > > >       srcu: Don't queue workqueue handlers to never-online CPUs
> > > >       While an srcu_struct structure is in the midst of switching from CPU-0
> > > >       to all-CPUs state, it can attempt to invoke callbacks for CPUs that
> > > >       have never been online.  Worse yet, it can attempt in invoke callbacks
> > > >       for CPUs that never will be online due to not being present in the
> > > 
> > > for CPUs that never will be online due to being present in the cpu_possible_mask?
> > 
> > Exactly.
> > 
> > Just because a CPU is in cpu_possible_mask doesn't mean that it will
> > ever actually come online.  For example, for single-threaded performance
> > reasons, a given system might choose to bring online only one CPU from
> > each hypertheaded core.  In that case, the other CPU in each hyperthreaded
> > core could be in the cpu_possible_mask, but would never come online.
> 
> Nit: I was suggesting *not* is probably not needed in that changelog.
> I agree with explanation.

Fair point, although before the fix it really would quite happily invoke
queue_work_on() for CPUs *not* in the cpu_possible_mask.  So I believe
that the original sentence is correct.

Me, I thought that you were asking if this also applied to CPUs in
cpu_possible_mask that were never going to come online.  I could change
this sentence to something like:

	Worse yet, it can attempt in invoke callbacks for CPUs that
	never will be online, even including imaginary CPUs not in
	cpu_possible_mask.

Would that help?

> > > >       cpu_possible_mask.  This can cause hangs on s390, which is not set up to
> > > >       deal with workqueue handlers being scheduled on such CPUs.  This commit
> > > >       therefore causes Tree SRCU to refrain from queueing workqueue handlers
> > > >       on CPUs that have not yet (and might never) come online.
> > > >       Because callbacks are not invoked on CPUs that have not been
> > > >       online, it is an error to invoke call_srcu(), synchronize_srcu(), or
> > > >       synchronize_srcu_expedited() on a CPU that is not yet fully online.
> > > >       However, it turns out to be less code to redirect the callbacks
> > > >       from too-early invocations of call_srcu() than to warn about such
> > > >       invocations.  This commit therefore also redirects callbacks queued on
> > > >       not-yet-fully-online CPUs to the boot CPU.
> > > >       Reported-by: Vasily Gorbik <gor@linux.ibm.com>
> > > >       Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > > >       Tested-by: Vasily Gorbik <gor@linux.ibm.com>
> > > >       Cc: Tejun Heo <tj@kernel.org>
> 
> 
> Alright. With those two explanations, this LGTM.
> 
> Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>

Thank you!

Unless you tell me otherwise, I will make the change I suggested above
and add your Reviewed-by.

							Thanx, Paul
