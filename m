Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853890;
	b=4ey7NzpL0nD08knkUXAL3ulHH9SXv5MdphNHNHuebb6rI7vowcwJ5Ar2vh75w1XaVW8v
	 8P+9N692QYTBj5HXGfzJ+39nRyNPNSKpGt1fe2MVO8A5YP+qO6fssasyZgaDFYSN6fjIu
	 nZ+dFXB7CYoM0PYi3Ig2PIoqkFGiDeGblrrfus2FuaXCS9qfp5N6Km1c7WQXmBsiLBTqb
	 VzwfFwV+sYFeqWSnGsJc0jWb7oUM6a02v3KkSasammtyXRhuGwoA3C+njFn/mOTl9rzmT
	 c92Vk38yFOFqERKqLuErtnt2DX7jlevEAp1vcTKg+OUUzTTHyypu8t8DIAPAMlv8sZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853890;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=q0jJ9DG871OFSsJRPfDNFiA+MAmHAYLFk8xwl1caeO8=;
	b=ouo1PZwr5ji6A4GwiuRAKxc4S/nplE2p+B7aewaLz4InReJWqYmjSkNV8btJkFVtyo5Y
	 iGCHWJ0dSYEe6qdTJo2beODGUiREwqMesW/dQgmMRHDELeODd8Ml7OjCloAbeQrgJkUf3
	 8pz5jgKEyOUkbXYE/YHJ4swU99n5XtXE+TjSBMhsG+JQJyzXO2wya0UGGQ4hIxdvd2wEw
	 no/BPfPHV1nAR5vsk5JootC3I7lpJleMHK1qU9iY7DMwgGzwo5TMz5ivVXM+qzrlH9c4d
	 JQoLXWCWvUv2FpCxr13Qs/P99SiL/QtPNPMVAJEyDTP+aLq1JIEgQ5LLff8TsuYkRSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzU3ZvOP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF0B8606A32A;
	Mon, 16 Nov 2026 18:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gzU3ZvOP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C1B1F000D2;
	Mon, 16 Nov 2026 18:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853890;
	bh=q0jJ9DG871OFSsJRPfDNFiA+MAmHAYLFk8xwl1caeO8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=gzU3ZvOPOm6u99r1euC5lial6Qf/zt9Z2yF20f0NZfK0BVs2UBiLqG7yras464Rq5
	 U/O54qNu+c8Ffk4R8OioGkEV2DxIx6W2UBRXjc7RgtGhuRVZyZvGi380w6qagb+iaY
	 H9T6pnKcrcLEz29qrY3kpf1UsQ0fahsCc5+cUGi84dIoCI0gI4eUAJbcOn5HdCb2Ak
	 f0VFiHQBSxpfcvcYAk05ieFQaDQ5PTaN00cI3lUo5iaXRR71T0/LYj01OAOsb2YLhY
	 byGtidwywQpBEzyyOwWxmdTBT9Jga8CtTWC8ZMQ5QBajeLrCaOLvFZJCEuxlRc3C4P
	 ReSDG4BvlyAhQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:32 +0100
Subject: [PATCH v2 11/15] hugetlbfs: do not grow a sealed file in mmap()
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
Message-Id: <20261116-fixes_hugetlb-v2-11-4dd9e94ea9ac@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1744; i=david@kernel.org;
 h=from:subject:message-id; bh=G/tuABhS2tS7ZSsk7F/KPnT0aGZ5wg9nvABDUFm2+8w=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e3fGM9mYXipelJ7Ywvbq5fLfrpsUPx/6NO/X87g3o
 QFamoadHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExEX4jhf6Wtzm3ZywGvbzdN
 TE6efEZc8KnNtVUBczU1DvIp39V8/ICR4UPy4sf/53i6vRIoZznvk/3IQ8Bp2r9jsyb+KxX5E59
 QwQEA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

From: Chris Mason <mason@kernel.org>

hugetlbfs_file_mmap() grows a file when a writable mapping extends beyond
EOF. We are missing seal checks similar to hugetlbfs_setattr() and
hugetlbfs_fallocate(), allowing a user to grow a file that has F_SEAL_GROW
set.

To fix it, skip the resize when F_SEAL_GROW is set; mmap() still succeeds
without growing the file.

We currently also allow CoW mappings to grow a file. Disallowing this,
maybe even only for read-only file descriptors, could break existing
userspace, so we have to be more careful. QEMU's file backend is an
example user that might rely on such things, and would suddenly start
getting SIGBUS when faulting in memory outside EOF.

So be careful and focus on F_SEAL_GROW for now.

Fix generated by an LLM and sent by Chris Mason in private.

Fixes: ff62a3421044 ("hugetlb: implement memfd sealing")
Cc: stable@kernel.org
Signed-off-by: Chris Mason <mason@kernel.org>
[ david: drop comment; simplify+extend description ]
Acked-by: Muchun Song <muchun.song@linux.dev>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 7f64bdc07aa80..68761e1ed4d2e 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -157,7 +157,8 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		goto out;
 
 	ret = 0;
-	if (vma_test(vma, VMA_WRITE_BIT) && inode->i_size < len)
+	if (vma_test(vma, VMA_WRITE_BIT) && inode->i_size < len &&
+	    !(HUGETLBFS_I(inode)->seals & F_SEAL_GROW))
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);

-- 
2.56.1

