Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793352053;
	b=4z4v4Wl2iy1dsh5i1Ypf5d9FjxsE/4kPUV95cCf1UGt3LG5SmFD0vIWdDSleq0f3lkRc
	 TwOKbwLdAgMqSlpsiGJL2ymbc5a8vR/ePSXfwtsPfsgfwRR6PKxWa1lZfcEtoI8QfTPBb
	 hgZnVBpQxOirLMvwpUebzNziEfEwyn3Idw6xb4grByw7QRPa+S/EPi9zy36X+/RK+qPS0
	 HiA2xS4rfH2U6ys0WcW0p7RrggmCFFo2NZbj8c0jMwCI/PGzXx83yOst7SDJ4aTqlOl8L
	 Ic+IOm4ZRaq5BuaDhQ1EOv2fyUa/aRjGALaUjpZPKpVy20BZl4clNY+IGp3q6W68d/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793352053;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:Content-Type:Mime-Version:Subject:From:
	 In-Reply-To:Date:Cc:Content-Transfer-Encoding:Message-Id:References:
	 To:X-Mailer;
	bh=DwWDiQU31GhAJkKLOok0q5GmDT5UejWxDA7k4JTVj4M=;
	b=l0vMYPWBw7iRuRfVdxz7S5eA1ww/Eq+fHKD0ZoK9rVb9r0E/kAIpBL7FBzPRbHWSUf5r
	 lgW4wW6E2c3y1P0/O1klo5e6g0Ry/oVZMhi78gXoZrB7iks0il11GdCUJIuoipm8Z9mfd
	 BxEmn2r9QefCj0HBjVw/cNKJLJkEevF2bhLMnkqCEAdIcCj5Sa7L+b+SckG0VjD/271lp
	 ppjdMmskX6Ji6vHjx5DlqIpNsymFwVNX3INsSYvaalNsXJsM6T7sb8SzUF14uS8JllvBi
	 wVTiBsSCtwOKK5cpXnbmzcNz6aFn1GMfyjYT2kSkePtxts/PSpVSoulakMHzPsfgw8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d87jxZYs;
	arc=none smtp.remote-ip=91.218.175.84
Received: from mta0.migadu.com (out-84.mta0.migadu.com [91.218.175.84])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DCA606A31D
	for <linux-s390@vger.kernel.org>; Fri, 30 Oct 2026 09:20:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8DCA606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=d87jxZYs
X-Envelope-To: linux-s390@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=DwWDiQU31GhAJkKLOok0q5GmDT5UejWxDA7k4JTVj4M=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793352050; v=1; x=1793956850;
 b=d87jxZYsXzSYCQ/xHD6fPWdvBbmfDED2jZYdIP/wz0YMDb65qjez3nTkqQ2OiGGUSbvTbfQM
 4fRPwHh32lyypRcBqLI618nMxfYTKzklpEZuKUGzwqzhkdwzTqJOKu5v5/QYZXXVsjgPD8Ix4e3
 f6sg9vfDv/TQg6Cbx/x5kjZ0=
X-Envelope-To: linux-s390@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 222f0c8429a65a02;
	Fri, 30 Oct 2026 09:20:38 +0000
X-Mizu-Trace-ID: 222f0c8429a65a02
X-Migadu-Flow: FLOW_OUT
Content-Type: text/plain;
	charset=us-ascii
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.12\))
Subject: Re: [PATCH 06/15] mm/hugetlb: fix mremap() racing with page migration
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20261028-fixes_hugetlb-v1-6-a0a033db180f@kernel.org>
Date: Fri, 30 Oct 2026 17:20:12 +0800
Cc: Oscar Salvador <osalvador@suse.de>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@suse.de>,
 Andy Whitcroft <apw@canonical.com>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>,
 Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>,
 Dave Airlie <airlied@redhat.com>,
 Jason Gunthorpe <jgg@ziepe.ca>,
 Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>,
 Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>,
 Randy Dunlap <rdunlap@infradead.org>,
 Peter Xu <peterx@redhat.com>,
 Breno Leitao <leitao@debian.org>,
 Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>,
 Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>,
 Arnd Bergmann <arnd@arndb.de>,
 linux-mm@kvack.org,
 linux-kernel@vger.kernel.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 linux-doc@vger.kernel.org,
 linux-arch@vger.kernel.org,
 linux-s390@vger.kernel.org,
 stable@kernel.org,
 Chris Mason <mason@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9FFF0EF2-A99A-4448-9CA3-50E1733D6232@linux.dev>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-6-a0a033db180f@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: Apple Mail (2.3901.100.1.1.12)



> On Oct 29, 2026, at 04:13, David Hildenbrand (Arm) <david@kernel.org> =
wrote:
>=20
> Migration of anon hugetlb folios walks the anon_vma, so the file's
> i_mmap_rwsem does not serialize it against move_hugetlb_page_tables().
>=20
> There are various issues with that. Most importantly, move_huge_pte()
> releases both page table locks before the TLB is flushed. Migration =
can
> then find the destination entry and finish migration, reusing the old
> folio while the TLB still has entries cached.
>=20
> Hold the anon_vma write lock across the move and the final TLB flush.
> This also prevents concurrent rmap walks from missing entries moved
> during rollback.
>=20
> When we must allocate a destination page table, flush the TLB before
> dropping the anon_vma lock, then reacquire it after allocation.
>=20
> Dropping the lock only works around lockdep: hugetlb folios are not
> reclaimed or migrated by allocation compaction, but their anon_vmas
> share the lock class used by ordinary anonymous memory. Having a
> separate lock class for hugetlb's anon_vma (like already done for
> i_mmap_rwsem via hugetlbfs_i_mmap_rwsem_key) requires more thought.
>=20
> There is a concern that this can block page migration of anonymous
> folios quite a while ... which is not really different to what happens
> to page-cache folios today. If ever a problem, we can temporarily
> release the lock.
>=20
> So let's keep it simple for now.

Make sense.

>=20
> It is a shame that hugetlb has to implement everything core-mm =
implements
> in a different way that just screams for problems.

Yeah, nightmare in MM.

>=20
> Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage =
backed vma")
> Cc: stable@kernel.org
> Reported-by: Chris Mason <mason@kernel.org>
> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>

Acked-by: Muchun Song <muchun.song@linux.dev>

Thanks.

