Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41143189F59
	for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2024 18:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278371; cv=none; b=Q3p6W2BijTB4Yn8oSMBOBR3cAFLMv9D75Y9o8ICt9TAmRZHKmCOvP0TwgBjZhxkJGqANbz5azf3s5t/7U0of/fZhO0Q9yUYFLrtYArTeW7gjTOEGaddZbcOMV5GPsPoFhv5/EOUlRan31uNk/w6TCzkcadKloPVDhhiqlFmZmgk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278371; c=relaxed/simple;
	bh=xk3+KuScjITGXiDzDjfIu4gA/sRyc3tOmEiEhe4VNEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qohTvnqpLRIlylUiOM2VwXIAz9CSwSwjxSUMW16AfmXLbWX3aDcfiS6AamWxiUHGJ27SckKpJ/dzkKmIVU5IcxtXgNyg9siAw9Vget4Vg4EwgzThMHwhdS2nyPTJbIOztEzgAPJL8YkHY8owBjy+weudG4OukC2DQkur4awc6K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ermcUooG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ermcUooG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722278369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9H38+PlxDPb0B2kVTxHGHrLppqPJ/7ePtq7mF29j+5Q=;
	b=ermcUooGjVx+8Wg+/Mr3GwIXSOJRGjjZO3ddFOAgdUezHz9MiNu9U4POa47p90eCGjS+JR
	N4g1mbqGJzoaFYsb6I9DF/SWj0tUr0NC83LKb63RA3A9MCqP9dtB/2FiQwNWj529eKNJWP
	g3HC032mnjMKv19H2smkD8agyQRmCVU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-274-TyEAJ39yMBCJknv_CsRGMA-1; Mon,
 29 Jul 2024 14:39:22 -0400
X-MC-Unique: TyEAJ39yMBCJknv_CsRGMA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C61E19560A1;
	Mon, 29 Jul 2024 18:39:19 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5EF6D1955D42;
	Mon, 29 Jul 2024 18:39:13 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: [PATCH v1 3/3] s390/uv: drop arch_make_page_accessible()
Date: Mon, 29 Jul 2024 20:38:44 +0200
Message-ID: <20240729183844.388481-4-david@redhat.com>
In-Reply-To: <20240729183844.388481-1-david@redhat.com>
References: <20240729183844.388481-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

All code was converted to using arch_make_folio_accessible(), let's drop
arch_make_page_accessible().

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/page.h | 2 --
 arch/s390/kernel/uv.c        | 5 -----
 include/linux/mm.h           | 7 -------
 3 files changed, 14 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 06416b3f94f59..515db8241eb6b 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -176,8 +176,6 @@ static inline int devmem_is_allowed(unsigned long pfn)
 
 int arch_make_folio_accessible(struct folio *folio);
 #define HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
-int arch_make_page_accessible(struct page *page);
-#define HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
 
 struct vm_layout {
 	unsigned long kaslr_offset;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 36db065c7cf75..35ed2aea88918 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -548,11 +548,6 @@ int arch_make_folio_accessible(struct folio *folio)
 }
 EXPORT_SYMBOL_GPL(arch_make_folio_accessible);
 
-int arch_make_page_accessible(struct page *page)
-{
-	return arch_make_folio_accessible(page_folio(page));
-}
-EXPORT_SYMBOL_GPL(arch_make_page_accessible);
 static ssize_t uv_query_facilities(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
 {
diff --git a/include/linux/mm.h b/include/linux/mm.h
index bab689ec77f94..07b478952bb02 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2205,13 +2205,6 @@ static inline bool folio_likely_mapped_shared(struct folio *folio)
 	return atomic_read(&folio->_mapcount) > 0;
 }
 
-#ifndef HAVE_ARCH_MAKE_PAGE_ACCESSIBLE
-static inline int arch_make_page_accessible(struct page *page)
-{
-	return 0;
-}
-#endif
-
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
 static inline int arch_make_folio_accessible(struct folio *folio)
 {
-- 
2.45.2

