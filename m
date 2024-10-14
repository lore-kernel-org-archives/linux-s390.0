Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556A11C2DA1
	for <linux-s390@vger.kernel.org>; Mon, 14 Oct 2024 14:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728917214; cv=none; b=C3mAGsv3PXmnwnDU5liXlpVBr7R9KJZyG5dOOmecEvDxWFTJRbWD/gIA+eYTKlUR4XhPYceTEpe3a0xAHHzpgki0FM4c8TFb6wmTFXs83fcM4M4CdbZp/L9n4p1s/sL/7V9CFPURxd0VNkYs+MXWPXXJ+CV3FfljHn1nBaLQc+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728917214; c=relaxed/simple;
	bh=+gUYFnuIYAZ0uZvGof5w1gH0tr8nQ6YumuZz/jvCqn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r7Dch8caAF10SHxV3VjZTLozG1AnoNQ2LH40yGQSnQkVaohb00xz+fc7zsoF+j65lI0Ye2PLPqXs8rvS2I959CWQ8iUHUqk3sG+uGJT/oNDUXNW3X9O7rpXadVjXVcqs6pWxXyIttmTGWlLE3Asdif4blAUu0JnqDvf8buw0Mz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FGHN0stU; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FGHN0stU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728917212;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a1gfpTnBaz7Rw8DDcy7+GcKNAbMQ0JDruhBEQq7xW1o=;
	b=FGHN0stUZi/RwFtZYtrfyODBZ79YTTkJy97LjVxY8clo4dXTvNEr3s08iTY+zYirBPBIe6
	xdLap9xYffiRppRGO/wDmgc57k/lmCkYUZCw01/az8wHn2mecrPv282ZL828hhBTS4xiYD
	CL3k5+4IMJVJm/nsjMcl7PLbxifYUzk=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-571-YaPY5B82Mt2_929L_qPidA-1; Mon,
 14 Oct 2024 10:46:49 -0400
X-MC-Unique: YaPY5B82Mt2_929L_qPidA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3531919560B5;
	Mon, 14 Oct 2024 14:46:47 +0000 (UTC)
Received: from t14s.cit.tum.de (unknown [10.22.32.146])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C0E941955E8F;
	Mon, 14 Oct 2024 14:46:39 +0000 (UTC)
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
	Jonathan Corbet <corbet@lwn.net>
Subject: [PATCH v2 2/7] Documentation: s390-diag.rst: make diag500 a generic KVM hypercall
Date: Mon, 14 Oct 2024 16:46:14 +0200
Message-ID: <20241014144622.876731-3-david@redhat.com>
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

Let's make it a generic KVM hypercall, allowing other subfunctions to
be more independent of virtio.

This is a preparation for documenting a new hypercall.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 Documentation/virt/kvm/s390/s390-diag.rst | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/virt/kvm/s390/s390-diag.rst b/Documentation/virt/kvm/s390/s390-diag.rst
index ca85f030eb0b..d9b7c6cbc99e 100644
--- a/Documentation/virt/kvm/s390/s390-diag.rst
+++ b/Documentation/virt/kvm/s390/s390-diag.rst
@@ -35,15 +35,16 @@ DIAGNOSE function codes not specific to KVM, please refer to the
 documentation for the s390 hypervisors defining them.
 
 
-DIAGNOSE function code 'X'500' - KVM virtio functions
------------------------------------------------------
+DIAGNOSE function code 'X'500' - KVM functions
+----------------------------------------------
 
-If the function code specifies 0x500, various virtio-related functions
-are performed.
+If the function code specifies 0x500, various KVM-specific functions
+are performed, including virtio functions.
 
-General register 1 contains the virtio subfunction code. Supported
-virtio subfunctions depend on KVM's userspace. Generally, userspace
-provides either s390-virtio (subcodes 0-2) or virtio-ccw (subcode 3).
+General register 1 contains the subfunction code. Supported subfunctions
+depend on KVM's userspace. Regarding virtio subfunctions, generally
+userspace provides either s390-virtio (subcodes 0-2) or virtio-ccw
+(subcode 3).
 
 Upon completion of the DIAGNOSE instruction, general register 2 contains
 the function's return code, which is either a return code or a subcode
-- 
2.46.1

