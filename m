Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795079400;
	b=STWkTssUEa38N5IzESJHjEsN5cnh1+qBfK7aZX61LtJTaUyFVB/H4GLwMIyEWpYXk8R6
	 EcZw463Brn7Sc4I7cw29RMQbP0b3HXbhM7qwN4Kl0vUYUr8mbpjsvRofOCqh0hbg1X0PI
	 TmVwiKwFwELX1NvLOly+X4IVqqSD3z+xVruiWXawAPQetsPLUit57jipPDRxkZ6uuZsFA
	 64H8GSp8dIkaPWCf3tPaCzguSyEmVJiHNSBuquvx10MQmrG+MKKFbq99hcVH4ai1LLMaR
	 GapFeJ4IJLpCyox08op6zp++faati6FoGNZgIIkqTx++SpUTora0WuoWIYQ6+hSEcGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795079400;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=ZGhE24qIBqiTNN8z+BFa93ke6YAjy7suuxpu/4LDT3E=;
	b=tFSN4AjQVljwhUKpulwYw8JQ863+V2ml31N2hMlDwkQ20bjc63iOrBfXXRMZIkaNSN6z
	 Iw/uWL1JfPxqbsUv+aIyQDfTFNFXYsvDcnFRfVIFp3wRtewi3rQ1NgLr24uATYkqBnnQn
	 X3pxgsHof8sJSQC1OENp5eI5F4Oj6ldoaDa05qsnwscbnMa6QGhR+Ib2xROMjj55R06oV
	 3t1Xl1B3OaKLo+m8l62FySecKMyCDSndDJ/ZTj69pqspmY02Ex9fjUZ9cxo2ZZLYuNM7N
	 t1FedUQZILE5y1qxh9QhoJh6nQq2fIhCtR1hamSLhL/Ni87dti4sio/cXpP1YMCJelw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBOLjtDN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24841606A320;
	Thu, 19 Nov 2026 09:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NBOLjtDN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C2A51F000C4;
	Thu, 19 Nov 2026 09:09:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795079400;
	bh=ZGhE24qIBqiTNN8z+BFa93ke6YAjy7suuxpu/4LDT3E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NBOLjtDNHucTwb27MjevugAZuIv7/bosEyeF0DijnNaXGSk17S47LQkxkz6Wi2F02
	 +bEWRZhQGyz1eabWT0EqltvKgLkeniA4fJ+KRGAhWgvhip5VALR992fXbQDwRqbhpz
	 KpUWQc60q5yZcpiUVe8o4+EjpocWIzN075V/ZUg90SIx7d6cICIXOCxGc9oKiYeHLT
	 zOxQUhJHODAaVcgTSL6YBIpPUOiX8/6xnbJbJZb/lm+rArzgjy1fOiKtj47JjLHy2f
	 H2MhsQ01rf8p0pTvHKT3BkH/KsDrBKz8g17dBXVKzS60/L2AHKoCMYG6nMpy01udOW
	 QygD50i/z1d8Q==
Date: Thu, 19 Nov 2026 10:09:48 +0100
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
	stable@kernel.org, Josef Bacik <josef@toxicpanda.com>
Subject: Re: [PATCH v2 08/15] mm/hugetlb: serialize page-cache allocations
 with truncation
Message-ID: <av683B0FDj-xB-7w@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-8-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-8-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:29PM +0100, David Hildenbrand (Arm) wrote:
> Truncation can remove an inode reservation while a fault is still
> allocating its folio. UFFDIO_COPY and memfd pinning can also consume
> reservations beyond the new i_size. This can underflow resv_huge_pages
> and leave folios beyond EOF.
> 
> The main issue is that truncation takes the fault mutex for folios in
> the page-cache, but it has no clue about faults that are still being
> processed concurrently.
> 
> Matthew Wilcox raised mapping->invalidate_lock in a different upstream
> hugetlb locking discussion:
> 
>   "although I wonder if we still need the fault mutex array, given that we
>    now have mapping->invalidate_lock?"
> 
> While it likely cannot remove the mutex array entirely (concurrent page
> faults have to sync ... ), we can at least use it to fix this problem.
> 
> Hold mapping->invalidate_lock shared across the size check, allocation
> and page cache insertion or reservation rollback. Truncation takes it
> exclusively around i_size_write() only for now: it waits for concurrent
> allocations to finish updating the page-cache or rolling back reservations
> before changing the size. Subsequent allocations see the updated i_size.
> 
> Let truncation release the lock for now before unmapping and removing
> folios to preserve the existing lock ordering. Cached-folio faults and
> private allocations do not acquire the new lock.
> 
> Use it to synchronize with truncation, keeping the fault mutexes to
> serialize allocations for the same index.
> 
> Locking order is now:
> 
>   fault mutex -> hugetlb VMA lock (read) -> invalidate lock (read) ->
>   folio lock -> PTE lock
> 
> And on truncation:
> 
>   i_rwsem (write) -> invalidate lock (write)
> 
> Add hugetlb_pgoff_valid() to not repeat the same size check multiple
> times. Memfd needs a bit of care, as it traditionally allowed partial
> folios to be pinned: the size check in memfd_pin_folios() allows for
> that.
> 
> Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
> Fixes: 188a39725ad7 ("hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race")
> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Link: https://lore.kernel.org/all/ajMfdQf-Fspwmstr@casper.infradead.org/
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

Just one thing:

mm/rmap.c has a description of the lock ordering for hugetlb:

 "
   * hugetlbfs PageHuge() take locks in this order:
   *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
   *     vma_lock (hugetlb specific lock for pmd_sharing)
   *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
   *         folio_lock
 "

We should update it to reflect the updated locking order, right?

 

-- 
Oscar Salvador
SUSE Labs
