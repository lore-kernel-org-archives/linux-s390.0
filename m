Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EAB1A38E3
	for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 19:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995782; cv=none; b=QDfTngTEu/K0f0jn5wNKA76gx+ebS4Rj6CsvHs//XJHY51zL/2mI4j/J8EX/lyOkheznhJxY5Du2F6MSX1l+AQ+24ASBiWG25sqinGMZkp2CTxXGzcb0MXVz4uaUt0OsedFLyXQ8DlZhhkmj36q6YiYsfD6WvZNGUinJwVRgBjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995782; c=relaxed/simple;
	bh=g2MT/MwTETprI4pBWNr9vWAdNWEhQnGcNvqYKtU2pWE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EidFzoN0IM0ZMyot6+oo/9uxIcZjEFlqzu5NBHgBIgQlpPZQJgGQO3okmAw5UCk8s5FGdChwzFyneHOuSU+kP8/XuWB5Wso3fx8tPUvNqTA3nJfZVr3Ph6aLHAenBKk85KXQMQly1EqKZfx2BkoSy3C7aT0QnhPzViAzZ23WkuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QI+OYWFe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QI+OYWFe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725995779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f8jrsz+oSo4UCVf0NzVCWgl3T4VzNafVCQ5XVw1eXHQ=;
	b=QI+OYWFey2knFXg/6TV3zWfXWgBA6brmw7vu1RU/4CAWjhqZp7obg2EW20gJGwpc9GeeiR
	BjiQ6iLeW1Nf2uLUC+LmUup/k7OP4CuglmpB/A64PFGbPvypykr7B/Zbim+NkC7W8xDVH1
	PD2GBd1Mn6BNIxVPWwrA8xi/yDMhQ5U=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-dB9lZH7VNWyNeRxWmJ1cNA-1; Tue,
 10 Sep 2024 15:16:16 -0400
X-MC-Unique: dB9lZH7VNWyNeRxWmJ1cNA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DDF491956069;
	Tue, 10 Sep 2024 19:16:10 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.17.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6DC0130001A1;
	Tue, 10 Sep 2024 19:16:03 +0000 (UTC)
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
Subject: [PATCH v1 3/5] virtio-mem: s390x support
Date: Tue, 10 Sep 2024 21:15:37 +0200
Message-ID: <20240910191541.2179655-4-david@redhat.com>
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

Now that s390x code is prepared for memory devices that reside above the
maximum storage increment exposed through SCLP, everything is in place
to unlock virtio-mem support.

As virtio-mem in Linux currently supports logically onlining/offlining
memory in pageblock granularity, we have an effective hot(un)plug
granularity of 1 MiB on s390x.

As virito-mem adds/removes individual Linux memory blocks (256MB), we
will currently never use gigantic pages in the identity mapping.

It is worth noting that neither storage keys nor storage attributes (e.g.,
data / nodat) are touched when onlining memory blocks, which is good
because we are not supposed to touch these parts for unplugged device
blocks that are logically offline in Linux.

We will currently never initialize storage keys for virtio-mem
memory -- IOW, storage_key_init_range() is never called. It could be added
in the future when plugging device blocks. But as that function
essentially does nothing without modifying the code (changing
PAGE_DEFAULT_ACC), that's just fine for now.

kexec should work as intended and just like on other architectures that
support virtio-mem: we will never place kexec binaries on virtio-mem
memory, and never indicate virtio-mem memory to the 2nd kernel. The
device driver in the 2nd kernel can simply reset the device --
turning all memory unplugged, to then start plugging memory and adding
them to Linux, without causing trouble because the memory is already
used elsewhere.

The special s390x kdump mode, whereby the 2nd kernel creates the ELF
core header, won't currently dump virtio-mem memory. The virtio-mem
driver has a special kdump mode, from where we can detect memory ranges
to dump. Based on this, support for dumping virtio-mem memory can be
added in the future fairly easily.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 drivers/virtio/Kconfig | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
index 42a48ac763ee..fb320eea70fe 100644
--- a/drivers/virtio/Kconfig
+++ b/drivers/virtio/Kconfig
@@ -122,7 +122,7 @@ config VIRTIO_BALLOON
 
 config VIRTIO_MEM
 	tristate "Virtio mem driver"
-	depends on X86_64 || ARM64 || RISCV
+	depends on X86_64 || ARM64 || RISCV || S390
 	depends on VIRTIO
 	depends on MEMORY_HOTPLUG
 	depends on MEMORY_HOTREMOVE
@@ -132,11 +132,11 @@ config VIRTIO_MEM
 	 This driver provides access to virtio-mem paravirtualized memory
 	 devices, allowing to hotplug and hotunplug memory.
 
-	 This driver currently only supports x86-64 and arm64. Although it
-	 should compile on other architectures that implement memory
-	 hot(un)plug, architecture-specific and/or common
-	 code changes may be required for virtio-mem, kdump and kexec to work as
-	 expected.
+	 This driver currently supports x86-64, arm64, riscv and s390x.
+	 Although it should compile on other architectures that implement
+	 memory hot(un)plug, architecture-specific and/or common
+	 code changes may be required for virtio-mem, kdump and kexec to
+	 work as expected.
 
 	 If unsure, say M.
 
-- 
2.46.0

