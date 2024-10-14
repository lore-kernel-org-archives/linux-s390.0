Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6A911CACEB
	for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2024 14:47:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917246; cv=none; b=VyY8QP+7NmFY14J1+clsqakCzwMmxQlb9dO0M+XAtNPDQxlVAmU6TdjwRiH8pP8s7lPRZExh5VH9M3D5IPJc2YmJb9sGF28PIVddbinzgfR9i6d3aESivWbeg+efIo4jq8+vw6sZRUkK1oUjcYFUemRAyVQdwiGXtRUVe0vHft4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917246; c=relaxed/simple;
	bh=e4ylo1FCKZby+zq0gRFyJO22hmlj0ioJwGzNWFVJP5g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b5hQl+RhEIv2GUsAwbk/ogwQsuEtwb22Bx1BqASzAE/VKyipUndSTip3u/3nruWLwRbGepi+If30Izg+qHqAi+98TuWv8nD+S+rTu/uOI3rurWbG0ejy/5dFh1Z5M/a4AgN/LcRN+Var4wyG2A/jJ7smgfglHZL9Fhzj6HFblu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D4+emzVa; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D4+emzVa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728917242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TEhGx1JLq9dSKRa67DDmtCgVp6iAA+J1mNausVPzC38=;
	b=D4+emzVa8gi5WcZj8DVqlo+9NUF6aOZ34opGUilY1VmyjeqAES9tmRCh2LDB2GZZt5zBYj
	KFAkZF26rFl5aGPVYS1jimziCjcYC79KaQZ1peMvRch97eQphu2GP8Ro/LqsmUQb8lj39A
	ayb80iwxTOwDic6KIuGtyYNfAgDXtKw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-643-EvDDUXnzPSm_Vd_naOQgNw-1; Mon,
 14 Oct 2024 10:47:19 -0400
X-MC-Unique: EvDDUXnzPSm_Vd_naOQgNw-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6078819560B5;
	Mon, 14 Oct 2024 14:47:17 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.22.32.146])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7C87E1955E8F;
	Mon, 14 Oct 2024 14:47:10 +0000 (UTC)
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
	Andrew Morton <akpm@linux-foundation.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Mario Casquero <mcasquer@redhat.com>
Subject: [PATCH v2 6/7] lib/Kconfig.debug: default STRICT_DEVMEM to "y" on s390
Date: Mon, 14 Oct 2024 16:46:18 +0200
Message-ID: <20241014144622.876731-7-david@redhat.com>
In-Reply-To: <20241014144622.876731-1-david@redhat.com>
References: <20241014144622.876731-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

virtio-mem currently depends on !DEVMEM | STRICT_DEVMEM. Let's default
STRICT_DEVMEM to "y" just like we do for arm64 and x86.

There could be ways in the future to filter access to virtio-mem device
memory even without STRICT_DEVMEM, but for now let's just keep it
simple.

Tested-by: Mario Casquero <mcasquer@redhat.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 lib/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 7315f643817a..e7a917540e2a 100644
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

