Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EC952E414;
	Mon, 27 Apr 2026 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777327432; cv=none; b=TBEG9sepoFLdIbrkhGdQApTarH9l/KdimDbKVcrYBpZ1QvmKyiJIlYnRx7LDROSJlv2K5KMJVaSgETz13EomSodAJiHns8v2AF2xllelHNxuG/wSWvnD2ywrng+ii0iSGUnCD4J9B9h0kVmsNsYA9Ux1NcbdqcLmrvbIIKXihQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777327432; c=relaxed/simple;
	bh=pPTuUPRefTYXU0h48znUz5nLioqs+x++M3hE2079xYU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GiQm2ID07w7hKhEe/7bFyMLF2GgwrSvnqY1p3onW7MDEwixeFGpYkE9LQOlkPF78RG1l861njixg0JQ1M5yyOjGBKMDkYHOz7/rri1wEVdNB+FJm+NcTpK+F6K6DGiCaLV/yIHiOVC5i8Ig26IcYIsfkkwC/E5DQpfr1K4ZdJ84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h41KS2Z7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h41KS2Z7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86F5FC19425;
	Mon, 27 Apr 2026 22:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777327431;
	bh=pPTuUPRefTYXU0h48znUz5nLioqs+x++M3hE2079xYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h41KS2Z77hg/VY2/+NTtoUFxQIthkEBER+hZSEVIpJPXonq2EWUNVVUwjwsbNRBgs
	 KSZCamtEW0ld0Je/vDvixlslp/ydxcYwhmo37UePuG71OgymKVtfRLTSSjtOEgxGaQ
	 U7OS0H2Rx72wANcLxqefSbt8c6kwJa1lB9gYTmoehWXLV4B6QdDsuUzrB7cGI6fazN
	 nHrJJtau5azQogDf6HtV/j+plH/wwwUcPq2DDIyTdQ27xiTBptmuApKUP7XtJ9v3Wi
	 vWFGRTordeQQAURGGO2SIcp1/GOgJwYLYtsLJv/r8abloGac0Rh/0tRxbSgvs4PF3i
	 FZfIK3umVgTzg==
Date: Mon, 27 Apr 2026 15:03:49 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <ae_dRZ95dCDTTxaQ@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka>
 <aevzbx_Pk5Cu5exa@google.com>
 <ae8KD_Tq0t7RvUy1@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae8KD_Tq0t7RvUy1@tiehlicka>

On Mon, Apr 27, 2026 at 09:02:39AM +0200, Michal Hocko wrote:
> On Fri 24-04-26 15:49:19, Minchan Kim wrote:
> > On Fri, Apr 24, 2026 at 09:57:20AM +0200, Michal Hocko wrote:
> > > On Tue 21-04-26 16:02:39, Minchan Kim wrote:
> > > > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > > > prior to the call. This separation introduces a scheduling race window
> > > > where the victim task may receive the signal and enter the exit path
> > > > before the reaper can invoke process_mrelease().
> > > > 
> > > > When the victim enters the exit path (do_exit -> exit_mm), it clears its
> > > > task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> > > > leaving the actual address space teardown (exit_mmap) to be deferred until
> > > > the mm's reference count drops to zero. In Android, arbitrary reference counts
> > > > (e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
> > > > VM accesses) frequently delay this teardown indefinitely, defeating the
> > > > purpose of expedited reclamation.
> > > > 
> > > > This delay keeps memory pressure high, forcing the system to unnecessarily
> > > > kill additional innocent background apps before the memory from the first
> > > > victim is recovered.
> > > 
> > > Thanks, this makes the motivation much more clear and usecase very
> > > sound.
> > > 
> > > > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> > > > an integrated auto-kill mode. When specified, process_mrelease() directly
> > > > injects a SIGKILL into the target task.
> > > > 
> > > > To solve the race condition deterministically, we grab the mm reference
> > > > via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
> > > > Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
> > > > victim from calling exit_mmap() in its own exit path.
> > > 
> > > Why is this needed? Address space tear down is an operation that can run
> > > from several execution contexts.
> > 
> > Agreed.
> > 
> > > 
> > > > This ensures that
> > > > the memory is reclaimed synchronously and deterministically by the reaper
> > > > in the context of process_mrelease(), avoiding delays caused by
> > > > non-deterministic scheduling of the victim task.
> > > 
> > > The memory is still reclaimed synchronously from the mrelease context.
> > > This is really confusing.
> > > 
> > > Please also explain why do you need to do all that ugly
> > > task_will_free_mem hoops. Why cannot you simply kill the task if
> > > task_will_free_mem fails (if PROCESS_MRELEASE_REAP_KILL is used).
> > 
> > I wanted to handle shared address spaces.
> > Even though we are okay with the target task not being in a SIGKILL
> > state yet (since we are about to kill it), we must ensure that all
> > *other* processes sharing the same mm are also dying.
> 
> Then just bail out when the mm is shared accross thread groups, rather
> than kill just one of them. Or kill all of them. There is no reason to
> play around that on the task_will_free_mem level.

Kiling unrelated processes just because they share an mm is too radicical.

Thinking about quick check whether mm is shared.

An idea:

`atomic_read(&mm->mm_users) > task->signal->nr_threads` to detect sharing
across thread groups without looping like task_will_free_mem.

However, the problem is that mm_users is easily elevated by transient remote
VM accesses, such as when monitoring tools read /proc/<pid>/cmdline, which
happens quite often in the field.
This would cause too many false positives, making process_mrelease() fail
unnecessarily even when no other thread group is actually pinning the mm.

Do you have any ideas on how to check this quickly without calling
task_will_free_mem() reliably?




