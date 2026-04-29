Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E824335081;
	Wed, 29 Apr 2026 21:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777498940; cv=none; b=h+3Ie05O7svrge9pwsOKqehzWnXQaPoCSZJB4BEV+dcwrs8IDXCLWRgKj1RquPMT3MDr9B3437pQCLxzoYTqsgiOVrpmAVi5Q4aXY3ddmzaNTE2KcBS8GkU1kSy4kmHLgAhfAm5GTpaQLHUSmklHUcndDbeg8Vs+nVvce8VsIcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777498940; c=relaxed/simple;
	bh=LwKwakj8JQvdi7CWqQLtK7O2+mUpeZJ75DrDVytdbgQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oRL/9kLvnSjyOXjPEQ5vKG9pw5Q5Kj963ZtyCsdhuzRP1dOi5UQyTnlMwjYOC5mwpGioxmeHM/3povFIHHpPx41fEOe9RDYGwRoJDIjehkWPGHYeDqF9EOsV/FeQPA68kjkix9itpcwh/xWQCxYcnFVSRJy2lb1vzzE6kD/fZlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TPkh9jZz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TPkh9jZz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B9DEC19425;
	Wed, 29 Apr 2026 21:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777498940;
	bh=LwKwakj8JQvdi7CWqQLtK7O2+mUpeZJ75DrDVytdbgQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TPkh9jZzNQbVrGSgR6g2dF81CFcvOzt6d+e90Xk/K1vn3KaTTIicc6YJUE2l8WLJg
	 +Xc3OhZb/HMJ3jffKNflV/PT41X2pMCmNb961jMj+xjDjyC9AzsFl3BjQ1nsbWDguW
	 6Fr9WWBb1HFu95hUHGGQ59aOutaXJD9f/5a0uWMiWoa50KBa6xnzp46Bq7ZMm8qB4H
	 wMGPqzXBOi9ZbK0VDfzYb0+j5/xuu9KL4+zpD94sDF53kyi4JTe0h2wAl43SmTWFTn
	 CPSnYwMRYUs1Dfp0kDuPJJRZuvyS01KY34w7wAQYtEW0wuExvSTdLGz3SktGN+kJ6c
	 XuM06kWQMnaTA==
Date: Wed, 29 Apr 2026 14:42:18 -0700
From: Minchan Kim <minchan@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
	akpm@linux-foundation.org, hca@linux.ibm.com,
	linux-s390@vger.kernel.org, brauner@kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, timmurray@google.com
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
Message-ID: <afJ7OhkfTj4sjTPR@google.com>
References: <aesg-sj6_VmXyqxb@tiehlicka>
 <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com>
 <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka>
 <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka>
 <afFco71vwmpQy3pk@google.com>
 <e5a06ee7-0916-44af-a90c-7ff7cf1397c8@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5a06ee7-0916-44af-a90c-7ff7cf1397c8@kernel.org>

On Wed, Apr 29, 2026 at 10:55:25AM +0200, David Hildenbrand (Arm) wrote:
> 
> >  
> > -static bool __oom_reap_task_mm(struct mm_struct *mm)
> > +static bool __oom_reap_task_mm(struct mm_struct *mm, bool try_evict_file_folios)
> >  {
> >  	struct vm_area_struct *vma;
> >  	bool ret = true;
> > @@ -556,12 +556,14 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
> >  						mm, vma->vm_start,
> >  						vma->vm_end);
> >  			tlb_gather_mmu(&tlb, mm);
> > +			tlb.try_evict_file_folios = try_evict_file_folios;
> > +			struct zap_details details = { .ignore_access = try_evict_file_folios };
> >  			if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
> >  				tlb_finish_mmu(&tlb);
> >  				ret = false;
> >  				continue;
> >  			}
> > -			unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> > +			unmap_page_range(&tlb, vma, range.start, range.end, &details);
> >  			mmu_notifier_invalidate_range_end(&range);
> 
> 
> This API was changed in the meantime into zap_vma_for_reaping(), and I do not
> want to pass details on the new interface. If so, zap_vma_for_reaping() would
> handle that internally I guess.
 
Will take a look what's the best way.

Thank you.

