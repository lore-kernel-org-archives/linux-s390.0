Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97BF620BB20
	for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865771; cv=none; b=JkL2mgdaRHH+fyBrEJA5gxFhXb2x8odWAyGEHQw1O7QOM2KF6c4u4pZOwA7IBLV7aoD/dAxgViduEQ3yT7qs34V45S/Ky5JyK6E21696gilG1oWFtaS2doUTe4mQaH+HC3Y+/U5gDC1+5hcgdXvqnU4JHA0RJJvQXlnW3u5LQeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865771; c=relaxed/simple;
	bh=rYhwBK9SCZ9zfJJywiKfESHUTBEUEMFB3Y18DVCgEr8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qQxMrTVKI/1LmUPsT0j8+P9J9WA2e0JsGfC038vKfMW9+7vMAuODNp83rGBNIabyx5ECcSCpPfQb/mFp1jJrtL5S4R1EzIX4RepUx8ZP2u87e8+ysSlQ6lZhdlGfMy+jEg1rYIwdv+yIsQ9YFgjFQlF0w4moGY1l2XpDEHm7XLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KPjTOJKS; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KPjTOJKS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729865768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RqrSCL9SnqQxdMhiUeTqL0vv0HNcmyIpWy8EeAUhBAs=;
	b=KPjTOJKS6djXhyxV7bHMbDkw4XZTy4i52mUk9wxlzqlHIgYnt6TLf0SIzTSFf+f5tZI0Yr
	kiOXH70x/RLFAdq+IttDUHp6Z2LUyg+YGzA8IsZnpU6oL5vZDlvoiuRrTL/gsLvveJU3FO
	CXhZCAIa4TwUKNRHAthJFqqxrT1eZhc=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-378-QVg6coorOeq0mXJ05YLkIw-1; Fri,
 25 Oct 2024 10:16:03 -0400
X-MC-Unique: QVg6coorOeq0mXJ05YLkIw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6CF7E1955F3F;
	Fri, 25 Oct 2024 14:15:58 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2459119560A2;
	Fri, 25 Oct 2024 14:15:50 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-doc@vger.kernel.org,
	kvm@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Eric Farman <farman@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v3 7/7] s390/sparsemem: provide memory_add_physaddr_to_nid() with CONFIG_NUMA
Date: Fri, 25 Oct 2024 16:14:52 +0200
Message-ID: <20241025141453.1210600-8-david@redhat.com>
In-Reply-To: <20241025141453.1210600-1-david@redhat.com>
References: <20241025141453.1210600-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

virtio-mem uses memory_add_physaddr_to_nid() to determine the NID to use
for memory it adds.

We currently fallback to the dummy implementation in mm/numa.c with
CONFIG_NUMA, which will end up triggering an undesired pr_info_once():

	Unknown online node for memory at 0x100000000, assuming node 0

On s390, we map all cpus and memory to node 0, so let's add a simple
memory_add_physaddr_to_nid() implementation that does exactly that,
but without complaining.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/sparsemem.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/s390/include/asm/sparsemem.h b/arch/s390/include/asm/sparsemem.h
index ff628c50afac..6377b7ea8a40 100644
--- a/arch/s390/include/asm/sparsemem.h
+++ b/arch/s390/include/asm/sparsemem.h
@@ -5,4 +5,12 @@
 #define SECTION_SIZE_BITS	27
 #define MAX_PHYSMEM_BITS	CONFIG_MAX_PHYSMEM_BITS
 
+#ifdef CONFIG_NUMA
+static inline int memory_add_physaddr_to_nid(u64 addr)
+{
+	return 0;
+}
+#define memory_add_physaddr_to_nid memory_add_physaddr_to_nid
+#endif /* CONFIG_NUMA */
+
 #endif /* _ASM_S390_SPARSEMEM_H */
-- 
2.46.1

