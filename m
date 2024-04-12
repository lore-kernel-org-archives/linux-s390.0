Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E0DB8626E
	for <linux-s390@vger.kernel.org>; Fri, 12 Apr 2024 14:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931726; cv=none; b=E9b9yQjaxyUFPyxFyfVvjjlZoWlF5FBGNnMX4V2bYR+aDzK1L6OxUUMDKSfydkH6HMjDC9Pb5XdMxPqkIbsOnGUJc2CUrChH/sHOOh1M/LmHxpOGFmqlqRYeDV6LEUQWjwLSSupKOH/u3kV5A4COEORW4N6zPkRLLAuaNYCl508=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931726; c=relaxed/simple;
	bh=NYIsyAKTyDfXL1OBDe7AcstW++1OcYH4oDp5YUoFpOI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hxuJWlq7YKB0lSShCFpsJ1OieOiAJqmbF7kxMCw0zlvE/52olu2mftonag+6Ddard+FETK4qUF2jygk0UgfEiJ6QaQ0zXiY6Ez1vI87OKEvLcmzcItlo8DRUlIovjM9rQn4gn0D2dSS9wqbaHVTY1mUDequLfHhzdJh44Avpf9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmsyJcRK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmsyJcRK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712931724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6DKeQI6yMk4WrSKY3ISFL+eRa3o1/6tdDeS8ur8VVlk=;
	b=FmsyJcRKn63tCieffpb6pQwMbj3/CEXx08210U7zu0x5lm9f17yA9Rj5JpCSDpmJvIj5ja
	+Ht8Yc60BcdekvCI7Avgk7ogX8hN0kmevxkfDOyl/QS1lRC4yVbz2L5gR7TyANJUawvrt0
	kwjuzdpjFBAOWzomjIjaCBYb2uwCef0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-BlVDikT7O-igiyZtvUI5pw-1; Fri, 12 Apr 2024 10:22:00 -0400
X-MC-Unique: BlVDikT7O-igiyZtvUI5pw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 391BF802E4D;
	Fri, 12 Apr 2024 14:21:59 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 867AB40C6CC0;
	Fri, 12 Apr 2024 14:21:56 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Matthew Wilcox <willy@infradead.org>,
	Thomas Huth <thuth@redhat.com>
Subject: [PATCH v2 04/10] s390/uv: convert PG_arch_1 users to only work on small folios
Date: Fri, 12 Apr 2024 16:21:14 +0200
Message-ID: <20240412142120.220087-5-david@redhat.com>
In-Reply-To: <20240412142120.220087-1-david@redhat.com>
References: <20240412142120.220087-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Now that make_folio_secure() may only set PG_arch_1 for small folios,
let's convert relevant remaining UV code to only work on (small) folios
and simply reject large folios early. This way, we'll never end up
touching PG_arch_1 on tail pages of a large folio in UV code.

The folio_get()/folio_put() for functions that are documented to already
hold a folio reference look weird; likely they are required to make
concurrent gmap_make_secure() back off because the caller might only hold
an implicit reference due to the page mapping. So leave that alone for now.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/page.h |  2 ++
 arch/s390/kernel/uv.c        | 41 ++++++++++++++++++++++--------------
 2 files changed, 27 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 9381879f7ecf..b64384872c0f 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -214,7 +214,9 @@ static inline unsigned long __phys_addr(unsigned long x, bool is_31bit)
 #define pfn_to_phys(pfn)	((pfn) << PAGE_SHIFT)
 
 #define phys_to_page(phys)	pfn_to_page(phys_to_pfn(phys))
+#define phys_to_folio(phys)	page_folio(phys_to_page(phys))
 #define page_to_phys(page)	pfn_to_phys(page_to_pfn(page))
+#define folio_to_phys(page)	pfn_to_phys(folio_pfn(folio))
 
 static inline void *pfn_to_virt(unsigned long pfn)
 {
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 3c6d86e3e828..914dcec27329 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -135,14 +135,18 @@ static int uv_destroy_page(unsigned long paddr)
  */
 int uv_destroy_owned_page(unsigned long paddr)
 {
-	struct page *page = phys_to_page(paddr);
+	struct folio *folio = phys_to_folio(paddr);
 	int rc;
 
-	get_page(page);
+	/* See gmap_make_secure(): large folios cannot be secure */
+	if (unlikely(folio_test_large(folio)))
+		return 0;
+
+	folio_get(folio);
 	rc = uv_destroy_page(paddr);
 	if (!rc)
-		clear_bit(PG_arch_1, &page->flags);
-	put_page(page);
+		clear_bit(PG_arch_1, &folio->flags);
+	folio_put(folio);
 	return rc;
 }
 
@@ -170,14 +174,18 @@ int uv_convert_from_secure(unsigned long paddr)
  */
 int uv_convert_owned_from_secure(unsigned long paddr)
 {
-	struct page *page = phys_to_page(paddr);
+	struct folio *folio = phys_to_folio(paddr);
 	int rc;
 
-	get_page(page);
+	/* See gmap_make_secure(): large folios cannot be secure */
+	if (unlikely(folio_test_large(folio)))
+		return 0;
+
+	folio_get(folio);
 	rc = uv_convert_from_secure(paddr);
 	if (!rc)
-		clear_bit(PG_arch_1, &page->flags);
-	put_page(page);
+		clear_bit(PG_arch_1, &folio->flags);
+	folio_put(folio);
 	return rc;
 }
 
@@ -479,33 +487,34 @@ EXPORT_SYMBOL_GPL(gmap_destroy_page);
  */
 int arch_make_page_accessible(struct page *page)
 {
+	struct folio *folio = page_folio(page);
 	int rc = 0;
 
-	/* Hugepage cannot be protected, so nothing to do */
-	if (PageHuge(page))
+	/* See gmap_make_secure(): large folios cannot be secure */
+	if (unlikely(folio_test_large(folio)))
 		return 0;
 
 	/*
 	 * PG_arch_1 is used in 3 places:
 	 * 1. for kernel page tables during early boot
 	 * 2. for storage keys of huge pages and KVM
-	 * 3. As an indication that this page might be secure. This can
+	 * 3. As an indication that this small folio might be secure. This can
 	 *    overindicate, e.g. we set the bit before calling
 	 *    convert_to_secure.
 	 * As secure pages are never huge, all 3 variants can co-exists.
 	 */
-	if (!test_bit(PG_arch_1, &page->flags))
+	if (!test_bit(PG_arch_1, &folio->flags))
 		return 0;
 
-	rc = uv_pin_shared(page_to_phys(page));
+	rc = uv_pin_shared(folio_to_phys(folio));
 	if (!rc) {
-		clear_bit(PG_arch_1, &page->flags);
+		clear_bit(PG_arch_1, &folio->flags);
 		return 0;
 	}
 
-	rc = uv_convert_from_secure(page_to_phys(page));
+	rc = uv_convert_from_secure(folio_to_phys(folio));
 	if (!rc) {
-		clear_bit(PG_arch_1, &page->flags);
+		clear_bit(PG_arch_1, &folio->flags);
 		return 0;
 	}
 
-- 
2.44.0

