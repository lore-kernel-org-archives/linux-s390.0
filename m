Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD40140DFC7;
	Mon, 20 Apr 2026 08:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776674731; cv=none; b=FnWhDJdKFrXvMNgihtnG8qW20rFZq1EAsKxZgC9XgZZ2H0IwPUg+oeVqndMiIVIs4deNtFpuPNbGQSxOn9qS6hIHpGhxO/tyU6IYcW+jSUNb4HAHWn4CbJmJOmOsUHXuSd3yfMjy+5sd2YeoyApGO7uSU/8z4t6nVRdDfK0sXv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776674731; c=relaxed/simple;
	bh=aslz2yLWAjdD4IGDrGw5HHuwwhSvb0pvA4zxjSBGvVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UwzsYq24p6XlvAaEU/V5eDIrl4pp6elF6b8IsDLtXSWPFBTSC3Fh3K7IXe2ThH6vjurDTNBoPFbN/u1Ghrk7JjwWv3nNh2Cte261llq9CpqfJ73bwD6biwUPqVhrb70ziX5XfqgA5juGCCu5CpBgmlg2g4mJLr704gmxg/wJQqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=VjShxqIz; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="VjShxqIz"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6A7101516;
	Mon, 20 Apr 2026 01:45:23 -0700 (PDT)
Received: from [10.57.63.177] (unknown [10.57.63.177])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 099303F641;
	Mon, 20 Apr 2026 01:45:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1776674728; bh=aslz2yLWAjdD4IGDrGw5HHuwwhSvb0pvA4zxjSBGvVs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VjShxqIz/6pMdOJQItTXiMxAPrFkmVWqvoYYBHd0AMUOhK0k5/62F2MGuWywZJEqs
	 wfSc/fxt60OjpdpVIgxBXM16uOXIBtA0G7dqIgeBasDbjK/LrEuN0RJ0U4NKryvprH
	 V9PtftScrn0LGxfrb3BFXmLddSwKvVQZWCibDzXY=
Message-ID: <4dc47078-0f8b-4388-9715-744c18590a00@arm.com>
Date: Mon, 20 Apr 2026 10:45:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mm: Make lazy MMU mode context-aware
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org
References: <cover.1776264097.git.agordeev@linux.ibm.com>
 <8809412aaed8a515fe2e149c822543d640060936.1776264097.git.agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <8809412aaed8a515fe2e149c822543d640060936.1776264097.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/04/2026 17:01, Alexander Gordeev wrote:
> +/**
> + * lazy_mmu_mode_enable_for_pte_range() - Enable the lazy MMU mode with a speedup hint.
> + * @mm: Address space the pages are mapped into.
> + * @addr: Start address of the range.
> + * @end: End address of the range.
> + * @ptep: Page table pointer for the first entry.
> + *
> + * Enters a new lazy MMU mode section; if the mode was not already enabled,
> + * enables it and calls arch_enter_lazy_mmu_mode_for_pte_range().
> + *
> + * PTEs that fall within the specified range might observe update speedups.
> + * The PTE range must belong to the specified memory space and not cross
> + * a page table boundary.

Does that mean that all PTEs mapping [addr, end) must belong to the same
PTE page? I think the wording should be more specific.

LGTM otherwise:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> + *
> + * There are no requirements on the order or range completeness of PTE
> + * updates for the specified range.
> + *
> + * Must be paired with a call to lazy_mmu_mode_disable().
> + *
> + * Has no effect if called:
> + * - While paused - see lazy_mmu_mode_pause()
> + * - In interrupt context
> + */
> +static inline void lazy_mmu_mode_enable_for_pte_range(struct mm_struct *mm,
> +		unsigned long addr, unsigned long end, pte_t *ptep)
> +{
> +	struct lazy_mmu_state *state = &current->lazy_mmu_state;
> +
> +	if (in_interrupt() || state->pause_count > 0)
> +		return;
> +
> +	VM_WARN_ON_ONCE(state->enable_count == U8_MAX);
> +
> +	if (state->enable_count++ == 0)
> +		arch_enter_lazy_mmu_mode_for_pte_range(mm, addr, end, ptep);
> +}
