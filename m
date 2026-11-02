Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626975;
	b=faxNcJHL7IE/iUmefENgS04/4ZPBi5ILIMMZ+20oBJhhRcHR78mrldT1Kp87J+D7/uZE
	 Wb17DhE58BgdIIhVR/JldHmE5hELazLA86kU0E4Szki9ugXzaj0dB480OmtPJYYCeoxgO
	 KOs1rDGMBiI5I9Z8DkdGKMryJZn84+H4lJoXqbc64dUZaMRjU+FYv9Kl2E0r9CKv+Kyx1
	 CCRyGqPc4bjNt8NrXsqwS61Ya0x+u7FgHprtYc6TVSzp+eS8s0583N8Fg4UJ53sB/zURz
	 8LUjquR9u/bEIs8U2lSdODLxTATHDczpyPwVg0jq29W73o32rc4O9LMzJFQn9Elx18A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626975;
	h=Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:From:Content-Language:Autocrypt:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding;
	bh=N92l3jjvO00CtpEZOu8rveygTDy+OqbCyAbm8AeBzYI=;
	b=GbqpJuLhRMKsKFKMOQJKXkJ+Jahc8KsNswsdEYyuR1p7lH6/9T2cPSO1q2d0wA7IJUPP
	 lvN3m6eeXys9fC4GzubBOnxjjaPVjIQBVJ7M5EZa3yOWXKDBOuYx6No0ZhX0yh/BHD+f6
	 BInUWLEDjYgtcbRF4jbDDh6b65D2yysMfW2sl8HDqFHzVrZCwJEt/U6jx5VEVpoRvE+Ma
	 UnXfsQjX8kfQvFYJQ4vmnORaCV/Nz7iNIDnoptbdBZyVViuQaXHGTQlxULQDLspWPiE7B
	 e2lhp3Rjyhu/t9jJdB81eJpmK4hQcrJhlC82yf2EXyDLDftLeDOdbqNGERvUuZ9c51w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tl7djDwB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3AAC606A324;
	Mon,  2 Nov 2026 13:42:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tl7djDwB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11AEB1F00A17;
	Mon,  2 Nov 2026 13:42:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793626974;
	bh=N92l3jjvO00CtpEZOu8rveygTDy+OqbCyAbm8AeBzYI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tl7djDwBaHB0P3Kuzzh7diRALB/XJy9zz68TIIVk13VN6FbCQF9rlMQTZ+oud5OLl
	 HWdrdGu92Aug5rumrxIjAlxSeiiGCK05JPKz7CjySd03tUiGnIMPEeY4RxKPlM4i80
	 DBwyqwD33qgtQ032BD3Wqd/FqZfcfOycAsImhKBSBE9gr0LdZkH3MJO08/pvLlQQVj
	 svMwhggPT2rj+R+FeAo817O/t8DLzYJ8t2drgE6WPataY85jbXk9eJTHug2kgBiV1n
	 0IhhxesRgcT5odVtnYFc1IRsmkrSeAyFybeAQwiHqdguNoJt3cghZKbcXpqjTLdDii
	 ocf436Tuj7SfA==
Message-ID: <12d9eb7a-a9eb-4e3a-b5fe-abc49f67f212@kernel.org>
Date: Mon, 2 Nov 2026 14:42:44 +0100
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
Subject: Re: [PATCH 14/15] RFC: mm/hugetlb: account restored reservations
 before freeing folios
To: sashiko-reviews@lists.linux.dev, Muchun Song <muchun.song@linux.dev>,
 Oscar Salvador <osalvador@suse.de>, Naoya Horiguchi
 <nao.horiguchi@gmail.com>, Andrew Morton <akpm@linux-foundation.org>,
 Mel Gorman <mgorman@suse.de>, Andy Whitcroft <apw@canonical.com>,
 Miaohe Lin <linmiaohe@huawei.com>, Michal Hocko <mhocko@suse.com>,
 Rik van Riel <riel@surriel.com>, Hugh Dickins <hughd@google.com>,
 Baolin Wang <baolin.wang@linux.alibaba.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>, Dave Airlie
 <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>,
 Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap
 <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>,
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>,
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin
 <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, Gerd Hoffmann <kraxel@redhat.com>,
 linux-s390@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
 <20261028-fixes_hugetlb-v1-14-a0a033db180f@kernel.org>
 <sashiko-outbox-189914@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <sashiko-outbox-189914@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/29/26 21:16, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] mm/hugetlb: gather_surplus_pages() over-allocates and retains surplus folios
> --
> 
> commit d5256483029a06972dd519de19de57831de33af4
> Author: David Hildenbrand (Arm) <david@kernel.org>
> 
> RFC: mm/hugetlb: account restored reservations before freeing folios
> 
> This commit updates anonymous hugetlb folio unmapping to increment
> resv_huge_pages immediately when restoring the VMA reservation rather than
> waiting for the folio to be freed. Because resv_huge_pages can now
> temporarily exceed free_huge_pages while unmapped folios still have
> elevated reference counts, available_huge_pages() is updated to clamp at
> zero.
> 
>> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
>> index 69a5d2c73ee1d..06ef8ba41df7c 100644
>> --- a/mm/hugetlb.c
>> +++ b/mm/hugetlb.c
> [ ... ]
>> @@ -5313,6 +5309,45 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
>>  	return len + old_addr - old_end;
>>  }
>>  
>> +/* Must be called after rmap removal. */
>> +static void hugetlb_folio_restore_rsv_on_unmap(struct vm_area_struct *vma,
>> +		struct folio *folio)
>> +{
>> +	struct hstate *h = hstate_vma(vma);
>> +	unsigned long address;
>> +	long rc;
>> +
>> +	/*
>> +	 * Restore only on the last unmap, otherwise the owner could reuse
>> +	 * the reservation while the folio is still mapped by a child.
>> +	 *
>> +	 * TODO: Handle migration temporarily dropping the mapcount to zero.
>> +	 * TODO: Prevent reservation reuse before the folio is freed.
>> +	 */
>> +	if (!folio_test_anon(folio) || !__vma_private_lock(vma) ||
>> +	    folio_mapped(folio))
>> +		return;
>> +
>> +	address = vma_anon_address(vma, folio->index, 1);
>> +	rc = vma_needs_reservation(h, vma, address);
>> +	if (!rc)
>> +		vma_end_reservation(h, vma, address);
>> +	if (rc <= 0)
>> +		return;
>> +
>> +	rc = vma_add_reservation(h, vma, address);
>> +	if (rc < 0)
>> +		return;
>> +
>> +	/* The restored reservation owns the subpool charge. */
>> +	hugetlb_set_folio_subpool(folio, NULL);
>> +
>> +	/* Account before the VMA can close or fault again. */
>> +	spin_lock_irq(&hugetlb_lock);
>> +	h->resv_huge_pages++;
>> +	spin_unlock_irq(&hugetlb_lock);
>> +}
> 
> [Severity: High]
> With h->resv_huge_pages now able to exceed h->free_huge_pages while an
> unmapped folio is still referenced (for example, via vmsplice() or GUP),
> can a concurrent hugetlb_acct_memory() -> gather_surplus_pages() over-allocate
> surplus folios and retain them in the pool?
> 
> In surplus_pages_needed():
> 
> 	static long surplus_pages_needed(struct hstate *h, long delta, long allocated)
> 	{
> 		long global_free = (long)h->free_huge_pages + allocated;
> 		long allowed_free = (long)allowed_mems_nr(h) + allocated;
> 
> 		return max((long)h->resv_huge_pages + delta - global_free,
> 			   delta - allowed_free);
> 	}
> 
> When h->resv_huge_pages > h->free_huge_pages, (long)h->resv_huge_pages +
> delta - global_free includes the deficit from the in-flight unmapped
> folios on top of delta.
> 
> If gather_surplus_pages() succeeds, needed += allocated equals delta +
> (h->resv_huge_pages - h->free_huge_pages), so it allocates and enqueues
> extra surplus folios beyond delta (or fails with -ENOMEM if
> nr_overcommit_huge_pages only had room for delta).
> 
> Furthermore, when gather_surplus_pages() cleans up unused or aborted
> folios at the free label:
> 
> 	free:
> 		spin_unlock_irq(&hugetlb_lock);
> 
> 		/*
> 		 * Free unnecessary surplus pages to the buddy allocator.
> 		 * Pages have no ref count, call free_huge_folio directly.
> 		 */
> 		list_for_each_entry_safe(folio, tmp, &surplus_list, lru)
> 			free_huge_folio(folio);
> 
> free_huge_folio() checks:
> 
> 	} else if (h->surplus_huge_pages_node[nid] &&
> 		   h->free_huge_pages >= h->resv_huge_pages) {
> 		/* Free this surplus folio that is not required globally. */
> 		remove_hugetlb_folio(h, folio, true);
> 		spin_unlock_irqrestore(&hugetlb_lock, flags);
> 		update_and_free_hugetlb_folio(h, folio, true);
> 	} else {
> 		arch_clear_hugetlb_flags(folio);
> 		enqueue_hugetlb_folio(h, folio);
> 		spin_unlock_irqrestore(&hugetlb_lock, flags);
> 	}
> 
> While h->free_huge_pages < h->resv_huge_pages, free_huge_folio() will
> enqueue the aborted surplus folios into the hugetlb pool instead of
> returning them to the buddy allocator. If the in-flight unmapped folio is
> a persistent folio on node A (where surplus_huge_pages_node[nid_A] == 0)
> and the surplus folio was allocated on node B, dropping the last reference
> to the persistent folio on node A will not free the surplus folio on
> node B either, leaving the surplus folio stranded in the pool.
> 

Damn that's confusing. What an overengineered mess :)

Surplus pages ... another thing that should have never been merged.

I guess we'd have to clamp also in surplus_pages_needed:

@@ -2317,11 +2312,13 @@ static nodemask_t *policy_mbind_nodemask(gfp_t gfp)
  */
 static long surplus_pages_needed(struct hstate *h, long delta, long allocated)
 {
-	long global_free = (long)h->free_huge_pages + allocated;
-	long allowed_free = (long)allowed_mems_nr(h) + allocated;
+	long available = min(available_huge_pages(h), allowed_mems_nr(h));

-	return max((long)h->resv_huge_pages + delta - global_free,
-		   delta - allowed_free);
+	return delta - available - allocated;
 }


And in gather_surplus_pages() we'd then have to be more careful about which
surplus folios we're actually freeing.

-- 
Cheers,

David
