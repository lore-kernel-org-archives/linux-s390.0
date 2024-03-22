Received: from casper.infradead.org (casper.infradead.org [90.155.50.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AFAD5787F
	for <linux-s390@vger.kernel.org>; Fri, 22 Mar 2024 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.50.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711123920; cv=none; b=azuIapi7aJz672GmeI7hGllKlnD2uwgQgY0usGSmohK0xg0BtHxyCrHnbSSleQqmKiw7DwQXOodJXk6O8qCw/EMJ/OEHVGrnyejOdZ6NzSGbp8ayrlEiI7ZepzJ6duJRZ0J5tv5gS4/C01PaNyjlBaSQJRZNT2dJP6l2qW1EFXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711123920; c=relaxed/simple;
	bh=02RaXfUnsXak0BHXx1+5wfE426/RTv97mTynz1/WahA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JAfAlDu/r0TtXWI4sGEzVBASAxdmnpEk8MhapkIuygxYzrhZ4p3oQunPRK1do7nIlkUjTV12Re2So0elYq7b65TRrtJHZYpfBQlR65asUJzWdMnjw492aQfSKGH0izcyeptfn6RINakHW10xYqO1wrR73EUNmfRElJviGWt/2R8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=HMLsoN3R; arc=none smtp.client-ip=90.155.50.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="HMLsoN3R"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=l+t5YCc+UaLeEKNCNniG/c5siEJ0EHi/jD9JPpBRrhU=; b=HMLsoN3RCwpqbFeHysYEGyw/ne
	svkODOFVeBklsZkpu6PtY4vpwOtTeTJqYhJ8rY0JjmdctAOKo0qOqIkywY44KEQcBAMonCf/xxvjg
	XosiusM9wEDrAI392q39xHuXrDlK5RGdTtON9jfAaS18NLi88E+QrbUZGuKbYjw/vd3LpsxbPoP7T
	YK8YC3Y3MN81kt9WHwRiDIXiNEZUefjr5j/1yLXsjnir2lp50933LsHUDCna1yBii3NRqh6vmRsGa
	8jz9k7FLzwITawxeJcHiKEAhL+9Bu4WvZAs6TxjNzYe7q9nVcG4Esrf+pVJ/HQUPkax9AYVddV6gA
	YQuIFZzA==;
Received: from willy by casper.infradead.org with local (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rnhUl-00000009lUy-2csx;
	Fri, 22 Mar 2024 16:11:51 +0000
From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
To: Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	linux-s390@vger.kernel.org
Subject: [PATCH 2/2] s390: Convert gmap_make_secure to use a folio
Date: Fri, 22 Mar 2024 16:11:47 +0000
Message-ID: <20240322161149.2327518-3-willy@infradead.org>
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

Remove uses of deprecated page APIs, and move the check for large
folios to here to avoid taking the folio lock if the folio is too large.
We could do better here by attempting to split the large folio, but I'll
leave that improvement for someone who can test it.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
---
 arch/s390/kernel/uv.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 0634448698b0..2aed5af7c4e5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -201,13 +201,10 @@ static int expected_folio_refs(struct folio *folio)
 	return res;
 }
 
-static int make_page_secure(struct page *page, struct uv_cb_header *uvcb)
+static int make_folio_secure(struct folio *folio, struct uv_cb_header *uvcb)
 {
-	struct folio *folio = page_folio(page);
 	int expected, cc = 0;
 
-	if (folio_test_large(folio))
-		return -EINVAL;
 	if (folio_test_writeback(folio))
 		return -EAGAIN;
 	expected = expected_folio_refs(folio);
@@ -280,7 +277,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 	bool local_drain = false;
 	spinlock_t *ptelock;
 	unsigned long uaddr;
-	struct page *page;
+	struct folio *folio;
 	pte_t *ptep;
 	int rc;
 
@@ -309,15 +306,19 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 	if (!ptep)
 		goto out;
 	if (pte_present(*ptep) && !(pte_val(*ptep) & _PAGE_INVALID) && pte_write(*ptep)) {
-		page = pte_page(*ptep);
+		folio = page_folio(pte_page(*ptep));
+		rc = -EINVAL;
+		if (folio_test_large(folio))
+			goto unlock;
 		rc = -EAGAIN;
-		if (trylock_page(page)) {
+		if (folio_trylock(folio)) {
 			if (should_export_before_import(uvcb, gmap->mm))
-				uv_convert_from_secure(page_to_phys(page));
-			rc = make_page_secure(page, uvcb);
-			unlock_page(page);
+				uv_convert_from_secure(PFN_PHYS(folio_pfn(folio)));
+			rc = make_folio_secure(folio, uvcb);
+			folio_unlock(folio);
 		}
 	}
+unlock:
 	pte_unmap_unlock(ptep, ptelock);
 out:
 	mmap_read_unlock(gmap->mm);
@@ -327,10 +328,10 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		 * If we are here because the UVC returned busy or partial
 		 * completion, this is just a useless check, but it is safe.
 		 */
-		wait_on_page_writeback(page);
+		folio_wait_writeback(folio);
 	} else if (rc == -EBUSY) {
 		/*
-		 * If we have tried a local drain and the page refcount
+		 * If we have tried a local drain and the folio refcount
 		 * still does not match our expected safe value, try with a
 		 * system wide drain. This is needed if the pagevecs holding
 		 * the page are on a different CPU.
@@ -341,7 +342,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 			return -EAGAIN;
 		}
 		/*
-		 * We are here if the page refcount does not match the
+		 * We are here if the folio refcount does not match the
 		 * expected safe value. The main culprits are usually
 		 * pagevecs. With lru_add_drain() we drain the pagevecs
 		 * on the local CPU so that hopefully the refcount will
-- 
2.43.0

