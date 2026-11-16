Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794853791;
	b=LaL9wMmTu4GJ3nG8mNlQF8QL6vdQ5tXmVdjh7tCnbKRxeHanyXQeiSXrRSv+BVqCSRyM
	 YGrcDwyNrAPPzcKLHGwN/modWxcRuc+8z0xtrDD0gWk3K58vyAgHLhLPXHFL9MMQMxF6o
	 FpCJVEynRBZDmJmT3hUdlDzldX9yBoS/TdpvE8L/Gho0EEqVNHfP3PjdsT5RkCDmnufwW
	 ufR+i0R6MeK1WXUlCLY5GYF7bdPHx2KuTyCAjNwi6O1AdvA+HMfJSjoa/9MwO1j/Dc/uH
	 hKqQxU/+ZuooAoQ2UqQmf7FM7YKwFYefAUnFxSJIrHDAkvtnEhmY+wU9vi+O2lN19cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794853791;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=BDKwBnssy4agIUeqV3XD2T4cqqodSZ5/K7uKqzvbVTo=;
	b=Ix75ZB7Jd7wiqkvEfwRtuQKPjfoPQXauPzfLh9xnmjYeoBleqMkTcVbpB7KJPR48iDjC
	 MdAV350r3crymWYJN5MN4DVnuS2vKNqOADxL/0RWfY7PmXztQUz6ano/4DWwMpCDN+eiT
	 ebE3Mw5IZwl9NAJ0qjE5Xd5tY+/PTRq8Zol2vtcxQP9v5dEf8b7niUgeKEaI9Vr/pCDBW
	 Dy6eOr9oQiurc08vGJmvYa2bcq/6UxQkYmFWG3jkWULLktEVFmVBR1+TYhRTPeNdzj9d2
	 QsUpvyXxOlFTmKCOD8XKRm4wMe7PqsxE25RBUgIak7j9B03W00owbVHoTDLoPSJBNVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="frTMT/BB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DA7D606A322;
	Mon, 16 Nov 2026 18:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=frTMT/BB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D3C1F000C4;
	Mon, 16 Nov 2026 18:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794853791;
	bh=BDKwBnssy4agIUeqV3XD2T4cqqodSZ5/K7uKqzvbVTo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=frTMT/BBjQfNrhm+isVpW1M1JadVDrkuyoM+l1Kt9CYcRUMtdljdPkd+1eUSDEOKp
	 lcgVPz6EopuvnX7rrxMXk9dg+FhH1yeux1/LyyDXJE805w+n/6YYfd4eCq5r85XKNI
	 lYTBp+RPKMr9sCzgzOjdp1sBIRWq6xT4mgA3+qR+fbaUKb1bS2jtbdoM30nYdICi27
	 x/111AzBvAmJnUoXkIBnOOA5DWQWGbBK5uecgSsex7PC/9sf0Fy1b5ueL1r0MTZ8rj
	 xjYHhyGpzg9mySTJtumtF+u+KcoU03ar1bN+mF8xkluXjeKobf09Wq4N13sT8LklYY
	 dfdi+qg2Yjz1Q==
From: "David Hildenbrand (Arm)" <david@kernel.org>
Date: Mon, 16 Nov 2026 19:29:22 +0100
Subject: [PATCH v2 01/15] hugetlbfs: fix integer overflow in fallocate()
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
Message-Id: <20261116-fixes_hugetlb-v2-1-4dd9e94ea9ac@kernel.org>
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
 luojiajun <luojiajun3@huawei.com>, Josef Bacik <josef@toxicpanda.com>, 
 stable@kernel.org, Ackerley Tng <ackerleytng@google.com>, 
 "Gregory Price (Meta)" <gourry@gourry.net>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2425; i=david@kernel.org;
 h=from:subject:message-id; bh=s4vY02Z66QhN2vzSqhVJnXZ9yDCfCoi6K0jWeQw2axw=;
 b=owGbwMvMwCF2/OVpCdfQ3ZWMp9WSGLJ+e7dvD7GoClikdnle1fqn3m+j+EtNZ/mXSS4pWsrDy
 zytNf9uRykLgxgHg6yYIktQ8H2Dly/X1Va78THDzGFlAhnCwMUpABMJaWJkOGBc4swuFVgum6EU
 y39pfXxn8MvXSplKfaJn/inWtczbwcjwM5Clvp37xJXf3xQajy2LDe8X1/E64WLxxDDt2m0P/ip
 eAA==
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
Acked-by: Muchun Song <muchun.song@linux.dev>
Reviewed-by: Ackerley Tng <ackerleytng@google.com>
Tested-by: Gregory Price (Meta) <gourry@gourry.net>
Reviewed-by: Gregory Price (Meta) <gourry@gourry.net>
Acked-by: Oscar Salvador <osalvador@suse.de>
Signed-off-by: David Hildenbrand (Arm) <david@kernel.org>
---
 fs/hugetlbfs/inode.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/hugetlbfs/inode.c b/fs/hugetlbfs/inode.c
index 02e0a65d596d8..9f502a456cdb0 100644
--- a/fs/hugetlbfs/inode.c
+++ b/fs/hugetlbfs/inode.c
@@ -722,11 +722,13 @@ static long hugetlbfs_fallocate(struct file *file, int mode, loff_t offset,
 
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
2.56.1

