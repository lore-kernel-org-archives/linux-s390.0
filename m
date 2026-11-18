Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992483;
	b=eG0ZXOLwiFg8Cqxw8TypXz1XE2Ks8yQqkRJnZCM8JYlforeHD+DZMrc9jsC7vnBtLPXq
	 wWvE0MXHFRUQhRBEcUy68Ul5sJXIwZXNfQOGCY6C+YUhlyHD54oGVY51sSMZnGxSPtGce
	 m8hCRIwqvhklea76+mjdRstBOhqBvdUKLO5Y0poQDgSCQKv7ImOuS6IPG4ZphAFfCHcBx
	 P9bKlLr7KiVxSHL8/LsNq4DFxjrIlt08960HiwcWIRZ9XSPEModPwNSV54jQz4LGxV4qy
	 4DGWxOsWhI/ERVCS6LHudvSA8X7kEDosLaQyyMxYBsqk9CDjNsyyaKenx3hOGIwQ0lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992483;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=r3zKqF+kTssGoSAglKwaVff1yakHy07R69gEEdogQZI=;
	b=dDhST5HYDTtZ0b2Jo97a3Hioegk7UUnWECOzO2E5oSum/PQIHVVcOpf4bwxNkO/hS3q/
	 LR0CMbhOFMmsIKt3T9YdbAgdIpNpHZ1O2yC7hBtJPZAfQvy5cSd6VHVBd0TI7+mRa+3yq
	 305q99nhq0NzvnXVQTdmDnxqlNfo7EslSMkwYRvNjlagkms2fDLtEfimmh3mIXd89Iqgf
	 qhtQ28+k/rZ6tMRNEZ3ofQQmrPAIPtfEH9U2iopC4oZuxj1pOXDflf3XcZLu4BNeoLhQk
	 OmfdmvUZTAPtg6hOXdTTIvwNXeJhYpedu0EpJjXPIXRJszABbuL6TKcs0k+6pXsOA0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOfeMSw0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70113606A320;
	Wed, 18 Nov 2026 09:01:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fOfeMSw0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6FF11F000C5;
	Wed, 18 Nov 2026 09:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992483;
	bh=r3zKqF+kTssGoSAglKwaVff1yakHy07R69gEEdogQZI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fOfeMSw000DsM9A69Oli12bUEKPpD/X/XKxt/LB8/e357NHtOSWRFyQzYkzDeHR87
	 XPi6EI22BdpJ5u+QsVeCPZG/YoLcdMwq42Q85DcDpnfiYQ2vJp71xxVh8wAl9iVs5/
	 xKfx/pQepXEI2isOmHqlVgWhSKlgPftdJnAybpFWZWvqED5PDisRhL3hUckZQqQ7Su
	 7RQk36bKKUsNorsTBAhk85iO58854iR1HSnxFh0L42vALOoIhUyq4sHJIEnw8ijRoE
	 d/HzpOLB+C0l7pEFc1ZU74iKvRkljEn2qzsXd0tjhoNr9+bN3dCopLwl/u2J9yy/pK
	 M/kqh8c1Y0FOw==
Date: Wed, 18 Nov 2026 10:01:06 +0100
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
	Josef Bacik <josef@toxicpanda.com>, stable@kernel.org,
	"Gregory Price (Meta)" <gourry@gourry.net>
Subject: Re: [PATCH v2 05/15] mm/hugetlb: keep surplus folios when the pool
 shrinks
Message-ID: <av1pUsRqz3qA0UGi@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-5-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-5-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:26PM +0100, David Hildenbrand (Arm) wrote:
> From: Josef Bacik <josef@toxicpanda.com>
> 
> Surplus folios are accounted per node. When shrinking the pool,
> set_max_huge_pages() removes free folios through
> remove_pool_hugetlb_folio() and accounts them as persistent folios.
> 
> It can select a node whose folios are all surplus and leave its surplus
> count larger than its total count. Free surplus folios can back
> reservations created by gather_surplus_pages().
> 
> For example, with nr_overcommit_hugepages = 8 on two nodes:
> 
>   (node columns show total/free/surplus)
> 
>                                       total free surp   node0   node1
>   mmap() of one page, bound to node 0     1    1    1   1 1 1   0 0 0
>   node1/nr_hugepages = 7                  8    8    1   1 1 1   7 7 0
>   nr_hugepages = 6                        7    7    1   0 0 1   7 7 0
>   munmap()                                7    7    1   0 0 1   7 7 0
>   nr_hugepages = 0                        1    1    1   0 0 1   1 1 0
> 
> After shrinking to six persistent folios, node 0 has no folios but its
> surplus count is still one. Releasing the reservation cannot clear that
> count, and shrinking the pool to zero leaves one free page on node 1.
> 
> A later write to node0/nr_hugepages underflows the unsigned per-node
> persistent count: 0 - 1, resulting in allocation of many folios.
> 
> Use persistent_huge_pages_node() to skip nodes with no persistent folios,
> as adjust_pool_surplus() does. This also excludes temporary folios.
> 
> Fixes: e4e574b767ba ("hugetlb: Try to grow hugetlb pool for MAP_SHARED mappings")
> Cc: stable@kernel.org
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>
> [ david: cleanup code and description ]
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Tested-by: Gregory Price (Meta) <gourry@gourry.net>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
