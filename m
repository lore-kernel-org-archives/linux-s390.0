Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218454;
	b=m7BEX+EN/dyW36TmZMbVqod0KMt/9c0bDYY+QX2OmCx+LJpEJpF/UGL2pxYVXPDXQR+0
	 oLAi8A0enRWnxLzzcW3cJUnRp4pzWB0tg1GnOb8W2+gYiM5BLrCh7nCEEWYF0TDeOpGId
	 QiOdoFlu+KpbbBYWtDQCelTleIJn8ZbpsSPKZMNNsnHxkINl9qS3pQ7OYCvahFT2HhaH+
	 X2qaHxHqSrEvzXNRnNB0xNmfNSjHeJMcqheSTxpvb8udILK6WMBCT9hgfdIMkKFPZjILK
	 i9qlHjhedJ/YtJupYcEnCspimBb7IAbKm4s5j1G7YCTC4o5YsJxdytTj4sR2gSju9Dg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218454;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=qEBctXhmn4h5YyAOB0r8W63ghO8tdi+PNnWiA8yCOpA=;
	b=orvg8S0tHiQaJZ7qAcoms+vWqBGYhxcvmawMtbUIQzHjngM/LBa7zRsYAVd79NAgsJme
	 oT3+UV96nLt1k8hIG/n30DxxjkHj4lv7gtSkV2Gebz7YEakumU2uHqSFXvZqsMNxUOqkV
	 rGhBWIJOteqI8Gamheprt3u/R0wbqhnWi44TwNH3REXJVQOZg5gf7i3giYBInK0+Um4/g
	 TvHvQfjHBDHYJd7DImXrC7kdn2ZsW041v1mQn8TkCNS4y4vwl2erPT3mZCgueBRSn2Rjr
	 dQNt9e2UHd7CZumNqlcFMgCnKyBYaWOKFFUm21+xoUOYvZYUhp7lUxzLrRjO0B5wQFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAE0xBd8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9F606A323;
	Wed, 28 Oct 2026 20:14:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gAE0xBd8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53671F01825;
	Wed, 28 Oct 2026 20:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218453;
	bh=qEBctXhmn4h5YyAOB0r8W63ghO8tdi+PNnWiA8yCOpA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gAE0xBd8fJHcKjRT9ms2IAxmhPu/nKhwS/b5GZa2xV+OeRrYHiDFxM8NxJ4KMecJ+
	 3EhtquudZNVaihZXb35hXL+2IwbANf6KABKqncm2c81z3yeHdh3B1yKwbzeAf9EAId
	 ivR/W9uCcXiqEwPFWcSnvOZuQ5OClOelI9zD44uFcIsZmkbo5wIxAi/mVJScOrqxwp
	 jaDN7TAw4JUEDZ1IwL4djohnzOtUb+N4bylhGmAX6C568XaQCsWYoHqgVw4K+iZwKR
	 PiAf0k1koxMdIyzmCyqsscGTLC7hc+UqjcAtMskoKDDgZfyuVqvINrgiITAfJkEM3L
	 HwBpH8nhU1FPg==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:30 +0100
Subject: [PATCH 02/15] mm/hugetlb: compare against persistent count when
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
Message-Id: <20261028-fixes_hugetlb-v1-2-a0a033db180f@kernel.org>
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
 "David Hildenbrand (Arm)" <david@kernel.org>, stable@kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1943; i=david@kernel.org;
 h=from:subject:message-id; bh=Rd6aso6VgETc53Dh/h6R4OrmZ5cP92PBFstwxhi7Wzo=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZeu673RsWBlee3MBYxi+ba6dbx33waIf53VlrVmk
 uz9q3tzOkpZGMQ4GGTFFFmCgu8bvHy5rrbajY8ZZg4rE8gQBi5OAZiI7GSG/9HZR48me92XnvUw
 kzFJgLU2efmeZj6tq/cenjLeJrjMgJnhf+baewHSn7tOrE8/FPVn7uFXJdX3dI8xfXjCc8+E/VZ
 mBAMA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/hugetlb.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index da5d04edf7c1..3a94ea1c9457 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1335,6 +1335,11 @@ static unsigned long available_huge_pages(struct hstate *h)
 	return h->free_huge_pages - h->resv_huge_pages;
 }
 
+static unsigned long persistent_huge_pages(struct hstate *h)
+{
+	return h->nr_huge_pages - h->surplus_huge_pages;
+}
+
 static struct folio *dequeue_hugetlb_folio(struct hstate *h, gfp_t gfp_mask,
 					   struct mempolicy_interpreted *mpoli)
 {
@@ -3719,7 +3724,7 @@ static void try_to_free_low(struct hstate *h, unsigned long count,
 		struct folio *folio, *next;
 		struct list_head *freel = &h->hugepage_freelists[i];
 		list_for_each_entry_safe(folio, next, freel, lru) {
-			if (count >= h->nr_huge_pages)
+			if (count >= persistent_huge_pages(h))
 				goto out;
 			if (folio_test_highmem(folio))
 				continue;
@@ -3773,7 +3778,6 @@ static int adjust_pool_surplus(struct hstate *h, nodemask_t *nodes_allowed,
 	return 1;
 }
 
-#define persistent_huge_pages(h) (h->nr_huge_pages - h->surplus_huge_pages)
 static int set_max_huge_pages(struct hstate *h, unsigned long count, int nid,
 			      nodemask_t *nodes_allowed)
 {

-- 
2.43.0

