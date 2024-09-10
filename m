Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C1217BEBD
	for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 19:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995771; cv=none; b=TxkEFy+MHiqj/rwi3jTndJURQzap9MGqqeAvk1EKabhgUcvwDJSCdzjuHN+bHBHyu6y5YpKHpmD+uAcau3DCOkM5zTUhFPvUH5TMYQBuy26r4mVVcK3XjV8lkiLSy+ehVobCYFzuknAkY8M8tbYdQzCVNkekhrKl1C8PvXh22bM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995771; c=relaxed/simple;
	bh=78GqS+FJMRc1v3zn5JSPVLZDDgcaItiFFgkRUR2/MpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kkmN590ksj8J6SoLUTcSJ3GquDwgirn+EvR487XeNq6/MJ/Q4yZd8HXmN0xuqS49ZXpDIOi+4zjjk9YXrXaImdBpNCSLXPmPr1WijAaN27iBoOUhNZz+KZgCla8tZiyYsqa06GvLNqHp5fKFGXbPuT7YysqPcNZmZjLrNi9nZAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hro5NJpp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hro5NJpp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725995768;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xq/TMyiVBlIW+rwu1EuyYBMF+1VwzZ0MGyvT9zBb2aI=;
	b=hro5NJppvJnZtDrBB60Z5heUGMKyrJQfkySMpPZvrrkD5ejP2fMBB43gw28NlBGW6WMzzX
	z+iT0zcBBgQlYxPB18lHuCGQWXHeg2d90u5XF+s0GhBVYbS0YuYxniewv2E/uARi18U3aa
	FXbtZyGTPKnDWDc2TT4YQ9KxGsc64/E=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-125-xGJCYATCMwGtvkeozeKKzg-1; Tue,
 10 Sep 2024 15:16:05 -0400
X-MC-Unique: xGJCYATCMwGtvkeozeKKzg-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EA6F21955F07;
	Tue, 10 Sep 2024 19:16:02 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.17.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1E8D730001A1;
	Tue, 10 Sep 2024 19:15:56 +0000 (UTC)
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
Subject: [PATCH v1 2/5] s390/physmem_info: query diag500(STORAGE_LIMIT) to support QEMU/KVM memory devices
Date: Tue, 10 Sep 2024 21:15:36 +0200
Message-ID: <20240910191541.2179655-3-david@redhat.com>
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

To support memory devices under QEMU/KVM, such as virtio-mem,
we have to prepare our kernel virtual address space accordingly and
have to know the highest possible physical memory address we might see
later: the storage limit. The good old SCLP interface is not suitable for
this use case.

In particular, memory owned by memory devices has no relationship to
storage increments, it is always detected using the device driver, and
unaware OSes (no driver) must never try making use of that memory.
Consequently this memory is located outside of the "maximum storage
increment"-indicated memory range.

Let's use our new diag500 STORAGE_LIMIT subcode to query this storage
limit that can exceed the "maximum storage increment", and use the
existing interfaces (i.e., SCLP) to obtain information about the initial
memory that is not owned+managed by memory devices.

If a hypervisor does not support such memory devices, the address exposed
through diag500 STORAGE_LIMIT will correspond to the maximum storage
increment exposed through SCLP.

To teach kdump on s390x to include memory owned by memory devices, there
will be ways to query the relevant memory ranges from the device via a
driver running in special kdump mode (like virtio-mem already implements
to filter /proc/vmcore access so we don't end up reading from unplugged
device blocks).

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/boot/physmem_info.c        | 46 ++++++++++++++++++++++++++--
 arch/s390/include/asm/physmem_info.h |  3 ++
 2 files changed, 46 insertions(+), 3 deletions(-)

diff --git a/arch/s390/boot/physmem_info.c b/arch/s390/boot/physmem_info.c
index 4c9ad8258f7e..9cac8550bdca 100644
--- a/arch/s390/boot/physmem_info.c
+++ b/arch/s390/boot/physmem_info.c
@@ -109,6 +109,38 @@ static int diag260(void)
 	return 0;
 }
 
+static int diag500_storage_limit(unsigned long *max_physmem_end)
+{
+	register unsigned long __nr asm("1") = 0x4;
+	register unsigned long __storage_limit asm("2") = 0;
+	unsigned long reg1, reg2;
+	psw_t old;
+
+	asm volatile(
+		"	mvc	0(16,%[psw_old]),0(%[psw_pgm])\n"
+		"	epsw	%[reg1],%[reg2]\n"
+		"	st	%[reg1],0(%[psw_pgm])\n"
+		"	st	%[reg2],4(%[psw_pgm])\n"
+		"	larl	%[reg1],1f\n"
+		"	stg	%[reg1],8(%[psw_pgm])\n"
+		"	diag	2,4,0x500\n"
+		"1:	mvc	0(16,%[psw_pgm]),0(%[psw_old])\n"
+		: [reg1] "=&d" (reg1),
+		  [reg2] "=&a" (reg2),
+		  "+&d" (__storage_limit),
+		  "=Q" (get_lowcore()->program_new_psw),
+		  "=Q" (old)
+		: [psw_old] "a" (&old),
+		  [psw_pgm] "a" (&get_lowcore()->program_new_psw),
+		  "d" (__nr)
+		: "memory");
+	if (!__storage_limit)
+	        return -EINVAL;
+	/* convert inclusive end to exclusive end. */
+	*max_physmem_end = __storage_limit + 1;
+	return 0;
+}
+
 static int tprot(unsigned long addr)
 {
 	unsigned long reg1, reg2;
@@ -157,7 +189,9 @@ unsigned long detect_max_physmem_end(void)
 {
 	unsigned long max_physmem_end = 0;
 
-	if (!sclp_early_get_memsize(&max_physmem_end)) {
+	if (!diag500_storage_limit(&max_physmem_end)) {
+		physmem_info.info_source = MEM_DETECT_DIAG500_STOR_LIMIT;
+	} else if (!sclp_early_get_memsize(&max_physmem_end)) {
 		physmem_info.info_source = MEM_DETECT_SCLP_READ_INFO;
 	} else {
 		max_physmem_end = search_mem_end();
@@ -170,11 +204,17 @@ void detect_physmem_online_ranges(unsigned long max_physmem_end)
 {
 	if (!sclp_early_read_storage_info()) {
 		physmem_info.info_source = MEM_DETECT_SCLP_STOR_INFO;
+		return;
 	} else if (!diag260()) {
 		physmem_info.info_source = MEM_DETECT_DIAG260;
-	} else if (max_physmem_end) {
-		add_physmem_online_range(0, max_physmem_end);
+		return;
+	} else if (physmem_info.info_source == MEM_DETECT_DIAG500_STOR_LIMIT) {
+		max_physmem_end = 0;
+		if (!sclp_early_get_memsize(&max_physmem_end))
+			physmem_info.info_source = MEM_DETECT_SCLP_READ_INFO;
 	}
+	if (max_physmem_end)
+		add_physmem_online_range(0, max_physmem_end);
 }
 
 void physmem_set_usable_limit(unsigned long limit)
diff --git a/arch/s390/include/asm/physmem_info.h b/arch/s390/include/asm/physmem_info.h
index f45cfc8bc233..51b68a43e195 100644
--- a/arch/s390/include/asm/physmem_info.h
+++ b/arch/s390/include/asm/physmem_info.h
@@ -9,6 +9,7 @@ enum physmem_info_source {
 	MEM_DETECT_NONE = 0,
 	MEM_DETECT_SCLP_STOR_INFO,
 	MEM_DETECT_DIAG260,
+	MEM_DETECT_DIAG500_STOR_LIMIT,
 	MEM_DETECT_SCLP_READ_INFO,
 	MEM_DETECT_BIN_SEARCH
 };
@@ -107,6 +108,8 @@ static inline const char *get_physmem_info_source(void)
 		return "sclp storage info";
 	case MEM_DETECT_DIAG260:
 		return "diag260";
+	case MEM_DETECT_DIAG500_STOR_LIMIT:
+		return "diag500 storage limit";
 	case MEM_DETECT_SCLP_READ_INFO:
 		return "sclp read info";
 	case MEM_DETECT_BIN_SEARCH:
-- 
2.46.0

