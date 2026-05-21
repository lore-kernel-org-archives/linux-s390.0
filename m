Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F7F37F73B;
	Thu, 21 May 2026 11:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779364256; cv=none; b=KnZgI1VKR26+QbMhsjkhP2ZOMGqtKRngCUrHOO6LDT6hkkI/L7bgb/bDXBA40fz4QBpFNLbSxwt/eTgtB6rdhVkhqorB8dOdoyMvEvGVuzpVe+m6mkFNEYnd6Q3oS5d5xDXRIHD/I13mpFPMmdPLCwQYcys+4SxX3bxrZKMZk2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779364256; c=relaxed/simple;
	bh=c2CNaNZE458SurxpD5wFTLtpbtw3/P+zbXkUIyJhklg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HgLcgJePxwqJ6BVax6bEANffd2ocxIQhbPGfRHHR8uayYe24A80Tah0+fiOY0z2P3Oz50f3wPjUKZu2bIeN70Zxj8p7p9GcBiEDc68hF7zy4i/Jr8MXnhd+1y+MRsgG6qt4dygyk+20Xdre/g4Hn0XVq9JkCrM4M97PlZ4KNLqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MRKZFDWb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MRKZFDWb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B34651F000E9;
	Thu, 21 May 2026 11:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779364254;
	bh=Mxmzw2keS/IWw65LW2VBQA2Mr861k+BrmQPUw3Orkk0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=MRKZFDWbtFwY+D1XK7YXUgEDz2oAzVEz4C1qGJ7I4CJHVnOASNC97pUQKCz7EnN8P
	 lo+7bpbwOr3QBU8+gp3z+dwyxxtdLEMuUCGxg0oNNAph68BdeJy9sfTWe7+ZNbMv7m
	 jy4Rd1hD/hMT7MuVkCILpB5vwTWFtZcqc+GyMBR4WC/yfaNv87a9ndEVOa2PchI2Ku
	 As+bU54MEWUSoQ1nrOwdcgxcw3asfAPGfLh48hJKeotibVBCW0Ku5m6KMEbKkrGMGk
	 p2XQi5T4z94JVrdjesACegxGnTtAvHiBBf/pTLPP0j2AC1azH8U0QLK7qxjWlxvSCZ
	 LyL6/73ncJL6w==
Date: Thu, 21 May 2026 13:50:44 +0200
From: Christian Brauner <brauner@kernel.org>
To: Minchan Kim <minchan@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
	Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>, akpm@linux-foundation.org, 
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com, 
	timmurray@google.com
Subject: Re: [PATCH v3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <20260521-voreilig-investieren-34f6e0c56258@brauner>
References: <20260511214226.937793-1-minchan@kernel.org>
 <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com>
 <agefLhQeWpvil14M@google.com>
 <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
 <aggE2haQ7yGeHPeF@google.com>
 <CAHk-=wg08=sZb=hVa22KjN2pD3aNk-diGmKQnizCgmoMMfrvwQ@mail.gmail.com>
 <agzNyXKIirm1zOob@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <agzNyXKIirm1zOob@google.com>

On Tue, May 19, 2026 at 01:53:29PM -0700, Minchan Kim wrote:
> On Sat, May 16, 2026 at 09:31:04AM -0700, Linus Torvalds wrote:
> > On Fri, 15 May 2026 at 22:47, Minchan Kim <minchan@kernel.org> wrote:
> > >
> > > Regarding proc_mem_open(), it actually operates very close to what you suggested.
> > > It acquires a reference to the mm_struct itself via mmgrab() but immediately
> > > unpins the address space memory via mmput(). Thus, no long-term mm_users
> > > reference is held across the open file descriptor.
> > 
> > Ahh, and we've actually done that since 2012. How time flies..
> > 
> > > The latency issue occurs during seqfile iteration (m_start/m_stop) in
> > > smaps/maps, or during get_cmdline() and ptrace_access_vm(), where the reader
> > > temporarily acquires mm_users via mmget_not_zero() or get_task_mm().
> > 
> > Ok, so it's that much smaller region.
> > 
> > How about a completely different approach then - make exit_mmap() just
> > take the mmap_write_lock() properly, and allow walking the vma's
> > without ever grabbing mm_users at all?
> > 
> > IOW, just a mm_count ref would be sufficient to hold the mm_struct
> > around, and then the read-lock protects against exit_mm() actually
> > tearing the list down when the last "real" user goes away.
> > 
> > [ exit_mm() is currently a bit odd - it does take the mmap_write lock,
> > but it *starts* with the read-lock.
> > 
> >    I'm not sure why it does that - it used to do the write lock over
> > the whole sequence, but that was changed in commit bf3980c85212 ("mm:
> > drop oom code from exit_mmap").
> > 
> >   Sure, read-lock allows more concurrency, but that would seem to be a
> > complete non-issue for exit_mmap(), and switching locking seems to
> > just complicate things.
> > 
> >   But that's a separate issue that I just happened to notice while
> > looking at this ]
> > 
> > I may be missing something else again.
> 
> Hi Linus,
> 
> Sorry for the slow response.
> Thank you for the incredibly detailed feedback and the suggestions.
> 
> Your proposal to avoid mm_users and synchronize via mmap_lock is an elegant
> conceptual cleanup. However, from the perspective of userspace OOM recovery,
> we hit two critical roadblocks that this alone cannot resolve:
> 
> First, the -ESRCH race remains unsolved.
> Even if we don't grab mm_users, the victim process still clears its task->mm
> to NULL early in exit_mm(). Here is the timing mismatch:
> 
> CPU A (Userspace OOM Killer)      CPU B (Victim Task)
> ----------------------------      -------------------
> 1. Sends SIGKILL
> 2. Victim receives SIGKILL
>                                   do_exit()
>                                     exit_mm()
>                                       task->mm = NULL  <==== (Stops pinning mm)
>                                       mmput()
> 3. Calls process_mrelease()
>    (Looks up task->mm)
>    (Sees NULL)
>    Returns -ESRCH! <======================================== (Reaping fails!)
> 
> Without Jann's patch to preserve the mm pointer via task->exit_mm, the
> userspace killer won't even have a chance to attempt reaping.
> 
> Second, the latency bottleneck transfers from mmput() to mmap_lock.
> If a low-priority procfs reader is preempted or stalled while holding the
> mmap_read_lock, the exiting process calling exit_mmap() will block indefinitely
> when trying to acquire the mmap_write_lock.
> 
> Crucially, if this lock contention occurs, process_mrelease() itself would
> also block on the same mmap_lock while trying to reap the memory, defeating the
> synchronous and expedited nature of the API.
> 
> [An Alternative Proposal: Combining Kill and Reap via pidfd_send_signal()]
> 
> Taking a step back, I believe the fundamental issue stems from separating
> the asynchronous "Kill" and synchronous "Reap" operations into two distinct
> system calls. Because userspace cannot predict when the victim will execute
> exit_mm(), the timing mismatch is practically unavoidable so the reaping
> doesn't work in the end.
> 
> Since Christian understandably dislikes combining signaling semantics into
> process_mrelease(), perhaps we could solve this from the signal side.
> 
> What if we introduce a new flag for pidfd_send_signal(), such as
> PIDFD_SIGNAL_PROCESS_GROUP_EXPEDITE?
> 
> When invoked with this flag and SIGKILL, pidfd_send_signal() would deliver the
> fatal signal and immediately trigger the oom_reaper's VM zapping on the target
> mm within the same synchronous syscall context (where task->mm is guaranteed to
> be valid and easily locked).

Maybe. We would need to see what that actually looks like.

> 
> This would completely eliminate the -ESRCH race by making the kill-and-reap
> operation atomic from userspace's perspective, while keeping each syscall
> focused strictly on its primary responsibility (signaling vs. reclaiming)
> 
> Honestly, if we adopt this atomic interface, it might actually make the
> separate process_mrelease() syscall obsolete. I am not entirely sure about
> the historical reasons why they were split into two distinct APIs
> in the first place, but merging them into a single pidfd-based atomic
> operation seems much cleaner.
> 
> I would highly appreciate everyone's thoughts on this perspective and
> alternative direction.
> 
> > 
> > Also, I do really hate the smap code. People have optimized it because
> > it's so piggy, but that code is still just silly. The "rollup" case in
> > particular knows how bad it is, and does that whole "unlock and relock
> > under contention" because it knows it's a horrible latency pig.
> 
> And yes, I completely agree with your frustration on the smaps code—it is
> indeed a massive latency pig. In fact, userspace tools have increasingly moved
> away from smaps and even PSS (Proportional Set Size) altogether because they
> are simply too slow to be usable in production.
> 
> > 
> > Oh well. But it really feels like we *could* do this all without mm_users. No?
> > 
> >                   Linus
> > 
