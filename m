Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218543;
	b=nJNqf0PDjQ9GjGqtVPgQZAbvoBro2NfOgn3tJdK1LLmoZuse4Y8JCILd1LvXeX0YLgrg
	 4mVo2FutixysLlojho/56WZFkmPr+b1MPiSnxeicOu0NsTEucwFs3ZFX3w1w0Xb74OPmm
	 olhag+/6SFYbH2sXiDklBqF5q9zqymNhMcJg774hCA1T+OiWzosU3t0wY+gaRkyQ9cDhk
	 oTHElF8WlHIvCJgyu+H65tqEifU6DHyiOMpTKoP2u3gnLH3yFbAGTAnScwyMSsoKQbyLM
	 XlIrscCr1ZFQGWwE1PVfs5Pitq0wOFBPK5zi2zS6ZdRZrwUGQknwOpa9E3nfWRWt5jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218543;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=dhlOcylSqv6vV3g9yAiSRK5LeWK6PvVVUjVeVgzCiQQ=;
	b=fgsvVMihLpSKRRVEs/pdn6uVmryRdLuyNjHO+tJ6YpharApgD0hqbz9ZLMge332hX8Fj
	 I3DQnWmX5t2xBoRlfvEKGiWJGEUAK7MxkZPkz5Q5nIWN2Na6KAkbHe6BDti8Rqz/q098h
	 xSaI4T1hhE9aZEQC08sPeT7gIsRXB6PDHLMML0D4GaHgZi/h5RUOMDQw+0PsL+k4pHSMh
	 21agToq3s8XHvgnYME/87FqGtJiJqbnV86EsB0Ub9l+5Ya2fncowHkOwODwVaPySd4exN
	 c/a+BZZhbjLEKWQVH0Gr3sTF3cmH7iQpgWZVYmLIT8V2e5XpQDHfktnKWJUtYhY42rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDryEfII;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91A0606A31E;
	Wed, 28 Oct 2026 20:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MDryEfII
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5134A1F01828;
	Wed, 28 Oct 2026 20:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218542;
	bh=dhlOcylSqv6vV3g9yAiSRK5LeWK6PvVVUjVeVgzCiQQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MDryEfIIbBaBrNLjVh8hACudAmXfL/S1kjrTLh5SZ08bjgHV6iWXaXp31ewgzfKe+
	 zWNEbZUYhL/laZa4wmO5uWL429aLw9BrkwUNg9TYVRY5iPDgN5wldEw1bIoxGd9Toq
	 PQh1eb5oeGrVkia/U2LFeH3hWctk396bHN/cwEVZW1towoLPmbhcF0C5pzLxc9fE9x
	 6yZmXjQs8uIOijZ0DoGLNB78fF56/72A3d+tDxUxf6iGgw2KYtvPos5F1X+diqmqMt
	 c4S8d2I/GmOne7rKz5V+Z0nCjCzEAmelHZpDitJZ2FTrtPqI24uifZXvNp1VdlE5I5
	 GxDSJ1FqFqmYQ==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:39 +0100
Subject: [PATCH 11/15] hugetlbfs: do not grow a sealed file in mmap()
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
Message-Id: <20261028-fixes_hugetlb-v1-11-a0a033db180f@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1642; i=david@kernel.org;
 h=from:subject:message-id; bh=jfkxciSMrikjpjxL1MRSlSwGiIzaViEI3tCQWSWiOnE=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZfd+Xd4tvvyz5xvlh03sXngfnuSyoGrLxMOfbHTm
 3vghl/O2o5SFgYxDgZZMUWWoOD7Bi9frqutduNjhpnDygQyhIGLUwAmoqzM8M8qr+y2cslv7tel
 Yjo7GTnfTlNcYyIkuzDX4J/kGgX2Qm1GhvU6GhpWRcdurZr0NYObk8Vxq9uH12bhR/KXcU2N2hW
 gzAoA
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
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 174455e10d0f..47da18bb3490 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -156,7 +156,8 @@ static int hugetlbfs_file_mmap(struct file *file, struct vm_area_struct *vma)
 		goto out;
 
 	ret = 0;
-	if (vma_test(vma, VMA_WRITE_BIT) && inode->i_size < len)
+	if (vma_test(vma, VMA_WRITE_BIT) && inode->i_size < len &&
+	    !(HUGETLBFS_I(inode)->seals & F_SEAL_GROW))
 		i_size_write(inode, len);
 out:
 	inode_unlock(inode);

-- 
2.43.0

