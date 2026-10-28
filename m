Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218493;
	b=XeVohpfNKLqhVVPy1DtYCYnYCxjeUWST9DMn1VPWyPPMAIEhYwNcqD1acQklc6w265XJ
	 bRW9JuCWpECeOejBcFxUzsRFP7Z2n6cL2kFXEYCR0WgbUFkdO1i5Dj6wQ19qTO6/3Kewh
	 qmUTtCbLHLtehuKLdHYI/rf7iunwf/x+6K8JQQ9HRy/RONMagzcPcp4Mb1G9jHW5iHqpP
	 WsixLi6nUvKPpPygQfkeBTNYnwVOPP/B2y4RjttfIdJAM9YtMbtkGAEadj16z7VUx+GaV
	 24DykFLo6ip6fhs+uBJzJOEJVZ2TP7+IfQBh/EVXTLx/jDG1t9/Vvx3ZPIUBChN7iqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218493;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=aoGdqsTvzLA1760x2UeODapQMueGdwb7A8k2qy/4a8M=;
	b=oGV4nQFZrCSMMmBc2UmsGA3UASnOfTXG6vKIed79SfsJgOEDLUW/9ZvwOmryR4P9ya0H
	 TS+t3WDPGJGv5u3JGFMl03k4FpuiXSCevNmYOeleWieQFt92F6LYEjG6/C8BrRrPXeRWX
	 IjQn9jqsoXm5YJWXJs2SKUfrVME7Wkazg6s0AOIp2kMMoZxSsfceQtoHNatTioKnELyPv
	 tGyMskkb9U5qEJr4Y5C2m3TumSGXK6d/QlsyWwIDL4ctYCMR24/WocYgQD5iGZvybLliI
	 7nkQ7/LnqfwaWnVgzQTGjyefoBnapXGtN+Nb/w93S8ZVLDq7ZbCDDfdZu3P6Z5dbSqg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gx5kUXfc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B346606A323;
	Wed, 28 Oct 2026 20:14:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Gx5kUXfc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5DD81F01828;
	Wed, 28 Oct 2026 20:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218493;
	bh=aoGdqsTvzLA1760x2UeODapQMueGdwb7A8k2qy/4a8M=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Gx5kUXfch19iSs0VosFuRnCOol2TCuQBci3Yh4uo7Ahb4fBAy70eN6icqJVjgW7Td
	 wEUWghFTxvzygcoC+fYINVklUz87RmXT+kDWUItm3z3ykDitSp3CSSgkegkKePnudq
	 D6fTHv/KjjaInn7b3PIfy/LH8NcSp/G7gXh298s8/zhjeWeyY+vf5F0VISfpbvbU5Q
	 6Vp0khcsHBlB87Iiz9hz7Yb9WyGDwKoDKy9wVuDMZP6tUH/kibXc+g4T6mT0CdKLhH
	 XD9R8UsWl4JYQ6d4FfbC82iaqrYhZ6Xxn3Qc4bmom3HDBL4XJsgASn/tr9DpfHQqGR
	 R6HPs2vEJF9tw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:34 +0100
Subject: [PATCH 06/15] mm/hugetlb: fix mremap() racing with page migration
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261028-fixes_hugetlb-v1-6-a0a033db180f@kernel.org>
References: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
In-Reply-To: <20261028-fixes_hugetlb-v1-0-a0a033db180f@kernel.org>
To: Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
 Naoya Horiguchi <nao.horiguchi@gmail.com>, 
 Andrew Morton <akpm@linux-foundation.org>, Mel Gorman <mgorman@suse.de>, 
 Andy Whitcroft <apw@canonical.com>, Miaohe Lin <linmiaohe@huawei.com>, 
 Michal Hocko <mhocko@suse.com>, Rik van Riel <riel@surriel.com>, 
 Hugh Dickins <hughd@google.com>, 
 Baolin Wang <baolin.wang@linux.alibaba.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Dave Airlie <airlied@redhat.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>, 
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>, 
 Suren Baghdasaryan <surenb@google.com>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Peter Xu <peterx@redhat.com>, 
 Breno Leitao <leitao@debian.org>, Will Deacon <will@kernel.org>, 
 "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
 Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
 Gerd Hoffmann <kraxel@redhat.com>, linux-doc@vger.kernel.org, 
 linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, 
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@kernel.org, 
 Chris Mason <mason@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3709; i=david@kernel.org;
 h=from:subject:message-id; bh=nOGM/hZpyKq4A/tgBj98h+EqgdeB+UfqBF1GKLD20YY=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZdOPRm1NHSHLe8co+kLjB5rdh/M5pVuldjxb/mZG
 76HDuyc0VHKwiDGwSArpsgSFHzf4OXLdbXVbnzMMHNYmUCGMHBxCsBE/CMZGU7ceKzyfksgC6fi
 rPfmjOH/Mlal9X5eP7Nwn/7OS5MD268yMsxzcA8KvC92ZJbTxMlsjHt0n3JHC69bVZbY+PWzcGT
 dbwYA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

Migration of anon hugetlb folios walks the anon_vma, so the file's
i_mmap_rwsem does not serialize it against move_hugetlb_page_tables().

There are various issues with that. Most importantly, move_huge_pte()
releases both page table locks before the TLB is flushed. Migration can
then find the destination entry and finish migration, reusing the old
folio while the TLB still has entries cached.

Hold the anon_vma write lock across the move and the final TLB flush.
This also prevents concurrent rmap walks from missing entries moved
during rollback.

When we must allocate a destination page table, flush the TLB before
dropping the anon_vma lock, then reacquire it after allocation.

Dropping the lock only works around lockdep: hugetlb folios are not
reclaimed or migrated by allocation compaction, but their anon_vmas
share the lock class used by ordinary anonymous memory. Having a
separate lock class for hugetlb's anon_vma (like already done for
i_mmap_rwsem via hugetlbfs_i_mmap_rwsem_key) requires more thought.

There is a concern that this can block page migration of anonymous
folios quite a while ... which is not really different to what happens
to page-cache folios today. If ever a problem, we can temporarily
release the lock.

So let's keep it simple for now.

It is a shame that hugetlb has to implement everything core-mm implements
in a different way that just screams for problems.

Fixes: 550a7d60bd5e ("mm, hugepages: add mremap() support for hugepage backed vma")
Cc: stable@kernel.org
Reported-by: Chris Mason <mason@kernel.org>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 55f7d692ed0d..2fdd72897db8 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5219,6 +5219,7 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 {
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct anon_vma *anon_vma = vma->anon_vma;
 	unsigned long sz = huge_page_size(h);
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long old_end = old_addr + len;
@@ -5242,6 +5243,8 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 	/* Prevent race with file truncation */
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
+	if (anon_vma)
+		anon_vma_lock_write(anon_vma);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		const unsigned long offset_to_last_entry =
 			(old_addr | last_addr_mask) - old_addr;
@@ -5261,7 +5264,20 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 			continue;
 		}
 
-		dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
+		dst_pte = hugetlb_walk(new_vma, new_addr, sz);
+		if (!dst_pte) {
+			/*
+			 * We can allocate memory under anon_vma lock with hugetlb,
+			 * but lockdep does not know about that. So for now we simply
+			 * flush the TLB and temporarily drop the lock.
+			 */
+			tlb_flush_mmu_tlbonly(&tlb);
+			if (anon_vma)
+				anon_vma_unlock_write(anon_vma);
+			dst_pte = huge_pte_alloc(mm, new_vma, new_addr, sz);
+			if (anon_vma)
+				anon_vma_lock_write(anon_vma);
+		}
 		if (!dst_pte)
 			break;
 
@@ -5269,7 +5285,10 @@ int move_hugetlb_page_tables(struct vm_area_struct *vma,
 		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
 	}
 
+	/* Flush pending moves before allowing migration to walk the entries. */
 	tlb_flush_mmu_tlbonly(&tlb);
+	if (anon_vma)
+		anon_vma_unlock_write(anon_vma);
 	huge_pmd_unshare_flush(&tlb, vma);
 
 	mmu_notifier_invalidate_range_end(&range);

-- 
2.43.0

