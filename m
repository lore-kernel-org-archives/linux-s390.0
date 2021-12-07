Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD02C433FE
	for <linux-s390@archiver.kernel.org>; Tue,  7 Dec 2021 12:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbhLGNBg (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:01:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34679 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236679AbhLGNBf (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Dec 2021 08:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638881884;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31MTYU8aXEM5TbpS0TLPNjZHspRfGgNQU7IbkMweuUQ=;
        b=heEYBeBr/tnL0Kn2YxIJQnYO2LPhG/sdwhrTLgW5L49/EW409znqdvo9lwcHE18z0qI9tw
        Eidz746loFcZACv5iHKYb6CvOzb+yMHkWXRYXrDZtD9GzpR0Sgo41EQcmqmk2OKl5RmOOD
        pbvt/0HtGR5A/uDxdSEM99r3u+qQA54=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-123-1Z0FDvhDP2izBQAF0dBytg-1; Tue, 07 Dec 2021 07:58:01 -0500
X-MC-Unique: 1Z0FDvhDP2izBQAF0dBytg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B217F1012E48;
        Tue,  7 Dec 2021 12:58:00 +0000 (UTC)
Received: from workhorse.redhat.com (unknown [10.39.192.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 920F65D6BA;
        Tue,  7 Dec 2021 12:57:59 +0000 (UTC)
From:   Philipp Rudo <prudo@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     hca@linux.ibm.com, egorenar@linux.ibm.com, ltao@redhat.com
Subject: [PATCH v2 1/2] s390/kexec_file: print some more error messages
Date:   Tue,  7 Dec 2021 13:57:48 +0100
Message-Id: <20211207125749.6998-2-prudo@redhat.com>
In-Reply-To: <20211207125749.6998-1-prudo@redhat.com>
References: <20211207125749.6998-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Be kind and give some more information on what went wrong.

Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 9975ad200d74..b53fa670e289 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -7,6 +7,8 @@
  * Author(s): Philipp Rudo <prudo@linux.vnet.ibm.com>
  */
 
+#define pr_fmt(fmt)	"kexec: " fmt
+
 #include <linux/elf.h>
 #include <linux/errno.h>
 #include <linux/kexec.h>
@@ -304,15 +306,22 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		sym = (void *)pi->ehdr + symtab->sh_offset;
 		sym += ELF64_R_SYM(relas[i].r_info);
 
-		if (sym->st_shndx == SHN_UNDEF)
+		if (sym->st_shndx == SHN_UNDEF) {
+			pr_err("Undefined symbol\n");
 			return -ENOEXEC;
+		}
 
-		if (sym->st_shndx == SHN_COMMON)
+		if (sym->st_shndx == SHN_COMMON) {
+			pr_err("symbol in common section\n");
 			return -ENOEXEC;
+		}
 
 		if (sym->st_shndx >= pi->ehdr->e_shnum &&
-		    sym->st_shndx != SHN_ABS)
+		    sym->st_shndx != SHN_ABS) {
+			pr_err("Invalid section %d for symbol\n",
+			       sym->st_shndx);
 			return -ENOEXEC;
+		}
 
 		loc = pi->purgatory_buf;
 		loc += section->sh_offset;
-- 
2.31.1

