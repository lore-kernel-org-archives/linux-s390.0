Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD5C62AE78;
	Sat, 16 May 2026 05:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778910428; cv=none; b=SElypdVIdNSha759vMB0kZj19RwGuEctepJgFkrv5NI7psdFU/jCWw8V6dUdKZxYRNbdh7qbe2HsYymiMicAOOLBomSS4x699l6k12uq+TLoxEUQdHRXVeDK+q+Ig5YG2P+ZNEogqrlUddW6s1DKojhqoBSYjm5u078hNvBVH6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778910428; c=relaxed/simple;
	bh=IDkuGTq3F2cfjq4A2tMmj5t/Hru33a8Gq8U2/9uYEVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VdslqUuCliG1q2pVzyh5Bv+KxkXq2J65VQr/KteyJICt7oIcWHIf5LA14X/W29w7VDPTJSydrwU6GqPJzMexdzzkkfLFtxjq48Hjh3eYZb4NtFBWnnX2tCgRF+i5YeZwwTIvh3/9+rX2MQrb7Iry51Ni7Yic4vItobFyDxkBp8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MUpLo1mE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MUpLo1mE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E64AC19425;
	Sat, 16 May 2026 05:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778910428;
	bh=IDkuGTq3F2cfjq4A2tMmj5t/Hru33a8Gq8U2/9uYEVk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MUpLo1mE/JFhAvmQ6T2j8+UVQ/8VfAAgZ8NXh0CNdj5Pe1HMoNvm5aPL6TSp8hrbL
	 dT4mFHmSMvlayufTdon5cAt+146z+sHeABLvEvXsYr9wq0cjya0NUIlwSBA/dase6f
	 0rGdm2xf4etu2hI/gPy8nc1Tm1oRc77QDIe8i7nhfl+veelMc3pe6aD5cyNZ4n8djF
	 x1hHb48i8RVt3xlqhC3mUSLA0IU1zPmsvU2t4AACeYK+cZagXYDppvFnPW4vxjYpqL
	 2oYU7AA5z/iBA5CVCeyfH7UrpixJqi6Me0GgQCgpZcVdXnmRAUFQmR5Lvjy/rLTkFz
	 2XrdBD1gsptVw==
Date: Fri, 15 May 2026 22:47:06 -0700
From: Minchan Kim <minchan@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Christian Brauner <brauner@kernel.org>,
	Jann Horn <jannh@google.com>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	mhocko@suse.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	surenb@google.com, timmurray@google.com
Subject: Re: [PATCH v3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <aggE2haQ7yGeHPeF@google.com>
References: <20260511214226.937793-1-minchan@kernel.org>
 <20260515-nachdenken-umbenannt-a90006a46e14@brauner>
 <agd--WZpeTq2iKFW@redhat.com>
 <agefLhQeWpvil14M@google.com>
 <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wiHfzbufXD2nuc9BhOVp-pYEmnVUYeThKmfZRXLU0kJ7w@mail.gmail.com>

On Fri, May 15, 2026 at 04:45:38PM -0700, Linus Torvalds wrote:
> On Fri, 15 May 2026 at 15:33, Minchan Kim <minchan@kernel.org> wrote:
> >
> > I hope thisclarifies the motivation and mechanics behind this issue.
> 
> This still seems very hacky and a complete special case for one odd situation.

Hi Linus,

Thank you for looking into this issue and sharing your thoughts.

Regarding proc_mem_open(), it actually operates very close to what you suggested.
It acquires a reference to the mm_struct itself via mmgrab() but immediately
unpins the address space memory via mmput(). Thus, no long-term mm_users
reference is held across the open file descriptor.

The latency issue occurs during seqfile iteration (m_start/m_stop) in
smaps/maps, or during get_cmdline() and ptrace_access_vm(), where the reader
temporarily acquires mm_users via mmget_not_zero() or get_task_mm().

Because these monitoring processes or background readers often run with lower
priority on heavily loaded systems under memory pressure, their temporary
mmget() reference can easily be delayed or preempted for extended periods.

When the victim process exits, its memory teardown (exit_mmap) is blocked by
this stalled reference. Because any kernel interface acquiring mmget() can
potentially cause this delay under heavy load, the issue appears more general
than just a single file interface.

This is why I felt allowing process_mrelease() to directly acquire the dying
address space could be a clean and robust way to resolve this expedited reclaim
issue, without modifying individual callers across the kernel. I would highly
appreciate your thoughts on this perspective.

> 
> This all sounds like it's just because smap is a pig.
> 
> And yes, smap *is* a pig, but it should be trivial to just fix smap
> for this case - fix the problem spot, don't add new horrid logic
> elsewhere.
> 
> I really think the fix is to fix smap instead.
> 
> And I think smap is doing odd things. For example, it does
> 
>    pid_smaps_open -> do_maps_open -> proc_mem_open
> 
> and that proc_mem_open() takes that long-term ref to the mm. And then
> does various memory allocations - and copying data to user space -
> under that long-term ref, which is presumably what causes all the
> latency issues.
> 
> But it doesn't actually seem to *need* a long-term ref to the mm. The
> seqfile interface is designed so that it should all be chunkable, and
> the locks and refs should be done at m_start/m_end time.
> 
> And the smap / maps m_start and m_end functions already *almost* seem
> to do that. They literally look up the task again with
> 
>         priv->task = get_proc_task(priv->inode);
> 
> etc, but then they do that odd
> 
>         lock_ctx = &priv->lock_ctx;
>         mm = lock_ctx->mm;
>         if (!mm || !mmget_not_zero(mm)) {
>                 put_task_struct(priv->task);
>                 priv->task = NULL;
>                 return NULL;
>         }
> 
> dance (where lock_ctx->mm is literally that long-term ref we hold).
> 
> And I don't see why they need to do any of this. I think it's all a
> historical accident.
> 
> Because I think it could look up the mm from the task pointer every
> time, without holding that long-term ref from proc_mem_open() at all.
> 
> IOW, at open time, we could save off the "this is the mm I opened",
> but *without* any refcount, and then just verify that "yes, the task
> mm still matches". No long-term refs anywhere.
> 
> Yes, yes, we'd need some sequence counter for when the mm changes due
> to execve, but *that* should be absolutely trivial.
> 
> And wouldn't that make all of this go away entirely? And probably
> clean up the code at the same time?
> 
> I think the only reason "proc_mem_open()" does what it does was that
> it was simple. Not because it was a good idea.
> 
>                    Linus
