Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA95A272816
	for <linux-s390@vger.kernel.org>; Tue, 28 Apr 2026 06:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777359402; cv=none; b=TR2pyr/GiOdLUesNr8PIMDHQk9X17u2ihPnsIXjGlMQ28dP/gFUDyOzV5Vmtfd7QRQEzff9KCrcQ2qtlBl63xBUBL1C+QNJNywwd9lwfwQ9N+arciRDbsiwAL1IYyjhTln6AaxjyWUI6aXQazAbFh0R+e94s9FbqNlGfYLvBbHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777359402; c=relaxed/simple;
	bh=XM6c2bBRSFiMXvLPiY32qmO4PATP49IWoaPizvFZ9cw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rNTHQbhUWolDGnAdbinrk2FXZ7awvNwfVrPYlcnxy30MOY3ZIDmRor8Nr8G98ikaMKFlgpG2iOo40X8SnoFutJRIHkWfQA7qZ/wNDE4SvHEgIeV5ZJE51hWnHsHrMyfWQ/VXE/Cc+SDm4AVGWger49T/DDcIVfA0fYltojqJyXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Ftc62kuw; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Ftc62kuw"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-43eb012ac4fso6615889f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777359398; x=1777964198; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=B20i2WYVNCTtPC1H0a1XPOVbe8oJoCNkE6Fhoj7KHNQ=;
        b=Ftc62kuw5h2qi5dWX4P5cEALWNCB3wEa6JYmVJUQMPOyM6QsoVFb7kRgBpeEONzPQ1
         P7ovyeg6FnhD3es6cpeRabHqDQo0fg/yR2larbGtcGA6x5mOawRCsqAqQkQTu4iv72Tf
         C50OGPv7TCTwIMaqu++0Uvbdy8ok6MqVedI+Rsuil6prPQ5LhgrYFQif9AwycXvteX+Z
         it7jKISrUS/UproyzuE7qxyVw+Cek4fh2Ik+3gTIs4RfjNzVlu/uWroXllFI8RJSS7hT
         jx5moydJcpnGfiYBH9+3+hGL+GQVvC6p5R1gjXCpoxNkAlpPvFwdDbl7NIpI7gipuAix
         KRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777359398; x=1777964198;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B20i2WYVNCTtPC1H0a1XPOVbe8oJoCNkE6Fhoj7KHNQ=;
        b=oqS6VRkRyP5ACQTvn+9d6cT3JFYlOsU31OTRua9gSX5IeECtVqO1H46fGmvsyII2I5
         UqHvj4K9HJNmYs5c+fRDW4QZkwbzAXRFnvr1i3vy83lcrcs8jBQrvTHZde2lei093qd6
         y/HJO+cUObixoWCIbj0nu1AsvhqTbtMuM6volOfU5P5HC5S2dv/y2zIq4kdAC+z52syu
         CNWr3hfadtu7UDmig82y3krAMHt+Bn/zG0yHWXo8JK3W9JMw6TTwHHxryvez6h75E0Vn
         gr7jwTjIPgTWPeU0eJXBn6NpXNH0sNhTf4fXDvmiQk3fZDOp+W+M8RkNeU3k35bD6dmm
         7lTQ==
X-Forwarded-Encrypted: i=1; AFNElJ/AuOPyyQtBMTbNzHAoC2hUEsKLAskfeIVlKJU8yFqOIzTi8pchdhC9oQnwRLJtqibSAcfDe8uHJdXS@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3PybDvErcgDDyUcwAdwI2ipPuwFbnqnOrALlPPz7K6s2MWvaQ
	8xtuvj/OW9e0YxrcYxnBP5RuJMA8dBJnqh9ZUGOHBA+UBJI/jJg6aPeGrzOJZTreTwA=
X-Gm-Gg: AeBDievZ/09CR33RCg6/JPA+CqlY76AlLk/3GlBXoZgmcXXxQ/deAH9uLSFL+fX2kSE
	yhJQkGib7vayBVu2qOIKaFeyOoIcOUKW8FVkd1bcyLIwJz7z9slSgu7nLhRQ3Wq1zdPbYtSsvqx
	AWWLkPKb7uHl57d9Ih4dqaSsowKdRtDMuDvUUZGd/zFFzUZnNRKdftGK1xrLYX6WMdI5YK78heq
	3ZOxrGp2ceZitrWKMUN64ke8DJRjINEqapMZDJHZceXj2nwKaAbNOP/Wvb9MZ8tJMDZn+9VcVrj
	kqRW60c6/uHBr33qxgLH3Azf5yCZQtxFKwCQify1OuonwcsTFQR0zZLJfNlRigncQw/TMbLx0xe
	dTjP8q4a6H3V66KMG2ehxtvEIKVshIWi3hIr47TudRwYZyhqMyE1mvXADSeBaLZBRUhATXCZxpi
	o7LG4cy0oriqtskgj4eBGUCsp5e0DmrGOxe1IUX+zc68NM/Xs=
X-Received: by 2002:a05:6000:2511:b0:43d:73d4:b34 with SMTP id ffacd0b85a97d-44647dd1544mr3185020f8f.16.1777359397775;
        Mon, 27 Apr 2026 23:56:37 -0700 (PDT)
Received: from localhost (109-81-17-171.rct.o2.cz. [109.81.17.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4463f5b50c1sm3831876f8f.17.2026.04.27.23.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 23:56:37 -0700 (PDT)
Date: Tue, 28 Apr 2026 08:56:36 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: Suren Baghdasaryan <surenb@google.com>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <afBaJLLFigkdszov@tiehlicka>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka>
 <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com>
 <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka>
 <ae_roPR64e6sY_fN@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ae_roPR64e6sY_fN@google.com>

On Mon 27-04-26 16:05:04, Minchan Kim wrote:
> On Mon, Apr 27, 2026 at 07:15:39PM +0200, Michal Hocko wrote:
> > On Mon 27-04-26 09:48:28, Suren Baghdasaryan wrote:
> > > On Mon, Apr 27, 2026 at 12:16 AM Michal Hocko <mhocko@suse.com> wrote:
> > > >
> > > > On Fri 24-04-26 12:15:18, Minchan Kim wrote:
> > > > > On Fri, Apr 24, 2026 at 09:57:16AM +0200, David Hildenbrand (Arm) wrote:
> > > > > > On 4/24/26 09:51, Michal Hocko wrote:
> > > > > > > On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> > > > > > >> For the process_mrelease reclaim, skip LRU handling for exclusive
> > > > > > >> file-backed folios since they will be freed soon so pointless
> > > > > > >> to move around in the LRU.
> > > > > > >>
> > > > > > >> This avoids costly LRU movement which accounts for a significant portion
> > > > > > >> of the time during unmap_page_range.
> > > > > > >>
> > > > > > >> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
> > > > > > >>      exit_mm
> > > > > > >>      __mmput
> > > > > > >>      exit_mmap
> > > > > > >>      unmap_vmas
> > > > > > >>    - unmap_page_range
> > > > > > >>       - 55.75% folio_mark_accessed
> > > > > > >>          + 48.79% __folio_batch_add_and_move
> > > > > > >>            4.23% workingset_activation
> > > > > > >>       + 12.94% folio_remove_rmap_ptes
> > > > > > >>       + 9.86% page_table_check_clear
> > > > > > >>       + 3.34% tlb_flush_mmu
> > > > > > >>         1.06% __page_table_check_pte_clear
> > > > > > >>
> > > > > > >> Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > > > >
> > > > > > > As pointed out in the previous version of the patch. I really dislike
> > > > > > > this to be mrelease or OOM specific. Behavior. You do not explain why
> > > > > > > this needs to be this way, except for the performance reasons. My main
> > > > > > > question is still unanswered (and NAK before this is sorted out). Why
> > > > > > > this cannot be applied in general for _any_ exiting task. As you argue
> > > > > > > the memory will just likely go away so why to bother?
> > > > > >
> > > > > > I think there was a lengthy discussion involving Johannes from a previous series.
> > > > > >
> > > > > > That should be linked here indeed.
> > > > >
> > > > > How about this?
> > > > >
> > > > >     mm: process_mrelease: skip LRU movement for exclusive file folios
> > > > >
> > > > >     During process_mrelease() or OOM reaping, unmapping file-backed folios
> > > > >     spends a significant portion of CPU time in folio_mark_accessed() to
> > > > >     maintain accurate LRU state (~55% of unmap time as shown in the profile
> > > > >     below).
> > > > >
> > > > >     This patch skips LRU handling for exclusive file-backed folios during
> > > > >     such emergency memory reclaim.
> > > > >
> > > > >     One might ask why this optimization shouldn't be applied to any exiting
> > > > >     task in general. The reason is that for a normal, orderly exit or just
> > > > >     pure kill, it is worth paying the CPU cost to preserve the active state
> > > > >     of clean file folios in case they are reused soon. Preserving cache hits
> > > > >     is beneficial for overall system performance.
> > > >
> > > > This is a statement rather than an explanation. Why is it worth paying
> > > > the cost? What is different here?
> > > >
> > > > >     However, process_mrelease() and OOM reaping are emergency operations
> > > > >     triggered under extreme memory pressure. In these scenarios, the highest
> > > > >     priority is to recover memory as quickly as possible to avoid further
> > > > >     kills or system jank. Spending half of the unmap time on LRU maintenance
> > > > >     for pages belonging to a victim process is a bad trade-off. If speeding up
> > > > >     the victim's reclaim by avoiding LRU movement and evicting cache negatively
> > > > >     affects the workflow (due to immediate restart), it implies a sub-optimal
> > > > >     kill target selection by the userspace policy (e.g., LMKD), rather than
> > > > >     a problem in this expedited APIs.
> > > >
> > > > Your change effectively boils down to break aging for exclusively mapped
> > > > file pages when those pages should have been activated. All that because
> > > > the activation has some (batched) overhead. You argue that the overhead
> > > > is not a good trade-off for OOM path because those pages are exclusive
> > > > to the process and therefore they will go away after the task exits.
> > > 
> > > I think Minchan's argument is that mm reaping occurs only in special
> > > conditions (under high memory pressure) and for a very specific reason
> > > (to free up memory and prevent system memory starvation). Therefore
> > > priority in such conditions should shift towards more aggressive
> > > memory reclaim instead of normal aging. I can see both his point and a
> > > counter-argument that this might cause more refaults in some cases.
> > 
> > The way I see this is that the standard memory reclaim under a heavy
> > memory pressure would likely encounter those pages and aged them
> > accordingly already. So this is effectivelly racing with that process
> > and makes a potentially opposite decision.
> > I suspect that a lack of memory reclaim, as implied by the other patch
> > (to deal with clean page cache), is the reason why this one makes a
> > difference in these Android deployments.
> 
> The claim that kswapd would have already aged these pages is just an
> assumption; it is ultimately a matter of timing. We cannot reliably
> predict whether kswapd has processed them, nor can we know the future
> access patterns of a dying process.
> 
> Global system policies are not always optimal for every specific use case.
> That is precisely why we have hinting APIs like madvise and fadvise.
> 
> While hinting APIs can indeed conflict with global policies, a negative
> performance impact would imply that userspace is misusing the API, not
> that the optimization itself shouldn't exist.
> 
> We should view process_mrelease() (and this flag) as a similar hinting
> mechanism where userspace explicitly requests expedited, aggressive reclaim
> for a specific target under memory pressure.

This is you bending definition of what process_mrelease is. And I
disagree. There is nothing about aggressiveness for process_mrelease.
There are no aging assumptions. We do not have an official man page but
this is from the initial comment introducing the syscall
        DESCRIPTION
          The process_mrelease() system call is used to free the memory of
          an exiting process.

          The pidfd selects the process referred to by the PID file
          descriptor.
          (See pidfd_open(2) for further information)

          The flags argument is reserved for future use; currently, this
          argument must be specified as 0.

Userspace oom killers are one obvious users of the interface.

> > Unless I am completely wrong and misreading the whole situation this
> > might be very Android specific change. The question is whether these
> > side effects are generally useful for other worklods. So we really need
> > much more explanation of the actual behavior after this change for wider
> > variety of workloads.
> 
> While the primary motivation comes from Android's LMKD, this optimization
> is not active for normal workloads. It only applies to tasks that are
> already being reaped by the OOM reaper or by process_mrelease() with the
> special flag (via MMF_UNSTABLE).
> 
> Therefore, it is an opt-in or emergency-only behavior that will not hurt
> a wider variety of general workloads unless they explicitly use this
> targeted reclaim API. Any system with a userspace killer needing fast,
> targeted reclaim can benefit from this.

But any user of this interface will see side effects of your
implementation.

Look, you haven't convinced me that you are fully aware of all the
consequences. Your arguments are weak and you seem to be uninterested
about usecases beyond your specific Android LMK implementation.

So I am not in support of this change, same as with the page cache one.
Again, I am NOT NAKing this patch but I do insist a) the patch
description is damn clear about side effects and b) there is a support
from other non-Android people using this syscall.
-- 
Michal Hocko
SUSE Labs
