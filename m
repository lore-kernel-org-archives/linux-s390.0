Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0A1374752
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105690; cv=none; b=glI6WGV4XU1sMqo/Oj3z+BF/dc9IoZwQgMr6/6V/xcc2ipmxruKQEVNbcZx5HD1AKYOUjADdIvtOa28ryuaiLY0ASiN/vi98gFGK7paTNUZZUxe5vHnjl0b1niXYh6Hvj4iNGhglcxFL9TiHGZKyhBMZsf7lx7utzLOG6PF3z2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105690; c=relaxed/simple;
	bh=51esavDNFGG1Wz8hv4vjtdQUxnzcd1SIpqsqnSLT15o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jxOND8wlSK08Oea/3hO4QuhrcmJHPqZfXX/oFQ7TLTkRzaRfzfjs2gyrN7TandgJtY0EYvVDbVIzRH6mFwfsDPtO4ca/zKUh9zorZkmoo6a+eIOcgiInqfJyCN9ZZ0p4muWX1876VFdeghGvxzZDFAzm3/LwXUctD7tvFI7PeFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Ec17NRLq; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Ec17NRLq"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105686;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3EBMW5df/kqjxALvGCac5LeXwtQNaqEvULHNZHX+1lo=;
	b=Ec17NRLqZdkNOCfYyhxyJmbLXJ3hDN99fyOVr8S7gzesBylU0G5qLKGmWd2mUsNPo4QbCO
	0P46bXf4Y7YpPawzBDCHsB8JH5ZskGMhbudmRHaDZgLl4BF2ofVHpfjC5JFLtZFT9+SWee
	iFTIlNIY6EmRvwy8JGlhh+lWFExdBSw=
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
Subject: [RFC v2 17/21] selftests/mm: add THP PMD split test infrastructure
Date: Thu, 26 Feb 2026 03:23:46 -0800
Message-ID: <20260226113233.3987674-18-usama.arif@linux.dev>
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

Add test infrastructure for verifying THP PMD split behavior with lazy
PTE allocation. This includes:

- Test fixture with PMD-aligned memory allocation
- Helper functions for reading vmstat counters
- log_and_check_pmd_split() macro for logging counters and checking
  if thp_split_pmd has incremented and thp_split_pmd_failed hasn't.
- THP allocation helper with verification

Also add a test to check if partial unmap of a THP splits the PMD.
This exercises zap_pmd_range part of split.

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 tools/testing/selftests/mm/Makefile           |   1 +
 .../testing/selftests/mm/thp_pmd_split_test.c | 149 ++++++++++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 tools/testing/selftests/mm/thp_pmd_split_test.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 7a5de4e9bf520..e80551e76013a 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -95,6 +95,7 @@ TEST_GEN_FILES += uffd-stress
 TEST_GEN_FILES += uffd-unit-tests
 TEST_GEN_FILES += uffd-wp-mremap
 TEST_GEN_FILES += split_huge_page_test
+TEST_GEN_FILES += thp_pmd_split_test
 TEST_GEN_FILES += ksm_tests
 TEST_GEN_FILES += ksm_functional_tests
 TEST_GEN_FILES += mdwe_test
diff --git a/tools/testing/selftests/mm/thp_pmd_split_test.c b/tools/testing/selftests/mm/thp_pmd_split_test.c
new file mode 100644
index 0000000000000..0f54ac04760d5
--- /dev/null
+++ b/tools/testing/selftests/mm/thp_pmd_split_test.c
@@ -0,0 +1,149 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests various kernel code paths that handle THP PMD splitting.
+ *
+ * Prerequisites:
+ * - THP enabled (always or madvise mode):
+ *   echo always > /sys/kernel/mm/transparent_hugepage/enabled
+ *   or
+ *   echo madvise > /sys/kernel/mm/transparent_hugepage/enabled
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <sys/mman.h>
+#include <sys/wait.h>
+#include <fcntl.h>
+#include <errno.h>
+#include <stdint.h>
+
+#include "kselftest_harness.h"
+#include "thp_settings.h"
+#include "vm_util.h"
+
+/* Read vmstat counter */
+static unsigned long read_vmstat(const char *name)
+{
+	FILE *fp;
+	char line[256];
+	unsigned long value = 0;
+
+	fp = fopen("/proc/vmstat", "r");
+	if (!fp)
+		return 0;
+
+	while (fgets(line, sizeof(line), fp)) {
+		if (strncmp(line, name, strlen(name)) == 0 &&
+		    line[strlen(name)] == ' ') {
+			sscanf(line + strlen(name), " %lu", &value);
+			break;
+		}
+	}
+	fclose(fp);
+	return value;
+}
+
+/*
+ * Log vmstat counters for split_pmd_after/split_pmd_failed_after,
+ * check if split_pmd_after is greater than before and split_pmd_failed_after
+ * hasn't incremented.
+ */
+static void log_and_check_pmd_split(struct __test_metadata *const _metadata,
+	unsigned long split_pmd_before, unsigned long split_pmd_failed_before)
+{
+	unsigned long split_pmd_after = read_vmstat("thp_split_pmd");
+	unsigned long split_pmd_failed_after = read_vmstat("thp_split_pmd_failed");
+
+	TH_LOG("thp_split_pmd: %lu -> %lu", \
+	       split_pmd_before, split_pmd_after);
+	TH_LOG("thp_split_pmd_failed: %lu -> %lu", \
+	       split_pmd_failed_before, split_pmd_failed_after);
+	ASSERT_GT(split_pmd_after, split_pmd_before);
+	ASSERT_EQ(split_pmd_failed_after, split_pmd_failed_before);
+}
+
+/* Allocate a THP at the given aligned address */
+static int allocate_thp(void *aligned, size_t pmdsize)
+{
+	int ret;
+
+	ret = madvise(aligned, pmdsize, MADV_HUGEPAGE);
+	if (ret)
+		return -1;
+
+	/* Touch all pages to allocate the THP */
+	memset(aligned, 0xAA, pmdsize);
+
+	/* Verify we got a THP */
+	if (!check_huge_anon(aligned, 1, pmdsize))
+		return -1;
+
+	return 0;
+}
+
+FIXTURE(thp_pmd_split)
+{
+	void *mem;		/* Base mmap allocation */
+	void *aligned;		/* PMD-aligned pointer within mem */
+	size_t pmdsize;		/* PMD size from sysfs */
+	size_t pagesize;	/* Base page size */
+	size_t mmap_size;	/* Total mmap size for alignment */
+	unsigned long split_pmd_before;
+	unsigned long split_pmd_failed_before;
+};
+
+FIXTURE_SETUP(thp_pmd_split)
+{
+	if (!thp_available())
+		SKIP(return, "THP not available");
+
+	self->pmdsize = read_pmd_pagesize();
+	if (!self->pmdsize)
+		SKIP(return, "Unable to read PMD size");
+
+	self->pagesize = getpagesize();
+	self->mmap_size = 4 * self->pmdsize;
+
+	self->split_pmd_before = read_vmstat("thp_split_pmd");
+	self->split_pmd_failed_before = read_vmstat("thp_split_pmd_failed");
+
+	self->mem = mmap(NULL, self->mmap_size, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	ASSERT_NE(self->mem, MAP_FAILED);
+
+	/* Align to PMD boundary */
+	self->aligned = (void *)(((unsigned long)self->mem + self->pmdsize - 1) &
+				 ~(self->pmdsize - 1));
+}
+
+FIXTURE_TEARDOWN(thp_pmd_split)
+{
+	if (self->mem && self->mem != MAP_FAILED)
+		munmap(self->mem, self->mmap_size);
+}
+
+/*
+ * Partial munmap on THP (zap_pmd_range)
+ *
+ * Tests that partial munmap of a THP correctly splits the PMD.
+ * This exercises zap_pmd_range part of split.
+ */
+TEST_F(thp_pmd_split, partial_munmap)
+{
+	int ret;
+
+	ret = allocate_thp(self->aligned, self->pmdsize);
+	if (ret)
+		SKIP(return, "Failed to allocate THP");
+
+	ret = munmap((char *)self->aligned + self->pagesize, self->pagesize);
+	ASSERT_EQ(ret, 0);
+
+	log_and_check_pmd_split(_metadata, self->split_pmd_before,
+		self->split_pmd_failed_before);
+}
+
+TEST_HARNESS_MAIN
-- 
2.47.3

