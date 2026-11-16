Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853801;
	b=PooE39KwsuF6+5oOo2KMLQ+IfA+wcp34AsOPLZZVz5a90wDliWPdJPXvhy9tPQBKCM8K
	 WcaGPwCsfp10Usb+Dpis0lE1MmZHk+idCbkBQcRpJEBDudipGxTacW5wAr3mWdegsCScl
	 ZUd4CCGLKmsMdcjQoj4yHkl28Rpf8T1euICZ2CYGkz/JHWO/LQVWrRuPDoXO0JIZsKI3P
	 tfAGyWtGjSJ4bjOK7mjIMsQWgfHucP2w0OxTMu67iexQB4JI5bicpy5UyIfP2DMAzMvMG
	 vjYqrQ1kVMVyU1SUTD5aae6POUtDbedpSrCNOu/LUBU2BcgVef6fuyLISHOLSPq/58Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853801;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=QvDJKGzSv+kEo6DEGZGlP63nUWVKpmSYnaml8ai5PMU=;
	b=GrK+c9neVu96VH5SzYyi8MbCj3pRGZia46vZryeWE8Evd4PWGPT5XvYGiyeVgZuvNO+N
	 c+TB8sTP4gagbZVLKngtvlm5Fz76DyN/8nkaJUP3DYmeGrs16Dr2HcFb4i7wQ+KI3zbZb
	 +zBWqudltQAClMH0yijaQnRggVs2VhSjdVdA/s+S1bYJg5qXlMYz46oSb/sSUIZpGxAb8
	 /y5yeLmiFPQBZZLbqFoZJDH3fnDUDsuLW1tAcezigORWj1WGK4/mLrDxOyqGySg2IRraK
	 Myt+etfaMtmzjLeeb0LsAVzSfp6ivxIwZ4H9oT22nW0ZyS5ZBPp+utwDrZvvwdoKKxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVghdw1b;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D835606A31C;
	Mon, 16 Nov 2026 18:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVghdw1b
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD43F1F000C4;
	Mon, 16 Nov 2026 18:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853801;
	bh=QvDJKGzSv+kEo6DEGZGlP63nUWVKpmSYnaml8ai5PMU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MVghdw1bb5iVAEe0Y7asR8AvaEXIsJlTi4w1KL+/JJw1mfwRUospv8ANEfvFlzWxA
	 mEU2xGXDXZDfpFWf7+WrdKg1IRfbMPUtafZgFtnJLaiSugcOglYeBBNNoM4st9ioru
	 K9FOBte25cl2QUh4dOaV6nBuCt4oFNYluKRT5YdvGcWpxveFWxDuko389MlODaiVBi
	 3sUnehV/Zn15VkWRZ82iz44K8b7a8UDJQHVHs0DfF53iVEqJqLdTdLrz1fZHXfF4U2
	 06fr1GrIl0t+raEYtlXTLDSYgrdB2eWVsS6UUNIf7q7P5xSokMucIpcnNIL94LjR3p
	 A7GZLrlJGlx1g==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:23 +0100
Subject: [PATCH v2 02/15] mm/hugetlb: compare against persistent count when
 freeing lowmem folios
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
Message-Id: <20261116-fixes_hugetlb-v2-2-4dd9e94ea9ac@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1998; i=david@kernel.org;
 h=from:subject:message-id; bh=U2I3f0NptKRK+FQV1BsF9XE/Zx46VPb3vBH3cA0Buow=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3dM6dXZ+XB2/LTrrV/frX1Rft9+kthBZl/HxxdjT
 qUcCyoy7ShlYRDjYJAVU2QJCr5v8PLlutpqNz5mmDmsTCBDGLg4BWAiy74yMkwu6kgQ7Xpqwvl3
 9plFzGff7tL4c0Hh9Mpky1R999KLcpyMDK+3qaSKn9zxzUhcXe5oYnGqmbTg2RPXKwWv/PPvjDf
 W5AEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

try_to_free_low() gets a target number of persistent folios, but
compares it with "nr_huge_pages", which includes surplus folios. As a
result, it can free lowmem folios below that target.

For example, with two persistent folios and one surplus folio, a target
of two can still end up freeing one persistent folio.

Compare against persistent_huge_pages() instead. Convert the macro to a
helper function and place it before try_to_free_low().

Fixes: 7893d1d505d5 ("hugetlb: Try to grow hugetlb pool for MAP_PRIVATE mappings")
Cc: stable@kernel.org
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 630c96cd1e880..349d45b932d9b 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1339,6 +1339,11 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
+static unsigned long persistent_huge_pages(const struct hstate *h)
+{
+	return h->nr_huge_pages - h->surplus_huge_pages;
+}
+
 static struct folio *dequeue_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
 					   struct mempolicy_interpreted *mpoli)
 {
@@ -3723,7 +3728,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 		struct folio *folio, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(folio, next, freel, lru) {
-			if (count >= h->nr_huge_pages)
+			if (count >= persistent_huge_pages(h))
 				goto out;
 			if (folio_test_highmem(folio))
 				continue;
@@ -3777,7 +3782,6 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 	return 1;
 }
 
-#define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {

-- 
2.56.1

