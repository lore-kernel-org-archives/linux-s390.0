Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98CFB57312
	for <linux-s390@vger.kernel.org>; Fri, 22 Mar 2024 16:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123918; cv=none; b=KHYFnSrbcWkZ7b511g0o9VFnasxdoG3KB8IcrCD6hd9cL0DyIUgelHhC2u/MQ4MwYEemFlPmAmhZNvR8cEnXbUCKOYNcpkzU/NAykssFWrmoxxzL3DFBX5tmiEYD4ezzTSE5vg0SHn3tY0P55fqhJslDB9HG5sI8yCUJSXaNX0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123918; c=relaxed/simple;
	bh=QJKk6CUJYx1HokGt4fPURlzEza3LzOdVoFWgVms2Xv8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KCIA+dVO984B4+cUwQkYPXvBmpM8d8NCvuyfsJyVAbUgiz8L6DGkLICtGOKDNnPzrMC/wz2doCq9SpwpIilA3zz9lGXMnjztNirjQt9f+eZBkLDlTS/ijI1Sfc8Q+qU9D/awRDOHOBhxT8O33Dwl8t1wyV35U3OW1KSvCfomO7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=I5r9htU+; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="I5r9htU+"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=YMqpvZQDcWJGJEN/BRbCwSsjurTpq7PnTA41jOMehJY=; b=I5r9htU+SumrjhyrOAjltx4Dp4
	ZdCvIVuHLOgx6PZrfXaAnzZ5J2KFx5IyM3yWvrbut0eEmtjFFC4Qu4mKwiOWqD7q6+b3R8BCNPwqG
	TG1iac4GRYRIr4orJz6O69jlpSC10Pw3HZvp/MZ41fgTkW/E83OVvZqxLl8FAI38XSqNNqBMHwyx0
	YYf89Ixuko2OGX2DyZzjK/w+tpPi/YgukWeCHiJX6rBGKfu5gJhvsObsyNKqmA5feMCTWWKziv262
	n77ykuTsMj1/m393svn895tuqgBTKhpO5QPJ5GaMdawR7fMIchL0kYT07nFlQObx2SR1oU/2rfvXl
	QFi2uNOA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnhUl-00000009lUv-2EWT;
	Fri, 22 Mar 2024 16:11:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org
Subject: [PATCH 1/2] s390: Convert make_page_secure to use a folio
Date: Fri, 22 Mar 2024 16:11:46 +0000
Message-ID: <20240322161149.2327518-2-willy@infradead.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322161149.2327518-1-willy@infradead.org>
References: <20240322161149.2327518-1-willy@infradead.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These page APIs are deprecated, so convert the incoming page to a folio
and use the folio APIs instead.  The ultravisor API cannot handle large
folios, so return -EINVAL if one has slipped through.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/kernel/uv.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index fc07bc39e698..0634448698b0 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -181,21 +181,21 @@ int uv_convert_owned_from_secure(unsigned long paddr)
 }
 
 /*
- * Calculate the expected ref_count for a page that would otherwise have no
+ * Calculate the expected ref_count for a folio that would otherwise have no
  * further pins. This was cribbed from similar functions in other places in
  * the kernel, but with some slight modifications. We know that a secure
- * page can not be a huge page for example.
+ * folio can not be a large folio, for example.
  */
-static int expected_page_refs(struct page *page)
+static int expected_folio_refs(struct folio *folio)
 {
 	int res;
 
-	res = page_mapcount(page);
-	if (PageSwapCache(page)) {
+	res = folio_mapcount(folio);
+	if (folio_test_swapcache(folio)) {
 		res++;
-	} else if (page_mapping(page)) {
+	} else if (folio_mapping(folio)) {
 		res++;
-		if (page_has_private(page))
+		if (folio->private)
 			res++;
 	}
 	return res;
@@ -203,14 +203,17 @@ static int expected_page_refs(struct page *page)
 
 static int make_page_secure(struct page *page, struct uv_cb_header *uvcb)
 {
+	struct folio *folio = page_folio(page);
 	int expected, cc = 0;
 
-	if (PageWriteback(page))
+	if (folio_test_large(folio))
+		return -EINVAL;
+	if (folio_test_writeback(folio))
 		return -EAGAIN;
-	expected = expected_page_refs(page);
-	if (!page_ref_freeze(page, expected))
+	expected = expected_folio_refs(folio);
+	if (!folio_ref_freeze(folio, expected))
 		return -EBUSY;
-	set_bit(PG_arch_1, &page->flags);
+	set_bit(PG_arch_1, &folio->flags);
 	/*
 	 * If the UVC does not succeed or fail immediately, we don't want to
 	 * loop for long, or we might get stall notifications.
@@ -220,9 +223,9 @@ static int make_page_secure(struct page *page, struct uv_cb_header *uvcb)
 	 * -EAGAIN and we let the callers deal with it.
 	 */
 	cc = __uv_call(0, (u64)uvcb);
-	page_ref_unfreeze(page, expected);
+	folio_ref_unfreeze(folio, expected);
 	/*
-	 * Return -ENXIO if the page was not mapped, -EINVAL for other errors.
+	 * Return -ENXIO if the folio was not mapped, -EINVAL for other errors.
 	 * If busy or partially completed, return -EAGAIN.
 	 */
 	if (cc == UVC_CC_OK)
-- 
2.43.0

