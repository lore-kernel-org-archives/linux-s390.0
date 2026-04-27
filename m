Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6748371049
	for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777274196; cv=none; b=pPjJ2QT6gXmLbelBen0pLWWgoTo7cJbchDvGuS0235+ULxXQTLbMJkTUHPxdtODVBK2FAxTGfBjO3qykThRw3zR6wxVUdQ5yeIPG9wghilp0IgUM34fJeMqaMwP/HraBVnRdqYiyFdY0BGxrjguEb9UYm9C8XNbcjSMtgyDdKyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777274196; c=relaxed/simple;
	bh=CgYNoeo4Ma2x/AydAJ9rtFeZOoiEC4OwaUsFMIwsgtQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XYx45ws5Yp61C52z6cjzxml0hMYOIrBfKGv7yhii6IQ1iwalcmjJopoug2RdVzrEVkMd1RoGYQwDzDR1IrQUN7KVBU+eZqqk1C21dtnThkcICkIsUETP+sbemQ/SRfzKQNbBeQUYhondYbYG5qERL4WUk9q0bJAI/958HdPQ0Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=hDb7m1ZX; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="hDb7m1ZX"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4891e5b9c1fso82009525e9.2
        for <linux-s390@vger.kernel.org>; Mon, 27 Apr 2026 00:16:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1777274193; x=1777878993; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7AvPAXsuvtgC8xHgqZ0h0f5zzV7f6VHw1kg2bqEt4fs=;
        b=hDb7m1ZXCEU7U40wHfcJ1qdVA21mrF5/dJKreyA7cQ0iAGN7hD3NgY84Syn38W8BY+
         cZgr58ALRgoQFHy3GgfGzOsFRqPyORZdgetCj8qLsXqJPxg3r5wuOL5OU2Ra/fCq/rYD
         eaN2Dj6C0VVzr3bBcApe14m+bhsdSRftHx0wNSTWnTckELEbRrTiSFbD87NSSTT4Qe2c
         SS/qRC+JqetZvMIRTHIcdHVqn+GWd4X7SxxqlVWbG3AeoXJsxZ4Z31qZJwZ2VpyfFyzO
         Njv8XVRbJSq7DQzZ1l3gsYlf9yokIQZ3FlFSwuj6xgGmKZqPMwOPNSlfFZ5QdhN8F26Q
         PGtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777274193; x=1777878993;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7AvPAXsuvtgC8xHgqZ0h0f5zzV7f6VHw1kg2bqEt4fs=;
        b=ia0QQJzYEjP3hoBob9m2onY9SqHg5d5pUOx6ibYcPtesUu8ZIIcjOP7VPi/0+3qty/
         Ro255IUdYlh/2OLlL328f3qBMG63JLsa2zEjuChghdjUzGwmVzKTnB/MH2Z86J41jo8r
         Q3xDSBM2dzkA2Fae/NM6lJN5cRNwUaBM3T2Az8Ibo1V6iopGeagtCg0MakSQnymafu8c
         DXN0+4pjb4CMZ8WNg8cDuNBmEk8FWUMUS3dOVVqA6RqSJA7VReITpqZ59NSLjP4W1e93
         4pc+dCVJf+Oo/rrCvm3FF8gYtfN1f0C7l7mNG8Fq4hHBIAtrCyNKYk/sqSPDOR/kd4mf
         78tg==
X-Forwarded-Encrypted: i=1; AFNElJ9p7NHdQY0m9MOO+1LQelqO/asfLMby0hxmT5nZ4VkG6RaS0ZAV4lOt+oqjHkA6PzKG7N1HwUt/ww2P@vger.kernel.org
X-Gm-Message-State: AOJu0Yza3215JdAbarlKYw7CBD27g+E+YlbQ8Xi+fQES7hou8EuUG6Lo
	A2ZXMfCklYMvI1S052NLM1eCUfCFcKKLtg7fZIn+X574M2OfvkK09PB9kexMQk5n1xM=
X-Gm-Gg: AeBDiet4PR8TGV1ojkwEIojjvPEKkCEY/DDAaarhAs748OL9XHslmeCstZxGRsA/7eD
	8KUGM3Txic6tLA0yo9WqZ0ABP8bHY7XoOY8KHCWoWUiE6zMUeuZ7PrkgtJSS4KT1iU+g8PWY0sU
	WinsEbmOlnwSfZdJIV+TU7qc+aRyUANqfeG4eSM0zsW5B0ZzfcuFKAl1HJ13nJKjeIIUEFOlQff
	yDwY3PMTlsCOGKD+WqxYQdyzjwNyXjboKOlBK/TLOLlDWo7tzBVc4C+Y0hzOiD5fi+pRZc0GR8Y
	ltLQb7fceMESJo5H9QVCLEW48D47d5imm9GFTv4WKuVuKDgA7i6JhLWDMcStHDoshWWq5rZYRuQ
	niNazG/x5ECLhn/R9T1pGCbGJY7rIV4jsmHJhKSI8ydSFMvrrWyotobfM0qNDR8kXT8EEP+w6gM
	MPeTuIWY8k90aRWG8+2JKO3LsAY4HQQF0YSbzpYrEF6Ybb3sc=
X-Received: by 2002:a05:600c:858c:b0:48a:55d8:7882 with SMTP id 5b1f17b1804b1-48a55d87a58mr307347815e9.9.1777274192917;
        Mon, 27 Apr 2026 00:16:32 -0700 (PDT)
Received: from localhost (109-81-17-171.rct.o2.cz. [109.81.17.171])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488fc177dafsm936339475e9.4.2026.04.27.00.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 00:16:32 -0700 (PDT)
Date: Mon, 27 Apr 2026 09:16:31 +0200
From: Michal Hocko <mhocko@suse.com>
To: Minchan Kim <minchan@kernel.org>
Cc: "David Hildenbrand (Arm)" <david@kernel.org>, akpm@linux-foundation.org,
	hca@linux.ibm.com, linux-s390@vger.kernel.org, brauner@kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, surenb@google.com,
	timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <ae8NT0tLt7eBmH6j@tiehlicka>
References: <20260421230239.172582-1-minchan@kernel.org>
 <20260421230239.172582-3-minchan@kernel.org>
 <aesg-sj6_VmXyqxb@tiehlicka>
 <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aevBRh08X4UTMUj9@google.com>

On Fri 24-04-26 12:15:18, Minchan Kim wrote:
> On Fri, Apr 24, 2026 at 09:57:16AM +0200, David Hildenbrand (Arm) wrote:
> > On 4/24/26 09:51, Michal Hocko wrote:
> > > On Tue 21-04-26 16:02:38, Minchan Kim wrote:
> > >> For the process_mrelease reclaim, skip LRU handling for exclusive
> > >> file-backed folios since they will be freed soon so pointless
> > >> to move around in the LRU.
> > >>
> > >> This avoids costly LRU movement which accounts for a significant portion
> > >> of the time during unmap_page_range.
> > >>
> > >> -   91.31%     0.00%  mmap_exit_test   [kernel.kallsyms]  [.] exit_mm
> > >>      exit_mm
> > >>      __mmput
> > >>      exit_mmap
> > >>      unmap_vmas
> > >>    - unmap_page_range
> > >>       - 55.75% folio_mark_accessed
> > >>          + 48.79% __folio_batch_add_and_move
> > >>            4.23% workingset_activation
> > >>       + 12.94% folio_remove_rmap_ptes
> > >>       + 9.86% page_table_check_clear
> > >>       + 3.34% tlb_flush_mmu
> > >>         1.06% __page_table_check_pte_clear
> > >>
> > >> Signed-off-by: Minchan Kim <minchan@kernel.org>
> > > 
> > > As pointed out in the previous version of the patch. I really dislike
> > > this to be mrelease or OOM specific. Behavior. You do not explain why
> > > this needs to be this way, except for the performance reasons. My main
> > > question is still unanswered (and NAK before this is sorted out). Why
> > > this cannot be applied in general for _any_ exiting task. As you argue
> > > the memory will just likely go away so why to bother?
> > 
> > I think there was a lengthy discussion involving Johannes from a previous series.
> > 
> > That should be linked here indeed.
> 
> How about this?
> 
>     mm: process_mrelease: skip LRU movement for exclusive file folios
> 
>     During process_mrelease() or OOM reaping, unmapping file-backed folios
>     spends a significant portion of CPU time in folio_mark_accessed() to
>     maintain accurate LRU state (~55% of unmap time as shown in the profile
>     below).
> 
>     This patch skips LRU handling for exclusive file-backed folios during
>     such emergency memory reclaim.
> 
>     One might ask why this optimization shouldn't be applied to any exiting
>     task in general. The reason is that for a normal, orderly exit or just
>     pure kill, it is worth paying the CPU cost to preserve the active state
>     of clean file folios in case they are reused soon. Preserving cache hits
>     is beneficial for overall system performance.

This is a statement rather than an explanation. Why is it worth paying
the cost? What is different here?

>     However, process_mrelease() and OOM reaping are emergency operations
>     triggered under extreme memory pressure. In these scenarios, the highest
>     priority is to recover memory as quickly as possible to avoid further
>     kills or system jank. Spending half of the unmap time on LRU maintenance
>     for pages belonging to a victim process is a bad trade-off. If speeding up
>     the victim's reclaim by avoiding LRU movement and evicting cache negatively
>     affects the workflow (due to immediate restart), it implies a sub-optimal
>     kill target selection by the userspace policy (e.g., LMKD), rather than
>     a problem in this expedited APIs.

Your change effectively boils down to break aging for exclusively mapped
file pages when those pages should have been activated. All that because
the activation has some (batched) overhead. You argue that the overhead
is not a good trade-off for OOM path because those pages are exclusive
to the process and therefore they will go away after the task exits.
The same line of argument applies to task exiting normally too. Task
exit it not the most hot path but certainly something noticeable,
especially so for huge tasks.

All that being said, you really need to focus why breaking the aging is
a worth optimization. Keep in mind that while the page might be
exlusively mapped it could still be actively consumed from the page
cache and breaking the aging could lead to refaults.
-- 
Michal Hocko
SUSE Labs
