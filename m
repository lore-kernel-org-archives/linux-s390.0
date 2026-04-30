Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49163FE65D;
	Thu, 30 Apr 2026 14:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777559940; cv=none; b=JumE36bjjAVTeSugCqfI2bsFcOI+Yny+y9gBxrecTEYrdw51o+peA7DoNepru/SPQNidKIdnvKIvFh97jotVr0TOT0W8tlj72FMGkYpHTtseDemh9ePWO7OJocqU45H8t7+jCL+KY1cIAA8oRH6vudMMARYuP3cXVQzCClcjXA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777559940; c=relaxed/simple;
	bh=Gc0G/nPCLoAEXLQD+FtiMt3y+teazxkvZICdeWL4IwE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A2gim76qIJcXbGOy8i3mPaK7GU38VndDYWd4fLl3C5fpS6bmn9mIN4SK8tpPolw62Kml7RmIe294Iy4B7l50SKuUs5whR2INzcAx7hn7v0A7zb/MmnU1qj26S5cbTwoVjYKhejlLScZkFF6BCr1bg5iF1LaZm7o1WD8GlSC2D3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cBwzWdl4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cBwzWdl4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B8E8C2BCB3;
	Thu, 30 Apr 2026 14:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777559940;
	bh=Gc0G/nPCLoAEXLQD+FtiMt3y+teazxkvZICdeWL4IwE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=cBwzWdl4yUoKTWgksJJyhKfjlsm+HYb6h96SaWdcDFpiF7ClCSk4qAx1bTgq7rDa+
	 FKoVjMnszAcDwbqPa0iVOyr41ESF7ZFkR5G9u07gp4LlWVCH9NiyGv3SsWmoWdcVxX
	 xwDbu6eNe+rLQnb5bmxcgfrpBtPPAqMU9NCmIjMTRxyQcvZ4CV1q+80rQaGS+kCB91
	 nMvtPIOaueYC+KE0Rx6vg0lc/Kea58oohq/4yyOWLEHBm2HrDWkybfShWaYDi4I3mb
	 ggKnEZUOeN22zGA+0BNy8eRx0cNUOsva6ja+PAxJSVIkxaKm+Gn8N3umLqaRSJn3wu
	 opFKU9opqxYlQ==
Message-ID: <af21185c-3390-4566-bf28-ce79e13182dc@kernel.org>
Date: Thu, 30 Apr 2026 16:38:55 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/3] mm: process_mrelease: skip LRU movement for
 exclusive file folios
To: Minchan Kim <minchan@kernel.org>
Cc: Michal Hocko <mhocko@suse.com>, Suren Baghdasaryan <surenb@google.com>,
 akpm@linux-foundation.org, hca@linux.ibm.com, linux-s390@vger.kernel.org,
 brauner@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 timmurray@google.com, "Liam R. Howlett" <Liam.Howlett@oracle.com>
References: <7c7da8ae-cd39-4edf-b94f-c79ab85df456@kernel.org>
 <aevBRh08X4UTMUj9@google.com> <ae8NT0tLt7eBmH6j@tiehlicka>
 <CAJuCfpHQdA7C50V2WjNrdYcp7feV5ukgxJf+vMNEcp0P1SGEow@mail.gmail.com>
 <ae-Zu-VAzAA7SdLa@tiehlicka> <ae_roPR64e6sY_fN@google.com>
 <afBaJLLFigkdszov@tiehlicka> <afFco71vwmpQy3pk@google.com>
 <afG-4hq7Hr62Uu6J@tiehlicka>
 <7f98f461-62a7-455d-a7a8-cb8928465946@kernel.org>
 <afJ7FPkNK6cxUxSe@google.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <afJ7FPkNK6cxUxSe@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 4/29/26 23:41, Minchan Kim wrote:
> On Wed, Apr 29, 2026 at 11:09:55AM +0200, David Hildenbrand (Arm) wrote:
>> On 4/29/26 10:18, Michal Hocko wrote:
>>> [...]
>>>
>>> Page cache doesn't belong to any process.
>>>
>>> [...]
>>>
>>>
>>> I will let others to discuss this. I maintain my position that this is a
>>> hack for a very particular use case and you still seem to not explain
>>> non-Android users of the syscall. Anyway, I will not repeat myself here.
>>>
>>
>> One thing that got lost in the thread here: this code path is not
>> process_mrelease specific?
>>
>> We seem to end up in __oom_reap_task_mm() also from ordinary oom_reap_task_mm().
>>
>> There, we unconditionally set MMF_UNSTABLE to then zap_vma_for_reaping() where
>> memory can be "reaped".
> 
> After updating my development brach, I see zap_vma_for_reaping now.
> 
>>
>> So why is there "process_mrelease" part of the patch subject at all?
> 
> While __oom_reap_task_mm() is indeed shared with ordinary oom_reap_task_mm(),
> I added a boolean parameter (try_evict_file_folios) to isolate the
> optimizations in recent patch.

Well, not in the original patch, that's what I meant :)

> 
> -static bool __oom_reap_task_mm(struct mm_struct *mm)
> +static bool __oom_reap_task_mm(struct mm_struct *mm, bool try_evict_file_folios)
>  {
>         struct vm_area_struct *vma;
>         bool ret = true;
> @@ -556,12 +556,14 @@ static bool __oom_reap_task_mm(struct mm_struct *mm)
>                                                 mm, vma->vm_start,
>                                                 vma->vm_end);
>                         tlb_gather_mmu(&tlb, mm);
> +                       tlb.try_evict_file_folios = try_evict_file_folios;
> +                       struct zap_details details = { .ignore_access = try_evict_file_folios };
>                         if (mmu_notifier_invalidate_range_start_nonblock(&range)) {
>                                 tlb_finish_mmu(&tlb);
>                                 ret = false;
>                                 continue;
>                         }
> -                       unmap_page_range(&tlb, vma, range.start, range.end, NULL);
> +                       unmap_page_range(&tlb, vma, range.start, range.end, &details);
>                         mmu_notifier_invalidate_range_end(&range);
>                         tlb_finish_mmu(&tlb);
>                 }
> 
> In the current patch, ordinary oom_reap_task_mm() passes 'false', so it
> does not see these side effects of broken aging and file cache eviction.
> 
> The optimizations are strictly active only when userspace calls
> process_mrelease() with the PROCESS_MRELEASE_REAP_KILL flag.
> (I believe OOM killer is ultimately target of the user but didn't want
> to introduce side effect until we can conclude for the direction).

I'd assume we would want the same behavior for any form of OOM reaping.

-- 
Cheers,

David
