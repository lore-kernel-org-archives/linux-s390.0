Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853901;
	b=zedQTBySYTjzTtUh42F4PR2tqZe1niZnJsYPKxCqKWRm8HgRS0gIrNwgvKVBqOpGxb3Z
	 3Hx7pTt/Mp0iGJ0ieGs4xhvwNh2KTUrwxDvrUmFDd4TB6HiQ8TdyckMmrSoue+LtIV3y2
	 bV8GGCB8wSx7PZMKwOsYVi07A5aerKjZISQe1MaKxetHbPHBbHxtTG76fl8p/N/CL4ocJ
	 pdQEzzMnYF+dxSuya7RUNr9ezGy/jbPjMrZMj9hTBwgMbcNxyPRKojk7OQGcicVH5KScQ
	 sjr5T8p9BtefCxbgLYS8LoJYjqQf201dKyU60rZIes1Tzs+Ap1XieRoosEdYt6CbM9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853901;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=WaQX8RZ+ZLg0aNvmaH+LP+wUFJzV9EAHnDvW3aVzvPo=;
	b=xkQNgQRENUUFNDr8aifPyXTILVdP2f2lz+zzNFfRbe/skBH9B5vKfP+z6CdOQIuo5slb
	 SxEWOGU0Wp5HqwQnZl0GMzyovANofNsNip1sJC9j0useR0qHAx/RLu3MMnJOL+SsBluZv
	 H6ZiDVbjXCCkmx7CYPsdP+FGtAAQ9GqTANctgDIS5Hh3WSKILeY/TvOlYMf33xfZFl0Hb
	 GnDigMcFf4Fd/yWT/YCTDPXtJz1WHT1s4i6JkE0wFTByqW/75lgO+SIdM0HpWTJH3zysQ
	 i3xwPQXkzkhq9xab14EtmM/h7oKxhm5Bs5LnH1hUVK1pttzuQtPgUm0Oxe97nRUcngQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgDoB7ON;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF948606A32F;
	Mon, 16 Nov 2026 18:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FgDoB7ON
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A06E1F000C9;
	Mon, 16 Nov 2026 18:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853900;
	bh=WaQX8RZ+ZLg0aNvmaH+LP+wUFJzV9EAHnDvW3aVzvPo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=FgDoB7ON49lGuWa7wmkJSMPHPpViSNzUIG7maj47dOtB+OMJBgbTkqhkTAcAqDERL
	 M3tq+pUwKPC/Q2xhJ+YbQkTnlstbHU9I+UO1oitPsD+4uvT8TzW7E4Ix9rEQb2ucdk
	 XYxNrNGwQ2OuAh88nhF7afjI5WS+JjxITSLTWBkQcCTSHQ9cOuaXqjZ3cHg+bEoamP
	 sTdCxbjOolHbFxEBipbFmz9EaB4h97JKm6aN7fnxpZ4DSyopI6H7gMz/BX9/8TxsOA
	 n6u/0r4fd8nhnguUjyMdswSLRUIdlQ6d081fELaOLtmBUvXBaEUHWISOOnXpd78MQQ
	 z/V7SG9tEBQxQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:33 +0100
Subject: [PATCH v2 12/15] mm/hugetlb: keep surplus folios that are reserved
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
Message-Id: <20261116-fixes_hugetlb-v2-12-4dd9e94ea9ac@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Chris Mason <mason@kernel.org>, stable@kernel.org, 
 "Gregory Price (Meta)" <gourry@gourry.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2197; i=david@kernel.org;
 h=from:subject:message-id; bh=iyGBWyxJrp1WOZLQ9hPw/96nNcEiZoLnjNT9qzvPK60=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3d+quh/K/Rr4jpmr7qbrfvuerOfXiC+pcqO63/m8
 ZVfgtkYOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhIiRDDH85XNZdbjsypc2wP
 5jqq6mq3Ss/FsfLVHr9j4Y+UbukJr2T4zR4dl2B+eBeLxewSIc2Py59NdVpyN0C3rp9hi3v1L/M
 CXgA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

free_huge_folio() may restore a reservation, but still returns the folio
to the page allocator if its node has surplus huge pages.

For example, start with no hugetlb folios and allow one surplus 2 MiB
folio:

  1. Mount hugetlbfs with pagesize=2M,min_size=2M. This allocates and
     reserves one surplus folio: free=1, reserved=1.
  2. Create a 2 MiB file and write to a shared mapping of it. The fault
     consumes the folio and its reservation: free=0, reserved=0.
  3. Unmap the file and truncate it to zero. The mount's reservation is
     restored, but the surplus folio is freed: free=0, reserved=1.

Besides losing a hugetlb folio that is required for a reservation, this
can also make available_huge_pages() underflow and cause other issues.

Keep the folio in the pool if it is needed to cover reservations,
including any reservation we just restored.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: 07443a85ad90 ("mm, hugetlb: return a reserved page to a reserved pool if failed")
Cc: stable@kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: simplify comment and description ]
Acked-by: Muchun Song <muchun.song@linux.dev>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 112fa25f36833..2fd5a5e585ad5 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1778,8 +1778,9 @@ void free_huge_folio(struct folio *folio)
 		remove_hugetlb_folio(h, folio, false);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_hugetlb_folio(h, folio, true);
-	} else if (h->surplus_huge_pages_node[nid]) {
-		/* remove the page from active list */
+	} else if (h->surplus_huge_pages_node[nid] &&
+		   h->free_huge_pages >= h->resv_huge_pages) {
+		/* Free this surplus folio that is not required globally. */
 		remove_hugetlb_folio(h, folio, true);
 		spin_unlock_irqrestore(&hugetlb_lock, flags);
 		update_and_free_hugetlb_folio(h, folio, true);

-- 
2.56.1

