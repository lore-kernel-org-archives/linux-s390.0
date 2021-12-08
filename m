Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28D94C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 13:08:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbhLHNLi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 08:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36493 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232257AbhLHNLh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Dec 2021 08:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638968885;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dab8i9c1IsrPkMoR7Z+Ark+53poKm1dvl8GQwBnmqnc=;
        b=M0G653fTObeAQyGLhPayDCexeEkYNAqJPybUhtZb5Gp7Z5nKGIZE07X0+O5kT/v4MDDWH+
        3hrnk94HYg+YgV8XdcioEMBtq28NvRuOngej2swt7dKbz/FMoibDAiyTYHTJ3XkG/O47nk
        GvElhFCy+RVSnk+W2PHiQPSBjrvhEvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-500-fLHFu7A-NaWisuN8IeVRVg-1; Wed, 08 Dec 2021 08:08:04 -0500
X-MC-Unique: fLHFu7A-NaWisuN8IeVRVg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6FF74801AAB;
        Wed,  8 Dec 2021 13:08:03 +0000 (UTC)
Received: from workhorse.redhat.com (unknown [10.39.193.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 880755C23A;
        Wed,  8 Dec 2021 13:08:01 +0000 (UTC)
From:   Philipp Rudo <prudo@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     hca@linux.ibm.com, egorenar@linux.ibm.com, ltao@redhat.com
Subject: [PATCH v3 2/2] s390/kexec_file: fix error handling when applying relocations
Date:   Wed,  8 Dec 2021 14:07:41 +0100
Message-Id: <20211208130741.5821-3-prudo@redhat.com>
In-Reply-To: <20211208130741.5821-1-prudo@redhat.com>
References: <20211208130741.5821-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

arch_kexec_apply_relocations_add currently ignores all errors returned
by arch_kexec_do_relocs. This means that every unknown relocation is
silently skipped causing unpredictable behavior while the relocated code
runs. Fix this by checking for errors and fail kexec_file_load if an
unknown relocation type is encountered.

The problem was found after gcc changed its behavior and used
R_390_PLT32DBL relocations for brasl instruction and relied on ld to
resolve the relocations in the final link in case direct calls are
possible. As the purgatory code is only linked partially (option -r)
ld didn't resolve the relocations leaving them for arch_kexec_do_relocs.
But arch_kexec_do_relocs doesn't know how to handle R_390_PLT32DBL
relocations so they were silently skipped. This ultimately caused an
endless loop in the purgatory as the brasl instructions kept branching
to itself.

Fixes: 71406883fd35 ("s390/kexec_file: Add kexec_file_load system call")
Reported-by: Tao Liu <ltao@redhat.com>
Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index a8bfa7c8cbba..876cdd3c994e 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -296,6 +296,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 	const Elf_Shdr *sechdrs;
 	Elf_Rela *relas;
 	int i, r_type;
+	int ret;
 
 	/* String & section header string table */
 	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
@@ -347,7 +348,11 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		addr = section->sh_addr + relas[i].r_offset;
 
 		r_type = ELF64_R_TYPE(relas[i].r_info);
-		arch_kexec_do_relocs(r_type, loc, val, addr);
+		ret = arch_kexec_do_relocs(r_type, loc, val, addr);
+		if (ret) {
+			pr_err("Unknown rela relocation: %d\n", r_type);
+			return -ENOEXEC;
+		}
 	}
 	return 0;
 }
-- 
2.31.1

