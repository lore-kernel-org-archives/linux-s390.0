Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E010329C71;
	Tue,  5 May 2026 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777973431; cv=none; b=aizbw/BtZyB5JmutYWt4ciBwhi9hMgsJG+t1QBUv3W+40ex6BstV+pcRiVaaxg3fGFNmdKj85nrUy6kwddVGobFr7IqNjXx59HMTqW9lwTjRKZYqAzBzhBYSdQVJvnV1RhklGQ7PDwTw+5j52rgJ3C7aEdLgVOLbCGQhk9aJTEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777973431; c=relaxed/simple;
	bh=QUEqaKOiHh1ZOxaKg3KfDUXaatpEkTtgP1z5oeVjDEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=smFfAYYXrbwUZ5JVtpA0bC6Ig2jiT7ock7LVSj8sm4d/Z7qLA0WLU3hFwDzeggiPaaEmvuWsr7SAMbsmtbZ9sSfYx4rt41V8JCYQ8ZVwotxIzvxSSsFjT6nvY47xYdxqTM/UH/zgfffUT0wqKEEaN7Bs84TLHZrDYnZ0F5URjvM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kNjDGJ1Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kNjDGJ1Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A312FC2BCB4;
	Tue,  5 May 2026 09:30:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777973431;
	bh=QUEqaKOiHh1ZOxaKg3KfDUXaatpEkTtgP1z5oeVjDEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kNjDGJ1Z9jqR1AtJaHLz3UVwRtXa8wKRn+8Z9ABA+bP9K3b3UlQsZfV3KaB9xXUrD
	 tmA+fj7ZuWJ/HHF5+lYbinlXCbgP6C2pJQBYysbOsyawOhvsP2og3vA+D3ZQmGXL46
	 pGnVL2EBxZKnvUV82LohPKjuVV+r6/1uK5EbByOf0nAF87KWiSaE8MAod56uaqQQcZ
	 o9lhCctY4vS/HenHDEzGg0SDg1UfZckSXLnmSQDL3OY36jWIhIcPRcecCiBMb/PhCr
	 NmIzyqEmW2pEwY9z8JzF/4kIV4dztCCztn0hLL9CbfkzSQwSf0zLmK9I2Fk6L1IXTZ
	 vjukxG7XLahGQ==
Date: Tue, 5 May 2026 11:30:22 +0200
From: Christian Brauner <brauner@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Minchan Kim <minchan@kernel.org>, akpm@linux-foundation.org, 
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, surenb@google.com, timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <20260505-wegbleiben-deshalb-f929089dbdab@brauner>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
 <afhQB0CWEcflXpOi@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <afhQB0CWEcflXpOi@tiehlicka>

On Mon, May 04, 2026 at 09:51:35AM +0200, Michal Hocko wrote:
> On Fri 01-05-26 14:17:50, Minchan Kim wrote:
> > On Thu, Apr 30, 2026 at 11:55:54AM +0200, Michal Hocko wrote:
> > > On Wed 29-04-26 14:13:59, Minchan Kim wrote:
> > > > This policy differs from the global OOM killer, which kills all processes
> > > > sharing the same mm to guarantee memory reclamation at all costs (preventing
> > > > system hangs).
> > > 
> > > Incorrect, we do the same for memcg OOM killer as well. This is not
> > > about preventing system hands. But rather to 
> > > 
> > > > However, process_mrelease() is invoked by userspace policy.
> > > > If it fails due to sharing, userspace can simply adapt and select another
> > > > victim process (such as another background app in Android case) to release
> > > > memory. We do not need to force success or affect processes that were not
> > > > targeted.
> > > 
> > > This is a wrong justification for the proposed semantic. You seem to be
> > > assuming this is just fine rather than this would be problematic for
> > > reasons a), b) and c). If there are no strong reasons _against_
> > > following the global policy then we should stick with it. There are very
> > > good reasons why we are doing that on the global level.
> > > 
> > > If for no other reasons then the proposed semantic severly criples the
> > > shared MM case. You are left with a racy kill and call process_mrelease
> > > approach. You certainly do not want to allow a simple way for tasks to
> > > evade your LMK, do you? So just choose something else is a very bad
> > > approach.
> > > 
> > > So unless you are aware of a specific reason(s) where collective kill is a
> > > clearly an incorrect behavior then I believe the proper way is to kill
> > > all processes sharing the mm (unless you are crossing any security
> > > boundary when doing that).
> > 
> > I agree that in the case of a global or memcg OOM, the kernel deals with an
> > emergency, system-wide crisis where killing all sibling processes sharing
> > the same mm is an absolute necessity for system survival, bypassing
> > user-space privilege screening.
> 
> You are misinterpreting or missing my point. I am not suggesting to
> cross privilege boundaries. The syscall should fail if the mm is shared
> with tasks the caller cannot kill (same as it does now).
> 
> > However, process_mrelease() is an explicit user-space initiated system call,
> > and I am still hesitant to place that same raw, destructive policy blindly
> > at the UAPI syscall level even though I don't know of any known security
> > issues right now.
> 
> This is very wrong argument to introduce a potentially crippled syscall
> semantic.
>  
> > If we really want to go that way for the collective kill, at least, we should
> > evaluate signal authorization (kill permission) against *every single*
> > sibling process beforehand instead of only the target task of
> > process_mrelease. Do you agree?
> 
> This is what I've proposed already.
> 
> > Also, I wonder what the signal/process maintainer thinks about this approach.
> > Christian Brauner <brauner@kernel.org>?
> 
> Yes, this makes sense. There might be a very good reason why we might
> not want to introduce a way to kill cross thread groups when they share
> mm from userspace. I do not see any as long as you keep the proper
> permissions for all affected tasks. Maybe we cannot do that sanely now.
> But these reasons have to be properly documented. You whole argument
> that this is different from in-kernel oom killing is just not valid.

IIUC, then the OOM kill if invoked from the kernel just takes down
without permission checking what it wants to take down. That makes a lot
of sense and is mostly safe - after all it is the kernel that initiates
the kill.

However, when userspace initiates the kill we need at least the
semantics you proposed, Michal. You can only kill processes that you
have the necessary privileges over otherwise you end up allowing to
SIGKILL setuid binaries over which you hold no privileged possibly
generating information leaks or worse.

The other thing to keep in mind is that currently pidfds explicitly do
not to allow to signal taks that are outside of their pid namespace
hierarchy - see pidfd_send_signal()'s permission checking. I don't want
to break these semantics - it's just very bad api design if signaling
suddenly behaves differently and pidfd suddenly convey the ability to
do a very wide signal scope.

The other thing is that pidfds are handles that can be sent around using
SCM_RIGHTS which means they could be forwarded to a container or another
privileged user that then initiates kill semantics.

The other thing is that the type of pidfd selects the scope of the
signaling operation:

* If the pidfd was created via PIDFD_THREAD then the scope of the signal
  is by default the individual thread - unless the signal itself is
  thread-group oriented ofc.

* If the pidfd was created wihout PIDFD_THREAD then the scope of the
  signal is by default the thread-group.

* pidfd_send_signal() provides explicitly scope overrides:

  (1) PIDFD_SIGNAL_THREAD
  (2) PIDFD_SIGNAL_THREAD_GROUP
  (3) PIDFD_SIGNAL_PROCESS_GROUP

  The flags should be mostly self-explanatory.

  So I really dislike the idea of now letting the pidfd passed to
  process_mrelease() to have an implicit scope suddenly. The problem is
  that this is very opaque to userspace and introduces another way to
  signal a group of processes.

IOW, I still dislike the fact that process_mrelease() is suddenly turned
into a signal sending syscall and I really dislike the fact that it
implies a "kill everything with that mm and cross other thread-groups".

I wonder if you couldn't just add PIDFD_SIGNAL_MM_GROUP or something to
pidfd_send_signal() instead.
