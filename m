Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853831;
	b=dL5a09tPWPwT1f+GSUoRpyGafTJcSr6hUPIu4ClzDFE0hLUxppc1pgAXo9kRlqAIU1/p
	 t4IYZmqhmftQ5V2dSO4pki9iZdubgX7bb0l1MJVkiagU3ZbIAu6V0025NXcYrUpSf+l81
	 2jwCiJ/3G+SLN5cRV8Cgk9i4TNOmIV/C7JHx5CXt/5LeVvAr9+/f2TyVMweiATr9nN5wa
	 53gstuy+ztw4NXFLo6EEt2+jweexMk2rq9hSHJylBefwABBtb3lQhVVR296AODgYqlWRs
	 gNUkmkvqstbGh9vpdWOjxcmdOnQpkcSBplxU6dJykrNtbx0cfqb0kWsc1ptnY+RSNMA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853831;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=MAbycF0/+XNvdgeJe8qDtyiq8qtlOjB5ajoOuaStxBM=;
	b=bOWmOC/d1T87MdSOqvFkczkdwMAqPF0rnNDsDjS9yA0gLAl3EhsrUR07uRS9Xht1+Fue
	 XgL+6+QQ907XCgS7ceZqFLgfzYIMKWV+A9157X37mw6G5rvM/xxHC2+CahlSlToOJe22U
	 VX+rTSgMCOeQPAkrgr+ZQycJD0nYTWPAG+Uzt0INvkESlqCa7hnNO0/lHOuapjAQ1bRPY
	 lqWQXSDMVYVDxojDadhNRWmNuTZycph7ymps1m6YSTRzX2cldjdcLklFUUGEAetgxnfOq
	 Qkbi+DAF/ZOv0XAAhwcDEPJ02f3jtI/pZUA3YdIEGGzlxyEU6nnd4pSUR5f9lf1WlHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ao0kEzZi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DB1606A31C;
	Mon, 16 Nov 2026 18:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ao0kEzZi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C99E21F000CA;
	Mon, 16 Nov 2026 18:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853831;
	bh=MAbycF0/+XNvdgeJe8qDtyiq8qtlOjB5ajoOuaStxBM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ao0kEzZi0S4R/6HFc6vYp6H66hH146HshELvMNuBfW3wDR4Xmqa14Du85e8ZFtYdo
	 hvuqCh0o6GCANSyjeuo2+hv/FO5YxSQmPhJXy7Sq4EVSLs0fdJ2zaQ3Y3ok28eINhb
	 ZNgdfN6vjxHRgYTaCkCO8n5Y7k9jBnWYEToOxRaiByQpzmxn8d+wb3O+H0YlD3/uGg
	 YJ8uSV59VdqufDfbYEgO58HCx+atM6cK6mxldpSD2scA4lq5x2X8L2Anvg4SOj2TKN
	 b4AClfHx6Gj0WMRgdJbDKPpjiUm+WlgvpqH9Mhaod2pkQ7Zuo7EzBgtKcaq7qxHvNp
	 BLv60SWdKwK9w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:26 +0100
Subject: [PATCH v2 05/15] mm/hugetlb: keep surplus folios when the pool
 shrinks
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
Message-Id: <20261116-fixes_hugetlb-v2-5-4dd9e94ea9ac@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@kernel.org, 
 "Gregory Price (Meta)" <gourry@gourry.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3099; i=david@kernel.org;
 h=from:subject:message-id; bh=p2A2APQ/0/VopuKu/gGhIyLBtoUy7qw63EWyI85Mq8Y=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3fcFpl3cplx2jfuP8529fZ9dkEu3IVJznEs07ueX
 Yg/4SzUUcrCIMbBICumyBIUfN/g5ct1tdVufMwwc1iZQIYwcHEKwEQmvWH4n9FZeSPt1btNe/fd
 Wbv1anHLI+nl7ZvzCxlkQhYI/yy7HsTI8MJgrX2xw8/k1L8uHEFK85kduT4fd7/DViXUfO2y/pd
 DnAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

Surplus folios are accounted per node. When shrinking the pool,
set_max_huge_pages() removes free folios through
remove_pool_hugetlb_folio() and accounts them as persistent folios.

It can select a node whose folios are all surplus and leave its surplus
count larger than its total count. Free surplus folios can back
reservations created by gather_surplus_pages().

For example, with nr_overcommit_hugepages = 8 on two nodes:

  (node columns show total/free/surplus)

                                      total free surp   node0   node1
  mmap() of one page, bound to node 0     1    1    1   1 1 1   0 0 0
  node1/nr_hugepages = 7                  8    8    1   1 1 1   7 7 0
  nr_hugepages = 6                        7    7    1   0 0 1   7 7 0
  munmap()                                7    7    1   0 0 1   7 7 0
  nr_hugepages = 0                        1    1    1   0 0 1   1 1 0

After shrinking to six persistent folios, node 0 has no folios but its
surplus count is still one. Releasing the reservation cannot clear that
count, and shrinking the pool to zero leaves one free page on node 1.

A later write to node0/nr_hugepages underflows the unsigned per-node
persistent count: 0 - 1, resulting in allocation of many folios.

Use persistent_huge_pages_node() to skip nodes with no persistent folios,
as adjust_pool_surplus() does. This also excludes temporary folios.

Fixes: e4e574b767ba ("hugetlb: Try to grow hugetlb pool for MAP_SHARED mappings")
Cc: stable@kernel.org
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: cleanup code and description ]
Acked-by: Muchun Song <muchun.song@linux.dev>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d7c71025d166b..3ffd87eb9e45f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1959,17 +1959,25 @@ static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
 
 	lockdep_assert_held(&hugetlb_lock);
 	for_each_node_mask_to_free(h, nr_nodes, node, nodes_allowed) {
+		if (list_empty(&h->hugepage_freelists[node]))
+			continue;
+
 		/*
 		 * If we're returning unused surplus pages, only examine
-		 * nodes with surplus pages.
+		 * nodes with surplus pages. If we're shrinking the pool, only
+		 * examine nodes with persistent folios.
 		 */
-		if ((!acct_surplus || h->surplus_huge_pages_node[node]) &&
-		    !list_empty(&h->hugepage_freelists[node])) {
-			folio = list_entry(h->hugepage_freelists[node].next,
-					  struct folio, lru);
-			remove_hugetlb_folio(h, folio, acct_surplus);
-			break;
+		if (acct_surplus) {
+			if (!h->surplus_huge_pages_node[node])
+				continue;
+		} else if (!persistent_huge_pages_node(h, node)) {
+			continue;
 		}
+
+		folio = list_first_entry(&h->hugepage_freelists[node],
+					 struct folio, lru);
+		remove_hugetlb_folio(h, folio, acct_surplus);
+		break;
 	}
 
 	return folio;

-- 
2.56.1

