Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 608D83A1E9F;
	Mon, 27 Apr 2026 08:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777279804; cv=none; b=jleijsIfJMFwpy8kfTASybaaTRiLxW41zxmIdOsEHntw+rJCBh084Rp7wkzHODMtIEpOuPf2Q2+3FRKXhM/CG8lgmxjCmAkZqHFuTUjyRAp3z0Wska0xwlegFLYP8pBCMRYAP2vTeoZrD9y2eLMgb3QNi6+aywH3AZ2QvGJ8CSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777279804; c=relaxed/simple;
	bh=0GWUcMnbWktPaU4qy3M0B1w8OmTn/iOg4VU4cTHjVL0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=au7Afql4+z8CUBSXsk8/+rilg5Ln+Ls7WEoTvxc350jUucNx2J4q8PDstVhEO1kHQevhiXnbWsUN7f20TbHPSTi6FTjaJq4lMpg94COWOBAfTUfkvb1UXxpHxvIGMg/dPRyCVXfTLhMdjDR1f0cb71zG2LHuQc0Rq7v8cwvaGtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=FAQ0gJlp; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="FAQ0gJlp"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 341D01684;
	Mon, 27 Apr 2026 01:49:56 -0700 (PDT)
Received: from [10.164.18.48] (unknown [10.164.18.48])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0D33F62B;
	Mon, 27 Apr 2026 01:49:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1777279801; bh=0GWUcMnbWktPaU4qy3M0B1w8OmTn/iOg4VU4cTHjVL0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=FAQ0gJlpEEoTvwEwhsU6JZVwgxLpcaIig7al3nYlT9Ydh8NDbExHUZBUoIWUQ/SO2
	 rC6588/nH317mQspzt6mCBrwa0C2N2StAQo7oziQ9uI3uBX9qL4v0s3A0IW7s0gmaa
	 A2uvUy2uEQrdF0BPHmTh8KBSXwWQSwE+X7txYka4=
Message-ID: <453d3e2f-5b29-4fd5-987f-de590d89698e@arm.com>
Date: Mon, 27 Apr 2026 14:19:55 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] mm/page_vma_mapped_walk: add missing pgtable entry
 accessors
To: Oscar Salvador <osalvador@suse.de>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <ljs@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20260427052000.196402-1-agordeev@linux.ibm.com>
 <ae8g4jipQxQZRe6E@localhost.localdomain>
Content-Language: en-US
From: Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <ae8g4jipQxQZRe6E@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 27/04/26 2:10 PM, Oscar Salvador wrote:
> On Mon, Apr 27, 2026 at 07:20:00AM +0200, Alexander Gordeev wrote:
>> Convert pgtable direct entry dereferences to the corresponding
>> pXdp_get() accessors. Use ptep_get_lockless() variant for PTE
>> reads when no lock is taken.
>>
>> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
>> ---
>>  mm/page_vma_mapped.c | 12 ++++++------
>>  1 file changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/mm/page_vma_mapped.c b/mm/page_vma_mapped.c
>> index b38a1d00c971..a4520bb10d2a 100644
>> --- a/mm/page_vma_mapped.c
>> +++ b/mm/page_vma_mapped.c
> ...
>> @@ -317,7 +317,7 @@ bool page_vma_mapped_walk(struct page_vma_mapped_walk *pvmw)
>>  				goto restart;
>>  			}
>>  			pvmw->pte++;
>> -		} while (pte_none(ptep_get(pvmw->pte)));
>> +		} while (pte_none(ptep_get_lockless(pvmw->pte)));
> 
> map_pte() might take the lock if PVWN_SYNC mode, or am I missing something?

Right - should leave ptep_get() unchanged.
