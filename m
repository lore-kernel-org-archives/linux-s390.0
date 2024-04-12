Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 876FF130E46
	for <linux-s390@vger.kernel.org>; Fri, 12 Apr 2024 14:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931747; cv=none; b=Jh6W8GQtPk+q0lTZZ6mc46A/ZshftB3dc5DlDv8y9t9488y12tCXFvhtOYxawHg5swothHT+LedbkhOnDmC1lc23zOZ7BqyAxRzVBwTRz2FrXlx015injMwBzx7YhXqOjjQJbUGLMnlEl9ekxIkU6e+j3m3W83GR8+ITjYHvP64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931747; c=relaxed/simple;
	bh=u4jveH2EIzl1xqJEs2ZcFZUQ2YbXX3eXQ3sMb6x71k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sZENUIRmA6qqX6pmt2ZI26JbSO2UOkNNy62ril4TlGZMVmNrgy24WPcj34qbAF88F+eODwA48ziFS0V0VW5/2S7wctzopA6Z5J0ov9I5Ue8lSkqN/bSLIrD6Hg2+mPJK0vv6mWpv1aZxFt/JTGx+ntgEUcpe0uvMJ9SwLfzu7B4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fIg5pzM8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fIg5pzM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712931745;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KWRmug5O+fgsfYD+sP/4mX7PdwrqikXbqWpiomCHNOQ=;
	b=fIg5pzM83nSUmhc7f749GnA3EChVdI58D+VNLlpXreHuuJZGXO7U6RVGerHvLVpVcvlfuN
	02GtY+6DnhqpFFCjQKSgxXdefYT0I2fQmY+EJ/Itbr0STc6FUQT1LtTTwCmdlY/LZs2rp5
	r5FSdXm9aH+pzjWn84MuJA2vCKL7ETs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-rBEa3xiWN8m0NTwYBymYPQ-1; Fri, 12 Apr 2024 10:22:21 -0400
X-MC-Unique: rBEa3xiWN8m0NTwYBymYPQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B3F1C80021A;
	Fri, 12 Apr 2024 14:22:20 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 841B140C6CBF;
	Fri, 12 Apr 2024 14:22:17 +0000 (UTC)
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
Subject: [PATCH v2 10/10] s390/hugetlb: convert PG_arch_1 code to work on folio->flags
Date: Fri, 12 Apr 2024 16:21:20 +0200
Message-ID: <20240412142120.220087-11-david@redhat.com>
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

Let's make it clearer that we are always working on folio flags and
never page flags of tail pages.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/mm/gmap.c        | 4 ++--
 arch/s390/mm/hugetlbpage.c | 8 ++++----
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 0351cb139df4..9eea05cd93b7 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -2648,7 +2648,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 {
 	pmd_t *pmd = (pmd_t *)pte;
 	unsigned long start, end;
-	struct page *page = pmd_page(*pmd);
+	struct folio *folio = page_folio(pmd_page(*pmd));
 
 	/*
 	 * The write check makes sure we do not set a key on shared
@@ -2663,7 +2663,7 @@ static int __s390_enable_skey_hugetlb(pte_t *pte, unsigned long addr,
 	start = pmd_val(*pmd) & HPAGE_MASK;
 	end = start + HPAGE_SIZE - 1;
 	__storage_key_init_range(start, end);
-	set_bit(PG_arch_1, &page->flags);
+	set_bit(PG_arch_1, &folio->flags);
 	cond_resched();
 	return 0;
 }
diff --git a/arch/s390/mm/hugetlbpage.c b/arch/s390/mm/hugetlbpage.c
index c2e8242bd15d..a32047315f9a 100644
--- a/arch/s390/mm/hugetlbpage.c
+++ b/arch/s390/mm/hugetlbpage.c
@@ -121,7 +121,7 @@ static inline pte_t __rste_to_pte(unsigned long rste)
 
 static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 {
-	struct page *page;
+	struct folio *folio;
 	unsigned long size, paddr;
 
 	if (!mm_uses_skeys(mm) ||
@@ -129,16 +129,16 @@ static void clear_huge_pte_skeys(struct mm_struct *mm, unsigned long rste)
 		return;
 
 	if ((rste & _REGION_ENTRY_TYPE_MASK) == _REGION_ENTRY_TYPE_R3) {
-		page = pud_page(__pud(rste));
+		folio = page_folio(pud_page(__pud(rste)));
 		size = PUD_SIZE;
 		paddr = rste & PUD_MASK;
 	} else {
-		page = pmd_page(__pmd(rste));
+		folio = page_folio(pmd_page(__pmd(rste)));
 		size = PMD_SIZE;
 		paddr = rste & PMD_MASK;
 	}
 
-	if (!test_and_set_bit(PG_arch_1, &page->flags))
+	if (!test_and_set_bit(PG_arch_1, &folio->flags))
 		__storage_key_init_range(paddr, paddr + size - 1);
 }
 
-- 
2.44.0

