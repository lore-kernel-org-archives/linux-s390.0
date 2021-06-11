Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D376C48BD1
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 18:04:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F3B613D3
	for <linux-s390@archiver.kernel.org>; Fri, 11 Jun 2021 18:04:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhFKSG1 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 11 Jun 2021 14:06:27 -0400
Received: from mail-wr1-f48.google.com ([209.85.221.48]:43674 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231574AbhFKSGF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 11 Jun 2021 14:06:05 -0400
Received: by mail-wr1-f48.google.com with SMTP id r9so6949823wrz.10
        for <linux-s390@vger.kernel.org>; Fri, 11 Jun 2021 11:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=XlYSDT++/absff5COsQ6B7Y0tXIHpiPptSjx0mpHRxI=;
        b=btVW4wIMjalC0fUj2njoR7a+JHacTI0BaLJpL5RfRCiJ1LAE/7YB+Kvfof/hNx0dYx
         sBfDFEijp3TCFUINSRAOxr/aU6RAmYh9J0nxRrOBz7q155fAWH+lZiofymIVDNw1OoU7
         q0mICv47D/YSXfOQ/m7f4hCthsRU6RHuRDBznPBo/bqW619zumRRtyvAdCIdbVaW0can
         7KErFYU/vJBrBhCv7fJ+Q2o1Mh4LLbpUR+q8NUellGfRACUOg37g+G/AsBFsCBPcFb5A
         RdCfPTVnqtPvMP+Yr0Ced2YPxQnOMcibkXAX6KGusLJWiuhn2UW3LJ9ivp2xK5SPMM60
         fB2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=XlYSDT++/absff5COsQ6B7Y0tXIHpiPptSjx0mpHRxI=;
        b=k4D2+yU9AZi+W/NCBZWcyC0LoUmtB0uylnpRuE332sYx1wj+Vcs5tTzmr4S3qTd/1H
         5jFDVZfa3REfAy9i5SY82uUvYpCGsEuojsXBZ0xkYivAft8d62H438QijwVNv1L3M9Yn
         ko+B56s4/Eh9a5dW6z2HgRiQ6ft6coc8oYT02H5qLYuODgU7uydTEczzKXHjTSNRn0Rg
         JkR4OhsgLCmoPKt1PfUlwWAaNZnElkB5my7JO8y4+wDuc+PRhClIEdcwSm6r5hsq7wT6
         pCVO2nL+bwZeEHTZfdO3SJyRUxynzO3g9DChBDMKSsaykgAyNH8tOdRmDnESZrzQQ4yu
         BL7g==
X-Gm-Message-State: AOAM531TMlv+8deykePNgJ0QAbnREwkTnSF/4YNKzU55l60pYFZatKCu
        TAATrC3DwvIa32XCWjjgq4pdBw==
X-Google-Smtp-Source: ABdhPJxdCizfUAbvJRy2W+CLRyh15TzcCFEXaxy3xl5zN8gl5YG1Gpn2q6+dFq/jN/SkTGEy6Nredg==
X-Received: by 2002:adf:e5c1:: with SMTP id a1mr5470223wrn.16.1623434586769;
        Fri, 11 Jun 2021 11:03:06 -0700 (PDT)
Received: from localhost.localdomain ([2a02:8084:e84:2480:228:f8ff:fe6f:83a8])
        by smtp.gmail.com with ESMTPSA id v15sm7425881wrw.24.2021.06.11.11.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Jun 2021 11:03:06 -0700 (PDT)
From:   Dmitry Safonov <dima@arista.com>
To:     linux-kernel@vger.kernel.org
Cc:     Dmitry Safonov <0x7f454c46@gmail.com>,
        Dmitry Safonov <dima@arista.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Ingo Molnar <mingo@redhat.com>,
        Oleg Nesterov <oleg@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Will Deacon <will@kernel.org>, x86@kernel.org,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v3 11/23] s390/vdso: Remove vdso_base pointer from mm->context
Date:   Fri, 11 Jun 2021 19:02:30 +0100
Message-Id: <20210611180242.711399-12-dima@arista.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210611180242.711399-1-dima@arista.com>
References: <20210611180242.711399-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Not used any more: now sysinfo_ehdr is passed back from
arch_setup_additional_pages() to set AT_SYSINFO_EHDR tag.
.vdso_mremap() was only to track proper position of context.vdso
throughout any mremap() syscalls, remove it too.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/s390/include/asm/mmu.h | 1 -
 arch/s390/kernel/vdso.c     | 9 ---------
 2 files changed, 10 deletions(-)

diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
index e12ff0f29d1a..095d0596f700 100644
--- a/arch/s390/include/asm/mmu.h
+++ b/arch/s390/include/asm/mmu.h
@@ -15,7 +15,6 @@ typedef struct {
 	unsigned long gmap_asce;
 	unsigned long asce;
 	unsigned long asce_limit;
-	unsigned long vdso_base;
 	/* The mmu context belongs to a secure guest. */
 	atomic_t is_protected;
 	/*
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 8a72fdedbae9..b8fb43d3b657 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -143,13 +143,6 @@ static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
 	return vmf_insert_pfn(vma, vmf->address, pfn);
 }
 
-static int vdso_mremap(const struct vm_special_mapping *sm,
-		       struct vm_area_struct *vma)
-{
-	current->mm->context.vdso_base = vma->vm_start;
-	return 0;
-}
-
 static struct vm_special_mapping vvar_mapping = {
 	.name = "[vvar]",
 	.fault = vvar_fault,
@@ -157,7 +150,6 @@ static struct vm_special_mapping vvar_mapping = {
 
 static struct vm_special_mapping vdso_mapping = {
 	.name = "[vdso]",
-	.mremap = vdso_mremap,
 };
 
 int vdso_getcpu_init(void)
@@ -203,7 +195,6 @@ int arch_setup_additional_pages(unsigned long *sysinfo_ehdr)
 		do_munmap(mm, vvar_start, PAGE_SIZE, NULL);
 		rc = PTR_ERR(vma);
 	} else {
-		current->mm->context.vdso_base = vdso_text_start;
 		*sysinfo_ehdr = vdso_text_start;
 		rc = 0;
 	}
-- 
2.31.1

