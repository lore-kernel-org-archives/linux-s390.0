Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794845442;
	b=vysj6ksWz9ZXQCbpn2T54LGbrQhOXeN5O38QDnr6psVkdnuLiXAnN2MfEsS49qfm+TYT
	 MYllDoMgdaUCJwHidBp7KdFpP592iv9eX6imgB5+ulyI83hSHRikqsnPdzEgeJVyXBD46
	 CpaefI7IVisCh4lschc1HPrZ+Y4nMYAZuCRIi/lypVWqK9aSp0V0+AoeSJJrRfInQ+ruW
	 lpDcaW1LJtoF3XvgatAGVa9TnBgk4t1xEWZstQA4ZXfLA5n+hEsk1idQ5ZzB0IrQYp93w
	 wAGnfqEtU3ritWixUQdeama6ZWQp0Kri8aM+In7i4jpIQjEIFbtvKA9jh43l3u6hFkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794845442;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=Tn1OgnHLvY8pB7bssQ17l15coGdAwQFCYSQKrIsgJ7c=;
	b=AZ82yViIkaMnKqzE2/XvBpolYseNDzH1Pgij6n91pHG1bo+FhxH4iwp1OFB42KSohFfz
	 L7grJnyEeVMzLZe5PsgInsSCma7Xk5inRsOU/EHOJBQbWeikCfmVRUU4uhpmRJDDKEKsM
	 dJgcPV/+ObwDIbIVkSHDxVbbK9I4czK1Fvf0DhOPVRcxRdlQORSdFlrVKAcqNa2ssjt4k
	 YiThPFertEB5RLSMrm6pRTWeU1T4n8Yl61qdpgyuG0Y9PuYzoJASVl/w5acBgY+K4YBzJ
	 ESC29eDgCPLclhaNm+FsOzEmWa+Jqp7Bh59Ob9yus4eZHglrBS5oC1Emiu3VpWXV8/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Z/hSCkGI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C3B606A880;
	Mon, 16 Nov 2026 16:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z/hSCkGI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2480B1F000C9;
	Mon, 16 Nov 2026 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794845442;
	bh=Tn1OgnHLvY8pB7bssQ17l15coGdAwQFCYSQKrIsgJ7c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Z/hSCkGIBdKjXcFnFifRHR1/s0kmY4LGWQkh2wIyddubLz3E9S++w31sU0xIEGvEj
	 sdVfgd70xVYtY3xbzeD6uP2xU8utBg6CPwMzf0ViCi+UhH7WC53J+Gy3j26hlLlyLb
	 Slen8p26azocIdX0wyqkh6C4t6FEepzLw7Mb7188J/GU1+sBye81CTl1wFMYHk/5pI
	 xh9UN0djjiGcYJrahn7JZqZyQv/NV0BgDv2btFbP5MI5X4RSV7iRDtyY077WxaqrnR
	 yv0sMr0DS0H6UIL3ovg534U3UHePyM/6sqvgKtgwRyk+errg6ljzVXJlvrt4/GhbRB
	 e9/hbMXMgC7Fw==
Message-ID: <7544e13b-e926-4350-a48a-cd76df456bd2@kernel.org>
Date: Mon, 16 Nov 2026 17:10:28 +0100
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/15] mm/hugetlb: fix reservation leak on min_size=
 mounts
To: "Gregory Price (Meta)" <gourry@gourry.net>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>, Baolin Wang
 <baolin.wang@linux.alibaba.com>, Vivek Kasireddy
 <vivek.kasireddy@intel.com>, Dave Airlie <airlied@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
 Chris Mason <mason@kernel.org>, stable@vger.kernel.org
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-13-a0a033db180f@kernel.org>
 <179467919954.482102.5381456550239958011.b4-reply@b4>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <179467919954.482102.5381456550239958011.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/14/26 18:59, Gregory Price (Meta) wrote:
> On 2026-10-28 21:13 +0100, David Hildenbrand (Arm) wrote:
>> From: Chris Mason <mason@kernel.org>
>>
>> Failed allocations for CoW mappings can leak reservations on hugetlbfs
>> mounts with min_size= and no size=. The leaked reservations survive
>> unmount.
>>
>> HPG_restore_reserve makes free_huge_folio() restore the global
>> reservation without returning it to the subpool. This assumes the
>> reserve map holds the reservation. However, a CoW mapping may have no
>> reserve map, or the map may already account for another folio at the
>> same index.
>>
>> Commit 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking
>> folio from subpool") allowed owner CoW allocations to consume subpool
>> reservations. Commit 51e1de00acdb ("mm/hugetlb: simplify
>> vma_has_reserves()") later extended this to CoW mappings without a
>> reserve map.
>>
>> For example, with a subpool minimum of one page and a
>> MAP_PRIVATE|MAP_NORESERVE mapping:
>>
>>                                       subpool       global
>>                                       rsv_hpages    resv_huge_pages
>>   1. Mount                             1             1
>>   2. Allocate using subpool reserve    0             0
>>   3. Free on error with flag set       0             1
>>   4. Allocate without a reservation    0             1
>>   5. Free and return to subpool        1             2
>>
>> Call folio_clear_hugetlb_restore_reserve() for CoW mappings when
>> map_chg != MAP_CHG_REUSE, meaning no reserve-map reservation was consumed.
>> This lets free_huge_folio() return subpool reservations to the subpool
>> on error.
>>
>> Do not set the flag again if region-cache allocation fails during
>> rollback: that would undo the flag clearing and skip returning the
>> reservation to the subpool. This also fixes the older case where setting
>> the flag invents a reservation for an unreserved allocation for a CoW
>> mapping.
>>
>> The doc still mentions PagePrivate at various places: future work should
>> clean that up.
>>
>> Fix generated by an LLM and sent by Chris Mason in private.
>>
>> Fixes: 846be08578ed ("mm/hugetlb: expand restore_reserve_on_error functionality")
>> Fixes: 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking folio from subpool")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Chris Mason <mason@kernel.org>
>> [ david: simplify comments and improve description; updated Fixes ]
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Commit message is still hard to read :| (or maybe HugeTLB is just awful
> and no amount of massaging the message will ever help this).

It's just absolutely horrible stuff.

> 
> Maybe note - this is an accounting error only, the pages do not leak.

Ack, I will add this.

> 
> Was able to reproduce the issue with a UFFDIO_COPY the provides an invalid
> invalid source address (src=0).
> 
> 1. Create the pool and mapping (hugetlbfs w/ pagesize=2M,min_size=2M)
> 2. invalid UFFDIO_COPY  (kernel allocates, fails the, rolls back)
> 3. Close uffd, cause a normal fault
> 4. Unmap and truncate the file
> 5. Remove the file and unmount
> 
>                   Base                    Patch
> step 2:  total=2 free=2 rsvd=1     total=2 free=2 rsvd=1
> step 3:	 total=2 free=2 rsvd=2     total=2 free=2 rsvd=1*
> step 5:  total=2 free=2 rsvd=1     total=2 free=2 rsvd=0*
> 
> Result looks correct to me.
> The code hurts my brain but looks reasonable.
> 
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>

Thanks!

-- 
Cheers,

David
