Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 531C97081E;
	Fri, 27 Mar 2026 02:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577792; cv=none; b=jVqJ1zG7MOB9zUqgaohL01EnWySell3FZ/Bfb4iVwl9NQHf0ZMZUBJL54ZfSziA88ne/4Q1aAAG5Sz/W4CK93O41yIqu8F99IbdCGoHkkBVQrdjs/SaLKgqtP5rdoNY/FshoXcnj/5GvfiBJuEVjA7WKaB+526vEJc+u7Mu2ecg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577792; c=relaxed/simple;
	bh=UUT7iH24/amHFqogk8FoV3c5CLRQAISV08V1vKPOync=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzixXUhX6rxoMstStXww2j7x6ntIPU+kQ2/dMCrP1KXOgTlXnUnd9y2AywcBYCBpmbi1bvybq/MvPG0z030JHlbwsUdOcdvcp6TMnpQzKRv0YT4RvGDCIQMVbBprh/CZxepJ6rK+sP10LOL4I6xNEvx77DLHF57zKoV49qDSyqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LBA+DGA7; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LBA+DGA7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577789;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/HdPBhl1cpZOUmiZuBTWaeHIDSWjs3qo4yxLZnBGpA=;
	b=LBA+DGA7C1hpEc4UK/USzbeWl9ofYAB9golUoHkRx3arz+0f+tCFBPShuiq8sFBcmjRcuj
	BkqIUVWSZWrzlncJMS6q2HSKiSIKaHundpnJFyYH9WZp0Dq8jBzWfRFloYOIU6zqnN8+4q
	hwvlj8SU2eHG55dpFcr7cLa/cO3P9xE=
From: Usama Arif <usama.arif@linux.dev>
To: Andrew Morton <akpm@linux-foundation.org>,
	david@kernel.org,
	Lorenzo Stoakes <ljs@kernel.org>,
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
Subject: [v3 24/24] selftests/mm: add madv_dontneed_partial test
Date: Thu, 26 Mar 2026 19:09:06 -0700
Message-ID: <20260327021403.214713-25-usama.arif@linux.dev>
In-Reply-To: <20260327021403.214713-1-usama.arif@linux.dev>
References: <20260327021403.214713-1-usama.arif@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Add test for partial MADV_DONTNEED on THP. This verifies that
MADV_DONTNEED correctly triggers a PMD split, discards only the
requested page (which becomes zero-filled), and preserves data
in the surrounding pages.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 1f29296759a5b..060ca1e341b75 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -253,4 +253,38 @@ TEST_F(thp_pmd_split, partial_mremap)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * MADV_DONTNEED on THP
+ *
+ * Tests that MADV_DONTNEED on a partial THP correctly handles
+ * the PMD split and discards only the requested pages.
+ */
+TEST_F(thp_pmd_split, partial_madv_dontneed)
+{
+	volatile unsigned char *ptr = (volatile unsigned char *)self->aligned;
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Write pattern */
+	memset(self->aligned, 0xDD, self->pmdsize);
+
+	/* Partial MADV_DONTNEED - discard middle page */
+	ret = madvise((char *)self->aligned + self->pagesize, self->pagesize, MADV_DONTNEED);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify non-discarded pages still have data */
+	ASSERT_EQ(ptr[0], (unsigned char)0xDD);
+	ASSERT_EQ(ptr[2 * self->pagesize], (unsigned char)0xDD);
+	ASSERT_EQ(ptr[self->pmdsize - 1], (unsigned char)0xDD);
+
+	/* Discarded page should be zero */
+	ASSERT_EQ(ptr[self->pagesize], (unsigned char)0x00);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0

