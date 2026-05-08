Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FF61DF75B;
	Fri,  8 May 2026 20:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778273855; cv=none; b=mdve11xRwgNPsFFH9Q1S1kfiFMfMjfuTLz0C8XNFbRQzmR1YabaM7cJfd4VvOjj33VYuUmUbtoEv5dFjSaCyzoOgL6SqIcd2AQPogFSjGXNZQM9YZYygf2T6tgFw3Dtl3umg3neU70Stxi6mi2xSluTX8KUJyiyXdnvcZ8TqIFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778273855; c=relaxed/simple;
	bh=6tsyJYfxilAusCSocB51kUZkp7E69qaKYWtBRFECzXs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Of29u1i/Lk1bsuualCscKhb9Ltpp2eXHaohzn1tyUnqLSPi7sq8mcEWO167xOsuHzAJZqQOsebexOltzCvGZrBpqY2BPJM5+DfG+QS4PNpJGwHTBikq3+6d3Hh9/rMwL+0iLSFaNvr5GO/FV0wrToEiXfcGBJxnVy09B+xRsqPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=dVjdGo1W; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dVjdGo1W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=mu8daim6qkcaeD6OUpYjQtJ/V2hKZECcF7+XQco/y+o=; b=dVjdGo1W+YqvAgdP/RzAqBIFIE
	S7PuZ1jYjDbsjnOIUcYBZeQl1zUPvNBz+Q7B7iHt3F2LRKZbLV9nZ1Kr5ocUh3TRqYuMkmqXQrZpr
	2FXeNgegJCfy9yq17MmHgnSCJOvgVXFivFQMDnUBmZuxju84WovJBsGnbRjlAVd6guDPMIsks8ZKx
	RbmBoiNFmyPfuIThUtGeqknQoGTuW7RsQFua9OAaSUL+6Rcn68hUTLAWtBZJA5YpAFcKR8eIpNM1S
	1RRrsvg1pa8dmWgWeA/QQfqLH8jDXtkAYdudncw5hToS+HDomPyvyvJYqsOPeZ0Qz7I/8olqKKMRZ
	xfvN/SWA==;
Received: from [38.23.173.23] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wLSGI-00000007VHt-3YCB;
	Fri, 08 May 2026 20:57:31 +0000
Date: Fri, 8 May 2026 22:57:31 +0200
From: "Liam R. Howlett" <liam@infradead.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Minchan Kim <minchan@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org, hca@linux.ibm.com, 
	linux-s390@vger.kernel.org, brauner@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, timmurray@google.com, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <7g5g57jbll5joujbwjb4osqhdwqd4yzc54wmoi7ftx4a4chuax@xtxyljtqaodp>
References: <ae-Zu-VAzAA7SdLa@tiehlicka>
 <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka>
 <afFco71vwmpQy3pk@google.com>
 <afG-4hq7Hr62Uu6J@tiehlicka>
 <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>
 <afHeXY-yeTwmURWh@tiehlicka>
 <4a612d63-2838-40f5-ab67-79bf35dd3a56@kernel.org>
 <afIZQOtaBabeHtCc@tiehlicka>
 <b2d9fe2b-abb0-49d1-8056-ac93aa232bbb@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b2d9fe2b-abb0-49d1-8056-ac93aa232bbb@kernel.org>

On 26/04/30 08:08AM, David Hildenbrand (Arm) wrote:
> On 4/29/26 16:44, Michal Hocko wrote:
> > On Wed 29-04-26 15:07:04, David Hildenbrand wrote:
> >> On 4/29/26 12:33, Michal Hocko wrote:
> >>>
> >>> While the oom is the only current kernel user of MMF_UNSTABLE (in a
> >>> sense it sets the flag) the flag should denote that any page faults are
> >>> reliable because it might fault in a fresh memory and user would lose
> >>> the previous content without knowing that. Not sure MMF_OOM_REAPING
> >>> would reflect that reality better.
> >>
> >> We use it for failed fork() as well, but that's slightly different semantics (no
> >> real page faults ever made sense).
> 
> Well, there is a difference: a failed-fork process was never scheduled and will
> never get scheduled.
> 
> In fact, we added the MMF_UNSTABLE to the fork path in
> 
> commit 64c37e134b120fb462fb4a80694bfb8e7be77b14
> Author: Liam R. Howlett <liam@infradead.org>
> Date:   Mon Jan 27 12:02:21 2025 -0500
> 
>     kernel: be more careful about dup_mmap() failures and uprobe registering
> 
>     If a memory allocation fails during dup_mmap(), the maple tree can be left
>     in an unsafe state for other iterators besides the exit path.  All the
>     locks are dropped before the exit_mmap() call (in mm/mmap.c), but the
>     incomplete mm_struct can be reached through (at least) the rmap finding
>     the vmas which have a pointer back to the mm_struct.
> 
>     Up to this point, there have been no issues with being able to find an
>     mm_struct that was only partially initialised.  Syzbot was able to make
>     the incomplete mm_struct fail with recent forking changes, so it has been
>     proven unsafe to use the mm_struct that hasn't been initialised, as
>     referenced in the link below.
> 
>     Although 8ac662f5da19f ("fork: avoid inappropriate uprobe access to
>     invalid mm") fixed the uprobe access, it does not completely remove the
>     race.
> 
>     This patch sets the MMF_OOM_SKIP to avoid the iteration of the vmas on the
>     oom side (even though this is extremely unlikely to be selected as an oom
>     victim in the race window), and sets MMF_UNSTABLE to avoid other potential
>     users from using a partially initialised mm_struct.
> 
> Which was later changed in
> 
> commit 43873af772f8138c5cb4b76dde9c26339e89be3b
> Author: Liam R. Howlett <liam@infradead.org>
> Date:   Wed Jan 21 11:49:42 2026 -0500
> 
>     mm: change dup_mmap() recovery
> 
>     When the dup_mmap() fails during the vma duplication or setup, don't write
>     the XA_ZERO entry in the vma tree.  Instead, destroy the tree and free the
>     new resources, leaving an empty vma tree.
> 
>     Using XA_ZERO introduced races where the vma could be found between
>     dup_mmap() dropping all locks and exit_mmap() taking the locks.  The race
>     can occur because the mm can be reached through the other trees via
>     successfully copied vmas and other methods such as the swapoff code.
> ...
> 
> and I am not sure if MMF_UNSTABLE is still required, as we don't leave these
> stale VMA copies in the maple tree.
> 
> The process might just look like just another process that is getting torn down now.
> 
> But we'd have to learn from Liam :)

Yes, it will be a zero entry tree now.

I left the flag to indicate that it's an unstable mm, not for faulting
in but to be skipped in OOM events and process_mrelease since neither
should bother doing anything in the window between the dup_mm() failure
and the exit_mmap() window where the write lock was dropped.

We can safely drop the flag now if you want to, because everything has
to deal with an empty vma tree anyways - a race can occur between a call
to unmap everything and the task seg faulting.

> 
> 
> > 
> > The bottom line is the same. Make sure PF fails rather than silently
> > provide potentially corrupted data.
> > 
> >> Looking at the original patch here, using MMF_OOM_REAPING to modify zapping
> >> behavior would be clearer than MMF_UNSTABLE, I guess.
> > 
> > Ohh, you mean to add a new flag, right?
> 
> We could do that as well, if it's of any help.

I really think this goes back to the life cycle of the mm being somewhat
difficult to figure out.  I'm fine with another flag.

Thanks,
Liam

