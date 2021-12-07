Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D54C4332F
	for <linux-s390@archiver.kernel.org>; Tue,  7 Dec 2021 12:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236697AbhLGNBh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 7 Dec 2021 08:01:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49370 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236679AbhLGNBg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 7 Dec 2021 08:01:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638881886;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C/boykOtFHls27QHIueJTq3Uru1YFDQEsfx09mb3B7g=;
        b=gqAdRxoiPHgoaAcZ6XcusEIijxhoZyuNgHJBoUq4l8qXcxTGDvCi0MpqQGvJF1mVkhmSM5
        Q2nOJDAkfxGhsAoAPkcI2Rck5jr2UbjmE3hMwhU5t+8blzUfcAE98oXfY2RNN2cgNnvwBY
        LweXsRDbyAnGzGBaXmSm/kGH76JpiQQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-kmvDt6YJNFugGS_sSIfROQ-1; Tue, 07 Dec 2021 07:58:03 -0500
X-MC-Unique: kmvDt6YJNFugGS_sSIfROQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 29B1A8015B7;
        Tue,  7 Dec 2021 12:58:02 +0000 (UTC)
Received: from workhorse.redhat.com (unknown [10.39.192.196])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 069C05D6BA;
        Tue,  7 Dec 2021 12:58:00 +0000 (UTC)
From:   Philipp Rudo <prudo@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     hca@linux.ibm.com, egorenar@linux.ibm.com, ltao@redhat.com
Subject: [PATCH v2 2/2] s390/kexec_file: fix error handling when applying relocations
Date:   Tue,  7 Dec 2021 13:57:49 +0100
Message-Id: <20211207125749.6998-3-prudo@redhat.com>
In-Reply-To: <20211207125749.6998-1-prudo@redhat.com>
References: <20211207125749.6998-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
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
index b53fa670e289..5e1da2e67cb7 100644
--- a/arch/s390/kernel/machine_kexec_file.c
+++ b/arch/s390/kernel/machine_kexec_file.c
@@ -294,6 +294,7 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 {
 	Elf_Rela *relas;
 	int i, r_type;
+	int ret;
 
 	relas = (void *)pi->ehdr + relsec->sh_offset;
 
@@ -335,7 +336,11 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
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

