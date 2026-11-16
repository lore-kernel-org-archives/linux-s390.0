Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853811;
	b=qWRrQ6gPC1fRzj5PJyCS8vwvM+nqt4pOGbRje69ekE3GcVvjGP3iyyj57EndOtZBc4fv
	 GYq+wHChEkLq/6kPGK04Zziw3HJIbOn0IdPmZOErXi0k7Oc37uErEnlONSV2cFQT5PE4t
	 At7LSm75I6RjrMBiYtLcGEb65XSpDv176w6M3xKRdynMEo8z8Gd7wLwNBTqkXgPP/ZVHi
	 yVY+C6Qyyxs+NqeAL1JX2+y+jzGz1vrt3uNxtXV61pcY8d8kh9/+8AjmbrzEm/KoaYqPU
	 G/0c4OePQgRQRn7r1lBu9WXIiwG8zniZJABQ5m90nwp8LKlUHVOsw7NYOQn4RJ+BxXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853811;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=2bxc7Y1o0IJUNu9aa9tdWaFfEPqOd6AjiRxCSLgH+Bo=;
	b=JmkD4sb/HxShiyW52KyXC/pbq0/7zLXf6Ug//jgwkLHHO/+69a9jzCl/NN5L41L6oKkW
	 c/+LO+5X7sRqviY3A+HkyuB3fRXXZPXztmbm3XxyeslEdiKhXEr80vkZx+sTazaZPtmEG
	 1kKUmXJHw1Wr27idkXzc5ApTSGJZohTnQirVEG3Z062foP7Jle4pQ76Hs5giFxy8gQ4rZ
	 RsL1SCer6F62IuYTdYVUKbX0DI7c9xyfDysqqMh0WIEQ1YHCNLsiQIsHZIzgRSMTDFsCm
	 wWs8kOUXKtYLvS1BoQCqyZ+RN56QlpnqEkNxXl5bvB6aDpsDfAFFfjy/6H/Ec5J9sNg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cS47NPSf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529C6606A331;
	Mon, 16 Nov 2026 18:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cS47NPSf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACA51F000C4;
	Mon, 16 Nov 2026 18:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853810;
	bh=2bxc7Y1o0IJUNu9aa9tdWaFfEPqOd6AjiRxCSLgH+Bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cS47NPSf1gAw5oMwK36MhxFKNNMf0Zf5rdwGjatdYMRI4cfCx+8fa3l77UfCcKdE6
	 ApXuBPsF8x9XYTR/ZlwZ4qpaoFpf+aV1r+5qlHrnb89jyTZH9sHwrfZjRRjZuozltj
	 CHVv5vqW8n6bo6vNBMk/4+8d+4rgu+UUvXcRA1zxUVMiBUl0XFXlqRZBukIl9HsYqq
	 MCJu/2N4PS8/dwGA8fnkL0laB4ZETSk3FlO6nrmpjDXkl23Eeh0hJ6aKZGKhfabLPD
	 yDcKtQ13hEGwYOaNmU7XyaE1+Wkj2dK73LJl17F+ExoV7wJ5jiCSoNA77M89afE6fC
	 8M6yv/UgoCSpw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:24 +0100
Subject: [PATCH v2 03/15] mm/hugetlb: preserve reservations when shrinking
 on HIGHMEM
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
Message-Id: <20261116-fixes_hugetlb-v2-3-4dd9e94ea9ac@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2610; i=david@kernel.org;
 h=from:subject:message-id; bh=LLOzrq96DN9yt2OFJ2ZyOmBcDl7+i0ip7px3+VJMlgc=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3f4i3Qb/bjD9n9Fy+ekbrGTTP7VWhvCBK6qPEgw5
 Ho23/lnRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABPxMWf4n2f6IXbVt8MXIn7n
 Bq2aufvR3oecydOeaAWKHbnvuu3A2XOMDMtTl2svmu14P6O1SHj1rnWHDlapSO/wWFb6uNLPQMX
 yLQMA
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
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 349d45b932d9b..0b071bef226ac 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3712,39 +3712,31 @@ static void __init report_hugepages(void)
 
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
@@ -3939,7 +3931,7 @@ static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 	}
 	min_count = h->resv_huge_pages + persistent_huge_pages(h) - persistent_free_count;
 	min_count = max(count, min_count);
-	try_to_free_low(h, min_count, nodes_allowed);
+	try_to_free_low(h, min_count, nodes_allowed, &page_list);
 
 	/*
 	 * Collect pages to be removed on list without dropping lock

-- 
2.56.1

