Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EFE374739
	for <linux-s390@vger.kernel.org>; Thu, 26 Feb 2026 11:34:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772105645; cv=none; b=TmGkJ6zPALlMXyFbVhvQKnKZy6Prqxf64nQNLZQE9wYEW5GCGWPZMlZfcXS0RKH6Jdc+RYgVlbtzMPZz4+AiqV+kOjaVBEjIACkq59prc8Im3E10FJwfNdQG5vL0/UMbvoSrxBa1zAUJZMuan36ipriDm+BGZlxg5i1R/zgRXrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772105645; c=relaxed/simple;
	bh=pHaVhCtcJfzM+fMMyd9UacwkKSY7AALCZ6vcBTf8wJM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AkJlfpUS5PUy46OdJhGf0KcSPbEo2fR8hA4ql8aJCBB09bVgxqr6RtBiWoRJfDSjnTfPAeOI0tMO33ap3SRTAYTehkkHfqqZkMPpEzKwsfQ5tgATDPQcbfXCWFZMqmZMUyZb/X3VCk+n/JPO1UySonJpR98/+A3VxBelDqMntkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=C44MfwaQ; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="C44MfwaQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772105641;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3zn8+Git0EggRmhaca5IE2gupO7ol+4qJNppzm+/Ej8=;
	b=C44MfwaQZXC9xurNJm1Gj33Zxo1gLQS8k4IWyBzLJ3bDH3iEaWw2xI76yUVCOJhu+N0fjz
	uImfnhnDx1t7VDozyvgsx0dmj2PUnj69wqMG8MPzuScq2zzmXFeTbiFWn+QmycgKIMWYDT
	hh2GKNuNvA84UQEGRKDJ+AfYcSWycUg=
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
Subject: [RFC v2 11/21] mm: thp: handle split failure in userfaultfd move_pages()
Date: Thu, 26 Feb 2026 03:23:40 -0800
Message-ID: <20260226113233.3987674-12-usama.arif@linux.dev>
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

The UFFDIO_MOVE ioctl's move_pages() loop splits a huge PMD when the
folio is pinned and can't be moved at PMD granularity.

If the split fails, the PMD stays huge and move_pages_pte() can't
process individual pages. Break out of the loop on split failure
and return -ENOMEM to the caller. This is similar to how other
allocation failures (__pte_alloc, mm_alloc_pmd) are handled in
move_pages().

Signed-off-by: Usama Arif <usama.arif@linux.dev>
---
 mm/userfaultfd.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e19872e518785..2728102e00c72 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1870,7 +1870,13 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 				}
 
 				spin_unlock(ptl);
-				split_huge_pmd(src_vma, src_pmd, src_addr);
+				/*
+				 * If split fails, the PMD stays huge and
+				 * move_pages_pte can't process it.
+				 */
+				err = split_huge_pmd(src_vma, src_pmd, src_addr);
+				if (err)
+					break;
 				/* The folio will be split by move_pages_pte() */
 				continue;
 			}
-- 
2.47.3

