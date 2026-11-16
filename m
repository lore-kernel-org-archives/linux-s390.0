Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853851;
	b=fYrdHwzD4cYSyAaXle0YWyrQNlsIYZWqSnKznb+eHtojBkTmO7CtK11MisTCI/h/VTyw
	 ukA1B07SIKgxfd6/qmhjhF24s8hfY/ZDmSbS2hqU6A+dZC97/6fqF/8+spIaxlCKMpOxZ
	 15XjMS/0OqXDpHqF7fchaoURxfdKBhh8Awrqk2BPBIRL5s3793So01HqJHzJCbPb+nrnm
	 7MELeLxQ6Gh8eZVUWzNW6JxJ9d2ws1VofJ1cgF7FASb9ALQROfUsvWePSZ3wMCPBnUC4T
	 /Yyx7e37CqB8muekEtacDS4JxDhMnVz7ZLakev5HNCS5T2MO3ZJ/uZab03pi/9QMO8A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853851;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=o6PYS21e1qzhPD+clr29kXL1Odn23CBKU4MGaHVrsFk=;
	b=hN9Cv5SpCDpBy58Nw1gReH+4HvE6TKqRa8NUaQ7i/7qvE4iS2UUlmGoHiEOvZCOQet+Q
	 U8wpLmArjrVd+kteu3gcgf4OfuuTVN//UAIQTN4FIaCcITiF1uXlUDUb25uMPXqz6hLuF
	 tEOLLWifT6O5nY+IEu9gyNI7tg05NmNQtbJGsGEk3fI2hXqit5lyyakcZ3FrLSsYhYzMK
	 577TMa21eWyn4vkxHDoUHhESejaioMpHaWhBaufX5YXZ+l/w7MkGYN4rNwlXFAgADlfC8
	 4A5q62CUplIJLRT3Yc+Zc8Z1as7c59mhaPoJd+0hv0yJ0LT3xJVdzwdLKQMX7CojZYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVK4sRRn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57C34606A322;
	Mon, 16 Nov 2026 18:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bVK4sRRn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A98A51F000D1;
	Mon, 16 Nov 2026 18:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853851;
	bh=o6PYS21e1qzhPD+clr29kXL1Odn23CBKU4MGaHVrsFk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bVK4sRRnGn+L+J2Am0Z/tsuoc8SgVowIBYkVQm+LzF9nmHc2edHX+oQ6uI12gLwRD
	 fDqrkuaf+3EWHrMC8xRooDVX5Cp2Fo3kzJ5na/pV83SKF8S4+AptniblU/hbrSWrFo
	 5iunhxjtSw2c31epVCKDoYcRq+WTWcBuT5j6nFAratLxghlFEgushz+NXMKyJSqRIq
	 nt2euhGTGf9IcmJvQvz0oxrnt+ZYiUz77iQ2aU7jLIquJeSgmVQjCI6xzExnfuJevm
	 1u+xtI7bqBDbuh5qEXtVqAbvY2IFij4n7rn3r+N0G4h6DcGRnooL2bDlWwHvtjD59h
	 9NbiReDdEkCNQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:28 +0100
Subject: [PATCH v2 07/15] hugetlbfs: fix unmapping folios from private VMAs
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
Message-Id: <20261116-fixes_hugetlb-v2-7-4dd9e94ea9ac@kernel.org>
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
 Daehyeon Ko <4ncienth@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1733; i=david@kernel.org;
 h=from:subject:message-id; bh=vYFnAW6yKXJXOaiP5JOgGjPOTzuMx6UkG09rimRGfuw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3foBZu0rNgZ68DGdFE4v/EIe8m+yd92OXkUF/vvP
 qAQLXGlo5SFQYyDQVZMkSUo+L7By5fraqvd+Jhh5rAygQxh4OIUgImoGjEyXKz8wH4i7cplmQn3
 U+fL3ry+w8Nlp1zhAw0zoznJqVd/3Gb4X53v+VnyXOnTieENTn0SE78qfIpRk2GMffPUXG7a7bY
 JrAA=
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
Acked-by: Muchun Song <muchun.song@linux.dev>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 9f502a456cdb0..1d0c35e639e80 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -401,6 +401,16 @@ static void hugetlb_unmap_file_folio(struct hstate *h,
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
2.56.1

