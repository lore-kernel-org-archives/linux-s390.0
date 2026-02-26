Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC5833081C2
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105709; cv=none; b=fWhmuFwTpOBrMdtE0r+N58sLmogyhJjqSiVu6V1VbikvAj5yyJEZCnzrPhDgY+NsoxNKGXnJdpVXK1eNoTgx/569/HD3A4RHEzBT+oNxHJwuM/ZJELWJiM1KUqmyyCZxpM+bxAW2LglDwukAzVIhcBCoSlLhk7bv1pcmHvyR4tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105709; c=relaxed/simple;
	bh=+yKnXd1ZKIxQPLVKvuyq1/dahylMFLiXl/aO8LykuLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ufnLi9/oUGwwPviRFujY+ErtmoEbvefZd7egzaQlmxmwPVAYgf49D/x7OXxBId8OFNO4rg+4OA8hx3FpvpzQqJ6J5Ad+vNEesYTiAP0PAyEQzcMhp61GeZswneGQwmuE3fwbaJdkIBwDKlZtvVD95dhcLvZJfSNO4rCa7HTHp3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vDnDtqlu; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vDnDtqlu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105706;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=90K3/Ap/gcMw9j71y2Oyck7qwp5+WMwh/4brt0FtyC0=;
	b=vDnDtqlus/KJ8Kb996zZEjIj0Q0OZrP9GY6JYe5v0jo/jHj6Hhvq7Y6+kbJrhcBUFwKCR+
	ptXaefkfhEcHKSCBne13vyEB9khUI5H2IRECqYMjzQXrM98xkEITpmyhzIlR8rRiLVUScp
	6fbItK2kptHjFBl0pkeiWG9RptvrStU=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	willy@infradead.org,
	linux-mm@kvack.org
Cc: fvdl@google.com,
	hannes@cmpxchg.org,
	riel@surriel.com,
	shakeel.butt@linux.dev,
	kas@kernel.org,
	baohua@kernel.org,
	dev.jain@arm.com,
	baolin.wang@linux.alibaba.com,
	npache@redhat.com,
	Liam.Howlett@oracle.com,
	ryan.roberts@arm.com,
	Vlastimil Babka <vbabka@kernel.org>,
	lance.yang@linux.dev,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com,
	maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	linuxppc-dev@lists.ozlabs.org,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	linux-s390@vger.kernel.org,
	Usama Arif <usama.arif@linux.dev>
Subject: [RFC v2 20/21] selftests/mm: add partial_mremap test for move_page_tables
Date: Thu, 26 Feb 2026 03:23:49 -0800
Message-ID: <20260226113233.3987674-21-usama.arif@linux.dev>
In-Reply-To: <20260226113233.3987674-1-usama.arif@linux.dev>
References: <20260226113233.3987674-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test for partial mremap on THP which exercises move_page_tables().
This verifies that partial mremap correctly splits the PMD, moves
only the requested page, and preserves data integrity in both the
moved region and the original mapping.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 50 +++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 3c9f05457efec..1f29296759a5b 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -203,4 +203,54 @@ TEST_F(thp_pmd_split, partial_mlock)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * Partial mremap (move_page_tables)
+ *
+ * Tests that partial mremap of a THP correctly splits the PMD and
+ * moves only the requested portion. This exercises move_page_tables()
+ * which now handles split failures.
+ */
+TEST_F(thp_pmd_split, partial_mremap)
+{
+	void *new_addr;
+	unsigned long *ptr = (unsigned long *)self->aligned;
+	unsigned long *new_ptr;
+	unsigned long pattern = 0xABCDUL;
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Write pattern to the page we'll move */
+	ptr[self->pagesize / sizeof(unsigned long)] = pattern;
+
+	/* Also write to first and last page to verify they stay intact */
+	ptr[0] = 0x1234UL;
+	ptr[(self->pmdsize - self->pagesize) / sizeof(unsigned long)] = 0x4567UL;
+
+	/* Partial mremap - move one base page from the THP */
+	new_addr = mremap((char *)self->aligned + self->pagesize, self->pagesize,
+			  self->pagesize, MREMAP_MAYMOVE);
+	if (new_addr == MAP_FAILED) {
+		if (errno == ENOMEM)
+			SKIP(return, "mremap failed with ENOMEM");
+		ASSERT_NE(new_addr, MAP_FAILED);
+	}
+
+	/* Verify data was moved correctly */
+	new_ptr = (unsigned long *)new_addr;
+	ASSERT_EQ(new_ptr[0], pattern);
+
+	/* Verify surrounding data is intact */
+	ASSERT_EQ(ptr[0], 0x1234UL);
+	ASSERT_EQ(ptr[(self->pmdsize - self->pagesize) / sizeof(unsigned long)], 0x4567UL);
+
+	/* Cleanup the moved page */
+	munmap(new_addr, self->pagesize);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.47.3

