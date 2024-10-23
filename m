Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD79184556
	for <linux-s390@vger.kernel.org>; Wed, 23 Oct 2024 09:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674424; cv=none; b=TW7WygPAi7dcwsLa1MCjQMGoxvOBkYRdg9FfscHlvBWWS3muu2w2kB8uatdlvPjSVnDuly91AAmpApMnKgHFxdf/BwimzAJ1Pb3POZIdCF3U0XHJwkAqHXOPdl0UHjLyeBbMLu3fbkDnjUsDyfCkdxtfM0QwuXHyLry5TcsT+9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674424; c=relaxed/simple;
	bh=bjOJOfZfY/iX44yodp3Y3Csyso/TAeICAqN1lJoie78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gYwWpffr2s1hjKFfTmaReyC5kVjQCrUB1VhXIWI3Gsg5SOdBtiywKVSVQAq3RBxo9KzokwHXp7SYt6vj4vbgrH/ral2+DLl2cHrB4UQyMIXEMNW1RDtpkbRZu0qf+OAZcqNCoX9O4r+fgFgdRtCI3u1ZA9gPQExITjudVJ7GGwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=V9jkVcgE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="V9jkVcgE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729674421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rmnd9v0LSmhXFonF77TwYci6uZaGz+E2notKw0mY5v0=;
	b=V9jkVcgENVs3Y3SaO5/c7V59rbPE18rhZATlsowgH4GKUwcXgadUWO6NNTW1YBXuVn511I
	YgT2rG8rI+thHvG5VkVRnDNf0wF1kLXnGnzKE8YrEDYRi3ZeQrWUQBgstCCHyk23/6ARUm
	dBSXv4Fct55g63QbPax+v+EVxQkvgZw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-306-ej37Uap8NNKLQcT2wViX7g-1; Wed,
 23 Oct 2024 05:06:58 -0400
X-MC-Unique: ej37Uap8NNKLQcT2wViX7g-1
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 782CA1955D4E;
	Wed, 23 Oct 2024 09:06:56 +0000 (UTC)
Received: from t14s.fritz.box (unknown [10.22.88.10])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EEA221956089;
	Wed, 23 Oct 2024 09:06:52 +0000 (UTC)
From: David Hildenbrand <david@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org,
	David Hildenbrand <david@redhat.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3] s390/kdump: make is_kdump_kernel() consistently return "true" in kdump environments only
Date: Wed, 23 Oct 2024 11:06:51 +0200
Message-ID: <20241023090651.1115507-1-david@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

s390 sets "elfcorehdr_addr = ELFCORE_ADDR_MAX;" early during
setup_arch() to deactivate the "elfcorehdr= kernel" parameter, resulting in
is_kdump_kernel() returning "false".

During vmcore_init()->elfcorehdr_alloc(), if on a dump kernel and
allocation succeeded, elfcorehdr_addr will be set to a valid address and
is_kdump_kernel() will consequently return "true".

We want to make is_kdump_kernel() return a consistent result during
all boot stages, and properly return "true" if we are actually in a kdump
environment -- just like we already do on powerpc where we indicate "false"
in fadump environments, as added in commit b098f1c32365 ("powerpc/fadump:
make is_kdump_kernel() return false when fadump is active").

Similarly provide a custom is_kdump_kernel() implementation that will only
return "true" in kdump environments, and will do so consistently during
boot.

Update the documentation of is_dump_available().

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: David Hildenbrand <david@redhat.com>
---

This is v3 of [1], split out from the virtio-mem stuff.

I played more with having virtio-mem built in as a module on current
upstream and at least for virtio-mem this change *might* currently not be
required (built-in virtio-mem driver seems to get probed after fs_init();
I recall this behavior was different 4 years ago with my RFCs where I
first decided to craft this patch).

But this change sounds like a reasonable cleanup to me in any case.

v1 -> v2:
* Use "oldmem_data.start" and add a comment to is_kdump_kernel()
* Update dump_available() documentation
* Rewrote patch subject/description

[1] https://lore.kernel.org/all/20241014144622.876731-2-david@redhat.com/

---
 arch/s390/include/asm/kexec.h |  3 +++
 arch/s390/kernel/crash_dump.c | 11 +++++++++++
 arch/s390/kernel/smp.c        | 16 ++++++++--------
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/kexec.h b/arch/s390/include/asm/kexec.h
index 1bd08eb56d5f..9084b750350d 100644
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
diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index edae13416196..d9301c00852e 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -237,6 +237,17 @@ int remap_oldmem_pfn_range(struct vm_area_struct *vma, unsigned long from,
 						       prot);
 }
 
+/*
+ * Return true only when we are in a kdump or stand-alone kdump environment.
+ * Note that /proc/vmcore might also be available in "standard zfcp/nvme dump"
+ * environments, where this function returns false; see dump_available().
+ */
+bool is_kdump_kernel(void)
+{
+	return oldmem_data.start;
+}
+EXPORT_SYMBOL_GPL(is_kdump_kernel);
+
 static const char *nt_name(Elf64_Word type)
 {
 	const char *name = "LINUX";
diff --git a/arch/s390/kernel/smp.c b/arch/s390/kernel/smp.c
index 4df56fdb2488..455400bdafe8 100644
--- a/arch/s390/kernel/smp.c
+++ b/arch/s390/kernel/smp.c
@@ -574,7 +574,7 @@ int smp_store_status(int cpu)
 
 /*
  * Collect CPU state of the previous, crashed system.
- * There are four cases:
+ * There are three cases:
  * 1) standard zfcp/nvme dump
  *    condition: OLDMEM_BASE == NULL && is_ipl_type_dump() == true
  *    The state for all CPUs except the boot CPU needs to be collected
@@ -587,16 +587,16 @@ int smp_store_status(int cpu)
  *    with sigp stop-and-store-status. The firmware or the boot-loader
  *    stored the registers of the boot CPU in the absolute lowcore in the
  *    memory of the old system.
- * 3) kdump and the old kernel did not store the CPU state,
- *    or stand-alone kdump for DASD
- *    condition: OLDMEM_BASE != NULL && !is_kdump_kernel()
+ * 3) kdump or stand-alone kdump for DASD
+ *    condition: OLDMEM_BASE != NULL && !is_ipl_type_dump() == false
  *    The state for all CPUs except the boot CPU needs to be collected
  *    with sigp stop-and-store-status. The kexec code or the boot-loader
  *    stored the registers of the boot CPU in the memory of the old system.
- * 4) kdump and the old kernel stored the CPU state
- *    condition: OLDMEM_BASE != NULL && is_kdump_kernel()
- *    This case does not exist for s390 anymore, setup_arch explicitly
- *    deactivates the elfcorehdr= kernel parameter
+ *
+ * Note that the legacy kdump mode where the old kernel stored the CPU states
+ * does no longer exist: setup_arch() explicitly deactivates the elfcorehdr=
+ * kernel parameter. The is_kdump_kernel() implementation on s390 is independent
+ * of the elfcorehdr= parameter.
  */
 static bool dump_available(void)
 {
-- 
2.46.1

