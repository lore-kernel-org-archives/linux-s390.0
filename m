Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218523;
	b=aORM08J8632RM9Xnn3HLFahbdA7oI1uUahgFRLkc27H42Pgh9IT4npnBrMimfB+WOre1
	 P2m9aDPjBeJcWqxTxs4PmvfUoIHRF2BJhC6NgyXyXCx7gM6OIVXTotg4CHu6Z4Ogx+f2s
	 uCYCaEoe7pXkJWTBa6/Zb65oU5VOZm3QWj10UJrIUcBxqz2Hk4m/7Zf9Oko/rml6tbTjb
	 rpKAJO3thids3k3jb0cW0rIVWx73TycPLFsdwBfhWLhu+bznBBQxVNdzw2GYOy4RI0ANl
	 gSyTj4bgpfaxgYuFtPw3C/KdqrmfiTmScl8gnJN7/WPbWVAKhAEzpkJDYWc+2K6+/cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218523;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KdmedUrWzEtTp05PuFK4Ncer2dR3r5JAfq1llDowfs8=;
	b=KxBc0CGDy8rhKYdIUFAB5otUtWBzl7Ow0uK5fRUU22BfwERMtkb7bdTMULwC3xeBlpP0
	 6btdAKT6rie5AaD16iF4zaGICvgXU2Ulf/v9Hcwd/f6DIYCTD66aRC3Xg44Jg6M+ZuELC
	 p7ZT0zy4U1KPjIc0Qs+szOnQxfPPdHwkZYf3lKJxS0AutUB661NxHdTXifiFM4A+BcRxP
	 ERESrkCWxw7D+ZE/y1rJ9DsAFWb6qJU5koeBhdSj/EF+fNwvh+sv+irGPAtkWeLVR4TVz
	 HoqlzxPtHE86nVpdUiTZCsKSaBBACgr6ONDG5aX+GDtNKCKGhIVVIt/hIT0K9vbDMzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fL8qtDFp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF6606A31D;
	Wed, 28 Oct 2026 20:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fL8qtDFp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A97A11F01828;
	Wed, 28 Oct 2026 20:15:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218523;
	bh=KdmedUrWzEtTp05PuFK4Ncer2dR3r5JAfq1llDowfs8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=fL8qtDFpArubnAzzUrN4DekT5Rnq/qB54hxYZR/vjjwa1WD/AE9d+0DFjjWOc0Yjv
	 v6OUwG/iOgpMHGqwhajbqeKtjcqSFNMYY7VNWt3LW7LYbvie5aqirQRAoIemFr16ix
	 KC/9k04QQ1In0Cu/OdDoKMGqMPbCDYC5p3lZfVTCScE71iWcUWVtqidNwlvKHAy04w
	 XJH8x3R+LlLLGeSvevjLFpuD10/j/xygBGK2TmAFuKU2h6B1eRxX79XC9ves3y27TI
	 0OVJMNJLz+HAYuda8MSyLKVxgblQovSQKJM1A7eIHr09+9r24b1MofFAbcMLA9z0x/
	 bzyU2QiokJ99w==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:37 +0100
Subject: [PATCH 09/15] mm/memfd: recheck the page cache before allocating a
 hugetlb folio
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
Message-Id: <20261028-fixes_hugetlb-v1-9-a0a033db180f@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1657; i=david@kernel.org;
 h=from:subject:message-id; bh=GKSzWPjp1+dBjhIazkgIibLYlmz/l1AboKBRT1V8Q84=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZftjfMpft56POuC0fX06JvccolPd9w/XWwrYto2w
 08qTJ+xo5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgIk4sTIyXG9qOqsdELzQtPXk
 80jRHRzp7RVCmfzekqpPd9gWVNy+z8hwZfaj97atsYxxeldDHop8zbkSIqSz+0vs/JQCDUWbGh1
 mAA==
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

A concurrent fault or PIN request can populate the page cache
after memfd_pin_folios() misses it in the page cache but before
memfd_alloc_folio() takes the fault mutex. The latter still tries to
allocate another folio and can return -ENOMEM even though the requested
folio is already cached.

In particular, hugetlb_reserve_pages() finds the existing reservation-map
entry and reserves nothing. If no global reservations remain,
alloc_hugetlb_folio_reserve() fails even when the pool has free pages,
effectively failing memfd_pin_folios().

Recheck the page cache before reserving or allocating. If the folio is
present, drop the lookup reference and return -EEXIST so
memfd_pin_folios() retries its lookup.

This is probably not worth backporting to stable.

Fixes: 89c1905d9c14 ("mm/gup: introduce memfd_pin_folios() for pinning memfd folios")
Reported-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memfd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index 4650a69aa7a6..86842c077cdd 100644
--- a/mm/memfd.c
+++ b/mm/memfd.c
@@ -102,6 +102,15 @@ struct folio *memfd_alloc_folio(struct file *memfd, pgoff_t idx)
 			goto out_unlock;
 		}
 
+		/* Let the caller retry if we raced with population. */
+		folio = filemap_get_folio(memfd->f_mapping,
+					  idx << huge_page_order(h));
+		if (!IS_ERR(folio)) {
+			folio_put(folio);
+			err = -EEXIST;
+			goto out_unlock;
+		}
+
 		nr_resv = hugetlb_reserve_pages(inode, idx, idx + 1, NULL, EMPTY_VMA_FLAGS);
 		if (nr_resv < 0) {
 			err = nr_resv;

-- 
2.43.0

