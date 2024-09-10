Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010031A76DF
	for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 19:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995785; cv=none; b=S34MnwMrqWeg51ynvK30TsWFpkBBtkCYsbfx1uFqGlvjJy+ZZk9Mfcd8K1nNiFo+qRU3m4y6YcCoC0CAQ+EJImI+UXyLu0YWLlcFtrMCMHNN5Inx//Dt3fUCPzZMjsKIz5QRrYcX8Hb4VeF8sN4fzvzWWyrGw5nxgc9G3vM0518=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995785; c=relaxed/simple;
	bh=LDxSkPoI+HT/J2WKBXNgRLxgSrReE8BVDgXu2HZs7aw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QjnAHEFrcN1ZUYty0yX3CumFRfUUl8Jg3ewPLhKfetij9YBfHq93t6suf2XTfdqyfFoS4IRM+N1DURUbz85bUNG/+ThltX+rfS1Q1My3YCxVEao8lfivGeJyrKGRHfvI3yocZGs4kr+Qp8mC2pANPYBmBv4tq5DddfTaGxc/NT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S9GiH19T; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S9GiH19T"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725995782;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dwp1+ZWlakCCMbjLs+RuljQC2sU4OdCWLWut1FtVKY=;
	b=S9GiH19TA8EgjiNOWacL/x1PHa8cLJgknSxkts5M8mq9tDBV7f0xOZhrCWKICLu2TjwXF7
	8a8sBWy35aOxYvmKmt4hrwNvzCAtAJkxtPr/5miwyVPAciq94ZYAqC5ILf9OP8+393QIp9
	0wdIjgRq0aKlOvR9bpgRUziX4kIzPJE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-221-xIwG_QIJM6al6Jomp-rQGQ-1; Tue,
 10 Sep 2024 15:16:19 -0400
X-MC-Unique: xIwG_QIJM6al6Jomp-rQGQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 64853193E8EC;
	Tue, 10 Sep 2024 19:16:17 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.17.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6AF713001D0F;
	Tue, 10 Sep 2024 19:16:11 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org,
	linux-s390@vger.kernel.org,
	virtualization@lists.linux.dev,
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
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v1 4/5] lib/Kconfig.debug: default STRICT_DEVMEM to "y" on s390x
Date: Tue, 10 Sep 2024 21:15:38 +0200
Message-ID: <20240910191541.2179655-5-david@redhat.com>
In-Reply-To: <20240910191541.2179655-1-david@redhat.com>
References: <20240910191541.2179655-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

virtio-mem currently depends on !DEVMEM | STRICT_DEVMEM. Let's default
STRICT_DEVMEM to "y" just like we do for arm64 and x86.

There could be ways in the future to filter access to virtio-mem device
memory even without STRICT_DEVMEM, but for now let's just keep it
simple.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index a30c03a66172..fce22ce54983 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1887,7 +1887,7 @@ config STRICT_DEVMEM
 	bool "Filter access to /dev/mem"
 	depends on MMU && DEVMEM
 	depends on ARCH_HAS_DEVMEM_IS_ALLOWED || GENERIC_LIB_DEVMEM_IS_ALLOWED
-	default y if PPC || X86 || ARM64
+	default y if PPC || X86 || ARM64 || S390
 	help
 	  If this option is disabled, you allow userspace (root) access to all
 	  of memory, including kernel and userspace memory. Accidental
-- 
2.46.0

