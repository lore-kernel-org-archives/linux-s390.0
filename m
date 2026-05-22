Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E22368277;
	Fri, 22 May 2026 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779487757; cv=none; b=lOrYxHcX2rUTDL2fjfWJ4+8/fU7hTNWm+Tr47V0ZhrB1kVoqyVM/B1mbRAJ515I0OLzVZcjidqE1nznQe5dLgR0lr8zeBopEHrfnkiXJJT5bZ+o2EXn/+Meibk1T8W50FH6UuIZpjKojU8pg7C7DYwWbcENPS4BbKi49+59pADE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779487757; c=relaxed/simple;
	bh=6qIQBkWgoqqmkzAFAs/BuNKqIw/Q0Uwa4clGjMh9Bhg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YuhXcDBSrNla+5YIZYhSAMutRhXm1YrjfIhWkTXn8E2ydGgzPniMAzSBLeb+zGc4mgBx7pWlQ1JLWa8+7rKapKu3S3Q8oGmvUiupdLi9KowSOUioJd8S1CTpT3SBtsr/1ZGe29zqojRw2C7x5bNnKHFokLpPR4QrTL/VFBc54bM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WBld1bOX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WBld1bOX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E2081F000E9;
	Fri, 22 May 2026 22:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779487755;
	bh=yf2vEzlZ5+p+ATp9gN007KI2Z3fmEmZMNNzYlyeFYlA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=WBld1bOXzLJCq3Bw17JrbLFuzGPxIszFTxGQZb7z2lmiU9Yypj3FKG+qWRywZju1E
	 1KFiWIMGtBflx9SOmTDgX3R8s4+pRHAbVCL23cYXsXSH2sKGZHgvJ+c23rK4KUtEnQ
	 X0jyv7P1SJbMSGE0AkbgLLGmXbchgiiCXhbMB9HgGtnMgypiKJ7wrnZPfi/gdS85Ub
	 IvnMYD7XSMNJgsuaQOr7jmFJCX9Gx70hwE5KwfdcQZQAMmHs75Xl54nZsjFiNBkkih
	 YaCxoRJdA4T8QLKEF2LX96hQDjsC6L3vUfRZ3T3ZHMmG98DWhTYjK/GYx3y3Ug9Dyy
	 e1GjUdLcRwIaw==
Date: Fri, 22 May 2026 15:09:13 -0700
From: Minchan Kim <minchan@kernel.org>
To: Christian Brauner <brauner@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <ahDUCbo4fIKA7rMZ@google.com>
References: <20260511214226.937793-1-minchan@kernel.org>
 <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com>
 <agefLhQeWpvil14M@google.com>
 <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
 <aggE2haQ7yGeHPeF@google.com>
 <CAHk-=wg08=sZb=hVa22KjN2pD3aNk-diGmKQnizCgmoMMfrvwQ@mail.gmail.com>
 <agzNyXKIirm1zOob@google.com>
 <20260521-voreilig-investieren-34f6e0c56258@brauner>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260521-voreilig-investieren-34f6e0c56258@brauner>

On Thu, May 21, 2026 at 01:50:44PM +0200, Christian Brauner wrote:
> On Tue, May 19, 2026 at 01:53:29PM -0700, Minchan Kim wrote:
> > On Sat, May 16, 2026 at 09:31:04AM -0700, Linus Torvalds wrote:
> > > On Fri, 15 May 2026 at 22:47, Minchan Kim <minchan@kernel.org> wrote:
> > > >
> > > > Regarding proc_mem_open(), it actually operates very close to what you suggested.
> > > > It acquires a reference to the mm_struct itself via mmgrab() but immediately
> > > > unpins the address space memory via mmput(). Thus, no long-term mm_users
> > > > reference is held across the open file descriptor.
> > > 
> > > Ahh, and we've actually done that since 2012. How time flies..
> > > 
> > > > The latency issue occurs during seqfile iteration (m_start/m_stop) in
> > > > smaps/maps, or during get_cmdline() and ptrace_access_vm(), where the reader
> > > > temporarily acquires mm_users via mmget_not_zero() or get_task_mm().
> > > 
> > > Ok, so it's that much smaller region.
> > > 
> > > How about a completely different approach then - make exit_mmap() just
> > > take the mmap_write_lock() properly, and allow walking the vma's
> > > without ever grabbing mm_users at all?
> > > 
> > > IOW, just a mm_count ref would be sufficient to hold the mm_struct
> > > around, and then the read-lock protects against exit_mm() actually
> > > tearing the list down when the last "real" user goes away.
> > > 
> > > [ exit_mm() is currently a bit odd - it does take the mmap_write lock,
> > > but it *starts* with the read-lock.
> > > 
> > >    I'm not sure why it does that - it used to do the write lock over
> > > the whole sequence, but that was changed in commit bf3980c85212 ("mm:
> > > drop oom code from exit_mmap").
> > > 
> > >   Sure, read-lock allows more concurrency, but that would seem to be a
> > > complete non-issue for exit_mmap(), and switching locking seems to
> > > just complicate things.
> > > 
> > >   But that's a separate issue that I just happened to notice while
> > > looking at this ]
> > > 
> > > I may be missing something else again.
> > 
> > Hi Linus,
> > 
> > Sorry for the slow response.
> > Thank you for the incredibly detailed feedback and the suggestions.
> > 
> > Your proposal to avoid mm_users and synchronize via mmap_lock is an elegant
> > conceptual cleanup. However, from the perspective of userspace OOM recovery,
> > we hit two critical roadblocks that this alone cannot resolve:
> > 
> > First, the -ESRCH race remains unsolved.
> > Even if we don't grab mm_users, the victim process still clears its task->mm
> > to NULL early in exit_mm(). Here is the timing mismatch:
> > 
> > CPU A (Userspace OOM Killer)      CPU B (Victim Task)
> > ----------------------------      -------------------
> > 1. Sends SIGKILL
> > 2. Victim receives SIGKILL
> >                                   do_exit()
> >                                     exit_mm()
> >                                       task->mm = NULL  <==== (Stops pinning mm)
> >                                       mmput()
> > 3. Calls process_mrelease()
> >    (Looks up task->mm)
> >    (Sees NULL)
> >    Returns -ESRCH! <======================================== (Reaping fails!)
> > 
> > Without Jann's patch to preserve the mm pointer via task->exit_mm, the
> > userspace killer won't even have a chance to attempt reaping.
> > 
> > Second, the latency bottleneck transfers from mmput() to mmap_lock.
> > If a low-priority procfs reader is preempted or stalled while holding the
> > mmap_read_lock, the exiting process calling exit_mmap() will block indefinitely
> > when trying to acquire the mmap_write_lock.
> > 
> > Crucially, if this lock contention occurs, process_mrelease() itself would
> > also block on the same mmap_lock while trying to reap the memory, defeating the
> > synchronous and expedited nature of the API.
> > 
> > [An Alternative Proposal: Combining Kill and Reap via pidfd_send_signal()]
> > 
> > Taking a step back, I believe the fundamental issue stems from separating
> > the asynchronous "Kill" and synchronous "Reap" operations into two distinct
> > system calls. Because userspace cannot predict when the victim will execute
> > exit_mm(), the timing mismatch is practically unavoidable so the reaping
> > doesn't work in the end.
> > 
> > Since Christian understandably dislikes combining signaling semantics into
> > process_mrelease(), perhaps we could solve this from the signal side.
> > 
> > What if we introduce a new flag for pidfd_send_signal(), such as
> > PIDFD_SIGNAL_PROCESS_GROUP_EXPEDITE?
> > 
> > When invoked with this flag and SIGKILL, pidfd_send_signal() would deliver the
> > fatal signal and immediately trigger the oom_reaper's VM zapping on the target
> > mm within the same synchronous syscall context (where task->mm is guaranteed to
> > be valid and easily locked).
> 
> Maybe. We would need to see what that actually looks like.

Hi Christian,

Sure, Let me cook the initial draft.

Thanks.
