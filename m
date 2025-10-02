Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 349AF19D880
	for <linux-s390@vger.kernel.org>; Thu,  2 Oct 2025 15:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759420476; cv=none; b=m2N/OmPbDdODVszXbMpNT622iDq0bdbal5hCFZNlwRjQd7OaxASrbrOKDf7W0FWsyLwmSimZ4wrwrH+vAvhBETNMa97lvS5MaCOL8DrWKNCteIm8WTOO8EPnaxW1LaY54zJzbNDk40J+i4uQRNTQf4sRnwvd6mXHK9918JZpPjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759420476; c=relaxed/simple;
	bh=I7Y+Mjnls8k0ABWDnwpu1wtXQPHjQ8esyz8RTghTA6Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hqG4u//R3Zfhf6CsvWaPIb7mmi56XPDV1LUs7qpiYF2KLZv9/BmUVn5xZXFB5rQ9Qn8QrWQ4N+o9RsvUdj7yThs1kIB46GX6lf9wq4xo50wb2khXKBlRwAPnlt+jzivxFJWyiOMuTD1zI3qWhpYS+6jtH5m4qy8HFTtrtk5YMKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bfAzJFzt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bfAzJFzt"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759420473;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=obRbji6GklroAykeBLLoI0W4RXQ2A2jgpCxrAePKjvU=;
	b=bfAzJFztQpkdWUpTh9e01QZWg146IKmZfJp2oj3/hXTABrweS/hDSYBNuuJkwI+P+Jt9gQ
	eYqLmeRCUKTtMXSC3ZehlqnUcbj/0+pK6IYZt5QMss0D8rN0E466b88KNhyBdM3bcIRggJ
	eZoXhbpjBW3+zrn7qT+6mJJJlttzQIQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-454-1br6Ph0oNCufNEXaDUYfmA-1; Thu,
 02 Oct 2025 11:54:31 -0400
X-MC-Unique: 1br6Ph0oNCufNEXaDUYfmA-1
X-Mimecast-MFC-AGG-ID: 1br6Ph0oNCufNEXaDUYfmA_1759420469
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B5039180048E;
	Thu,  2 Oct 2025 15:54:29 +0000 (UTC)
Received: from thuth-p1g4.redhat.com (unknown [10.45.224.58])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 55005300018D;
	Thu,  2 Oct 2025 15:54:25 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: freude@linux.ibm.com,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Cc: David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] s390/uv: Fix the comment of the uv_find_secret() function
Date: Thu,  2 Oct 2025 17:54:23 +0200
Message-ID: <20251002155423.466142-1-thuth@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

From: Thomas Huth <thuth@redhat.com>

The uv_get_secret_metadata() function has been removed some
months ago, so we should not mention it in the comment anymore.

Fixes: a42831f0b74dc ("s390/uv: Remove uv_get_secret_metadata function")
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 arch/s390/kernel/uv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/s390/kernel/uv.c b/arch/s390/kernel/uv.c
index 47f574cd1728a..324cd549807a5 100644
--- a/arch/s390/kernel/uv.c
+++ b/arch/s390/kernel/uv.c
@@ -866,8 +866,8 @@ static int find_secret_in_page(const u8 secret_id[UV_SECRET_ID_LEN],
 	return -ENOENT;
 }
 
-/*
- * Do the actual search for `uv_get_secret_metadata`.
+/**
+ * uv_find_secret() - search secret metadata for a given secret id.
  * @secret_id: search pattern.
  * @list: ephemeral buffer space
  * @secret: output data, containing the secret's metadata.
-- 
2.51.0

