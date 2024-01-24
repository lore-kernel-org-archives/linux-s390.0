Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD09FF9D7
	for <linux-s390@vger.kernel.org>; Wed, 24 Jan 2024 05:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706073216; cv=none; b=gt5O4JTlDxws1xyRpNPH39DQE5KjagdfioUyBSpfXz3tx9RvkC2R7ugwYQ+CUINnNNswnQEZp1UKuYmMgVlzPSa6FNF47jQFxBcjG3MtUHlriTc5hL76+amfe24FxJSW9ra5SuGn7bqLsjRwHU794HImg04MX8mBUW4yTUNsRU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706073216; c=relaxed/simple;
	bh=L5yLU/k0ooCkonbr++MBJfSm/8KCJJUj3iF2xt2fI+c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-type; b=KQbJacK+ZDg78UeQnufv4RKw+ob/3wauFAXRuuqZMOr+/L38Tbg//Z2O5MJj3V9KXn8aydRnXvjnMUmxrCgf839Jeelc8KOrHiKMJS3YFSBCXqYySER4echGJZiXA15uZJeHaKDjlOslyUJF02uXWkF5gkOIkP4B9MXy3vQuNNk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S5sYTH0O; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S5sYTH0O"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706073214;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7FwSShRxQ9Tdi9ry6e3sjt7QsULMQ9BLjdoZyBo73zI=;
	b=S5sYTH0OPNkLihRS0D51FhkexYmaTPJImf+8Ar9GxeVDBOuasskRZUqVQa+rxz0FwGRTh0
	1TvwVyqRTSKoIpqjQD/OAWl04S+3WcN0smDLVWGJKAXShxuhzYvaRu4ee/II49/kbO+fmU
	KEFUx2OF6/hNPMGmqRDz/aZqMG0eiCI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-407-oQQZMzQgMtGxveztjROlEA-1; Wed,
 24 Jan 2024 00:13:26 -0500
X-MC-Unique: oQQZMzQgMtGxveztjROlEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E193C28B6AA1;
	Wed, 24 Jan 2024 05:13:25 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (unknown [10.72.116.117])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 24AF51C060AF;
	Wed, 24 Jan 2024 05:13:18 +0000 (UTC)
From: Baoquan He <bhe@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: kexec@lists.infradead.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	loongarch@lists.linux.dev,
	akpm@linux-foundation.org,
	ebiederm@xmission.com,
	hbathini@linux.ibm.com,
	piliu@redhat.com,
	viro@zeniv.linux.org.uk,
	Baoquan He <bhe@redhat.com>
Subject: [PATCH linux-next v3 03/14] crash: remove dependency of FA_DUMP on CRASH_DUMP
Date: Wed, 24 Jan 2024 13:12:43 +0800
Message-ID: <20240124051254.67105-4-bhe@redhat.com>
In-Reply-To: <20240124051254.67105-1-bhe@redhat.com>
References: <20240124051254.67105-1-bhe@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

In kdump kernel, /proc/vmcore is an elf file mapping the crashed kernel's
old memory content. Its elf header is constructed in 1st kernel and passed
to kdump kernel via elfcorehdr_addr. Config CRASH_DUMP enables the code
of 1st kernel's old memory accessing in different architectures.

Currently, config FA_DUMP has dependency on CRASH_DUMP because fadump
needs access global variable 'elfcorehdr_addr' to judge if it's in
kdump kernel within function is_kdump_kernel(). In the current
kernel/crash_dump.c, variable 'elfcorehdr_addr' is defined, and function
setup_elfcorehdr() used to parse kernel parameter to fetch the passed
value of elfcorehdr_addr. Only for accessing elfcorehdr_addr, FA_DUMP
really doesn't have to depends on CRASH_DUMP.

To remove the dependency of FA_DUMP on CRASH_DUMP to avoid confusion,
rename kernel/crash_dump.c to kernel/elfcorehdr.c, and build it when
CONFIG_VMCORE_INFO is ebabled. With this, FA_DUMP doesn't need to depend
on CRASH_DUMP.

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 arch/powerpc/Kconfig                  | 1 -
 kernel/Makefile                       | 3 +--
 kernel/{crash_dump.c => elfcorehdr.c} | 0
 kernel/kexec_internal.h               | 2 ++
 4 files changed, 3 insertions(+), 3 deletions(-)
 rename kernel/{crash_dump.c => elfcorehdr.c} (100%)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 495d197c9b27..e66fd9923250 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -692,7 +692,6 @@ config FA_DUMP
 	depends on PPC64 && (PPC_RTAS || PPC_POWERNV)
 	select VMCORE_INFO
 	select CRASH_RESERVE
-	select CRASH_DUMP
 	help
 	  A robust mechanism to get reliable kernel crash dump with
 	  assistance from firmware. This approach does not use kexec,
diff --git a/kernel/Makefile b/kernel/Makefile
index 649272a1d6b9..35abc65e1f1a 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_MODULE_SIG_FORMAT) += module_signature.o
 obj-$(CONFIG_KALLSYMS) += kallsyms.o
 obj-$(CONFIG_KALLSYMS_SELFTEST) += kallsyms_selftest.o
 obj-$(CONFIG_BSD_PROCESS_ACCT) += acct.o
-obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o
+obj-$(CONFIG_VMCORE_INFO) += vmcore_info.o elfcorehdr.o
 obj-$(CONFIG_CRASH_RESERVE) += crash_reserve.o
 obj-$(CONFIG_KEXEC_CORE) += kexec_core.o crash_core.o
 obj-$(CONFIG_KEXEC) += kexec.o
@@ -121,7 +121,6 @@ obj-$(CONFIG_PERF_EVENTS) += events/
 
 obj-$(CONFIG_USER_RETURN_NOTIFIER) += user-return-notifier.o
 obj-$(CONFIG_PADATA) += padata.o
-obj-$(CONFIG_CRASH_DUMP) += crash_dump.o
 obj-$(CONFIG_JUMP_LABEL) += jump_label.o
 obj-$(CONFIG_CONTEXT_TRACKING) += context_tracking.o
 obj-$(CONFIG_TORTURE_TEST) += torture.o
diff --git a/kernel/crash_dump.c b/kernel/elfcorehdr.c
similarity index 100%
rename from kernel/crash_dump.c
rename to kernel/elfcorehdr.c
diff --git a/kernel/kexec_internal.h b/kernel/kexec_internal.h
index 74da1409cd14..2595defe8c0d 100644
--- a/kernel/kexec_internal.h
+++ b/kernel/kexec_internal.h
@@ -4,6 +4,8 @@
 
 #include <linux/kexec.h>
 
+struct kexec_segment;
+
 struct kimage *do_kimage_alloc_init(void);
 int sanity_check_segment_list(struct kimage *image);
 void kimage_free_page_list(struct list_head *list);
-- 
2.41.0

