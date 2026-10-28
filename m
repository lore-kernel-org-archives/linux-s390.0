Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218483;
	b=V4ewAqmVlpX6T7ILn4/2XuJ/QASEUurIJCMEaUe8XVMbMeGrS2NaU0SwBLE986GN/Od2
	 PTdcc+CJe+kW8Le19kh/iCBe/t7+7F4uLRowtppzIl0pgQWubqM7pX1NpEMAAHOQbJMTh
	 h1okKHW2HaxViQ7pxJTUHnY8DWVWl4Rp0AR2KtgfIMoPfDDMIM9EhAUqwHTEALuFHjW6j
	 zyYr6c/xxBXTlO6wEilpcnCxwFkkIS1WNS3iCc5zGQMweIzmZB0diyNHW4OztF78nQvTV
	 rRSlh5yfhluZtyGMeLV54OHeGaLYUptez31ZLkCSUpl6fsZtUFl5LWqCCvdkx0+mTjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218483;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=bTRazsZdBI8g+CFMzwwOmm+CDhczykCZW+7EwaTrQQg=;
	b=iEirLx0kbNI8IPURfTO9qJ97qf36bZ+3mcQon8BbQamW704XMQRhztomYJS9xj8DM/jc
	 XUNWs9zOcfgBC5gPqtbcJk++Mb/I8kW+tcM1FxyeIf7dOtMAi7ZJ3yeGRcZVxM/bge9wX
	 GLM5qaOZydrwdJTkIc89+ebKmpTBBWl8ztHz7fAEtO9fwiz1d0i5kaasC/aoe/qNI4AYr
	 QYkcwj09g0JuRMr2zkMJRs16zfnSQCU8S4EZBJRY/VlZ2pPBLSpKlNpJML6uwRXnW5ukR
	 TMdyw0rlBkKTfRGwswz+mm+ejesPzrQnc7yuXpa8o8+fIZrjJak9RpC0u/HZKOlGf9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmbv7PW3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86531606A31A;
	Wed, 28 Oct 2026 20:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jmbv7PW3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B64AE1F031E1;
	Wed, 28 Oct 2026 20:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218483;
	bh=bTRazsZdBI8g+CFMzwwOmm+CDhczykCZW+7EwaTrQQg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jmbv7PW3v2cjt4B/n2gTzkTl1YD8RUeM0qObl+iD4RdBCN8Ek23lk4Z8KQKt65+B3
	 2sQVi/yY2kV0mjN8MNtMe625va5FiXAROuuWOmuqk9Xgd1cFlSOoIE3Hk/KLEzS+BC
	 1DF4r86g2wmroWD9Cy2SPF+fYsyuA79OynxZh48vgrBtMFbWLN7avYYoUKhbKBQCZd
	 DyXMusa4MA4j/Nr/halMKmH5c5MzfOHXbmAb5dMpbaElac3Lo+EzqiJMgse7WXPZgq
	 iy5H9v0k/OeB89xyOJb6buLXxVYfDbpHEYuFsJkkbVuWCViPvBhTAdWzi2LeM2P9qt
	 0/3HQH1WNGjDg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:33 +0100
Subject: [PATCH 05/15] mm/hugetlb: keep surplus folios when the pool
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
Message-Id: <20261028-fixes_hugetlb-v1-5-a0a033db180f@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, 
 Josef Bacik <josef@toxicpanda.com>, stable@kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2997; i=david@kernel.org;
 h=from:subject:message-id; bh=Hat0z9s8tQAupFoGz/eDgT1MoLADnvCUPqvsqVk5s+4=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZfyXf5wdOWCO8uc/h3rfn34VaxZTElISGdKSfV5s
 y0qcV/SOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZjIvYWMDGd3fr72m7fsa+Um
 F5vrh+rvzz53blJp2ySzz/qTIhevj13MyLCW1Wdh9m3hND3fj4/ZV2dbqLUoyHWn/Bfl70heVHR
 YihkA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 110a5c2d9e50..55f7d692ed0d 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1955,17 +1955,25 @@ static struct folio *remove_pool_hugetlb_folio(struct hstate *h,
 
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
2.43.0

