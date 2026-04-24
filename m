Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650523469E7;
	Fri, 24 Apr 2026 22:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777070961; cv=none; b=Xhk55poI4sU2rUNgIMFvqFQTrLTYUBp18+eVNCKLWsqVuGrZMwk/qcmmLia+dZUGlFfk4cbrqWis8wpJ6K9o95v0Z5rWJhQEgrIefidTk5XhdNSY0oSGdOcd7uKFwnaIt32sXDHhg+4OzUVD4b2ZfK2WACzSwqkemr3WvRYU8Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777070961; c=relaxed/simple;
	bh=1l62ftx9rkfVGFVp1ptfxZUhOlbilrk3qypY8gQ/oic=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecq0g5egNrO+4J+CsHm77UzW1N3sdXA0q0lU6aJw7V527WCrDUQU0075dEjIgfa9sfVcvl3T1JyBln+wJxoB7CHRhPJrLhxQFavy6woaPdXilEacyGSre+S6Q8C53aDU+5k1HJLbQ74rVuwJfXrWSjxLLm8uXuwUFtnCuT+m68A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HZKfSCGh; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HZKfSCGh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB4F0C19425;
	Fri, 24 Apr 2026 22:49:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777070961;
	bh=1l62ftx9rkfVGFVp1ptfxZUhOlbilrk3qypY8gQ/oic=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HZKfSCGhqeT/Hgx9B3tULabhTtRaySMTyinTdk2FdWIyDC7t40ZprQtYh7JCySR8K
	 2wPYbEpNGkMwi7xDLMFjRV7dLQE7LLJwIlddQVn2FECNPdx1ldPqq5AgkzujbivYJ8
	 Mmz7sYngCWxENghv4T3MuDiar1qocWgKK31hWtO8PRYdepJ5+PP6Vc6AvP+Ahpwe+A
	 810t9AQCNij/dDbk0PuUYbz+cz8ob4pqtii8uFpeeHB1S0PuoufEX743NNQ0PxGGZs
	 FzoOxw1GEO+PMV0eWGhlJ3prsncgxpRP4l3wgVbN8c7DOAFK7o5HiCWEyGgn+z0QSk
	 tJuZiIi557lmA==
Date: Fri, 24 Apr 2026 15:49:19 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 3/3] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <aevzbx_Pk5Cu5exa@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-4-minchan@kernel.org>
 <aesiYAumkLCyedf0@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aesiYAumkLCyedf0@tiehlicka>

On Fri, Apr 24, 2026 at 09:57:20AM +0200, Michal Hocko wrote:
> On Tue 21-04-26 16:02:39, Minchan Kim wrote:
> > Currently, process_mrelease() requires userspace to send a SIGKILL signal
> > prior to the call. This separation introduces a scheduling race window
> > where the victim task may receive the signal and enter the exit path
> > before the reaper can invoke process_mrelease().
> > 
> > When the victim enters the exit path (do_exit -> exit_mm), it clears its
> > task->mm immediately. This causes process_mrelease() to fail with -ESRCH,
> > leaving the actual address space teardown (exit_mmap) to be deferred until
> > the mm's reference count drops to zero. In Android, arbitrary reference counts
> > (e.g., async I/O, reading /proc/<pid>/cmdline, or various other remote
> > VM accesses) frequently delay this teardown indefinitely, defeating the
> > purpose of expedited reclamation.
> > 
> > This delay keeps memory pressure high, forcing the system to unnecessarily
> > kill additional innocent background apps before the memory from the first
> > victim is recovered.
> 
> Thanks, this makes the motivation much more clear and usecase very
> sound.
> 
> > This patch introduces the PROCESS_MRELEASE_REAP_KILL UAPI flag to support
> > an integrated auto-kill mode. When specified, process_mrelease() directly
> > injects a SIGKILL into the target task.
> > 
> > To solve the race condition deterministically, we grab the mm reference
> > via mmget() and set the MMF_UNSTABLE flag *before* sending the SIGKILL.
> > Using mmget() instead of mmgrab() keeps mm_users > 0, preventing the
> > victim from calling exit_mmap() in its own exit path.
> 
> Why is this needed? Address space tear down is an operation that can run
> from several execution contexts.

Agreed.

> 
> > This ensures that
> > the memory is reclaimed synchronously and deterministically by the reaper
> > in the context of process_mrelease(), avoiding delays caused by
> > non-deterministic scheduling of the victim task.
> 
> The memory is still reclaimed synchronously from the mrelease context.
> This is really confusing.
> 
> Please also explain why do you need to do all that ugly
> task_will_free_mem hoops. Why cannot you simply kill the task if
> task_will_free_mem fails (if PROCESS_MRELEASE_REAP_KILL is used).

I wanted to handle shared address spaces.
Even though we are okay with the target task not being in a SIGKILL
state yet (since we are about to kill it), we must ensure that all
*other* processes sharing the same mm are also dying.

If we simply bypass the check and force a kill when there are living sharers,
the memory will NOT be freed even after the target task dies because
the other processes still pin the mm.

So, to address this, I think we need to modify task_will_free_mem() slightly
to ignore the exit state of the *target* task only, while still checking that
all *other* sharing processes are dying:

static bool task_will_free_mem(struct task_struct *task, bool ignore_exit)
{
...
/* ignore tarket task's signal state */
if (!__task_will_free_mem(task, ignore_exit))
    return false;

/*
 * but other processes sharing the mm with target must be exit
 * state
 */
for_each_process(p) {
    ...
    if (!__task_will_free_mem(p, false))
	return false;
}
...
}
