Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218464;
	b=Z1M6YP4GI196sGRIwlAjaPLeSd0ge25TOuLHvl50NC4ccFODqsczRAQlWjeX7g8udXtS
	 cMKd1q6fE14VRJSm5ejb3NknRgzWdVW9cxghQZtC2houWXk/nixppST45DyH5xftsPVX7
	 tanZEUUdbR3pWmBAKA9oq3t9qEm3hr85kynv5z4jJHMAWCS9fTMC/kTb9lKjaEMKHloCE
	 El+uSUfv8YNnXYRm8A/h//KJBgpbQ7dJ9hTpQWAkqXIo9s58GULUnw2nCb2bJGue3/rJW
	 0llPYyix3qrYfidYo2NNdtKphtCZizMz/M6vRjF4n8KtiBTNl9Gr4ixkAOhMtmOtO8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218464;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=h6GqamuA001HPemkjnOqUKBb2WcS9teBrRtjEmx99fA=;
	b=b6h7Q6cST4ueaiIBn9ChCE6rn/FmBgXi/mRA1Vy1GxwWbo9Y8Z0lXEOKvv70KIG8YVki
	 EpXN4JGRNjqaeFBeRIBbf9tjNWMf+7FWRdN/inpqi/8SEctz/03fzHO66gisbov7v0BXt
	 27d0Ekt3fNSESh62Q2ECd0PgwiBOtPUykZ7/FR6cRBlAmV9fcLzOT5NXngYObpt8uL/pH
	 VkUUZwV4CDhP7xjOl0QnwWKblXBMlA2RYHIsysvEbmCgsTFzIOc3rkXw/xVU63pyTGglA
	 BnJKNgZw/1eEQ3yfHxIWFxNkLscYoCHeyCEf4duainRBUWWxl0lx+DpEnknUErvzv9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmSj8+N2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEA06606A339;
	Wed, 28 Oct 2026 20:14:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VmSj8+N2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477271F031E3;
	Wed, 28 Oct 2026 20:14:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218463;
	bh=h6GqamuA001HPemkjnOqUKBb2WcS9teBrRtjEmx99fA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VmSj8+N2GzA0MbyYqBFCd1q6TYu1wwu2CeQnYCY5NJMrnwzn9omLMG6o8jgBSmll4
	 igFnOw111D4kzU5USzz+fQqulM7UVW2WVUrpKxUg4Dx3ZhL0i+82q053jOaO4pOhnH
	 NQSTg94doN4gEENEUDmEkwCcjOGPwVZ443UxxiKO/e1Wj2XuHBNxmFJfp2Oee9xrHx
	 3qNqIDpQZB7HlC7KnAACf4/1fJ4UpTvEwx9EAvHjGpkPgNp1iVLmxUrZm4jh8VtNeG
	 D0Iwv6FZ0BaKeJxJW6UTIjr1is3S9ENjSOTRd4cIXTh43um9ft8vrt2PCM1VIjNnEM
	 0vMa5Tdlrk2kA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:31 +0100
Subject: [PATCH 03/15] mm/hugetlb: preserve reservations when shrinking on
 HIGHMEM
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
Message-Id: <20261028-fixes_hugetlb-v1-3-a0a033db180f@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2561; i=david@kernel.org;
 h=from:subject:message-id; bh=fOag8m9aWaD8O5/vp5VjcGR+Ra7oerb0CGoQ+KJ8h0k=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZeG/by512hynePr08whB7ziv9zbXvip7y3nD7UDE
 VeUl//t6yhlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAic1oYGZ4ufiQux71z0xLZ
 pD8vZ3UwOj09OGuz0BxGRpciyXRdtacM/wtuzX9WWfrozIRFO0566Zs5qt54JsqZeXz916mzFpo
 +2s8PAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

try_to_free_low() drops the hugetlb_lock while freeing lowmem folios.
set_max_huge_pages() then resumes freeing folios using the
min_count computed before that unlock. Reservations created in between
can consequently lose their backing.

Collect lowmem folios on the caller's existing page_list instead. Keep
the hugetlb_lock held through both selection passes, and free the combined
list at the caller's existing unlock point.

Likely not stable-worthy.

Fixes: 1121828a0c21 ("hugetlb: call update_and_free_page without hugetlb_lock")
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 3a94ea1c9457..a78b2487c20c 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3708,39 +3708,31 @@ static void __init report_hugepages(void)
 
 #ifdef CONFIG_HIGHMEM
 static void try_to_free_low(struct hstate *h, unsigned long count,
-						nodemask_t *nodes_allowed)
+		nodemask_t *nodes_allowed, struct list_head *page_list)
 {
 	int i;
-	LIST_HEAD(page_list);
 
 	lockdep_assert_held(&hugetlb_lock);
 	if (hstate_is_gigantic(h))
 		return;
 
-	/*
-	 * Collect pages to be freed on a list, and free after dropping lock
-	 */
+	/* Collect lowmem pages to free after dropping the lock. */
 	for_each_node_mask(i, *nodes_allowed) {
 		struct folio *folio, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(folio, next, freel, lru) {
 			if (count >= persistent_huge_pages(h))
-				goto out;
+				return;
 			if (folio_test_highmem(folio))
 				continue;
 			remove_hugetlb_folio(h, folio, false);
-			list_add(&folio->lru, &page_list);
+			list_add(&folio->lru, page_list);
 		}
 	}
-
-out:
-	spin_unlock_irq(&hugetlb_lock);
-	update_and_free_pages_bulk(h, &page_list);
-	spin_lock_irq(&hugetlb_lock);
 }
 #else
 static inline void try_to_free_low(struct hstate *h, unsigned long count,
-						nodemask_t *nodes_allowed)
+		nodemask_t *nodes_allowed, struct list_head *page_list)
 {
 }
 #endif
@@ -3935,7 +3927,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 	min_count = h->resv_huge_pages + persistent_huge_pages(h) - persistent_free_count;
 	min_count = max(count, min_count);
-	try_to_free_low(h, min_count, nodes_allowed);
+	try_to_free_low(h, min_count, nodes_allowed, &page_list);
 
 	/*
 	 * Collect pages to be removed on list without dropping lock

-- 
2.43.0

