Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C7D477F05
	for <linux-s390@vger.kernel.org>; Fri, 16 Feb 2024 19:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708110058; cv=none; b=ma1Fhz0+UO/0GP2fwwLz2eLJj92L9XYQv5S0BoDCUIsFKKw9mKuSjVkG2/8a3yNICDmBDY2uoy4ebPHwEgZvi8E3a4ERs2Y3+5aYtC8VZF/ZhVDgBEwPIrLWoZMT8jDnNlHC/5T5TsBd9Eli1NNct6n5HBtO6hApOtx/f+0bKBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708110058; c=relaxed/simple;
	bh=Yj1DLuFAHhRVzABVro82zXPj9Y+ZiKikd+RSYP0I3Bo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=edgnKmruZgpZw85W4320F3u1GqrrVbZXBLny14TcjTzPWQyhFQLUV5iP+wGlfh5P/wp45w9Wx+T1wwFPwLk1euUK4mXTGySndjFrH9Yj/tNE91XYx4+OwQPVwT9WoTAazBfNGF+3kBC5lx6OEzuoqz7nBhLbmtm8AGAiE5m5+0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HWTT5l4b; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWTT5l4b"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708110056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=9rV2I4qDQqipxUQlTN+VO+51VV+6LJI9xW6T48mbZMw=;
	b=HWTT5l4bi4+tfm44TLMgRYjN4QOVFnZMQQN1ZdQAHHcyNk0F5LMkc3czWXO3fKv549lCiD
	nalOe+NpcmAPBlUA/7oRLRU3Zfo5SW6ChnHNZXQAutQ/mpBClD/Niq11pbBso8wo8W5Lm9
	TwSkif49ML+y3XcjHFhFQDZ9F4PrglU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-524-FA6tnD0CMpKOBT5bHoBLcg-1; Fri,
 16 Feb 2024 14:00:52 -0500
X-MC-Unique: FA6tnD0CMpKOBT5bHoBLcg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7EABC3C0F187;
	Fri, 16 Feb 2024 19:00:51 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.39.192.30])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4F0D4492BE3;
	Fri, 16 Feb 2024 19:00:49 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: kvm@vger.kernel.org,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	=?UTF-8?q?Nico=20B=C3=B6hr?= <nrb@linux.ibm.com>
Cc: linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Jan Richter <jarichte@redhat.com>
Subject: [kvm-unit-tests PATCH] s390x/snippets/c/sie-dat: Fix compiler warning with GCC 11.2
Date: Fri, 16 Feb 2024 20:00:48 +0100
Message-ID: <20240216190048.83801-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

GCC 11.2.1 from RHEL 9.0 complains:

 s390x/snippets/c/sie-dat.c: In function ‘main’:
 s390x/snippets/c/sie-dat.c:51:22: error: writing 1 byte into a region of size 0 [-Werror=stringop-overflow=]
    51 |         *invalid_ptr = 42;
       |         ~~~~~~~~~~~~~^~~~
 cc1: all warnings being treated as errors

Let's use the OPAQUE_PTR() macro here too, which we already used
in other spots to fix similar -Wstringop-overflow warnings.

Reported-by: Jan Richter <jarichte@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 s390x/snippets/c/sie-dat.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/s390x/snippets/c/sie-dat.c b/s390x/snippets/c/sie-dat.c
index ecfcb60e..9d89801d 100644
--- a/s390x/snippets/c/sie-dat.c
+++ b/s390x/snippets/c/sie-dat.c
@@ -9,6 +9,7 @@
  */
 #include <libcflat.h>
 #include <asm-generic/page.h>
+#include <asm/mem.h>
 #include "sie-dat.h"
 
 static uint8_t test_pages[GUEST_TEST_PAGE_COUNT * PAGE_SIZE] __attribute__((__aligned__(PAGE_SIZE)));
@@ -47,7 +48,7 @@ int main(void)
 	force_exit();
 
 	/* the first unmapped address */
-	invalid_ptr = (uint8_t *)(GUEST_TOTAL_PAGE_COUNT * PAGE_SIZE);
+	invalid_ptr = OPAQUE_PTR(GUEST_TOTAL_PAGE_COUNT * PAGE_SIZE);
 	*invalid_ptr = 42;
 
 	/* indicate we've written the non-allowed page (should never get here) */
-- 
2.43.0

