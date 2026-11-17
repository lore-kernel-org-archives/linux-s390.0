Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794910582;
	b=DO6rFSQJlH8ARi225hAM429In0pr4TVq7x9fOddOFW2+23QM19dLgUF0tjqSRQWxIFaN
	 I7ggHjo7cHmBlR6WDGZXZEThQTDQWbhk7XQ+OFGm0N8621HvPV9JP0h+x6I0Z5t4p6sGU
	 g+KR3j2gal1TJwjVtAiWa3htAA87J9Jx+5LD3OWpae/EE4h6YaiK2aSN60lc02e5TbzCl
	 unMrt9l7DHj0KU/kbVoZoXKCiNiT+U4Td11Q8cNhE04w2XhPJJ7kMPThYcJm3UlCTPX9O
	 eOYULR/iZHdW8JXWqV6Wz63dawsHxXyha8Z2vs+7TMyX0VJz1PG/SLvAXY2RdrOc7WA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794910582;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=xDYqn2zYmU/muKMWOwZRP/lmMgVBMmIpWntga6OkdHs=;
	b=vjJTc0QhJacXmqUxkCBe0n+8wzEKKVsm1wsFpavdLFP6fSYtPpUu0k93eRGf8EEJiWwp
	 crJZCV/uJsZoCkco1dM4ktOe0EvnmMcyOZ9q7oso+mL7YjgLF3aB6x3PsZ2vw7t/B8lqA
	 IlnLE6X5BMfgMNCI+MZ9+MYenako5LwLOwSqkejEctiJCxY/bO4HUD/IZjxFHRWlmJN8u
	 4Z8IWUTUM1rPwJWhS7ki8RdOrwOH874b7XjWsc28RaavmvwncNTnOHb43lFujDJr3DE43
	 0nyme+GK45v1HIIHsREzjMvRHKZMrlioDFT2uiltcH5jtQFtH0uZii65s/76LQuAcag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UygshCHv;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F921606A323;
	Tue, 17 Nov 2026 10:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UygshCHv
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 127881F000C5;
	Tue, 17 Nov 2026 10:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794910582;
	bh=xDYqn2zYmU/muKMWOwZRP/lmMgVBMmIpWntga6OkdHs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=UygshCHvYb0JI//oaXBOMwL1fJNJ9pPVP3LkGVS6bdBeM3Ve4cREnUxtcv8LLAZ/x
	 VcfcP1mmfCSfntA006QaldiGHIPKUNFKnXCV1y49BwMQo8/w7KmjuejXJutyY5EXWX
	 6tUFM8+8yK8/9stnEWJd9NSxT4S5m35e2WQEik+YhBMiRu3WDYvS2g9v+PYDcVtJhu
	 2C/srRWnTKNb/XrYpcWmevDcAdkhKHhhb9rETxv4dtlUJRHDLanZcejBB6YsQFZA9P
	 wOQzsVP4YB0lsu7IQkIUUbb5PPSOpAyJCS2FZm2ZeYUOUegy9TWNZhnBfrBhqaFGkD
	 vFVdMFSP7HmlA==
Date: Tue, 17 Nov 2026 11:16:10 +0100
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
Subject: Re: [PATCH v2 04/15] mm/hugetlb: account temporary folios separately
Message-ID: <avwpak13vu83aL9U@localhost.localdomain>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-4-4dd9e94ea9ac@kernel.org>
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
In-Reply-To: <20261116-fixes_hugetlb-v2-4-4dd9e94ea9ac@kernel.org>

On Mon, Nov 16, 2026 at 07:29:25PM +0100, David Hildenbrand (Arm) wrote:
> Hugetlb migration might have to allocate a temporary folio through
> alloc_migrate_hugetlb_folio(). Such folios are currently accounted in
> "nr_huge_pages" but not in "surplus_huge_pages". persistent_huge_pages()
> can mistake them as persistent huge pages, as it merely calculates the
> difference.
> 
> If set_max_huge_pages() shrinks the pool at the wrong time, it will turn
> hugetlb folios into surplus folios until persistent_huge_pages() returns
> the desired number.
> 
> After the migration (successful or unsuccessful) either the new (temporary)
> folio or the old folio gets freed: this will reduce "nr_huge_pages" but
> not "surplus_huge_pages", to undo what was done when allocating a
> temporary folio.
> 
> This can result in having more surplus folios than actually allocated
> folios:
> 
>   HugePages_Total:       0
>   HugePages_Surp:        1
> 
> From then on persistent_huge_pages() returns garbage.
> 
> To fix it, add internal temporary counters and subtract them when
> calculating persistent pool sizes. Update persistent_huge_pages() and add
> persistent_huge_pages_node() to make the code easier to read.
> 
> Count migration targets and rejected surplus allocations as temporary.
> Transfer the per-node temporary count along with the temporary flag on
> migration, such that folio freeing will always do the right thing.
> 
> Take care of calling account_new_hugetlb_folio() only after setting the
> folios to be temporary.
> 
> For now, keep temporary folios in nr_huge_pages, so HugePages_Total and
> Hugetlb continue to include them and overcommit accounting remains
> unchanged. The new temporary counters are internal for now and are not
> exported to userspace.
> 
> Fixes: ab5ac90aecf5 ("mm, hugetlb: do not rely on overcommit limit during migration")
> Cc: stable@kernel.org
> Reported-by: Josef Bacik <josef@toxicpanda.com>
> Acked-by: Muchun Song <muchun.song@linux.dev>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>

 

-- 
Oscar Salvador
SUSE Labs
