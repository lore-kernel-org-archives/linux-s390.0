Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D73CF20BB5A
	for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2024 14:15:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729865748; cv=none; b=HK06tq5uQGkSMqsVO/yyAr16DsAoMJjoKr/P7CVc0H3judl5NdqISNWpRJwZnGDV/EvUgIYR0nIMMVeJsDPcWUTvoCg21pN4oLRmZ9djC6Y0eDm9NBeTIHKG4lvYBgCdO5/Bo0XZM/wwF/IpdFhHyXK5PGhp2Thy7vQxa75XWMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729865748; c=relaxed/simple;
	bh=qP5BOMx+AFbuaOmNrHq+eACIGSsG+WF/uxJ1INUuM2o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tsGveQzxpcNuelpJeJidUjIA37lFyF2DwErEBVSOkn/E2hpK3Jx7D+aBGL5zSsEf+GH/gpPbxDGoYyAul8BpJBCZG1jrO9TBhNS170BgMPUqyOy6OyDVXuGomW7ltAcjJiR2sgWq9P+Rev3uVMKRNHsWQB1+dvoLOCCcF1e7sq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UaJncOwh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UaJncOwh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729865746;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dV9SC24YC4T4aWYHNQCxY+WbG2Bhk/i+Kj0AtdnRckY=;
	b=UaJncOwhiaKjNLFEV+8f/7/GGmTQ7fWgc1ptI+R1ohh6bMl5eWdq6rgcuNY/WE2O0B1cOw
	F53uws1tuuAv5eDbO2kMGwsoMqhSk0kmXB7CK4G1xDKYbT7S0IcHd6/jXkJgUzFm5GwuAY
	uma/pcDbRrA109T91PVtMhZc2o5jWp8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-hNG7DXsQMK2z95OHSVmGKQ-1; Fri,
 25 Oct 2024 10:15:44 -0400
X-MC-Unique: hNG7DXsQMK2z95OHSVmGKQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C14C1955DCD;
	Fri, 25 Oct 2024 14:15:42 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.22.65.27])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 499AE1955F30;
	Fri, 25 Oct 2024 14:15:35 +0000 (UTC)
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
	Jonathan Corbet <corbet@lwn.net>,
	Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v3 5/7] lib/Kconfig.debug: default STRICT_DEVMEM to "y" on s390
Date: Fri, 25 Oct 2024 16:14:50 +0200
Message-ID: <20241025141453.1210600-6-david@redhat.com>
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

virtio-mem currently depends on !DEVMEM | STRICT_DEVMEM. Let's default
STRICT_DEVMEM to "y" just like we do for arm64 and x86.

There could be ways in the future to filter access to virtio-mem device
memory even without STRICT_DEVMEM, but for now let's just keep it
simple.

Tested-by: Mario Casquero <mcasquer@redhat.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7312ae7c3cc5..fcad505e7c8b 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -1905,7 +1905,7 @@ config STRICT_DEVMEM
 	bool "Filter access to /dev/mem"
 	depends on MMU && DEVMEM
 	depends on ARCH_HAS_DEVMEM_IS_ALLOWED || GENERIC_LIB_DEVMEM_IS_ALLOWED
-	default y if PPC || X86 || ARM64
+	default y if PPC || X86 || ARM64 || S390
 	help
 	  If this option is disabled, you allow userspace (root) access to all
 	  of memory, including kernel and userspace memory. Accidental
-- 
2.46.1

