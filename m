Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C26CF3EBF02;
	Fri, 15 May 2026 22:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778884400; cv=none; b=I7EfOWDvO0zQTYBSe5Zjzim/Hzg3uCskVulIHk3JPmm7QnE9jRAC0gZhM1bz/NbouFzjhi7Fwt82Jj/VDXZyo62XnNj03Qt0NS0J3/5UlgI9MjZtSyxxqr8tUEU4M4Ph1BGb0dIc+4Y2uO4xsTKRroUXq3lBniI4kTFbEyGugs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778884400; c=relaxed/simple;
	bh=6CKdBEtb3qu5B5JUYnre/tgqxseESedpaSxDYKDwlrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWSxGAGkakEqR9Dju8lMplHj8mbCHtBjKBFL7s9fsccnkz92uYPmnz+XZbj7aJhP+Ch3RVCPfgqAiihQvqYCJNrUG6RA4nekBR4zfqOQzhhRVSSCejf0PYx5pja/4Qk2xGmlr1Vt/C6lSN/rWGbC7LaKTqaZwDNOO0TuULeoJkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Too1pJM+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Too1pJM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34EA1C2BCB0;
	Fri, 15 May 2026 22:33:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778884400;
	bh=6CKdBEtb3qu5B5JUYnre/tgqxseESedpaSxDYKDwlrk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Too1pJM+IoMkHbF9Efvjz++ELv7AuMkUT2Y0cl7609i8ZNO8N/TdztbdaENnilhV9
	 mZincVFX8WFHI3Azjmg9FjvLZXhEY+Y4aR+4F+JLnaEPxQXgMPsM709kXxHopf5h8e
	 G9wWGjD5IuBuuQExqgxvtCXoK2wgD1UOZt29ZL+w6hhqihi7NLJ31i9EkelCCnPQTC
	 CfxLD2DOYEfkmadv2QNHeY4xwabCwd3AuJcvZ5ea6gtLq9up5ICMcdbUSz3QKNjGEt
	 eTIYSGJtaL3MY0WjHdElbV8dYO8V/VlwgTBxK1LFuKQ2vd1rdyxWTcQA2R5QDPVNoJ
	 cqa9iR3vIYAjw==
Date: Fri, 15 May 2026 15:33:18 -0700
From: Minchan Kim <minchan@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Christian Brauner <brauner@kernel.org>, Jann Horn <jannh@google.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, mhocko@suse.com,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <agefLhQeWpvil14M@google.com>
References: <20260511214226.937793-1-minchan@kernel.org>
 <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <agd--WZpeTq2iKFW@redhat.com>

On Fri, May 15, 2026 at 10:15:53PM +0200, Oleg Nesterov wrote:
> In fact I don't even understand the motivation...
> 
> On 05/15, Christian Brauner wrote:
> >
> > On Mon, May 11, 2026 at 02:42:26PM -0700, Minchan Kim wrote:
> > > leaving the actual address space teardown (exit_mmap) to be deferred until
> > > the mm's reference count drops to zero. In the field (e.g., Android),
> > > arbitrary reference counts (reading /proc/<pid>/cmdline, or various other
> > > remote VM accesses) frequently delay this teardown indefinitely,
> 
> Sure, get_task_cmdline() can delay mmput(). But indefinitely ?
> 
> Perhaps the changelog could be more clear? I don't see how any remote VM access
> can pin mm->mm_users "indefinitely". Even if, say, a lot of threads read
> /proc/<pid>/cmdline in an endless loop in parallel...
> 
> I must have missed something.

Thank you for the review and questions. You are entirely right that under normal
uncongested conditions, a /proc reader drops mmput() quickly.

However, on any heavily loaded system under severe memory/CPU pressure, this delay
can be long enough to cause cascading issues. Here is exactly how this occurs
and why it acts as an indefinite delay from an emergency reclaim perspective.

When memory pressure is critical, a userspace OOM killer terminates a large
victim process. Simultaneously, another process (such as a monitoring tool) is
reading /proc/<pid>/smaps or cmdline. Because the system is heavily loaded, the
reader thread on CPU C can get preempted or blocked while holding mmget().

When the dying victim executes exit_mm(), mm_users drops from 2 to 1. Thus,
exit_mmap() does not run. For hundreds of milliseconds or seconds, the memory
remains fully trapped. The userspace OOM policy sees that memory is still
critically low and unnecessarily kills additional innocent processes.

Here is the exact timing chart illustrating the existing problem and why
process_mrelease() fails in this scenario:

CPU A (Userspace OOM Killer)      CPU B (Victim Task)      CPU C (/proc Reader)
----------------------------      -------------------      --------------------
						       open(/proc/pid/smaps)
						       get_task_mm()
						       [mm_users++ => 2]
						       (Preempted/Stalled)
							          |
1. Sends SIGKILL                                                  |
2. Victim receives SIGKILL                                        |
			      do_exit()                           |
				exit_mm()                         |
				  task->mm = NULL                 |
				  mmput() [mm_users => 1]         |
				  (Memory NOT freed!)             |
							          |
3. Calls process_mrelease()                                       |
							          |
find_lock_task_mm() sees task->mm == NULL                         |
Returns -ESRCH. Reaping fails!                                    |
(Memory remains trapped until CPU C finally finishes!) <==========/

I hope thisclarifies the motivation and mechanics behind this issue.
