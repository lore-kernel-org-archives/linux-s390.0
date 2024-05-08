Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A104013173C
	for <linux-s390@vger.kernel.org>; Wed,  8 May 2024 18:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193035; cv=none; b=Anw6XqcIt2Nm2cghv61KZm5h9cabg/mQsxGsJ51+iN4kbCi09GXDhkeclCP1yJFShMRvuK+F8Icgan41GOSucgzPOUh2m6qd/6XBRrLdrl9nqI5P7qsjOUbwRJ2fAbvQaoJiZZrZF48D0g+EVWtmWjkpPF0Wlm9Kyil6374yQs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193035; c=relaxed/simple;
	bh=f3q5vaylRey2t4J/YADV026h8jA3e59F4qqqjWSAOF8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5CYRM2zxHur9Sz9L3rWNmECFunbiABwwiaCHqtThtCvFcoTqa6H2RV9xp0uCMpj2gQXxlGrjG0jQ1QFyaZLkbQ6nU8NOqY3MkYB8MsfCoF2yfbOrNLrik7hJkEyGEr9tI5Rd8vElC+WN7neFOhphwChsxW7f1t4stJ8Gzv601Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bPXg5eYs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bPXg5eYs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pWFuk2wiFX16ao8wTNmTgJQA0SX97Qs/+S9ZiX3OBp0=;
	b=bPXg5eYsACzKcmJPlDCIWfKbEf3hJ9ruR9WGU1BOTLzS8q70OZwsXE8eT/7OPnaELb5Ue0
	qPEm0nNK3Wa3+0ucWHBk9Xrz3tDcqwSi3RnMIZ3HHUwZuF527qLXNlwOrUQtKVvT4OCodt
	Andqu65ij4gZffUD3ycD01/rpG0bFfQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-w74PWNShPA21_GIJcUd6Kw-1; Wed, 08 May 2024 14:30:27 -0400
X-MC-Unique: w74PWNShPA21_GIJcUd6Kw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CF28885A58C;
	Wed,  8 May 2024 18:30:26 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2E02710000AD;
	Wed,  8 May 2024 18:30:24 +0000 (UTC)
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
Subject: [PATCH v3 08/10] s390/uv: convert uv_convert_owned_from_secure() to uv_convert_from_secure_(folio|pte)()
Date: Wed,  8 May 2024 20:29:53 +0200
Message-ID: <20240508182955.358628-9-david@redhat.com>
In-Reply-To: <20240508182955.358628-1-david@redhat.com>
References: <20240508182955.358628-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Let's do the same as we did for uv_destroy_(folio|pte)() and
have the following variants:

(1) uv_convert_from_secure(): "low level" helper that operates on paddr
and does not mess with folios.

(2) uv_convert_from_secure_folio(): Consumes a folio to which we hold a
reference.

(3) uv_convert_from_secure_pte(): Consumes a PTE that holds a reference
through the mapping.

Unfortunately we need uv_convert_from_secure_pte(), because pfn_folio()
and friends are not available in pgtable.h.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/pgtable.h |  6 +++---
 arch/s390/include/asm/uv.h      |  4 ++--
 arch/s390/kernel/uv.c           | 18 +++++++++++++-----
 3 files changed, 18 insertions(+), 10 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index f65db37917f2..928282bacfc7 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1165,7 +1165,7 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
 	res = ptep_xchg_lazy(mm, addr, ptep, __pte(_PAGE_INVALID));
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(mm) && pte_present(res))
-		uv_convert_owned_from_secure(pte_val(res) & PAGE_MASK);
+		uv_convert_from_secure_pte(res);
 	return res;
 }
 
@@ -1183,7 +1183,7 @@ static inline pte_t ptep_clear_flush(struct vm_area_struct *vma,
 	res = ptep_xchg_direct(vma->vm_mm, addr, ptep, __pte(_PAGE_INVALID));
 	/* At this point the reference through the mapping is still present */
 	if (mm_is_protected(vma->vm_mm) && pte_present(res))
-		uv_convert_owned_from_secure(pte_val(res) & PAGE_MASK);
+		uv_convert_from_secure_pte(res);
 	return res;
 }
 
@@ -1222,7 +1222,7 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
 	 * if this is not a mm teardown, the slower export is used as
 	 * fallback instead.
 	 */
-	uv_convert_owned_from_secure(pte_val(res) & PAGE_MASK);
+	uv_convert_from_secure_pte(res);
 	return res;
 }
 
diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index a1bef30066ef..0679445cac0b 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -485,7 +485,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
 int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr);
 int uv_destroy_folio(struct folio *folio);
 int uv_destroy_pte(pte_t pte);
-int uv_convert_owned_from_secure(unsigned long paddr);
+int uv_convert_from_secure_pte(pte_t pte);
 int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr);
 
 void setup_uv(void);
@@ -508,7 +508,7 @@ static inline int uv_destroy_pte(pte_t pte)
 	return 0;
 }
 
-static inline int uv_convert_owned_from_secure(unsigned long paddr)
+static inline int uv_convert_from_secure_pte(pte_t pte)
 {
 	return 0;
 }
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 61c1ce51c883..b456066d72da 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -178,11 +178,10 @@ static int uv_convert_from_secure(unsigned long paddr)
 }
 
 /*
- * The caller must already hold a reference to the page
+ * The caller must already hold a reference to the folio.
  */
-int uv_convert_owned_from_secure(unsigned long paddr)
+static int uv_convert_from_secure_folio(struct folio *folio)
 {
-	struct folio *folio = phys_to_folio(paddr);
 	int rc;
 
 	/* See gmap_make_secure(): large folios cannot be secure */
@@ -190,13 +189,22 @@ int uv_convert_owned_from_secure(unsigned long paddr)
 		return 0;
 
 	folio_get(folio);
-	rc = uv_convert_from_secure(paddr);
+	rc = uv_convert_from_secure(folio_to_phys(folio));
 	if (!rc)
 		clear_bit(PG_arch_1, &folio->flags);
 	folio_put(folio);
 	return rc;
 }
 
+/*
+ * The present PTE still indirectly holds a folio reference through the mapping.
+ */
+int uv_convert_from_secure_pte(pte_t pte)
+{
+	VM_WARN_ON(!pte_present(pte));
+	return uv_convert_from_secure_folio(pfn_folio(pte_pfn(pte)));
+}
+
 /*
  * Calculate the expected ref_count for a folio that would otherwise have no
  * further pins. This was cribbed from similar functions in other places in
@@ -481,7 +489,7 @@ int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr)
 	 * we instead try to export the page.
 	 */
 	if (rc)
-		rc = uv_convert_owned_from_secure(page_to_phys(page));
+		rc = uv_convert_from_secure_folio(folio);
 	folio_put(folio);
 out:
 	mmap_read_unlock(gmap->mm);
-- 
2.45.0

