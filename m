Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583CE3AF65C;
	Mon, 27 Apr 2026 23:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777331107; cv=none; b=pCin3HmqD0GEhO5mlrl77Vym0rYjj36gm9MMNRoUwKqsnmuuv+cmFAvscLzMmnPFGmMfrDL2xFpM/gbTcAF2Ihw9tuNc7vM50sQWGpUj9RWVj2Un8MgBrtwUzL97unDYOs+YCUD/HsT8vL6FVcH4gRMrFHCmEMlwVQ3tkdpl27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777331107; c=relaxed/simple;
	bh=9/lxmCbTq0AuSKOlbY/9CDJD0d3Oki7PkmDtgla38FY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CHkGe5gyCIBeAdXpIZ3D/CW7f9G2LHz/j2OxrdkTWBwih4ZBmaXv4U2SH7166wCRgF3vsDoIhJkA+gp4fbr9Ov5kqbEDFc1lyYmz/lZwJdyQuOUfZ4H5p1SgKV8ezehNO+jK+yP8QIGX9543a8KTBH60DI2D5uIL/lgJw7nzFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW8qPZfm; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW8qPZfm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5546DC19425;
	Mon, 27 Apr 2026 23:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777331106;
	bh=9/lxmCbTq0AuSKOlbY/9CDJD0d3Oki7PkmDtgla38FY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EW8qPZfmVV+XQo6RVCDq/833thfnwKy5CmXCtLZ4URnkYbYAVYxO62BCvwe4rcqiP
	 +kob29aRQ7egmjFSs5Png0XIByrIof4VJeOO/J3fPW4XWSz2yxcNNDd7m8ZwTPfHbX
	 cDPMDOHbZ661NTbJKGngmX0zL9mYJ5pmESfjoBzs2cWzXc5+aUtXnVy0hpDVekrWCC
	 wmEOq/4ER3XPep7q3M/mB/GmsC4na3rJSEkgtWK7p5q/MqysI+kWqS4tekpLfeNE8K
	 E5oIPGlnF890MC1RkFIuMMEAuaLYhE45FeOJROCxhbVNq2poZUarJg2k8PYTfDJIsG
	 5+c5B2wn1Hscw==
Date: Mon, 27 Apr 2026 16:05:04 -0700
From: Minchan Kim <minchan@kernel.org>
To: Michal Hocko <mhocko@suse.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <ae_roPR64e6sY_fN@google.com>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka>
 <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com>
 <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae-Zu-VAzAA7SdLa@tiehlicka>

On Mon, Apr 27, 2026 at 07:15:39PM +0200, Michal Hocko wrote:
> On Mon 27-04-26 09:48:28, Suren Baghdasaryan wrote:
> > On Mon, Apr 27, 2026 at 12:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > >
> > > On Fri 24-04-26 12:15:18, Minchan Kim wrote:
> > > > On Fri, Apr 24, 2026 at 09:57:16AM +0200, David Hildenbrand (Arm) wrote:
> > > > > On 4/24/26 09:51, Michal Hocko wrote:
> > > > > > On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> > > > > >> For the process_mrelease reclaim, skip LRU handling for exclusive
> > > > > >> file-backed folios since they will be freed soon so pointless
> > > > > >> to move around in the LRU.
> > > > > >>
> > > > > >> This avoids costly LRU movement which accounts for a significant portion
> > > > > >> of the time during unmap_page_range.
> > > > > >>
> > > > > >> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
> > > > > >>      exit_mm
> > > > > >>      __mmput
> > > > > >>      exit_mmap
> > > > > >>      unmap_vmas
> > > > > >>    - unmap_page_range
> > > > > >>       - 55.75% folio_mark_accessed
> > > > > >>          + 48.79% __folio_batch_add_and_move
> > > > > >>            4.23% workingset_activation
> > > > > >>       + 12.94% folio_remove_rmap_ptes
> > > > > >>       + 9.86% page_table_check_clear
> > > > > >>       + 3.34% tlb_flush_mmu
> > > > > >>         1.06% __page_table_check_pte_clear
> > > > > >>
> > > > > >> Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > >
> > > > > > As pointed out in the previous version of the patch. I really dislike
> > > > > > this to be mrelease or OOM specific. Behavior. You do not explain why
> > > > > > this needs to be this way, except for the performance reasons. My main
> > > > > > question is still unanswered (and NAK before this is sorted out). Why
> > > > > > this cannot be applied in general for _any_ exiting task. As you argue
> > > > > > the memory will just likely go away so why to bother?
> > > > >
> > > > > I think there was a lengthy discussion involving Johannes from a previous series.
> > > > >
> > > > > That should be linked here indeed.
> > > >
> > > > How about this?
> > > >
> > > >     mm: process_mrelease: skip LRU movement for exclusive file folios
> > > >
> > > >     During process_mrelease() or OOM reaping, unmapping file-backed folios
> > > >     spends a significant portion of CPU time in folio_mark_accessed() to
> > > >     maintain accurate LRU state (~55% of unmap time as shown in the profile
> > > >     below).
> > > >
> > > >     This patch skips LRU handling for exclusive file-backed folios during
> > > >     such emergency memory reclaim.
> > > >
> > > >     One might ask why this optimization shouldn't be applied to any exiting
> > > >     task in general. The reason is that for a normal, orderly exit or just
> > > >     pure kill, it is worth paying the CPU cost to preserve the active state
> > > >     of clean file folios in case they are reused soon. Preserving cache hits
> > > >     is beneficial for overall system performance.
> > >
> > > This is a statement rather than an explanation. Why is it worth paying
> > > the cost? What is different here?
> > >
> > > >     However, process_mrelease() and OOM reaping are emergency operations
> > > >     triggered under extreme memory pressure. In these scenarios, the highest
> > > >     priority is to recover memory as quickly as possible to avoid further
> > > >     kills or system jank. Spending half of the unmap time on LRU maintenance
> > > >     for pages belonging to a victim process is a bad trade-off. If speeding up
> > > >     the victim's reclaim by avoiding LRU movement and evicting cache negatively
> > > >     affects the workflow (due to immediate restart), it implies a sub-optimal
> > > >     kill target selection by the userspace policy (e.g., LMKD), rather than
> > > >     a problem in this expedited APIs.
> > >
> > > Your change effectively boils down to break aging for exclusively mapped
> > > file pages when those pages should have been activated. All that because
> > > the activation has some (batched) overhead. You argue that the overhead
> > > is not a good trade-off for OOM path because those pages are exclusive
> > > to the process and therefore they will go away after the task exits.
> > 
> > I think Minchan's argument is that mm reaping occurs only in special
> > conditions (under high memory pressure) and for a very specific reason
> > (to free up memory and prevent system memory starvation). Therefore
> > priority in such conditions should shift towards more aggressive
> > memory reclaim instead of normal aging. I can see both his point and a
> > counter-argument that this might cause more refaults in some cases.
> 
> The way I see this is that the standard memory reclaim under a heavy
> memory pressure would likely encounter those pages and aged them
> accordingly already. So this is effectivelly racing with that process
> and makes a potentially opposite decision.
> I suspect that a lack of memory reclaim, as implied by the other patch
> (to deal with clean page cache), is the reason why this one makes a
> difference in these Android deployments.

The claim that kswapd would have already aged these pages is just an
assumption; it is ultimately a matter of timing. We cannot reliably
predict whether kswapd has processed them, nor can we know the future
access patterns of a dying process.

Global system policies are not always optimal for every specific use case.
That is precisely why we have hinting APIs like madvise and fadvise.

While hinting APIs can indeed conflict with global policies, a negative
performance impact would imply that userspace is misusing the API, not
that the optimization itself shouldn't exist.

We should view process_mrelease() (and this flag) as a similar hinting
mechanism where userspace explicitly requests expedited, aggressive reclaim
for a specific target under memory pressure.

> 
> Unless I am completely wrong and misreading the whole situation this
> might be very Android specific change. The question is whether these
> side effects are generally useful for other worklods. So we really need
> much more explanation of the actual behavior after this change for wider
> variety of workloads.

While the primary motivation comes from Android's LMKD, this optimization
is not active for normal workloads. It only applies to tasks that are
already being reaped by the OOM reaper or by process_mrelease() with the
special flag (via MMF_UNSTABLE).

Therefore, it is an opt-in or emergency-only behavior that will not hurt
a wider variety of general workloads unless they explicitly use this
targeted reclaim API. Any system with a userspace killer needing fast,
targeted reclaim can benefit from this.
