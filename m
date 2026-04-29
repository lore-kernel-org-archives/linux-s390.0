Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4334E3A7F66;
	Wed, 29 Apr 2026 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498902; cv=none; b=o5imQWg6qwgQvB3VHrN5ZhipgvHqW1eUks+ckMzAr9aU2yoj1PfawPAB0pdlz5HtKRv7QtRnS3+k5fKi3v9kVyyUI/fGhI2rwBIk5Ikif0YD2j16OfzFEvYi/JlwaK+TmgcvLLUf62Kp8gRFZ2FqdAWuuFavYvsDfubUOuUI4yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498902; c=relaxed/simple;
	bh=XOibkyLy0IVe150xVr58dFt6tHTML3fQOpFxcRHSscg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h0TUMs4UFwHgkhyaygdSbWWP3wsiMbdRqUS+1NuY5CyI6eXWtUx9Pa5VG0O/CaBnnic12GKuathdbXjMu9s93d4WmFJdMLkCIYwBi3toxEjAvyrEQqs3la1OVtp4KnGdIU4a+ohrni181h4HSl1J+srETDgp1GjMWhFuoFBlXe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtFP/9KM; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtFP/9KM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 802A3C2BCB3;
	Wed, 29 Apr 2026 21:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777498901;
	bh=XOibkyLy0IVe150xVr58dFt6tHTML3fQOpFxcRHSscg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtFP/9KMtfCIdMN59rmE+GGWQgKK6XalKGSYNc8W+mO5uIwxVSZmWUJmSYDnqKXiD
	 0Vwz44wcQfX/oIfgjgTnDcKDMBCCIuFYec4HbGobONXFWKtFcx0vDyXWId5wODvW9p
	 RiypTm+y98UiIOc5Ul+X0IOV8GXyD7gliZBZu0aE2hAXXmRPirHJpNRVrE2Hn3bmQ3
	 Gq4KedknY1j3/fBtOXTwuFigYB+VMX2t3NnHDKue2TlmTq4P1pa6fwzJqIOvEzpKsN
	 lrBVsdDuILaUED1pLifUwWYEPntH/Pt3ifDNRpLDPu48T3dR4dJeJhTaf09xYk6Uh0
	 oi++eFuWQ3e/Q==
Date: Wed, 29 Apr 2026 14:41:40 -0700
From: Minchan Kim <minchan@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, timmurray@google.com,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <afJ7FPkNK6cxUxSe@google.com>
References: <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com>
 <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka>
 <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka>
 <afFco71vwmpQy3pk@google.com>
 <afG-4hq7Hr62Uu6J@tiehlicka>
 <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>

On Wed, Apr 29, 2026 at 11:09:55AM +0200, David Hildenbrand (Arm) wrote:
> On 4/29/26 10:18, Michal Hocko wrote:
> > On Tue 28-04-26 18:19:31, Minchan Kim wrote:
> >> On Tue, Apr 28, 2026 at 08:56:36AM +0200, Michal Hocko wrote:
> > [...]
> >>>         DESCRIPTION
> >>>           The process_mrelease() system call is used to free the memory of
> >>>           an exiting process.
> >>
> >> "Free the memory of an exiting process" implies all memory, not just
> >> anonymous. User cannot know it will free only anonymous, and I am trying to
> >> make it work as intended by completing a symmetric reclamation path.
> > 
> > Page cache doesn't belong to any process.
> > 
> > [...]
> > 
> >> >From cf292f8f8ead8df9161aad342c36633ffa90257f Mon Sep 17 00:00:00 2001
> >> From: Minchan Kim <minchan@kernel.org>
> >> Date: Tue, 28 Apr 2026 16:39:06 -0700
> >> Subject: [PATCH] mm: process_mrelease: skip LRU movement and expedite clean
> >>  file folio reclaim
> > 
> > I will let others to discuss this. I maintain my position that this is a
> > hack for a very particular use case and you still seem to not explain
> > non-Android users of the syscall. Anyway, I will not repeat myself here.
> > 
> 
> One thing that got lost in the thread here: this code path is not
> process_mrelease specific?
> 
> We seem to end up in __oom_reap_task_mm() also from ordinary oom_reap_task_mm().
> 
> There, we unconditionally set MMF_UNSTABLE to then zap_vma_for_reaping() where
> memory can be "reaped".

After updating my development brach, I see zap_vma_for_reaping now.

> 
> So why is there "process_mrelease" part of the patch subject at all?

While __oom_reap_task_mm() is indeed shared with ordinary oom_reap_task_mm(),
I added a boolean parameter (try_evict_file_folios) to isolate the
optimizations in recent patch.

-static bool __oom_reap_task_mm(struct mm_struct *mm)
+static bool __oom_reap_task_mm(struct mm_struct *mm, bool try_evict_file_folios)
 {
        struct vm_area_struct *vma;
        bool ret = true;
@@ -556,12 +556,14 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
                                                mm, vma->vm_start,
                                                vma->vm_end);
                        tlb_gather_mmu(&tlb, mm);
+                       tlb.try_evict_file_folios = try_evict_file_folios;
+                       struct zap_details details = { .ignore_access = try_evict_file_folios };
                        if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
                                tlb_finish_mmu(&tlb);
                                ret = false;
                                continue;
                        }
-                       unmap_page_range(&tlb, vma, range.start, range.end, NULL);
+                       unmap_page_range(&tlb, vma, range.start, range.end, &details);
                        mmu_notifier_invalidate_range_end(&range);
                        tlb_finish_mmu(&tlb);
                }

In the current patch, ordinary oom_reap_task_mm() passes 'false', so it
does not see these side effects of broken aging and file cache eviction.

The optimizations are strictly active only when userspace calls
process_mrelease() with the PROCESS_MRELEASE_REAP_KILL flag.
(I believe OOM killer is ultimately target of the user but didn't want
to introduce side effect until we can conclude for the direction).
