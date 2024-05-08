Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9F4128803
	for <linux-s390@vger.kernel.org>; Wed,  8 May 2024 18:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715193011; cv=none; b=qJ+7hZJFQEiDVgsd3hsJ/HboAhl+KIlhlk0PvFu17I5Q0HI/fEVfmU1BfP0+URULFOjM2MYqziwUb4ZHNKfH5/cLXAr8LP0U5Y+730e/2M8imC6iJHczDW4N46D7YWl+PQS9m3a3aW48SeJ818yv2mln495kNKu+tfMX/KfRHiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715193011; c=relaxed/simple;
	bh=tGeTT+tQWNJbKsFVdDmQOB1mb9yMQs3jSrIboV+0orM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uHa3uRxsFpk5ubkVUR1MMvRJGazh2E5PBpAd8PVUeJP090UJOuk8a96koy7Ta5HHYrAjsLCe5B9t5lGpeI5EtUYHLBo8d7HKvZ4E9/aSz83Od9vJed+CiAmIhtsKDJBsLu2m+XbrM4rjlM2fhoTXrpuepDaZGVbNjtqfI/xAyKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MkTYOg3v; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MkTYOg3v"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1715193009;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y29b0cT6yB5VZTvsbZqA3LcuNrLGP3cN/SVFA7pEfpw=;
	b=MkTYOg3vjNs2ZnK0nrYGDQTbYPfqy2cnYA1YIp9Y3/65x/ymhtBs01i6rbrexBBfD6mkdw
	Kuc5Z4isBbntVas2fGNl2xC0RRg71jyyreOBZSehWsjCGdLZEO35KJ+RdG77X037YhUyMC
	YGcltCTYdtrwSBaU4uPZjSag2Lqls6A=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-36QGDf8mNPue-GhiuNEv6w-1; Wed,
 08 May 2024 14:30:06 -0400
X-MC-Unique: 36QGDf8mNPue-GhiuNEv6w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A9031380009B;
	Wed,  8 May 2024 18:30:05 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.39.192.63])
	by smtp.corp.redhat.com (Postfix) with ESMTP id DBAED10000AD;
	Wed,  8 May 2024 18:30:02 +0000 (UTC)
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
Subject: [PATCH v3 02/10] s390/uv: gmap_make_secure() cleanups for further changes
Date: Wed,  8 May 2024 20:29:47 +0200
Message-ID: <20240508182955.358628-3-david@redhat.com>
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

Let's factor out handling of LRU cache draining and convert the if-else
chain to a switch-case.

Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/kernel/uv.c | 66 ++++++++++++++++++++++++++-----------------
 1 file changed, 40 insertions(+), 26 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 016993e9eb72..25fe28d189df 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -266,6 +266,36 @@ static bool should_export_before_import(struct uv_cb_header *uvcb, struct mm_str
 	return atomic_read(&mm->context.protected_count) > 1;
 }
 
+/*
+ * Drain LRU caches: the local one on first invocation and the ones of all
+ * CPUs on successive invocations. Returns "true" on the first invocation.
+ */
+static bool drain_lru(bool *drain_lru_called)
+{
+	/*
+	 * If we have tried a local drain and the folio refcount
+	 * still does not match our expected safe value, try with a
+	 * system wide drain. This is needed if the pagevecs holding
+	 * the page are on a different CPU.
+	 */
+	if (*drain_lru_called) {
+		lru_add_drain_all();
+		/* We give up here, don't retry immediately. */
+		return false;
+	}
+	/*
+	 * We are here if the folio refcount does not match the
+	 * expected safe value. The main culprits are usually
+	 * pagevecs. With lru_add_drain() we drain the pagevecs
+	 * on the local CPU so that hopefully the refcount will
+	 * reach the expected safe value.
+	 */
+	lru_add_drain();
+	*drain_lru_called = true;
+	/* The caller should try again immediately */
+	return true;
+}
+
 /*
  * Requests the Ultravisor to make a page accessible to a guest.
  * If it's brought in the first time, it will be cleared. If
@@ -275,7 +305,7 @@ static bool should_export_before_import(struct uv_cb_header *uvcb, struct mm_str
 int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 {
 	struct vm_area_struct *vma;
-	bool local_drain = false;
+	bool drain_lru_called = false;
 	spinlock_t *ptelock;
 	unsigned long uaddr;
 	struct folio *folio;
@@ -331,37 +361,21 @@ int gmap_make_secure(struct gmap *gmap, unsigned long gaddr, void *uvcb)
 out:
 	mmap_read_unlock(gmap->mm);
 
-	if (rc == -EAGAIN) {
+	switch (rc) {
+	case -EAGAIN:
 		/*
 		 * If we are here because the UVC returned busy or partial
 		 * completion, this is just a useless check, but it is safe.
 		 */
 		folio_wait_writeback(folio);
 		folio_put(folio);
-	} else if (rc == -EBUSY) {
-		/*
-		 * If we have tried a local drain and the folio refcount
-		 * still does not match our expected safe value, try with a
-		 * system wide drain. This is needed if the pagevecs holding
-		 * the page are on a different CPU.
-		 */
-		if (local_drain) {
-			lru_add_drain_all();
-			/* We give up here, and let the caller try again */
-			return -EAGAIN;
-		}
-		/*
-		 * We are here if the folio refcount does not match the
-		 * expected safe value. The main culprits are usually
-		 * pagevecs. With lru_add_drain() we drain the pagevecs
-		 * on the local CPU so that hopefully the refcount will
-		 * reach the expected safe value.
-		 */
-		lru_add_drain();
-		local_drain = true;
-		/* And now we try again immediately after draining */
-		goto again;
-	} else if (rc == -ENXIO) {
+		return -EAGAIN;
+	case -EBUSY:
+		/* Additional folio references. */
+		if (drain_lru(&drain_lru_called))
+			goto again;
+		return -EAGAIN;
+	case -ENXIO:
 		if (gmap_fault(gmap, gaddr, FAULT_FLAG_WRITE))
 			return -EFAULT;
 		return -EAGAIN;
-- 
2.45.0

