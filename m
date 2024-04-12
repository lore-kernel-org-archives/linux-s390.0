Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A803127E28
	for <linux-s390@vger.kernel.org>; Fri, 12 Apr 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931716; cv=none; b=d1r602XUhpHVgEmV36b3wNYaXDEOYbTdshKIQT8Mwfdd3NdgqKCzaYN86aLpmvp3Qag+3ktylrIuYDL8qyshIDMjldM8C7W60nPDWleXFgxHj5zv8ToYyb56tTPABlwZ4OKqBlNkoOvoYl59IXf25vXAhdzNUcLBBoN1E+Lc/dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931716; c=relaxed/simple;
	bh=pVzRhZ6ZT+x69i7trRwSyvoC5xLpBia3FSDH6V6AM6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPxuc6OZ67iafqk18Iq3Rllr4isxRlC2GdkI3TEXK1sxVL7gotShEhFsqMoGQO2unY53CBA0Qdo9qpwMkLssM1tNjxdQdWwsBooTQ8Q/gtclAjdSXxgoMntGiPRItBv6RCmYReEcmUh12rbrj/6htWcvPaDZN0Jzf5rqLJP2W9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QadFuDFO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QadFuDFO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712931713;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mANI+UcvWmCI6nEby2g18+Ah/SQ4byG86Q1u6vzzE1Y=;
	b=QadFuDFOuMFuxcwYMsC/XfAy0tznATnXct+cP7nYO/7MPEDYRtmTuhvKtysorJdlNC7w0e
	LMPLD5ec9B7nTjzipitTbA/ynSvcJjdr9Hy0cYI1aaMvXENaWXZPFm2vGRcKExQ6uBtZgd
	cecTCznaauNH9WttINWsjcFFfzIBsWM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-65-y6V8ahENNPaWSwcNT8uCxw-1; Fri,
 12 Apr 2024 10:21:49 -0400
X-MC-Unique: y6V8ahENNPaWSwcNT8uCxw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 75EBF3C025C8;
	Fri, 12 Apr 2024 14:21:48 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4B6C740C123D;
	Fri, 12 Apr 2024 14:21:45 +0000 (UTC)
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
Subject: [PATCH v2 01/10] s390/uv: don't call folio_wait_writeback() without a folio reference
Date: Fri, 12 Apr 2024 16:21:11 +0200
Message-ID: <20240412142120.220087-2-david@redhat.com>
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

folio_wait_writeback() requires that no spinlocks are held and that
a folio reference is held, as documented. After we dropped the PTL, the
folio could get freed concurrently. So grab a temporary reference.

Fixes: 214d9bbcd3a6 ("s390/mm: provide memory management functions for protected KVM guests")
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/uv.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 265fea37e030..016993e9eb72 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -318,6 +318,13 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 			rc = make_folio_secure(folio, uvcb);
 			folio_unlock(folio);
 		}
+
+		/*
+		 * Once we drop the PTL, the folio may get unmapped and
+		 * freed immediately. We need a temporary reference.
+		 */
+		if (rc == -EAGAIN)
+			folio_get(folio);
 	}
 unlock:
 	pte_unmap_unlock(ptep, ptelock);
@@ -330,6 +337,7 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 		 * completion, this is just a useless check, but it is safe.
 		 */
 		folio_wait_writeback(folio);
+		folio_put(folio);
 	} else if (rc == -EBUSY) {
 		/*
 		 * If we have tried a local drain and the folio refcount
-- 
2.44.0

