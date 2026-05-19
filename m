Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4C3377017;
	Tue, 19 May 2026 20:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779224012; cv=none; b=bMMiAjisAI3FSiEiZWRL3F7W6YvC8+PWNtQcIDH4YNVA7vh8CAXf4MyiruY8PL5RAE3gcE6TAc2rdzGUK0T110CjKGxe53gzYdaT7dUX512/LiCqDZTFumQI15l1RhGaoF0oj3YSwMK+C6Bqc0q1M3XPLP7KrYma/EL9Rqdueas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779224012; c=relaxed/simple;
	bh=VNo94fcZ+jcCKTWScIEa9bXLVVawJonEFzL+GX6S3C4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YEPXiw+Sn4D11ExHjjg1iF5afUL5p1hCAP4PJ/WIHfULVjd3twuR6CoUwVtPipUmbjKmpefIwFzk3TmXdY2gK1EcD7WKQVtUtzCuDNQ9Jg35s3v7rJGkRDRp5Z9+xXcyK8qyYQEZ+C6d5Md5GnJqPLnL93QMWqYfDv0C76R9FQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OI4P2Mzp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OI4P2Mzp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E4C21F000E9;
	Tue, 19 May 2026 20:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779224010;
	bh=jCqIEXfw/wdvd3SK3XOskv8/nJywCW8w0ATavedCeCQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=OI4P2Mzpbf6YCwD9QkPGZO2VyqVZebFUp+qZ/ndrxtEvKZgvBFvazZ/5FhVarFVM4
	 sghlGq6PREViBvKMH0FDJtBVy2YhFLlz2Y5qAgUkP4pe+0PaeraCNDxS4ij0nDGGh2
	 fvK/XmKh8DDwtda1VYK7bEeSij8VUL7P+gApAinmbufjrtEXu8Ps9MBtTuYWMBZXFS
	 93N9tU86GTC/MhCxZpXalKA8GsOaefgybM/wFVHKb0JPgCIWcQnIZY/52ER8RG1QJI
	 /2EjE3jc1tWTGlkmTDfj+rY4sG0dDSMJ/YGD36JCvCwlWV93N5UEToe8EMc9Fo9ZRi
	 IErQOvsdch9vg==
Date: Tue, 19 May 2026 13:53:29 -0700
From: Minchan Kim <minchan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	surenb@google.com, timmurray@google.com
Subject: Re: [PATCH v3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <agzNyXKIirm1zOob@google.com>
References: <20260511214226.937793-1-minchan@kernel.org>
 <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com>
 <agefLhQeWpvil14M@google.com>
 <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
 <aggE2haQ7yGeHPeF@google.com>
 <CAHk-=wg08=sZb=hVa22KjN2pD3aNk-diGmKQnizCgmoMMfrvwQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAHk-=wg08=sZb=hVa22KjN2pD3aNk-diGmKQnizCgmoMMfrvwQ@mail.gmail.com>

On Sat, May 16, 2026 at 09:31:04AM -0700, Linus Torvalds wrote:
> On Fri, 15 May 2026 at 22:47, Minchan Kim <minchan@kernel.org> wrote:
> >
> > Regarding proc_mem_open(), it actually operates very close to what you suggested.
> > It acquires a reference to the mm_struct itself via mmgrab() but immediately
> > unpins the address space memory via mmput(). Thus, no long-term mm_users
> > reference is held across the open file descriptor.
> 
> Ahh, and we've actually done that since 2012. How time flies..
> 
> > The latency issue occurs during seqfile iteration (m_start/m_stop) in
> > smaps/maps, or during get_cmdline() and ptrace_access_vm(), where the reader
> > temporarily acquires mm_users via mmget_not_zero() or get_task_mm().
> 
> Ok, so it's that much smaller region.
> 
> How about a completely different approach then - make exit_mmap() just
> take the mmap_write_lock() properly, and allow walking the vma's
> without ever grabbing mm_users at all?
> 
> IOW, just a mm_count ref would be sufficient to hold the mm_struct
> around, and then the read-lock protects against exit_mm() actually
> tearing the list down when the last "real" user goes away.
> 
> [ exit_mm() is currently a bit odd - it does take the mmap_write lock,
> but it *starts* with the read-lock.
> 
>    I'm not sure why it does that - it used to do the write lock over
> the whole sequence, but that was changed in commit bf3980c85212 ("mm:
> drop oom code from exit_mmap").
> 
>   Sure, read-lock allows more concurrency, but that would seem to be a
> complete non-issue for exit_mmap(), and switching locking seems to
> just complicate things.
> 
>   But that's a separate issue that I just happened to notice while
> looking at this ]
> 
> I may be missing something else again.

Hi Linus,

Sorry for the slow response.
Thank you for the incredibly detailed feedback and the suggestions.

Your proposal to avoid mm_users and synchronize via mmap_lock is an elegant
conceptual cleanup. However, from the perspective of userspace OOM recovery,
we hit two critical roadblocks that this alone cannot resolve:

First, the -ESRCH race remains unsolved.
Even if we don't grab mm_users, the victim process still clears its task->mm
to NULL early in exit_mm(). Here is the timing mismatch:

CPU A (Userspace OOM Killer)      CPU B (Victim Task)
----------------------------      -------------------
1. Sends SIGKILL
2. Victim receives SIGKILL
                                  do_exit()
                                    exit_mm()
                                      task->mm = NULL  <==== (Stops pinning mm)
                                      mmput()
3. Calls process_mrelease()
   (Looks up task->mm)
   (Sees NULL)
   Returns -ESRCH! <======================================== (Reaping fails!)

Without Jann's patch to preserve the mm pointer via task->exit_mm, the
userspace killer won't even have a chance to attempt reaping.

Second, the latency bottleneck transfers from mmput() to mmap_lock.
If a low-priority procfs reader is preempted or stalled while holding the
mmap_read_lock, the exiting process calling exit_mmap() will block indefinitely
when trying to acquire the mmap_write_lock.

Crucially, if this lock contention occurs, process_mrelease() itself would
also block on the same mmap_lock while trying to reap the memory, defeating the
synchronous and expedited nature of the API.

[An Alternative Proposal: Combining Kill and Reap via pidfd_send_signal()]

Taking a step back, I believe the fundamental issue stems from separating
the asynchronous "Kill" and synchronous "Reap" operations into two distinct
system calls. Because userspace cannot predict when the victim will execute
exit_mm(), the timing mismatch is practically unavoidable so the reaping
doesn't work in the end.

Since Christian understandably dislikes combining signaling semantics into
process_mrelease(), perhaps we could solve this from the signal side.

What if we introduce a new flag for pidfd_send_signal(), such as
PIDFD_SIGNAL_PROCESS_GROUP_EXPEDITE?

When invoked with this flag and SIGKILL, pidfd_send_signal() would deliver the
fatal signal and immediately trigger the oom_reaper's VM zapping on the target
mm within the same synchronous syscall context (where task->mm is guaranteed to
be valid and easily locked).

This would completely eliminate the -ESRCH race by making the kill-and-reap
operation atomic from userspace's perspective, while keeping each syscall
focused strictly on its primary responsibility (signaling vs. reclaiming)

Honestly, if we adopt this atomic interface, it might actually make the
separate process_mrelease() syscall obsolete. I am not entirely sure about
the historical reasons why they were split into two distinct APIs
in the first place, but merging them into a single pidfd-based atomic
operation seems much cleaner.

I would highly appreciate everyone's thoughts on this perspective and
alternative direction.

> 
> Also, I do really hate the smap code. People have optimized it because
> it's so piggy, but that code is still just silly. The "rollup" case in
> particular knows how bad it is, and does that whole "unlock and relock
> under contention" because it knows it's a horrible latency pig.

And yes, I completely agree with your frustration on the smaps code—it is
indeed a massive latency pig. In fact, userspace tools have increasingly moved
away from smaps and even PSS (Proportional Set Size) altogether because they
are simply too slow to be usable in production.

> 
> Oh well. But it really feels like we *could* do this all without mm_users. No?
> 
>                   Linus
> 
