Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853871;
	b=lm4I/+IcDB1rYiuUVbvPiaGfPkxjcmYfKDOTMWoC3Jo527U6qQhK56Y43RKX2VTLA/8t
	 8Cht8WkF0dBKiajqhPHpLXVFLW1phWkkF0RhXPiRGd2J8ZWtE1H+veJUOD5siUQfAafYX
	 NVGRSz68jNUyLy2bAakUkRpNNWk1AX1yWy1D09OrDcL1ogVrs19AUyyLKP6TL/hAoWzAI
	 AR9z9mMig6MEGP/U//H58WspmiR3wWpipIrQ27uyPp3JYyYCUqRnhYs977BTgMritGQ9C
	 3Vrb5cHIBnKHR2+QI8/y38ABIowcqIMvNKypSYciVOosjP1cmcj+b2BKw2o0fHFPJdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853871;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=7xoRignLZxBv7QZtu4zQ7je7wi7y0KfxNbKworbD0gM=;
	b=nHp2VQ0P/e7Xu+yQf+TIHFop1KPBPgYtet3Sr7mGzp9QeBn40vtehGZJptvmAHo4LUzN
	 AEcHr5kcY7k4cBNPmSSj/fiyR5Z+McPx4byhCv2V87gJMV2fn+zP1GosmTCTUVHFsRiOd
	 b+H2ekSsm2rkJ+8Sur/9VC2N+dmsoC+AqlWnsJHkz4XGgiH6Z++7r5WotxtlA88G4WyPQ
	 ReMCam38sepz5fUrsKYnie0O3pW0jdE0iTQBo/okqULLVFVQ8ONswobG+qyoS0g/CM0Lb
	 I+jm6foO34Nuj51WDgm9veofj7F3HUAqTvzbtacx0jvdrpwLcnjhX/8BgurNungzxmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9cNzfm7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DFDE606A31C;
	Mon, 16 Nov 2026 18:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e9cNzfm7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A545C1F000CB;
	Mon, 16 Nov 2026 18:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853870;
	bh=7xoRignLZxBv7QZtu4zQ7je7wi7y0KfxNbKworbD0gM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=e9cNzfm7zhA94WiFHHOPsFle10thDfdLkUmMZHm0yFawrl5DPpcEg1O35UAka9G/c
	 aKKrw85NUzwrzQe78De4iorqYXugYPLNk7xlIz7NJI1tefZJQZFcyYR4i4fdLTezrm
	 mVSzxHT7/ckQnScWVXhub2qk9DniOh088MdDj9o0xXss4EFes/z47EWF11w8vQiiwB
	 OOL90pqX6FLIgazANPHOiEh67IQRXCyuGTl1aPFmuJ/4JnFmC/fzPemYxi+4ijTB9l
	 StocQ0oESnZJAoYKsSIjUGI+uqK4viz0FefzYiHvnGuu/mEeJ7qxxjvXp+i7E6BlMb
	 9cZjBnFwg81Yw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:30 +0100
Subject: [PATCH v2 09/15] mm/memfd: recheck the page cache before
 allocating a hugetlb folio
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
Message-Id: <20261116-fixes_hugetlb-v2-9-4dd9e94ea9ac@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1706; i=david@kernel.org;
 h=from:subject:message-id; bh=WyvaefU93I0GCeigHLBuumui8uriM1cUAYO1SQkwUYU=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3fM93KM2H1A55fa1H8ikqfaN/8+qXdr8vsrj5IzJ
 Xa5pnGldJSyMIhxMMiKKbIEBd83ePlyXW21Gx8zzBxWJpAhDFycAjARzrcM/33DbZt0pV7UTFkk
 76LybMJDm90rNi185/pUZb1hyIT4mM0M/2v5S2pn7Hh73UiB4cY+B1ttbgcdjZ39F3ZPvhe/6Mj
 ivywA
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
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 mm/memfd.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/mm/memfd.c b/mm/memfd.c
index f03d12aa71f7a..276f4323b6bda 100644
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
2.56.1

