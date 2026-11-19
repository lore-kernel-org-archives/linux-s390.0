Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795080331;
	b=e/gg/t2oBsmLw7IyD++kFkesNW3N4S9WBkqkOJTXM4OupesuHGhZP2RtcZD0N9hp6zv9
	 kFO5YLtqY4hUEXDDPb77yoEJKTcSf02hkP9jOwGuCbI8lLhkrQvaH7rnfUeJb2B4s8drP
	 NfyiP9zFMVt0Dwg4P4y4SymrGqkrGQdy4uQrIez7NBCgGjKRcoxQXolk/YjacUBqpD8VX
	 CG/Y4BhLOuxnIRkGY5RR/CIMagSCIijDSmUQbx2DO2Elyfcuj7LKNi4fNqSoVzJCRb0xk
	 xGB20N5FWIQLh9eDsH0AGU67OoAvMHisnmo9vCXhtsON5v19cL+3Nc4LwRpP0KjBkTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795080331;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ykzNXonS4EXpUTddVAokRRmNVBMx3zTvxuXv3tt6jrA=;
	b=tOHZmFUQqCDS1UHv0n01FV2mlmvd8EHTUhiIbbrXdiAssdeJYCzK7KyX3M83SfkADz0x
	 Ymjyj1e/+BVzgmcGcR9WXI9iZX2HAwGJ/FgyeC6nVR9EcX24V8UVilrLwyZLvKBpqcLOC
	 FiCY+nfwESIj9qfZx0vcS7lnvOhyd0sAkuPGIXuQSXLk7WuT8UAmhbY5ghXyc/ugIq9wZ
	 vI6rBh1f9RjqQ26H7qewBLocWuTQ60RYb3ty7hyc5XmmzUKQ1d72lRwOh0kXwPid3LDpv
	 Zuma5bJgfQsnHR/15ExkwVIaLU+gy7N8pl14KCtYnrr6fq2X3vZjptblNuWB2uQwSAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="U/a7b/tR";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4209606A320;
	Thu, 19 Nov 2026 09:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U/a7b/tR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC2281F000C5;
	Thu, 19 Nov 2026 09:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795080331;
	bh=ykzNXonS4EXpUTddVAokRRmNVBMx3zTvxuXv3tt6jrA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=U/a7b/tRhB8CSGT20eIHplkYFnOjIl0jl1P2BKWpqserpdTar8rZB/iL+28k4xgEX
	 RAe4srUmFH860mmQuuqauf+aCBEZMA05LBWTZJeFuWc4/pDEw7H4zNwyJ9jjFBkEgO
	 P1oN9DABuhlAvY9p6B9nv+OU3L2aK6i2S3Z5jBQRrL3hBhH6u7EDKVIkeVQpciiQ3s
	 gzclqEsBfSrLpqV19oScY15ygIOAL6spSiDl9Ma8gcJSmE8KSomJVIfweRJutFtVJ2
	 gFuDyLF9ZxXpXQaziu8mrHK12yt2wZuazhsdwVwHpf+Sge8TYoD6aWdk9lFGdz4FmE
	 XzmO5ASh87W4w==
Date: Thu, 19 Nov 2026 10:25:18 +0100
From: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>,
	Naoya Horiguchi <nao.horiguchi@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Mel Gorman <mgorman@suse.de>, Andy Whitcroft <apw@canonical.com>,
	Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
	Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>,
	Baolin Wang <baolin.wang@linux.alibaba.com>,
	Vivek Kasireddy <vivek.kasireddy@intel.com>,
	Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
	Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>,
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
	Nick Piggin <npiggin@gmail.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
	Chris Mason <mason@kernel.org>, stable@kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v2 13/15] mm/hugetlb: fix reservation leak on min_size=
 mounts
Message-ID: <av7Afqpp-C9pqcR3@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-13-4dd9e94ea9ac@kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261116-fixes_hugetlb-v2-13-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:34PM +0100, David Hildenbrand (Arm) wrote:
> From: Chris Mason <mason@kernel.org>
> 
> Failed allocations for CoW mappings can leak reservations on hugetlbfs
> mounts with min_size= and no size=. The leaked reservations survive
> unmount.
> 
> Note that this is only an accounting error and not a memory leak.
> 
> HPG_restore_reserve makes free_huge_folio() restore the global
> reservation without returning it to the subpool. This assumes the
> reserve map holds the reservation. However, a CoW mapping may have no
> reserve map, or the map may already account for another folio at the
> same index.
> 
> Commit 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking
> folio from subpool") allowed owner CoW allocations to consume subpool
> reservations. Commit 51e1de00acdb ("mm/hugetlb: simplify
> vma_has_reserves()") later extended this to CoW mappings without a
> reserve map.
> 
> For example, with a subpool minimum of one page and a
> MAP_PRIVATE|MAP_NORESERVE mapping:
> 
>                                       subpool       global
>                                       rsv_hpages    resv_huge_pages
>   1. Mount                             1             1
>   2. Allocate using subpool reserve    0             0
>   3. Free on error with flag set       0             1
>   4. Allocate without a reservation    0             1
>   5. Free and return to subpool        1             2
> 
> Call folio_clear_hugetlb_restore_reserve() for CoW mappings when
> map_chg != MAP_CHG_REUSE, meaning no reserve-map reservation was consumed.
> This lets free_huge_folio() return subpool reservations to the subpool
> on error.
> 
> Do not set the flag again if region-cache allocation fails during
> rollback: that would undo the flag clearing and skip returning the
> reservation to the subpool. This also fixes the older case where setting
> the flag invents a reservation for an unreserved allocation for a CoW
> mapping.
> 
> The doc still mentions PagePrivate at various places: future work should
> clean that up.
> 
> Fix generated by an LLM and sent by Chris Mason in private.
> 
> Fixes: 846be08578ed ("mm/hugetlb: expand restore_reserve_on_error functionality")
> Fixes: 58db7c5fbe7d ("mm/hugetlb: fix avoid_reserve to allow taking folio from subpool")
> Cc: stable@kernel.org
> Signed-off-by: Chris Mason <mason@kernel.org>
> [ david: simplify comments and improve description; updated Fixes ]
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
