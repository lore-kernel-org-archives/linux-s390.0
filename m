Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795107528;
	b=NiBdMh/8Xr6tac28oBdFnq2tpEk4UGnpLrWgSdHdGQnWBEzwLhENHOSatvHQNK4Z6k0z
	 m2JKN6ImXa+k9MnF8sRy5dQIVz7D4ywqsYkdp2WxcRFw3S3a1PHx0ums64EmnF4caVhyU
	 j+G7eVwYNtwSzu2mHn3oJkIozMnx/3l/C6p4BvW+JIbO9KJZMYYEDQ33totxnABT/UgLN
	 xicXHUG2oqPPnvtACrzueZb4OgJykjFiftlNHoZ2RBQKS4hb8f9OwNPcGSb0IAeNTsBHr
	 JLiFD3mf53F31FWSFEIRLQkAKl/TqPwIPSWTqCqd9VNUAzQ/A0ITssbdVNZirnHUfzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795107528;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=zlwPBqQep+gKK2qUpmm59NmPvSqltf2AvxyET+CzK7A=;
	b=E4EXyK6gmUe6RpHJO6LHkRCP4DK0MJ340rPpgydLCoCpE6bx79ToD/zPHIXsNAshWkzl
	 7Mru/kjITQficBJAzg0Pn/1A3niLfKNYdAXgr6KsVAVeFRGlbvYkC0fg4/lj46MPBW6FX
	 P7ZKnXZ9K8fz/rpKnAmwr/OR2+XKAAGzZDU3i1UXUY/fQ8LNUw9kqvQG5j0y+yE4ygW8b
	 yJB0qlcLiacCkDjlpWJgCm2wucGViBJUaeyi7iHtCC46dZUZrG4NmjUGIGPRwC9UCLG5o
	 YlG5Y+qGx0NdB/kIDVksvGRjqX1h2ANJoGeySB9jEvXu6K2gw1pV2JndQGGGw0Bdegg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="E5i7Q/+h";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D14606A320;
	Thu, 19 Nov 2026 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=E5i7Q/+h
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 369D81F000C4;
	Thu, 19 Nov 2026 16:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795107528;
	bh=zlwPBqQep+gKK2qUpmm59NmPvSqltf2AvxyET+CzK7A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=E5i7Q/+hFAt1BZyoYv9K52aBMARN3gdGsb5Hd0fQ/Ncp/+zhT8G31FoYRdlEw9Fn3
	 Sv+XgjLp3xuNMNpx/Os3SmlGfvIIHLdH2mYwaI5iELfsOsLyTUsARWkPokMdfVW/en
	 O8PK7XTxuWnoNq6GZCrKl3UAB2U73P0rQH5Vv1pscf1jAgHlAzkIgcDmTiAouU5CTh
	 UxDrMliSDGsiwiNVD/eiUXHfMjCrQxsGij/ugStyy/FnDo2XBORIHEmScDx9CtuoBS
	 jMnqM80TV0xX8lLL7RBdcUfGHKDvlixfkeVj8vxoCNAl/wCagQrid6mczsIKjX6PWA
	 rASJf86jUOqlA==
Message-ID: <68dcdfbc-2755-437f-bf58-d175b1740afd@kernel.org>
Date: Thu, 19 Nov 2026 17:58:34 +0100
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
Subject: Re: [PATCH v2 08/15] mm/hugetlb: serialize page-cache allocations
 with truncation
To: "Oscar Salvador (SUSE)" <osalvador@kernel.org>
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
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, stable@kernel.org,
 Josef Bacik <josef@toxicpanda.com>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
 <20261116-fixes_hugetlb-v2-8-4dd9e94ea9ac@kernel.org>
 <av683B0FDj-xB-7w@localhost.localdomain>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <av683B0FDj-xB-7w@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/19/26 10:09, Oscar Salvador (SUSE) wrote:
> On Mon, Nov 16, 2026 at 07:29:29PM +0100, David Hildenbrand (Arm) wrote:
>> Truncation can remove an inode reservation while a fault is still
>> allocating its folio. UFFDIO_COPY and memfd pinning can also consume
>> reservations beyond the new i_size. This can underflow resv_huge_pages
>> and leave folios beyond EOF.
>>
>> The main issue is that truncation takes the fault mutex for folios in
>> the page-cache, but it has no clue about faults that are still being
>> processed concurrently.
>>
>> Matthew Wilcox raised mapping->invalidate_lock in a different upstream
>> hugetlb locking discussion:
>>
>>   "although I wonder if we still need the fault mutex array, given that we
>>    now have mapping->invalidate_lock?"
>>
>> While it likely cannot remove the mutex array entirely (concurrent page
>> faults have to sync ... ), we can at least use it to fix this problem.
>>
>> Hold mapping->invalidate_lock shared across the size check, allocation
>> and page cache insertion or reservation rollback. Truncation takes it
>> exclusively around i_size_write() only for now: it waits for concurrent
>> allocations to finish updating the page-cache or rolling back reservations
>> before changing the size. Subsequent allocations see the updated i_size.
>>
>> Let truncation release the lock for now before unmapping and removing
>> folios to preserve the existing lock ordering. Cached-folio faults and
>> private allocations do not acquire the new lock.
>>
>> Use it to synchronize with truncation, keeping the fault mutexes to
>> serialize allocations for the same index.
>>
>> Locking order is now:
>>
>>   fault mutex -> hugetlb VMA lock (read) -> invalidate lock (read) ->
>>   folio lock -> PTE lock
>>
>> And on truncation:
>>
>>   i_rwsem (write) -> invalidate lock (write)
>>
>> Add hugetlb_pgoff_valid() to not repeat the same size check multiple
>> times. Memfd needs a bit of care, as it traditionally allowed partial
>> folios to be pinned: the size check in memfd_pin_folios() allows for
>> that.
>>
>> Fixes: 1c9e8def43a3 ("userfaultfd: hugetlbfs: add UFFDIO_COPY support for shared mappings")
>> Fixes: 188a39725ad7 ("hugetlbfs: revert use i_mmap_rwsem to address page fault/truncate race")
>> Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
>> Cc: stable@kernel.org
>> Reported-by: Josef Bacik <josef@toxicpanda.com>
>> Link: https://lore.kernel.org/all/ajMfdQf-Fspwmstr@casper.infradead.org/
>> Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
> 
> Acked-by: Oscar Salvador (SUSE) <osalvador@kernel.org>
> 
> Just one thing:
> 
> mm/rmap.c has a description of the lock ordering for hugetlb:
> 
>  "
>    * hugetlbfs PageHuge() take locks in this order:
>    *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
>    *     vma_lock (hugetlb specific lock for pmd_sharing)
>    *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
>    *         folio_lock
>  "
> 
> We should update it to reflect the updated locking order, right?

Indeed, thanks!

@Andrew, can you fault in the following:

From d050587df932067bcadb618cf8b72604bc9af58e Mon Sep 17 00:00:00 2001
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Thu, 19 Nov 2026 17:57:41 +0100
Subject: [PATCH] fixup: mm/hugetlb: serialize page-cache allocations with
 truncation

Update documented locking order in mm/rmap.c.

Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/rmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/rmap.c b/mm/rmap.c
index 0faef46806e5c..a452db02826e8 100644
--- a/mm/rmap.c
+++ b/mm/rmap.c
@@ -48,8 +48,9 @@
  * hugetlbfs PageHuge() take locks in this order:
  *   hugetlb_fault_mutex (hugetlbfs specific page fault mutex)
  *     vma_lock (hugetlb specific lock for pmd_sharing)
- *       mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
- *         folio_lock
+ *       mapping->invalidate_lock (when allocating page cache folios)
+ *         mapping->i_mmap_rwsem (also used for hugetlb pmd sharing)
+ *           folio_lock
  */
 
 #include <linux/mm.h>
-- 
2.56.1


-- 
Cheers,

David
