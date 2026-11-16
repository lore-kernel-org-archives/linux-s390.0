Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853841;
	b=W/FzkVmPsjYgnI7vW2Okc1RkjkR+jKtmbWnPf9l/nYj/HMoXJNazEO/YHUPc47IbM4fk
	 mwZUu6jkWIB1EBoTq9EM1fIAnWSDzKeBDv7mswliJF1pBNl9FLawjEcMrwPPsKWa6wbdY
	 At7IrQdZ+7f9IpIL7uR57jOior2Ysy0rGd4+24vF+LHyYSzalE3mfbzzcRXNfN4PfK1c0
	 ++jRPdcWGlcX+75CgM+nj5vNfI0qrFYcWb7DVciAI8/aNWA/mV9SI/jhl66uFhZ6/L4qy
	 twRoe/iIT2LJO8neOltONL0ZbQrkP7jmHZuXaAUoeIuV1WF1wmpWj1HkOi6ea+y5xig==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853841;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=M/EvVqPPmCZCcKVeR3NdpNWETVcV9F4mtjWBr1K1Fac=;
	b=c/i4GHhLJ9+usPymMfh8bZNpJInnZPA6vXeajhi/luDpxgQCLZpmlLnq7CrTUDz/5/xb
	 cwJ+fxfOzpuDh+RKyb1SdB55QUygePLW/wnBCpv2zboSqWVTZS+BEisKus+rnwHH3+3Lr
	 nIqw5QkzZ6JCifmYXOtr5xF5KWY2GquR2Zr/FHkPdTRMbPNNaB/fA21/0Xt/sDYWQrvYy
	 YI+9T4TFLqDzhlOzky2N4heSd6PxpNsWtGiVsBJIE0ikNLgJGB71YOkggEsgCNrsqwd7S
	 E8zlQGFxcd9L5R+/fxaj6AQyyq+HulAPeehOEC3QBBHkVSN80Hmlu5+tnr6EHyAs7JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJX0St54;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BA0E606A337;
	Mon, 16 Nov 2026 18:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BJX0St54
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A13BF1F000CB;
	Mon, 16 Nov 2026 18:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853841;
	bh=M/EvVqPPmCZCcKVeR3NdpNWETVcV9F4mtjWBr1K1Fac=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=BJX0St54r0eyFgfrrTGabY2Ky8SRdxy27FtZljILl7LSaa1m7IpomKvFfwQnugQDg
	 f+Qppe5eJ7DKAENfq+CHom7h77RkbjprQtUQ2uPHrz5rgcA17y37plUUUuSo0biAA0
	 O6JAPTMuN0CBQjA7NXdIKfBUp67mKfUUqu8+3iRLqJ2pULSmLoDhWcubfzdRqORkge
	 3xu5VVS3Uiq6s46G3jEHfp86nGYSbsKuI0tJkk3xohc23ezvGGr2v3/UzDChxvZUPo
	 2AyPOERdNDticSAW65tfGIreyPnk+68orni4JFQ3RqfM+TSlS60ve3ErRM90Z1RvUL
	 SzhH89h+7likQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:27 +0100
Subject: [PATCH v2 06/15] mm/hugetlb: fix mremap() racing with page
 migration
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
Message-Id: <20261116-fixes_hugetlb-v2-6-4dd9e94ea9ac@kernel.org>
References: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
In-Reply-To: <20261116-fixes_hugetlb-v2-0-4dd9e94ea9ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3798; i=david@kernel.org;
 h=from:subject:message-id; bh=ffMP6p7X0B7O7y0oXzxGIwviCt5laHHSvycoU7Pl2jg=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3ccXaNxO8NOT7ovct2mU49nMs0LtjqVHLFZzzv5/
 7r97A4lHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAEzEloXhn/XdA1u5e1PaLGzP
 cRfc/pgcdXNlRRPzcTZjrjntb9rfPGX4Z7Hk6rx7/Q/dpkhZyNSctv0atm/17kq2HWzsu4pCxI1
 iGQA=
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
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3ffd87eb9e45f..4a24819733730 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -5214,6 +5214,7 @@ unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
 {
 	struct hstate *h = hstate_vma(vma);
 	struct address_space *mapping = vma->vm_file->f_mapping;
+	struct anon_vma *anon_vma = vma->anon_vma;
 	unsigned long sz = huge_page_size(h);
 	struct mm_struct *mm = vma->vm_mm;
 	unsigned long old_end = old_addr + len;
@@ -5237,6 +5238,8 @@ unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
 	/* Prevent race with file truncation */
 	hugetlb_vma_lock_write(vma);
 	i_mmap_lock_write(mapping);
+	if (anon_vma)
+		anon_vma_lock_write(anon_vma);
 	for (; old_addr < old_end; old_addr += sz, new_addr += sz) {
 		const unsigned long offset_to_last_entry =
 			(old_addr | last_addr_mask) - old_addr;
@@ -5276,7 +5279,20 @@ unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
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
 
@@ -5284,7 +5300,10 @@ unsigned long move_hugetlb_page_tables(struct vm_area_struct *vma,
 		tlb_remove_huge_tlb_entry(h, &tlb, src_pte, old_addr);
 	}
 
+	/* Flush pending moves before allowing migration to walk the entries. */
 	tlb_flush_mmu_tlbonly(&tlb);
+	if (anon_vma)
+		anon_vma_unlock_write(anon_vma);
 	huge_pmd_unshare_flush(&tlb, vma);
 
 	mmu_notifier_invalidate_range_end(&range);

-- 
2.56.1

