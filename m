Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 783F63009E1;
	Fri, 17 Jul 2026 17:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784308455; cv=none; b=XssDXxnizd55cADKgQumOnckZ9CM67lZFOe0sWdIumg0yDkZ410hp2qUywL9R9VF1fAZhkZpk3p6JbSC24CtZ1sFxrkEye1d7cQdYvN3c3gqn5TuTWnWui5Es5KkYXFRaT1mNbn8LP5kCeCgmII0tvpwBNRRjFTkzjTWF/eD6lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784308455; c=relaxed/simple;
	bh=fKLHwWDsT70IOS55zp9+fmUR6rNub3TYSs84mX6aGQY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lc5uMhxjf2hc3F/CDLc9Je6CJjx6sxex2A4SajOOCubhAG5OwRtFLI7rQVndaMUuX1URAB2RFLd3duzBtzYmO9qv3LtEx351x1KATLvigLiOWSzyNKS7yO8TQYosHCRY3MVuO8P5wA0yCord5GVzKGznLstUpUW22CecvT696tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=XMgmXh8v; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="XMgmXh8v"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 951EF1476;
	Fri, 17 Jul 2026 10:14:08 -0700 (PDT)
Received: from [10.57.85.89] (unknown [10.57.85.89])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3DA383F7B4;
	Fri, 17 Jul 2026 10:14:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784308452; bh=fKLHwWDsT70IOS55zp9+fmUR6rNub3TYSs84mX6aGQY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XMgmXh8vex+m4K9cZzlZq5WNmdeN7osWAy3/rAp/i38LfeLs3WdrJ/U9pQyVJkstU
	 krj44fzOAE2k2Jfrk88DCDtSb3O3ZifhZP16RZY6pDcDUzZfEFEC7pjIHcz6BHWctT
	 sImLifnPM3U8WdiTuuoESC7WmL5WTokCGSjsWXRY=
Message-ID: <b44e071d-7c9d-4e7e-a84d-4af3499a5a05@arm.com>
Date: Fri, 17 Jul 2026 19:14:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 1/4] mm: use proper PTE accessors in madvise() and
 mremap()
To: Alexander Gordeev <agordeev@linux.ibm.com>,
 David Hildenbrand <david@redhat.com>, Chris Li <sparse@chrisli.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org
References: <cover.1784292223.git.agordeev@linux.ibm.com>
 <3c4d3c768ebf9cc7bbc7667e0e08bf5ad2fe8729.1784292223.git.agordeev@linux.ibm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <3c4d3c768ebf9cc7bbc7667e0e08bf5ad2fe8729.1784292223.git.agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/07/2026 15:32, Alexander Gordeev wrote:
> Follow the pattern established by commit c33c794828f2 ("mm:
> ptep_get() conversion") and use proper accessors instead of
> direct pointer dereferences.
>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  mm/madvise.c | 2 +-
>  mm/mremap.c  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/madvise.c b/mm/madvise.c
> index 77552b03d318..7d369b1ff8e5 100644
> --- a/mm/madvise.c
> +++ b/mm/madvise.c
> @@ -1106,7 +1106,7 @@ static int guard_install_set_pte(unsigned long addr, unsigned long next,
>  	unsigned long *nr_pages = (unsigned long *)walk->private;
>  
>  	/* Simply install a PTE marker, this causes segfault on access. */
> -	*ptep = make_pte_marker(PTE_MARKER_GUARD);
> +	set_pte(ptep, make_pte_marker(PTE_MARKER_GUARD));

AFAICT ptep is not pointing to a real page table entry, but a local copy
- see walk_pte_range_inner().

Such direct write to page tables are prevented by the pkeys-based
mechanism I proposed [1], and I can confirm that the guard-regions mm
kselftests do not cause any crash with that feature enabled.

- Kevin

[1] https://lore.kernel.org/all/20260526-kpkeys-v8-0-eaaacdacc67c@arm.com/

>  	(*nr_pages)++;
>  
>  	return 0;
> diff --git a/mm/mremap.c b/mm/mremap.c
> index e9c8b1d05832..fc3b90274a57 100644
> --- a/mm/mremap.c
> +++ b/mm/mremap.c
> @@ -264,7 +264,7 @@ static int move_ptes(struct pagetable_move_control *pmc,
>  
>  	for (; old_addr < old_end; old_ptep += nr_ptes, old_addr += nr_ptes * PAGE_SIZE,
>  		new_ptep += nr_ptes, new_addr += nr_ptes * PAGE_SIZE) {
> -		VM_WARN_ON_ONCE(!pte_none(*new_ptep));
> +		VM_WARN_ON_ONCE(!pte_none(ptep_get(new_ptep)));
>  
>  		nr_ptes = 1;
>  		max_nr_ptes = (old_end - old_addr) >> PAGE_SHIFT;
