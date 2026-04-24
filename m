Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6B41A6824
	for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2026 07:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777017087; cv=none; b=HtWODuNeMf7b44znmumCSKl6lKJryOY5wkbgnDi3MPYWEmdxPJux4xkLOXAAgoJrD5H4k2xabB0hAfbSP82p1AfzdvZgfqUhzetRTWuGhjNQPH8fETc0gz3O+ljzxmmdxpKplpwjSIlU6RXyF012vaJHD5D5cWzJXXKoJRBBPWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777017087; c=relaxed/simple;
	bh=gdNG1cqfsPosQRSrNZsmITbBbjQla+Qex8R0xXd1P50=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NCd0KYJHddYdcZm5j32pwoo7MGN8NqEdIlryGJGw33QSLjuW73UpERBdM496kyruJWlNZvNfFkeEZaS0go7TRnKmPvzM5pu9n42CQcJBFRZthdrjbK6lzQ7Y1CdxO99YoXv3jRtff5XbWbzQyDzI6zsv7yELTCLgeJd9l6H0LkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=E1wx5+HK; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="E1wx5+HK"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-488af9fdaa7so45267285e9.1
        for <linux-s390@vger.kernel.org>; Fri, 24 Apr 2026 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777017084; x=1777621884; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2/JtEzMAf3HHrd01fVfPU0c1qsQLQRrKfL4Fb7KVaB4=;
        b=E1wx5+HKZAe80RUbt/fCx+diMNkuMRBiIpsXZZM23fCTcZdn6aIFqNYJpE7fNMLySd
         OSD3TO9HbUIaJjAorThSCpZbQyeeamgHyMOsGYgg9WnIvEoXfg3MQQEoFmaXFWe/l2p7
         040pyLvnGi8Hc4Q1VZ0uDkIFGsiqLDaID9sEkdXU0N4tRNIhJIg2d4aKvkHz4BY+hrz7
         caHjkoNO9jPX3kVaviVSk+/6z2/zOfIx0euDeqKAIks4BQodCPjvXh5j6NNVppzBEgu6
         lt+jEMlFJegW7EGz0jPSfpph82LoVG+6hebbrigUYbIeZbN+HCVoDgAyIaGPvEhVVtmz
         oi2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777017084; x=1777621884;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2/JtEzMAf3HHrd01fVfPU0c1qsQLQRrKfL4Fb7KVaB4=;
        b=QNrd6/ukfzRxF28xld/MhOcWjTO8g3DNSfcVenOU/LmSLYSPD3YgJ28ds3ZHONLwga
         AvglyfG5hJyhjQAXvN+q8wDiLSFhet8jJ74PVE0OIXkC6A45oBOmuiFgo21JxSezwoNe
         B7RI/svaw+TDxUn22zdmiVCZHlByQ1L22GU07q0w4XhvYXTnHOLg4vA4p0dSZ3vFg1c8
         x5LM2jBGA4TD0kn8OQhU7csqQ52gP/Ir+xjqyvLc+1dYPWYd55edLM88xHPMAHtheek3
         V434vZiFVs/LGKeV60HtSC5AJfu9D61L6yBkhBwzVhqOx+4m/ff+2Qj35HqwKKTR9gxa
         nHLw==
X-Forwarded-Encrypted: i=1; AFNElJ+5I6TvyeiDfN1yYhx2uGvpWslpX3FhcGm4vWLmLtYCfhK7IETcjlCzVHWp/cQxET1+41N9jpULBeVK@vger.kernel.org
X-Gm-Message-State: AOJu0YwQ/h+wAuXqyLxEgqZyon0MUymDZeXR77b1RCBKDfYuFCjnZTCf
	R/Rkm4WKrn88o6yZ0ty5pglwT8BpogeJl8JCBLA+K95EYBIs3npp28xkCeX1h5iVHI59ZCryqnu
	tQJ5eh9M=
X-Gm-Gg: AeBDiesE1dNy4HTooqPUo8VqZBdtZQxxSDgyWgmpJ0FKrJRbsDHu2VtXU2UirRbzoRm
	YFny/4+FZ+lhi3RU/NxqAy0Vc/wSS44293H0z86+rVH7wwDqmU0GYwfi6MwUouSHfg4ZdtnXiOJ
	mhwg0GaTuC0n3/Q2/6oP2DNuwtP56k5ERJ6q9d45cjFtBOGBSa5puoTXFxZNor1yzS+RiJzgnLf
	hL8+R/8Wiz876IKHrYEgkKHoPoE3QznQV5Ll4h6djX8NdGZPDxmMJlAY9S1y6tnUgVekqCAvX5X
	pw/Rrq7C5uvewJTBnakSjcEzMf725xghaTw1OOShc2e/KH3FFb/mH8IWCwlrZmS4QgtSSgnmuZI
	3tVAyqMTGNsVaZF4KDy0LEpPlpPELNUsljpc8wNx6Eq1uTkBINXYSr5XkSUtx/GStu99QX5jQi5
	j0MuJXScTQXTQoicVdvJLEJe2ybgujjftzdylPDX9DJ7wcdc4=
X-Received: by 2002:a05:600d:8496:10b0:489:a4:e555 with SMTP id 5b1f17b1804b1-48900a4e79fmr243967435e9.21.1777017083931;
        Fri, 24 Apr 2026 00:51:23 -0700 (PDT)
Received: from localhost (109-81-17-171.rct.o2.cz. [109.81.17.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a5aa3ae83sm334399355e9.12.2026.04.24.00.51.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2026 00:51:23 -0700 (PDT)
Date: Fri, 24 Apr 2026 09:51:22 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, david@kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com, Minchan Kim <minchan@google.com>
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <aesg-sj6_VmXyqxb@tiehlicka>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260421230239.172582-3-minchan@kernel.org>

On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> For the process_mrelease reclaim, skip LRU handling for exclusive
> file-backed folios since they will be freed soon so pointless
> to move around in the LRU.
> 
> This avoids costly LRU movement which accounts for a significant portion
> of the time during unmap_page_range.
> 
> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
>      exit_mm
>      __mmput
>      exit_mmap
>      unmap_vmas
>    - unmap_page_range
>       - 55.75% folio_mark_accessed
>          + 48.79% __folio_batch_add_and_move
>            4.23% workingset_activation
>       + 12.94% folio_remove_rmap_ptes
>       + 9.86% page_table_check_clear
>       + 3.34% tlb_flush_mmu
>         1.06% __page_table_check_pte_clear
> 
> Signed-off-by: Minchan Kim <minchan@kernel.org>

As pointed out in the previous version of the patch. I really dislike
this to be mrelease or OOM specific. Behavior. You do not explain why
this needs to be this way, except for the performance reasons. My main
question is still unanswered (and NAK before this is sorted out). Why
this cannot be applied in general for _any_ exiting task. As you argue
the memory will just likely go away so why to bother?

> ---
>  mm/memory.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 2f815a34d924..fcb57630bb8d 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1640,6 +1640,8 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
>  	bool delay_rmap = false;
>  
>  	if (!folio_test_anon(folio)) {
> +		bool skip_mark_accessed;
> +
>  		ptent = get_and_clear_full_ptes(mm, addr, pte, nr, tlb->fullmm);
>  		if (pte_dirty(ptent)) {
>  			folio_mark_dirty(folio);
> @@ -1648,7 +1650,16 @@ static __always_inline void zap_present_folio_ptes(struct mmu_gather *tlb,
>  				*force_flush = true;
>  			}
>  		}
> -		if (pte_young(ptent) && likely(vma_has_recency(vma)))
> +
> +		/*
> +		 * For the process_mrelease reclaim, skip LRU handling for exclusive
> +		 * file-backed folios since they will be freed soon so pointless
> +		 * to move around in the LRU.
> +		 */
> +		skip_mark_accessed = mm_flags_test(MMF_UNSTABLE, mm) &&
> +				     !folio_maybe_mapped_shared(folio);
> +		if (likely(!skip_mark_accessed) && pte_young(ptent) &&
> +		    likely(vma_has_recency(vma)))
>  			folio_mark_accessed(folio);
>  		rss[mm_counter(folio)] -= nr;
>  	} else {
> -- 
> 2.54.0.rc1.555.g9c883467ad-goog
> 

-- 
Michal Hocko
SUSE Labs
