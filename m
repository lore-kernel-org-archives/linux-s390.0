Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB43E3155
	for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777310144; cv=none; b=OAOfVl3yNTFhjTmS+xwxBd40Z+bkvwrlMA5nHX+GYvmCT8QJDkItLdcd5uDJ0kn0qzkoGiRjNl+6SxpHFwlk4ecA7hMIlZO64bZl+2VHEInrQDQbQqjUlXuWqNkrpvRzwx2BO+evlWyITLzBFMRHCRiiL2DRHvoX9n6Dgy+vreU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777310144; c=relaxed/simple;
	bh=s0af02J+z4NlGCzLW0iDW47CFY1FgXU+vDi//9QFJvQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WWGJamvbQhdpikMLUrW71V9Z2wXbdZiADH920FDzIqGc1AF61l5HmM0LsI33fm/Gg/LfIKgMwJyHCmwSxGvbMpJZZd0LHtRbyn87Jz1Z3XEJk6tO11kYyRlCsuQbBzheSBFKQTvr2SjQG3p6uCMrCaIicgkqUaEV26ktwHDU7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=LbjeuAeq; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="LbjeuAeq"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-488e1a8ac40so130237035e9.2
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 10:15:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777310140; x=1777914940; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AakHsZlEQE9Rq1pnBFm3m7E9zfrXxQ6QJvrADxUHjrg=;
        b=LbjeuAeqYh7xDZ+cRFIfRPLCYEB2fnnrCRROr7V1yqx7Ed5rhXmvMU5FE+NlxvdPao
         OXl0py5NlblOJpoeQUb/1NzJnm3WIELEHRdivlRSGs1iOSIpWbAjYFHb4a4ToW8356Fw
         86e6In1qSdGylJY7mD6oF1Y+JfQ1f5t29Bh8paKwdZR3cYJMTZr/Ddh8gLVokLlxdQ+I
         L28qKjdiXYw/lD9typAVA4RvMELDiCe83+s7vMB0Dozdy04CVdhiN4w4NgVmOTE3Q9ks
         7ZGze02iEhofYuVTZalxp2D3yfNqOv1U3MzHLkyp2r3TlZ7cCbuXnWnAPlw2f/rHRD0D
         OpJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777310140; x=1777914940;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AakHsZlEQE9Rq1pnBFm3m7E9zfrXxQ6QJvrADxUHjrg=;
        b=fhGM8RyhoFer8g0G9AiI+XwI7OMvlwnyD3lTwk0oANC0SNefHmy8Wx+77WaVcXhV5z
         +94td/xVF9aKxZ/P7LrAc7Td5Ca+M0xczHeOlXCNvftToOfj97dPEtgonaEoWZPQuEBF
         fi//5DEHorPS97GHN2Tp9XUK9hO4zbw4FsVWxoW49G0m//FDmP1fp20VnqmRnaMn7vSN
         kFKFhHE9Bf3E5HvOfL00J1TdtmYyPMdGvdBh/vPcKXI6DnNBKwFblUA4pU4N0bVpZ0V8
         Q2A9yBV5nwCG6itthgMDa3CP+VgMhPqvyS+g+FEsn/7XoY+vxSujkLrThvQUH76tiUSo
         fJKw==
X-Forwarded-Encrypted: i=1; AFNElJ9Bj2J5MTv+P8wngu20qRgFYCfN8gIU969JJzQGrs7ubCBObacBW0VSRTzthPiEAgakxnI3gsfi7P2k@vger.kernel.org
X-Gm-Message-State: AOJu0YxFC2TuxtAdGGtMEIS+3RgYqJebBW+q36qpz2mudSuA6MWntPMn
	1a2bCOdeukP0o89GJWcyqvCNjbj6JfrxvzKdZ33609ogvsWs6AhQKdko3yS2CHlu/ho=
X-Gm-Gg: AeBDieveL9cB1gP4rSSfP8S+WOl8qQwDzVgSRSjw0kI1qNessgrRUw6DxTR6TB0djUa
	VK2Yc1h3/KWNEEiWSEZFFwOuA54QKxUPXtGytVVrgxU9IVRE/TbmKigIDEOnHRuCq/ZoqmTLqba
	VeNzF4HmY3dhmCtZxLvz5ek1fYEw4Rrs8zlAWDFLnPhsUjdCR+fn18l6A1V4qABr6rVfQ7CV2g2
	E5fMn9Sib9kk69rUIkihT/d+7BoYxT8bGpEJ5ZceArmP6Onzl6tGjAUx3OZvBmuBs9k1gtV5lwF
	YuBDkOtMS9WRGFU9Ciz9bs4y0qIHMSD7jMJImP8fMSQJQFB8+sHAmZJayBJxJF+2lrRzmTZJ8xw
	UOTGzqlT9Y2XVeEJ7zJJZlFWjVf+YQdVlNu5p/xObx6/yFnqsG0Zr2h+OD9l1L6UWikH9iaQHnR
	b1g9KY13y+3LtyM2uMHL/Snojuy5at3GkuslfxBGp7j6xexM4=
X-Received: by 2002:a05:6000:2902:b0:43d:77a8:3baa with SMTP id ffacd0b85a97d-43fe3dc551dmr69959006f8f.3.1777310140368;
        Mon, 27 Apr 2026 10:15:40 -0700 (PDT)
Received: from localhost (109-81-17-171.rct.o2.cz. [109.81.17.171])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44123d23e0bsm41748981f8f.15.2026.04.27.10.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 10:15:40 -0700 (PDT)
Date: Mon, 27 Apr 2026 19:15:39 +0200
From: Michal Hocko <mhocko@suse.com>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Minchan Kim <minchan@kernel.org>,
	"David Hildenbrand (Arm)" <david@kernel.org>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <ae-Zu-VAzAA7SdLa@tiehlicka>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka>
 <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com>
 <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>

On Mon 27-04-26 09:48:28, Suren Baghdasaryan wrote:
> On Mon, Apr 27, 2026 at 12:16 AM Michal Hocko <mhocko@suse.com> wrote:
> >
> > On Fri 24-04-26 12:15:18, Minchan Kim wrote:
> > > On Fri, Apr 24, 2026 at 09:57:16AM +0200, David Hildenbrand (Arm) wrote:
> > > > On 4/24/26 09:51, Michal Hocko wrote:
> > > > > On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> > > > >> For the process_mrelease reclaim, skip LRU handling for exclusive
> > > > >> file-backed folios since they will be freed soon so pointless
> > > > >> to move around in the LRU.
> > > > >>
> > > > >> This avoids costly LRU movement which accounts for a significant portion
> > > > >> of the time during unmap_page_range.
> > > > >>
> > > > >> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
> > > > >>      exit_mm
> > > > >>      __mmput
> > > > >>      exit_mmap
> > > > >>      unmap_vmas
> > > > >>    - unmap_page_range
> > > > >>       - 55.75% folio_mark_accessed
> > > > >>          + 48.79% __folio_batch_add_and_move
> > > > >>            4.23% workingset_activation
> > > > >>       + 12.94% folio_remove_rmap_ptes
> > > > >>       + 9.86% page_table_check_clear
> > > > >>       + 3.34% tlb_flush_mmu
> > > > >>         1.06% __page_table_check_pte_clear
> > > > >>
> > > > >> Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > > >
> > > > > As pointed out in the previous version of the patch. I really dislike
> > > > > this to be mrelease or OOM specific. Behavior. You do not explain why
> > > > > this needs to be this way, except for the performance reasons. My main
> > > > > question is still unanswered (and NAK before this is sorted out). Why
> > > > > this cannot be applied in general for _any_ exiting task. As you argue
> > > > > the memory will just likely go away so why to bother?
> > > >
> > > > I think there was a lengthy discussion involving Johannes from a previous series.
> > > >
> > > > That should be linked here indeed.
> > >
> > > How about this?
> > >
> > >     mm: process_mrelease: skip LRU movement for exclusive file folios
> > >
> > >     During process_mrelease() or OOM reaping, unmapping file-backed folios
> > >     spends a significant portion of CPU time in folio_mark_accessed() to
> > >     maintain accurate LRU state (~55% of unmap time as shown in the profile
> > >     below).
> > >
> > >     This patch skips LRU handling for exclusive file-backed folios during
> > >     such emergency memory reclaim.
> > >
> > >     One might ask why this optimization shouldn't be applied to any exiting
> > >     task in general. The reason is that for a normal, orderly exit or just
> > >     pure kill, it is worth paying the CPU cost to preserve the active state
> > >     of clean file folios in case they are reused soon. Preserving cache hits
> > >     is beneficial for overall system performance.
> >
> > This is a statement rather than an explanation. Why is it worth paying
> > the cost? What is different here?
> >
> > >     However, process_mrelease() and OOM reaping are emergency operations
> > >     triggered under extreme memory pressure. In these scenarios, the highest
> > >     priority is to recover memory as quickly as possible to avoid further
> > >     kills or system jank. Spending half of the unmap time on LRU maintenance
> > >     for pages belonging to a victim process is a bad trade-off. If speeding up
> > >     the victim's reclaim by avoiding LRU movement and evicting cache negatively
> > >     affects the workflow (due to immediate restart), it implies a sub-optimal
> > >     kill target selection by the userspace policy (e.g., LMKD), rather than
> > >     a problem in this expedited APIs.
> >
> > Your change effectively boils down to break aging for exclusively mapped
> > file pages when those pages should have been activated. All that because
> > the activation has some (batched) overhead. You argue that the overhead
> > is not a good trade-off for OOM path because those pages are exclusive
> > to the process and therefore they will go away after the task exits.
> 
> I think Minchan's argument is that mm reaping occurs only in special
> conditions (under high memory pressure) and for a very specific reason
> (to free up memory and prevent system memory starvation). Therefore
> priority in such conditions should shift towards more aggressive
> memory reclaim instead of normal aging. I can see both his point and a
> counter-argument that this might cause more refaults in some cases.

The way I see this is that the standard memory reclaim under a heavy
memory pressure would likely encounter those pages and aged them
accordingly already. So this is effectivelly racing with that process
and makes a potentially opposite decision.
I suspect that a lack of memory reclaim, as implied by the other patch
(to deal with clean page cache), is the reason why this one makes a
difference in these Android deployments.

Unless I am completely wrong and misreading the whole situation this
might be very Android specific change. The question is whether these
side effects are generally useful for other worklods. So we really need
much more explanation of the actual behavior after this change for wider
variety of workloads.
-- 
Michal Hocko
SUSE Labs
