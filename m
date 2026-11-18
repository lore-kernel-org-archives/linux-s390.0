Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794992569;
	b=hwuauEM1bBDk/fXIhUHpbTIN6BGaEo0LXRnGPZhoos+KXjmATOH83kUGTwjma6RG+oMA
	 hx2iSKmgWUdqMKWeJYZpOrpGDxVPkPAQm9+GEWUAWfHgCNII5hFLHuOquUE+yiQpYwhIZ
	 RJ6bCBQOZS+j/uTqbhP7VydYQ6lKYYWhXyyq4tv2+//ns3Rzwer/q3cbawPTdlZFVpAp+
	 HC9OiM0xqI9XwLfD/yw9DI3CQPJCaZg7jAXiWiPiCoOzAWshShpjg2VBDKozUDJ9JgQRd
	 mpOJxYVDcCTDI838U33rWxfx+8vwEpSypS2uDGey5ozK60L/JCJx3x/ujTNWFW70Pcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794992569;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=pLn6fncZGa4fgL+fOqpgq5YRYTggYFIcZ3+38mE0Nvc=;
	b=tFRMeXZZ/NlXTLlNdxPCb3+KcHZF3AQQ0GafY+E8qmKcEmS1WBnzbGO3xWy94E9+cAuq
	 b0mdxi/AN3VK2Z0HjU4SsHPd9nE9D/1SEN5RHcsja0GNF5E6s41N4ZrvhbTYtluheZ4Zb
	 2KAOnef5zaujWhdEnctAR+vLMEJYuo831aHDQ8j12xBfc7MBJd2Rex6XHCSCaKZyspR+4
	 9g4t/V/8H0DcywLJVtI2ZFL0W6kujp/kVk6et4VfZBH8g6se0R1hrsLsyqefSW5VJzSK4
	 k0SpKTu50bvs31UMUkjfX7ssHvGoi0ba2gb73+VV2P00GvLxuse/WslUFCb5vz6680A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRGdLTAs;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82486606A31C;
	Wed, 18 Nov 2026 09:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRGdLTAs
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DA511F000C5;
	Wed, 18 Nov 2026 09:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794992569;
	bh=pLn6fncZGa4fgL+fOqpgq5YRYTggYFIcZ3+38mE0Nvc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=JRGdLTAsXBvvBhLBMNip+PBzFeCWDHNGjtE/29dINX+9MVgmhVBLES9E+pEgXct03
	 EaY9TvK82FuPptmwjz5VrUCPSr+2JAdhpavzvKdMddAWW3XiiJkmTW4yxfYTFqrE4s
	 llB+3lnJvZm6LHLGcjo+pQ0tetlRwHocyPblj+j3nThU/CjmJ/zmDUfGDxnCMo2R16
	 ByEQjpAM4b4jvbfCpeb7+b9bdmuTsTgxEbGSutaNgNz+SAjG9Bc4/NiSb5P9tlV7Yc
	 vqjdaNvm0Bg16bzvsTMwBHAw2pVe6rUiiZpVj+Fd4v4PtQuJ8Jwy7v5d+MplCUwp5P
	 Py3LGm7/SaKLw==
Date: Wed, 18 Nov 2026 10:02:36 +0100
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
	stable@kernel.org, Chris Mason <mason@kernel.org>
Subject: Re: [PATCH v2 06/15] mm/hugetlb: fix mremap() racing with page
 migration
Message-ID: <av1prAuFVxsdBsIP@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:27PM +0100, David Hildenbrand (Arm) wrote:
> Migration of anon hugetlb folios walks the anon_vma, so the file's
> i_mmap_rwsem does not serialize it against move_hugetlb_page_tables().
> 
> There are various issues with that. Most importantly, move_huge_pte()
> releases both page table locks before the TLB is flushed. Migration can
> then find the destination entry and finish migration, reusing the old
> folio while the TLB still has entries cached.
> 
> Hold the anon_vma write lock across the move and the final TLB flush.
> This also prevents concurrent rmap walks from missing entries moved
> during rollback.
> 
> When we must allocate a destination page table, flush the TLB before
> dropping the anon_vma lock, then reacquire it after allocation.
> 
> Dropping the lock only works around lockdep: hugetlb folios are not
> reclaimed or migrated by allocation compaction, but their anon_vmas
> share the lock class used by ordinary anonymous memory. Having a
> separate lock class for hugetlb's anon_vma (like already done for
> i_mmap_rwsem via hugetlbfs_i_mmap_rwsem_key) requires more thought.
> 
> There is a concern that this can block page migration of anonymous
> folios quite a while ... which is not really different to what happens
> to page-cache folios today. If ever a problem, we can temporarily
> release the lock.
> 
> So let's keep it simple for now.
> 
> It is a shame that hugetlb has to implement everything core-mm implements
> in a different way that just screams for problems.
> 
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
> Cc: stable@kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
