Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6357B346FA6;
	Mon, 11 May 2026 21:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778535899; cv=none; b=Ra5U8U+sCBhx97Iw566CAltiskXYGtWqokhfeU720ZMxvmpQcGON87jTUWdrlUNQJm/ohKcNqyXz7TIVrRn3O9/1+HUghrPTIAXeiBIv7Vl4yDcEdZC2q88axRaLQ8U+t6WeBymbCAEjBGsY7srG2yy9ZxlLI9K1ZWFwWHRt/qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778535899; c=relaxed/simple;
	bh=98jBSuv1F1dX3cA80ejdn4ypbeO/KR79fZk6lhmH88w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Oqcqld8QleOQWo1+OE+uE1oQ5ARzEu3TPQLNFAoCYHmqBBdlcAz2Jqc9s2rzqEpAxBZ4KlyxemJj4wJO6UVjpnq3K7IORPaJrjSKZUnlKdJerLk1dhyzX2UjKBKsjWS/9AJSVyvPVtlS8wsA/GlRnjVruBxTtQaqgPbFGY8el5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SgfZFSsp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SgfZFSsp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3698C2BCB0;
	Mon, 11 May 2026 21:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778535899;
	bh=98jBSuv1F1dX3cA80ejdn4ypbeO/KR79fZk6lhmH88w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgfZFSspXJQBAZEi4MKR/S1lYPksnxNsXmino5liB6srPrI5oH4EP+fhkljfV2PiE
	 vBj/dhVGqD2qY5f4SkONzPfkE9PevxeG4UcF5EDIuvdLTCS/E4XiOepD7S41Mp2U4d
	 7wv252PbttjBnTrJeiOLyJEg9j+w0gXattS2wGdl8b0QEY9QkPHQNTLpiI8+ScApKM
	 AV77NZrrVyTUjT6Fz5RHHMlYWzALotYVXv6gzGTbLnbRIiOFYwrvCHCIHWWc3WdkF9
	 KlhnsJQsl4EylGyBivV9Kw3CeqmORud/bwRv4YWQSUEgtt+qYXXQ2sQ+D+nImjLxLs
	 gplP2SIDnwGrA==
Date: Mon, 11 May 2026 14:44:57 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Christian Brauner <brauner@kernel.org>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, david@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v2] mm: process_mrelease: introduce
 PROCESS_MRELEASE_REAP_KILL flag
Message-ID: <agJN2esiIGIhUlMG@google.com>
References: <20260429211359.3829683-1-minchan@kernel.org>
 <afMnKrYT0xG_a-b3@tiehlicka>
 <afUYfpwWsUQoB9hz@google.com>
 <afhQB0CWEcflXpOi@tiehlicka>
 <20260505-wegbleiben-deshalb-f929089dbdab@brauner>
 <afoUt3te1k2TNao-@tiehlicka>
 <afowD31YsGVdVUBP@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afowD31YsGVdVUBP@google.com>

On Tue, May 05, 2026 at 10:59:43AM -0700, Minchan Kim wrote:
> On Tue, May 05, 2026 at 06:03:03PM +0200, Michal Hocko wrote:
> > On Tue 05-05-26 11:30:22, Christian Brauner wrote:
> > > IIUC, then the OOM kill if invoked from the kernel just takes down
> > > without permission checking what it wants to take down. That makes a lot
> > > of sense and is mostly safe - after all it is the kernel that initiates
> > > the kill.
> > > 
> > > However, when userspace initiates the kill we need at least the
> > > semantics you proposed, Michal. You can only kill processes that you
> > > have the necessary privileges over otherwise you end up allowing to
> > > SIGKILL setuid binaries over which you hold no privileged possibly
> > > generating information leaks or worse.
> > 
> > Agreed!
> > 
> > > The other thing to keep in mind is that currently pidfds explicitly do
> > > not to allow to signal taks that are outside of their pid namespace
> > > hierarchy - see pidfd_send_signal()'s permission checking. I don't want
> > > to break these semantics - it's just very bad api design if signaling
> > > suddenly behaves differently and pidfd suddenly convey the ability to
> > > do a very wide signal scope.
> > 
> > Agreed!
> > 
> > > The other thing is that pidfds are handles that can be sent around using
> > > SCM_RIGHTS which means they could be forwarded to a container or another
> > > privileged user that then initiates kill semantics.
> > > 
> > > The other thing is that the type of pidfd selects the scope of the
> > > signaling operation:
> > > 
> > > * If the pidfd was created via PIDFD_THREAD then the scope of the signal
> > >   is by default the individual thread - unless the signal itself is
> > >   thread-group oriented ofc.
> > > 
> > > * If the pidfd was created wihout PIDFD_THREAD then the scope of the
> > >   signal is by default the thread-group.
> > > 
> > > * pidfd_send_signal() provides explicitly scope overrides:
> > > 
> > >   (1) PIDFD_SIGNAL_THREAD
> > >   (2) PIDFD_SIGNAL_THREAD_GROUP
> > >   (3) PIDFD_SIGNAL_PROCESS_GROUP
> > > 
> > >   The flags should be mostly self-explanatory.
> > > 
> > >   So I really dislike the idea of now letting the pidfd passed to
> > >   process_mrelease() to have an implicit scope suddenly. The problem is
> > >   that this is very opaque to userspace and introduces another way to
> > >   signal a group of processes.
> > 
> > I do see your point. Unfortunately the whole concept of mm shared
> > across thread (signal) groups is not fitting well into the overall
> > model. For the most usecases this is not a big problem. But oom handlers
> > do care. If you do not kill all owners of the mm you are not releasing
> > any memory.
> > 
> > > IOW, I still dislike the fact that process_mrelease() is suddenly turned
> > > into a signal sending syscall and I really dislike the fact that it
> > > implies a "kill everything with that mm and cross other thread-groups".
> > > 
> > > I wonder if you couldn't just add PIDFD_SIGNAL_MM_GROUP or something to
> > > pidfd_send_signal() instead.
> > 
> > That would be a clean interface for sure. The thing we are struggling
> > here is not just the killing side of things but also grabbing the mm
> > before it disappears which is the primary reason why process_mrelease is
> > turning into signal sending syscall (which you seem to be not in favor
> > of).
> > 
> > So I can see these options on the table
> > 1) keep process_mrelease as is and live with the race. This sucks
> > because it makes userspace low memory (oom) killers harder to predict.
> > 2) we add the proposed option to kill&release into process_mrelease that
> > is not aware of shared mm case. This sucks because it creates an easy
> > way to evade from the said oom killer
> > 3) same as 2 but add PIDFD_SIGNAL_MM_GROUP that would do the right thing
> > on the signal handling side. You seem to like the idea from the
> > pidfd_send_signal POV but I am not sure you are OK with that being
> > implanted into process_mrelease.
> 
> For 3, maybe something likle this?
> (Just to show the concept for further discussion)

Posted v3 - https://lore.kernel.org/linux-mm/20260511214226.937793-1-minchan@kernel.org/

Thank you.
