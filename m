Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218553;
	b=4Cp0BiSC7EHxQ7R6Jz+e6u2NBSsAAVGas3VjAzZV1GFExoR3U545bmu3GsYknVBjvwzD
	 ZVNinDKDiK/mfIkTRccUFS9QzFFTtjiCFS89OCeaI3fnTrRL1TgPfAZhXm2lt1AMfRTh7
	 MCM0PORcJae0Qu7xJH/nOYaiELcDycS+or8r/6blw3QXZvaWM26CQZMTNEjguauKwtTEl
	 Ty0he7goKMOvBAY+Xuplmd2X5eb81n3zC7a6Eg8hs1gGvSRCYfznrAnw+KlfGVu9NdLWv
	 trv0lCydvjIMboVzMr0rblo1YNRmnbtj0hXi6s8X9eqAhZFWr0oYWBjDwFDBy2byO3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218553;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=PD4hDhqXAiKFSflF7fULM3AAKFj+yDTHa7fJ5vGqNRQ=;
	b=th4jxfJ43WCGiNBrmgW8mrG1svuI2/pIzSrh6n+MZ7emxqGbU94QTo53n0pPzq47k+zL
	 u9jVFeqW4YQOAE55y/JIV5risVbZwesbcne3XUKTE/UESVCLpdoYXNULJDF6pqY1NF0oq
	 FkHsj41XJgNVs9OKQYKZmTIeA4MeyzUYzNrEbwX1epUH3hxvgT71veweE7Rx1qkJAF/fz
	 HxOGRzUjufiv9sEZBXD8QVpSVGw1kxNyJrCNntrCtwEHA+fFgZo0g4YhEPn3yQbRMmEdB
	 D3cLEl9fs0g+waNxK8NTVXBf6Nbcty+2IaFBFCBoTq2ReFVgMIsokeUAPc9KfbqT2Hg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFqeG8xC;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62E8606A337;
	Wed, 28 Oct 2026 20:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EFqeG8xC
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECA231F01829;
	Wed, 28 Oct 2026 20:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218552;
	bh=PD4hDhqXAiKFSflF7fULM3AAKFj+yDTHa7fJ5vGqNRQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EFqeG8xC5Mwi0UZUzqPwuieIuWaq9ZyZgwDIxWXkII2L/P/PHr0qV8jMBbtSdKAC9
	 AOZ6HfEN3h2XaPhzF6ibD4Cu2x0rs1DsAzHggynmtm9pKTYt/OE8H5thdZcMDOQKVR
	 XDEEEaqhW72tk4o43Nm/R7jfSWsfWM1j4b7tvIQxXpSl+OU48MXWcRojnn0oLlmppe
	 2PSNAsXd3xDKkrXuc8C7qKr8GkN2MoIINkXDc0ShqvKBandfQWmoJaojETBvk56xfx
	 UupoRquhv8uXkKegpdvG7yPBDhXgpUwUK1z9sLkIVrJ71zFbmHPjieAjhmEvZG6YAB
	 CTKdWmE2ePXvw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:40 +0100
Subject: [PATCH 12/15] mm/hugetlb: keep surplus folios that are reserved
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
Message-Id: <20261028-fixes_hugetlb-v1-12-a0a033db180f@kernel.org>
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
 Chris Mason <mason@kernel.org>, stable@kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2040; i=david@kernel.org;
 h=from:subject:message-id; bh=/mlxy/iaq1GeHcDtTEJ64LQetJjrHzqcoYxh6NLur8s=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZdN+Xi05eUjzYILfC+fuJ1Y2aXUbPSp52qkL6919
 ONM3gm3OkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZhIUzTDP2Wea2ev6vxQPPag
 xdXkcdHF6UWLH7ap3bx8PKUi4OF7m3KG/wEXcix2KZzf+/nGKpbonqSCqwu5q7ZtNnG4GZa+KPn
 jdWYA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 06d2a78c7170..32ecac4e0d3e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1774,8 +1774,9 @@ void free_huge_folio(struct folio *folio)
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
2.43.0

