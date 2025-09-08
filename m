Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0020430ACF8
	for <linux-s390@vger.kernel.org>; Mon,  8 Sep 2025 13:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757337488; cv=none; b=SFpZnYFXflezD0QXNKF3+oB0fBilHm30mFdKDDi9VkFJBN7WiG0MpbKo99IVZFZpF10dN7ttg9vrw1Wqh5htNZG4B4n5YMRCZjM6n+EaOcVbaSMu0FAmjvotk2LHHUtQXzzHX4TZrio5H0Gi2wJ0McbL+rgVf7TpfMnGQAdu/sQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757337488; c=relaxed/simple;
	bh=PWzBuhRiLykW9Jk2IT8JkXB/nA9MhhV+YpfUaL0mF4Y=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=UNzEBKVXhNgp+9mGP5d0Dze+fx50S8CJPXz8fsyjrpbLQ/hwa1ECIC1yBOzTD0nV25OhJQXyDzVitxadnZk5mLN6NuGk/g57hizPBy0UoW/A49RhhEPu0KN61VhDkWzil7WDrfx83iGJbF1GuXyEIRWYFX+c2vlQ3gecXoWswK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dl1eeP/k; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dl1eeP/k"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1757337486;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 references:references; bh=cu4zFAZ8jWl3w1cb/yYaFbQbv6iTdi9cTxYu8IqqX5Y=;
	b=Dl1eeP/kELnk2G3C7nidu4uZGxAohVt3UX+6mhkCBRzefVfPYy2uOA2y9Gwa4vLhr7LOSM
	+ltc1UfMq/L/lYiCMx0QNvwFydWDfmsxKKcIs9+BIOJVgEM+eVml19FSU5pC7SlAqdLwFd
	vdYvIvJlmOp93w8LnXTGbgKx6vKM6Jw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-655-buk4ebPHMmG1g5YS5qZ1LQ-1; Mon,
 08 Sep 2025 09:18:02 -0400
X-MC-Unique: buk4ebPHMmG1g5YS5qZ1LQ-1
X-Mimecast-MFC-AGG-ID: buk4ebPHMmG1g5YS5qZ1LQ_1757337481
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CFBD01956056;
	Mon,  8 Sep 2025 13:18:00 +0000 (UTC)
Received: from debian4.vm (unknown [10.44.32.12])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with SMTP id 6C0371955F24;
	Mon,  8 Sep 2025 13:17:56 +0000 (UTC)
Received: by debian4.vm (sSMTP sendmail emulation); Mon, 08 Sep 2025 15:17:54 +0200
Message-ID: <20250908131754.140185575@debian4.vm>
User-Agent: quilt/0.68
Date: Mon, 08 Sep 2025 15:16:46 +0200
From: Mikulas Patocka <mpatocka@redhat.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Herbert Xu <herbert@gondor.apana.org.au>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Biggers <ebiggers@kernel.org>,
 dengler@linux.ibm.com,
 linux-s390@vger.kernel.org,
 dm-devel@lists.linux.dev,
 ifranzki@linux.ibm.com,
 agk@redhat.com,
 snitzer@kernel.org,
 gmazyland@gmail.com,
 Mikulas Patocka <mpatocka@redhat.com>
Subject: [PATCH v2 4/7] dm-integrity: allocate the recalculate buffer with kmalloc
References: <20250908131642.385445532@debian4.vm>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Allocate the recalculate buffer with kmalloc rather than vmalloc. This
will be needed later, for the simplification of the asynchronous hash
interface.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
---
 drivers/md/dm-integrity.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6/drivers/md/dm-integrity.c
===================================================================
--- linux-2.6.orig/drivers/md/dm-integrity.c	2025-08-21 18:22:55.000000000 +0200
+++ linux-2.6/drivers/md/dm-integrity.c	2025-08-21 18:22:55.000000000 +0200
@@ -2998,7 +2998,7 @@ static void integrity_recalc(struct work
 	unsigned recalc_sectors = RECALC_SECTORS;
 
 retry:
-	recalc_buffer = __vmalloc(recalc_sectors << SECTOR_SHIFT, GFP_NOIO);
+	recalc_buffer = kmalloc(recalc_sectors << SECTOR_SHIFT, GFP_NOIO | __GFP_NOWARN);
 	if (!recalc_buffer) {
 oom:
 		recalc_sectors >>= 1;
@@ -3012,7 +3012,7 @@ oom:
 		recalc_tags_size += ic->internal_hash_digestsize - ic->tag_size;
 	recalc_tags = kvmalloc(recalc_tags_size, GFP_NOIO);
 	if (!recalc_tags) {
-		vfree(recalc_buffer);
+		kfree(recalc_buffer);
 		recalc_buffer = NULL;
 		goto oom;
 	}
@@ -3078,7 +3078,7 @@ next_chunk:
 		goto err;
 
 	io_req.bi_opf = REQ_OP_READ;
-	io_req.mem.type = DM_IO_VMA;
+	io_req.mem.type = DM_IO_KMEM;
 	io_req.mem.ptr.addr = recalc_buffer;
 	io_req.notify.fn = NULL;
 	io_req.client = ic->io;
@@ -3136,7 +3136,7 @@ unlock_ret:
 	recalc_write_super(ic);
 
 free_ret:
-	vfree(recalc_buffer);
+	kfree(recalc_buffer);
 	kvfree(recalc_tags);
 }
 

