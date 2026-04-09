Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A641F37C901
	for <linux-s390@vger.kernel.org>; Thu,  9 Apr 2026 12:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775738912; cv=none; b=Zp/LG3YtKI1u0w2mLYSoirQU6avdMU0u3Z4Q495gJUrMztwDut1AQ4KWInNE171H2dUzpUsbLyXsD3W990B+pkEkPYvLmQn4Butfg3DUenBtH5LIJokqDaH7axONo4mcXphNQQ2e8gbCtJGgddjpAWh6ooc39EnPbt/j2cnCzak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775738912; c=relaxed/simple;
	bh=4dXc4y7Z2uiNCX/sqDej6ApZBVqJv5iIOdFmrpCpoIc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pYHuT8Qhwu/TCi2W+sL4N9f6gi3R4yMybrt/d0uhbGkRhR9+0Z61YMtjJMT13z+teThDjZZNNu8xXhuwRSqJp9KeJaQrpfgYbMi5v6lN7yvgLUgPyKqaKZGxLlFY1AE7biRQhAgOfcHq6F4Bvdqde+0h1IbFPlLFy1LLaEOZYLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=N58DRV0l; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="N58DRV0l"
Message-ID: <9fb076b5-ed33-458d-b39b-a2de3433a0da@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775738906;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsDQYaBb80vPizdMN7gGIHoZqJFZXjCQHHQTYzLrH8c=;
	b=N58DRV0lqQMRB98jfQIHyX0PR1r8vfmdZbvQlX7bIk4RgD5Wfb1wM8xheil7ZLjaVplT/E
	s2RSV+kXmM2OV94QFp4bMptKc2N8nO7u3rlLIWbDicI7WEDlkv0GkdF4rWovVtYeXLB5UM
	OH8hilcKSz/LsY3bIUt2nX38zb3DXFc=
Date: Thu, 9 Apr 2026 13:48:14 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [v3 00/24] mm: thp: lazy PTE page table allocation at PMD split
 time
Content-Language: en-GB
To: Matthew Wilcox <willy@infradead.org>
Cc: Hugh Dickins <hughd@google.com>, Andrew Morton
 <akpm@linux-foundation.org>, david@kernel.org,
 Lorenzo Stoakes <ljs@kernel.org>, linux-mm@kvack.org, fvdl@google.com,
 hannes@cmpxchg.org, riel@surriel.com, shakeel.butt@linux.dev,
 kas@kernel.org, baohua@kernel.org, dev.jain@arm.com,
 baolin.wang@linux.alibaba.com, npache@redhat.com, Liam.Howlett@oracle.com,
 ryan.roberts@arm.com, Vlastimil Babka <vbabka@kernel.org>,
 lance.yang@linux.dev, linux-kernel@vger.kernel.org, kernel-team@meta.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 borntraeger@linux.ibm.com, svens@linux.ibm.com, linux-s390@vger.kernel.org,
 Nhat Pham <nphamcs@gmail.com>
References: <20260327021403.214713-1-usama.arif@linux.dev>
 <6869b7f0-84e1-fb93-03f1-9442cdfe476b@google.com>
 <3f9e8e12-2d51-4f2a-ada1-994ed24df284@linux.dev>
 <adaxWs8BjCJB1aan@casper.infradead.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Usama Arif <usama.arif@linux.dev>
In-Reply-To: <adaxWs8BjCJB1aan@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT



On 08/04/2026 20:49, Matthew Wilcox wrote:
> On Wed, Apr 08, 2026 at 04:06:29PM +0100, Usama Arif wrote:
>> On 06/04/2026 00:34, Hugh Dickins wrote:
>>> What would help a lot would be the implementation of swap entries
>>> at the PMD level.  Whether that would help enough, I'm sceptical:
>>> I do think it's foolish to depend upon the availability of huge
>>> contiguous swap extents, whatever the recent improvements there;
>>> but it would at least be an arguable justification.
>>>
>> Thanks for pointing this out. I should have thought of this as I
>> have been thinking about fork a lot for 1G THP and for this series.
>>
>> I am working on trying to make PMD level swap entires work. I hope
>> to have a RFC soon.
> 
> I think you may have missed Hugh's point a little bit.  If we do
> support PMD-level swap entries, that means we have to be able to find
> contiguous space in the swap space for 512 entries.  I don't know how
> hard that will be, but I can imagine it's not that easy.

Ah so my understanding is that with CONFIG_THP_SWAP enabled, the swap
allocator already tries to allocate 512 contiguous swap slots for a THP.
With CONFIG_THP_SWAP, each swap cluster is exactly SWAPFILE_CLUSTER (512)
entries in size, meaning 2M will fit perfectly. Clusters track their
allocation order (ci->order), and the swap allocator maintains per-order
free lists (nonfull_clusters[order]), so THP-order allocations are
directed to clusters already dedicated to that order rather than
competing with base-page allocations.
The per-CPU caching (percpu_swap_cluster.si[order] / offset[order])
should further ensure that consecutive THP swap-outs from the same CPU
reuse the same cluster efficiently.

With PMD swap entry we will change how the page table records it
(1 PMD entry vs 512 PTE entries). Hence we wont need to allocate
page tables and would help to address Hugh's valid concern
of have to allocate pagetables if there is no pagetable depost.


