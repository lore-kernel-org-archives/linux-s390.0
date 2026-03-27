Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7FF93346BE
	for <linux-s390@vger.kernel.org>; Fri, 27 Mar 2026 02:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774577776; cv=none; b=I/Q2swWdF5a178hrrTAwjy4aqXf603/iJ3Fj4HRGU7OGxcLfO78cc5bFtRRwE3dO342mUd7wRciyBAsuvLPAwd02XFb2xhAdA/34Ey4CSbJ1UR1Oyjr6yK0hAgLNyNQ51yOb/jIoEblrJDt+eP7DYPGWyDajNPl+Q0QwsIZbxgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774577776; c=relaxed/simple;
	bh=syfgM5OExLCbukx9GidchZx7ggSkQRCtkMoeVcO/C88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CAm3pc5L6PlcEVYE0vn70txQRoBZaV6j/YVLA8GFqLmHIxobLiviTT2A3ii1omR/1ukMdImIJZdxkJMFAJY1buShqz2ELIBxxMrAHhh68lzeMq52XusCQzsIi97U7Oe9vbxfaY5mrxS7DU6Gsz/bAPzYrP759CgGwrlQ45vbFLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=YkBnJlAA; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="YkBnJlAA"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1774577772;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KBHgpp/Hlt3gblMxOihtIUK/6fHGYOfso38xhE/8i5Y=;
	b=YkBnJlAAFSpKbHZ97+87mwwuiOpaKGfMki0IODGcWo+ltRqHD5dxWBr38RHva/Za8up5uN
	sjKP0IWJ4LKydgafIE8LafBBavHbtcDNVR0+2IRtgtbgOEykPv1ek68+Pcb9SQy5kozeBm
	TXn8jzFa4saniUkUmgk+kYIpggBjy8U=
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
Subject: [v3 21/24] selftests/mm: add partial_mprotect test for change_pmd_range
Date: Thu, 26 Mar 2026 19:09:03 -0700
Message-ID: <20260327021403.214713-22-usama.arif@linux.dev>
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

Add test for partial mprotect on THP which exercises change_pmd_range().
This verifies that partial mprotect correctly splits the PMD, applies
protection only to the requested portion, and leaves the rest of the
mapping writable.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 .../testing/selftests/mm/thp_pmd_split_test.c | 31 +++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
index 0f54ac04760d5..4944a5a516da9 100644
--- a/tools/testing/selftests/mm/thp_pmd_split_test.c
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -146,4 +146,35 @@ TEST_F(thp_pmd_split, partial_munmap)
 		self->split_pmd_failed_before);
 }
 
+/*
+ * Partial mprotect on THP (change_pmd_range)
+ *
+ * Tests that partial mprotect of a THP correctly splits the PMD and
+ * applies protection only to the requested portion. This exercises
+ * the mprotect path which now handles split failures.
+ */
+TEST_F(thp_pmd_split, partial_mprotect)
+{
+	volatile unsigned char *ptr = (volatile unsigned char *)self->aligned;
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	/* Partial mprotect - make middle page read-only */
+	ret = mprotect((char *)self->aligned + self->pagesize, self->pagesize, PROT_READ);
+	ASSERT_EQ(ret, 0);
+
+	/* Verify we can still write to non-protected pages */
+	ptr[0] = 0xDD;
+	ptr[self->pmdsize - 1] = 0xEE;
+
+	ASSERT_EQ(ptr[0], (unsigned char)0xDD);
+	ASSERT_EQ(ptr[self->pmdsize - 1], (unsigned char)0xEE);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
 TEST_HARNESS_MAIN
-- 
2.52.0

