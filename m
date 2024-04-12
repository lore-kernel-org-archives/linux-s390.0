Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 458EC86658
	for <linux-s390@vger.kernel.org>; Fri, 12 Apr 2024 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712931733; cv=none; b=nurnptG9lJmIo3z1g+DxAzwBkaEhpNJdWaNp19geEXl2xKN10QOON7n+2QfPlDfmk53iKtw6XjMQfWvFeDmTrXKfRTt3cRl6U224DQjQhphsZhIWeMB1bm88boxMtv44VD4eN73HnalXwjM0qZ+2t5nK8I2LPWrvUIPc/BHyUX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712931733; c=relaxed/simple;
	bh=Phe+lYXoRi24QyGQuxCqNCGKvUUZ+0zh5Rap9SldaDo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCznQmFIgFrWcAxtVT3qJXkPYa1BCH5KbppE44cSqKTPzBaUoDAdGFjrFYHV9DE5LDqbMEFA7k5JLPymuq/Ps0oSSK7hSWDmrLDDro1UX6q5gcpFlZ2FkG5z7rwK4izePPmrtshS6+6VmR23GAYM+84nkq4Wue3OBuPOKv+gA3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hk0zLCWi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hk0zLCWi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712931731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xnfJ1VHTxISYLGq4mlbz2Skb/m7VY1n6kTTDVNpcpew=;
	b=hk0zLCWi3KjrTISMyXpE6iteZBnyLH3flf+WCGLXZKeMkjdYM0hXKTm7rEW0/U1BmZrUnP
	hmdClJ7i3NutHUPwVKoN090HYKq0DQR16blROgqGF19wMhA2jpfE279E4BvfNBtiwy7Qu9
	MFOeqpvwJM0/xfWXorzTk9Te31zB0QE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-OoCH9gzXMWuEIstknxSGTQ-1; Fri, 12 Apr 2024 10:22:07 -0400
X-MC-Unique: OoCH9gzXMWuEIstknxSGTQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8129F881E62;
	Fri, 12 Apr 2024 14:22:06 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.39.193.165])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3626940C6CBF;
	Fri, 12 Apr 2024 14:22:03 +0000 (UTC)
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
Subject: [PATCH v2 06/10] s390/uv: make uv_convert_from_secure() a static function
Date: Fri, 12 Apr 2024 16:21:16 +0200
Message-ID: <20240412142120.220087-7-david@redhat.com>
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

It's not used outside of uv.c, so let's make it a static function.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/uv.h | 6 ------
 arch/s390/kernel/uv.c      | 2 +-
 2 files changed, 1 insertion(+), 7 deletions(-)

diff --git a/arch/s390/include/asm/uv.h b/arch/s390/include/asm/uv.h
index 0e7bd3873907..d2205ff97007 100644
--- a/arch/s390/include/asm/uv.h
+++ b/arch/s390/include/asm/uv.h
@@ -484,7 +484,6 @@ int uv_pin_shared(unsigned long paddr);
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb);
 int gmap_destroy_page(struct gmap *gmap, unsigned long gaddr);
 int uv_destroy_owned_page(unsigned long paddr);
-int uv_convert_from_secure(unsigned long paddr);
 int uv_convert_owned_from_secure(unsigned long paddr);
 int gmap_convert_to_secure(struct gmap *gmap, unsigned long gaddr);
 
@@ -503,11 +502,6 @@ static inline int uv_destroy_owned_page(unsigned long paddr)
 	return 0;
 }
 
-static inline int uv_convert_from_secure(unsigned long paddr)
-{
-	return 0;
-}
-
 static inline int uv_convert_owned_from_secure(unsigned long paddr)
 {
 	return 0;
diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index ecfc08902215..3d3250b406a6 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -156,7 +156,7 @@ int uv_destroy_owned_page(unsigned long paddr)
  *
  * @paddr: Absolute host address of page to be exported
  */
-int uv_convert_from_secure(unsigned long paddr)
+static int uv_convert_from_secure(unsigned long paddr)
 {
 	struct uv_cb_cfs uvcb = {
 		.header.cmd = UVC_CMD_CONV_FROM_SEC_STOR,
-- 
2.44.0

