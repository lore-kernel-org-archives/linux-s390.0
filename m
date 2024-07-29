Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E4FC1741D1
	for <linux-s390@vger.kernel.org>; Mon, 29 Jul 2024 18:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722278356; cv=none; b=oO6/OdmWXhGRFoPqaby6UAMvXUTYBDFqGVfqtZ0U+pvxhPHjeAHkHN43cbPqCbURYJRwQS3dnTlecDG6ujZfpSu/toWSGeMxWjvyuwUH9r5mpTUHXkrbLt9W4ML4mzIxobB/sj6OZAm0AYxJQ6X0Lri16iMRlxWmX7u3rCdFbHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722278356; c=relaxed/simple;
	bh=CuI3A3UP7rCuy25/6pPJiotF95Rkz1Dr1he2WDJI2ac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B48eMPkqnqB3QxYcwSjigMAT/ux0xqc4ZODWASionWfaPBziaHAUxPcaOQYfTtFuxgSBXqdNYwq8u4FLr4pyIHR+c4y4KNmblrrN9SB3RO7ljy5YL4ogktkchoXiCtfR5c/yqQsquXDNxmQesPdXmRFFEnPSuZuPpdfCIsHDC5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YvKwFUXP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YvKwFUXP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722278354;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1LweK4YyrJ+GH/WLrm8oiFvHfSVbn4+ENVtw/AVp5dM=;
	b=YvKwFUXPzUZNPZQUJ3LDU/7kzGXIdIGnrNTtgwopLe1cmNthShgRTDZcJUkoNpJPEJygPR
	E39K/S/5PaEoKGARanv9KaDQbOub5zgWW4j91WtWwJzjEml9+S6j9dloy/PCFX27LAMs7T
	GJdMn1dEQM7tkRIfw6cQ1fE4ybrR/FU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-8Qug9MJyOh6RXOQYIceWMA-1; Mon,
 29 Jul 2024 14:39:09 -0400
X-MC-Unique: 8Qug9MJyOh6RXOQYIceWMA-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B279A1955F49;
	Mon, 29 Jul 2024 18:39:07 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.25])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5CA481955D45;
	Mon, 29 Jul 2024 18:38:59 +0000 (UTC)
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
Subject: [PATCH v1 1/3] mm: simplify arch_make_folio_accessible()
Date: Mon, 29 Jul 2024 20:38:42 +0200
Message-ID: <20240729183844.388481-2-david@redhat.com>
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

Now that s390x implements HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE, let's turn
generic arch_make_folio_accessible() into a NOP: there are no other
targets that implement HAVE_ARCH_MAKE_PAGE_ACCESSIBLE but not
HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/mm.h | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 381750f41767a..bab689ec77f94 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -2215,16 +2215,7 @@ static inline int arch_make_page_accessible(struct page *page)
 #ifndef HAVE_ARCH_MAKE_FOLIO_ACCESSIBLE
 static inline int arch_make_folio_accessible(struct folio *folio)
 {
-	int ret;
-	long i, nr = folio_nr_pages(folio);
-
-	for (i = 0; i < nr; i++) {
-		ret = arch_make_page_accessible(folio_page(folio, i));
-		if (ret)
-			break;
-	}
-
-	return ret;
+	return 0;
 }
 #endif
 
-- 
2.45.2

