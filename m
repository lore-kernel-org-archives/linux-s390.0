Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218503;
	b=X1fF7cMUE7cWzWQ7SLuOsKn8VzLwsE4TZeSijhphoLHczWP3iPuG6uMwjapGMquXKW1z
	 oEKNBo8wtU2Bi1C3T+MMsS8QToE8UgO//VMEjZ4zR6aLd5Rv2ChznRjJk/ZXTxNy0nINu
	 9BgjRByb7kFpkf7B0/NvYkS2I+REMS9r71fEulm3HP0xcOoEECp8Afs8aMmo0cg7WW9qM
	 Imc87sTYV8Q0+7m3VaovD7lDiS52jhEDtB2y6swcqY+qvx10F9ypMzZm/mpxKkvpsW9SH
	 dPwL2MwhGZeI43KfWwKOg6nR9j/8s12Mriy3HUbGY8lwD+d9W3rl14NvCwZ7x9lSzdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218503;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=/U9n2F5dQOQHSwb1MXCfMAe5RfJMUNrLjUXev2VqdHo=;
	b=DCE4OQKQP6QyZjVvA5PRGLACPHs66D6QWJQkN4cxcTwtQXHzDSZ4ABVr/so++YZTQL5g
	 bwrlebCsuXk2QMpIPgllXJ1QCGkU+WO+l0taoQC0X3ZJDDf3GtfFC1QpLNoPjxpM20INY
	 3dPCKmhH7MCyXukLzZ2Jl4z6vVXekIJme83h4cs6fwONZBlG7IWoR6rGdxIuL7vCyYuGE
	 VWM9NBfJ5Qa3v5Suh6pdjMC3f3wk+40XAEZg9NaxgL11IxfCj6xAo2Z43/moeF88PkgKM
	 OgrVrY5ne6K1k4fNs0Wex/+OT/HiXCNabAQHgkkxneMpLlvLpnPRXVZssmphkDomRaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rq9Ru2l4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB8F606A323;
	Wed, 28 Oct 2026 20:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rq9Ru2l4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B921F01825;
	Wed, 28 Oct 2026 20:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218503;
	bh=/U9n2F5dQOQHSwb1MXCfMAe5RfJMUNrLjUXev2VqdHo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Rq9Ru2l4yMkJyr/jNoKFGTmkAlXE2FDGSgQxEQAku+lQY8AFnqQIyt1jzMmONwh4q
	 kDTLUzME3AvbI5d7QDNllciJdAzfa+61Fh44eWWBAmr6qPK4xxkv+6x300WqZp2BfR
	 zX/T0YJcIGStcwr5GdE4B3ZSqs6wXKJyp2c9IgJFjQaGqhKDykfe8bPb4hjmAf2Xwu
	 lJarCETJWX6/U/PqBmmlR5EQyyXPyjiut575L2P+6OYLtAbh99qxojHguMjAcS4Bss
	 q4OFyM9/FSL5Iuy4AHNYlsunTo/BqU25zXOGquu4qbgNHa4C0R8Lq17sPHtO2vN0Gy
	 5ZpB7NHG9uFbA==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:35 +0100
Subject: [PATCH 07/15] hugetlbfs: fix unmapping folios from private VMAs
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
Message-Id: <20261028-fixes_hugetlb-v1-7-a0a033db180f@kernel.org>
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
 Josef Bacik <josef@toxicpanda.com>, stable@kernel.org, 
 Daehyeon Ko <4ncienth@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1684; i=david@kernel.org;
 h=from:subject:message-id; bh=rVtz7fX7kcHzCCezweHAtetVEk43H7wa5E9No4kWJ70=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZfO5dZ6YFXlkbImz3NXXN2kF52vd6eYsGuKWIred
 ZgaGODaUcrCIMbBICumyBIUfN/g5ct1tdVufMwwc1iZQIYwcHEKwETOeTL8lQnbm73rQsEJnaZ0
 GyvLGfOb98tuNGOecLv3lOw074RdGxj+BygIq7pWz2K5O8u51Wqri0FSzNOQp08sTi57zbrxyKI
 3TAA=
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Josef Bacik <josef@toxicpanda.com>

hugetlb_unmap_file_folio() assumes vm_private_data points to a struct
hugetlb_vma_lock when hugetlb_vma_trylock_write() fails. Since hugetlb VMA
locking was extended to private VMAs, this can also happen when
vm_private_data contains a resv_map pointer; treating it as a
hugetlb_vma_lock corrupts memory and can cause crashes or hangs.

Only take the VMA lock when a shareable lock exists, as additional locking
is only needed for PMD table sharing. The fault mutex and i_mmap_rwsem
already provide the required protection for private VMAs.

Fix generated by an LLM and sent by Josef Bacik in private.

Fixes: bf4916922c60 ("hugetlbfs: extend hugetlb_vma_lock to private VMAs")
Cc: stable@kernel.org
Tested-by: Daehyeon Ko <4ncienth@gmail.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
[ david: simplify description and comment ]
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 5592cfc6cc8b..fa367fc9e019 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -400,6 +400,16 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
 		if (!hugetlb_vma_maps_pfn(vma, v_start, pfn))
 			continue;
 
+		/*
+		 * We only need additional VMA locking here for PMD table
+		 * sharing, which synchronizes on the shareable lock.
+		 */
+		if (!__vma_shareable_lock(vma)) {
+			unmap_hugepage_range(vma, v_start, v_end, NULL,
+					     ZAP_FLAG_DROP_MARKER);
+			continue;
+		}
+
 		if (!hugetlb_vma_trylock_write(vma)) {
 			vma_lock = vma->vm_private_data;
 			/*

-- 
2.43.0

