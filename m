Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E8F617C7C9
	for <linux-s390@vger.kernel.org>; Tue, 10 Sep 2024 19:16:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725995765; cv=none; b=oGNUtwMoBzZb1QV3Dar/+xjrIIdeyUINs+GSboBMncExcvTpTYZ/1Jqwav1UG8lTu60DiIj+/+cbj2q3RUDCBYTCdjKm/7QtEKq78+S7ATK4fDCGxBusvbPSxVxstkzrS0F9/FjBHDW4zbMLudNn9i9TXx/uiuV+C9jGwdu2zRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725995765; c=relaxed/simple;
	bh=ENqsfC2AIXwZ7rYjQKdgaymmNFIejXxikgRDslPwSKU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdOpaM6b+FNB8Gbuq+M/elEn+6nQwk2dZI3Iqh8o7px+jX3Q4+U3ovRqvw4tBWFEYU69yNLB3OyZVcDUfNRIJ2ogTgvXea8+VyPbndyWQk0MCfsY5ZXzCAIB3NyCGEgTM0aq8W9/XlamGw6SHA2/pfQFipZm8K8wxhpcBuelwFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UQtIkJ3u; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UQtIkJ3u"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725995761;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ueb83hVIj3hVMTASy964Wv7fO6dBN/axyM8tuEYr7Bc=;
	b=UQtIkJ3uo1yugDBV/mmqHJScoLBJdvqzkbM5SjySRTd7iGEa0OdpbQbm2UJsA0lkE6ZEuj
	RlgmRijb0iunOVj6uaIyvvqCOdAz0BtV5jDjMiIEf1zH7koHTXbcAl8b/8AmzW1xMuWE1S
	2aI5mrpwZqmStmAL4IVB0EC90+y2+Qg=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-116-doxVM81dNx2G7XLtemTiQw-1; Tue,
 10 Sep 2024 15:15:59 -0400
X-MC-Unique: doxVM81dNx2G7XLtemTiQw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 9738F1955F28;
	Tue, 10 Sep 2024 19:15:56 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.17.222])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E8F6E30001A1;
	Tue, 10 Sep 2024 19:15:50 +0000 (UTC)
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
Subject: [PATCH v1 1/5] s390/kdump: implement is_kdump_kernel()
Date: Tue, 10 Sep 2024 21:15:35 +0200
Message-ID: <20240910191541.2179655-2-david@redhat.com>
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

s390x currently always results in is_kdump_kernel() == false, because
it sets "elfcorehdr_addr = ELFCORE_ADDR_MAX;" early during setup_arch to
deactivate the elfcorehdr= kernel parameter.

Let's follow the powerpc example and implement our own logic.

This is required for virtio-mem to reliably identify a kdump
environment to not try hotplugging memory.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/kexec.h | 4 ++++
 arch/s390/kernel/crash_dump.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 1bd08eb56d5f..bd20543515f5 100644
--- a/arch/s390/include/asm/kexec.h
+++ b/arch/s390/include/asm/kexec.h
@@ -94,6 +94,9 @@ void arch_kexec_protect_crashkres(void);
 
 void arch_kexec_unprotect_crashkres(void);
 #define arch_kexec_unprotect_crashkres arch_kexec_unprotect_crashkres
+
+bool is_kdump_kernel(void);
+#define is_kdump_kernel is_kdump_kernel
 #endif
 
 #ifdef CONFIG_KEXEC_FILE
@@ -107,4 +110,5 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 int arch_kimage_file_post_load_cleanup(struct kimage *image);
 #define arch_kimage_file_post_load_cleanup arch_kimage_file_post_load_cleanup
 #endif
+
 #endif /*_S390_KEXEC_H */
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index edae13416196..cca1827d3d2e 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -237,6 +237,12 @@ int remap_oldmem_pfn_range(struct vm_area_struct *vma, unsigned long from,
 						       prot);
 }
 
+bool is_kdump_kernel(void)
+{
+	return oldmem_data.start && !is_ipl_type_dump();
+}
+EXPORT_SYMBOL_GPL(is_kdump_kernel);
+
 static const char *nt_name(Elf64_Word type)
 {
 	const char *name = "LINUX";
-- 
2.46.0

