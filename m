Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793218444;
	b=Am+M09JUBKzdlAU08AqjAab0qnplxTqKMxhGkILjjjvQ+DnntlFnsEsrQHpTCo1C8cSD
	 SHXuziATTab6EPnQAvhJMusYxU1ECJ2FgiMH6ypB9ZVikE00oOMT1ehnwxpdH24w26NRZ
	 xNrgkY96POQA3IAUgJkOIgQbbhtAD1ao3NKTUJyJt8no6hjJGzpApDyl3GHULPeMtBGaS
	 BBGS2y/biDfukWtN6rWTKPUCadnWbpUPgFft+B1aRJ273xp7RiIVe0klAUKlXAI4smxJN
	 Ta+fgzDBPuigekwPueEqsdop6bsvnsLpDnQuhpKkjCo9QEd05wIRWZ3tFOHbgqkEXdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793218444;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=kpnp0nKo1RLJPeIcxnHpYwtTOco9Mw53rg5cDi3/lLs=;
	b=uJGcQgXFij2Hi8b6ClezpmeD6PwNYU0OjcIm8aNNfXJdGEMQQrYPic9/xEuImxc9THjX
	 YpQaiKJMHZs7kG1wEEipSgvrb4ti3LNARJat29M+BXGDmSiZFjJc6BwyvYUPw0R7n3udi
	 keXY1IaeYDtMxA01oIQOJT7VFsb44dF0ldHd9TG/6wlgZGEte7IDVHyRsPhAdbutRe/XF
	 klV6zdCgRb7UiTWGQA7Z+R3r8Hb5LqnZRJHNoStHymojWOigs0ul5uPaOrkbf7pjDUCmn
	 N/QB0hb7K7iR9zr3osLNdA7iorH7/oFoxmOXI4Bhi4Kt4VzJEdRuwpUlYWoLRsTZEQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kdh2USKD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B5DA606A31C;
	Wed, 28 Oct 2026 20:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kdh2USKD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ECCE1F01829;
	Wed, 28 Oct 2026 20:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793218444;
	bh=kpnp0nKo1RLJPeIcxnHpYwtTOco9Mw53rg5cDi3/lLs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Kdh2USKDJZ0FkYnWxpwRhfUMZvge6+fv52eBOYXQE4K9FiM0K4U+BHJFNVSPa8SaR
	 qz0fJopgw/70FToz7iDOKngca29X//VXT5/e8eP6xGe5f7GFhffQH6zeC2GOp/hleH
	 n9o4bqtE3izozibZx0/EGpV6yc5ooao2ZOamV04m7ODd/0AjL324MpPNritM1bvgPV
	 i4WVSj11U1NP3zYtWbfrCuQSbjPM+7EWyuQ7RkG3U4c8cWx2ojiZ48TgZhVuUFx9jj
	 PTNmpfwlk+bKAkCQlPvJwDrVqWXVgoBNuxz+ZTVLJ/GThvLKqVUtebOP+aR2t9RJfI
	 QneBInCwD8IQw==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Wed, 28 Oct 2026 21:13:29 +0100
Subject: [PATCH 01/15] hugetlbfs: fix integer overflow in fallocate()
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
Message-Id: <20261028-fixes_hugetlb-v1-1-a0a033db180f@kernel.org>
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
 luojiajun <luojiajun3@huawei.com>, Josef Bacik <josef@toxicpanda.com>, 
 stable@kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2170; i=david@kernel.org;
 h=from:subject:message-id; bh=I1sQzSgEyvJMIZxcUjk6PSvZ4Sdw/GRLUPVEqCN7UCk=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLIehZcebvr66cjyjsA4Z8MHays+f2Jax1wSNyGwXXO75
 bTlOWxcHaUsDGIcDLJiiixBwfcNXr5cV1vtxscMM4eVCWQIAxenAExk8xaG/zEmOY2li54ueRq3
 v7n3zJSkguNagnz6Ep+ZLr7Oe6t++x3DP/VXvov+1dmK3lywRTvn29Xfb744bo47787m7frugMi
 alUwA
X-Developer-Key: i=david@kernel.org; a=openpgp;
 fpr=1BD9CAAD735C4C3A460DFCCA4DDE10F700FF835A

hugetlbfs_fallocate() rounds the range end up by adding hpage_size - 1
to offset + len. vfs_fallocate()'s existing overflow check only makes
sure that offset + len does not overflow.

Once we overflow for valid endpoints near LLONG_MAX, we can get a
negative temporary result that is then converted to a very large
huge page index.

A one-byte allocation ending at LLONG_MAX can therefore consume all
available huge pages. Pages added beyond LLONG_MAX are skipped during
inode eviction, leaking them and triggering the BUG_ON() in clear_inode().

To fix it, calculate the end index in a simpler way that cannot
overflow. This also fixes the signed overflow reported by luojiajun in
2019.

Backporting notes: without commit a08c7193e4f18 ("mm/filemap: remove
hugetlb special casing in filemap.c"), remove_inode_hugepages() must
include the final huge page during truncate and eviction.

Reported-by: luojiajun <luojiajun3@huawei.com>
Closes: https://lore.kernel.org/all/1554775226-67213-1-git-send-email-luojiajun3@huawei.com/
Reported-by: Josef Bacik <josef@toxicpanda.com>
Fixes: 70c3547e36f5 ("hugetlbfs: add hugetlbfs_fallocate()")
Cc: stable@kernel.org
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 01c4d6f44ebe..5592cfc6cc8b 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -721,11 +721,13 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
 	/*
 	 * Default preallocate case.
-	 * For this range, start is rounded down and end is rounded up
-	 * as well as being converted to page offsets.
+	 * vfs_fallocate() guarantees that offset + len is positive and does
+	 * not overflow. Avoid overflows when calculating the end huge page
+	 * index: set it to one past the index of the huge page containing the
+	 * last byte.
 	 */
 	start = offset >> hpage_shift;
-	end = (offset + len + hpage_size - 1) >> hpage_shift;
+	end = ((offset + len - 1) >> hpage_shift) + 1;
 
 	inode_lock(inode);
 

-- 
2.43.0

