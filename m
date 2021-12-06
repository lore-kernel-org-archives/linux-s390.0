Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF064C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  6 Dec 2021 11:21:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242310AbhLFLYc (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 6 Dec 2021 06:24:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:38660 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234845AbhLFLYc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 6 Dec 2021 06:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638789663;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ytiYUZiUAl3XzYzKoxgy0DHWMe1jgwOq0oJOPFaozMI=;
        b=K8LJqKw+KEhvuctoGtLuVA16i0naHaNTlhNxOU+U1NtdHESFXb9xv8yh6wyLznyvKFJTNL
        LtFhl+PgvJDKIEP9DxxlTL7BBYZhM2PuMHsE9/8vQ8j6qy6ZHWybGNny6OHSkYkLJc1o01
        En8L7iHRmVqlB8XXhgVCoOh2ZxJ9r6U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-452-C8hUqYlkNIWgCq3wxztYFw-1; Mon, 06 Dec 2021 06:20:59 -0500
X-MC-Unique: C8hUqYlkNIWgCq3wxztYFw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A849681EE6F;
        Mon,  6 Dec 2021 11:20:58 +0000 (UTC)
Received: from workhorse.redhat.com (unknown [10.39.194.234])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 36E335BAE2;
        Mon,  6 Dec 2021 11:20:50 +0000 (UTC)
From:   Philipp Rudo <prudo@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     egorenar@linux.ibm.com, ltao@redhat.com
Subject: [PATCH] s390/kexec_file: fix error handling when applying relocations
Date:   Mon,  6 Dec 2021 12:20:47 +0100
Message-Id: <20211206112047.4746-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
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
 arch/s390/kernel/machine_kexec_file.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 9975ad200d74..0e1d646207dc 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -292,6 +292,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 {
 	Elf_Rela *relas;
 	int i, r_type;
+	int ret;
 
 	relas = (void *)pi->ehdr + relsec->sh_offset;
 
@@ -326,7 +327,9 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		addr = section->sh_addr + relas[i].r_offset;
 
 		r_type = ELF64_R_TYPE(relas[i].r_info);
-		arch_kexec_do_relocs(r_type, loc, val, addr);
+		ret = arch_kexec_do_relocs(r_type, loc, val, addr);
+		if (ret)
+			return -EINVAL;
 	}
 	return 0;
 }
-- 
2.31.1

