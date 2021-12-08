Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AC45C433F5
	for <linux-s390@archiver.kernel.org>; Wed,  8 Dec 2021 13:08:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbhLHNLk (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 8 Dec 2021 08:11:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:28104 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234091AbhLHNLk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Dec 2021 08:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638968887;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=03sgDYFz/V4VUoZE66+jxTqXY4QF2bhTETEilgmJmJM=;
        b=SWN7tCxeiCZkp/PSvtmMb4sJny6ndmoXzP7MWy0WuX1EesScLPX6GR9VFFL2/9odM/0cqV
        4AbnF7YgJEj9HQX96d3U4qKpIhK6i00zU8/853soxwgVjXg8D6+3ZiPYxNlfaS9SzM4vCg
        N/fzeefZF7U/yd5YvyIGGLM2Oo1GIxs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-525-RovD4xusMfSflOxQvcs_Mw-1; Wed, 08 Dec 2021 08:08:06 -0500
X-MC-Unique: RovD4xusMfSflOxQvcs_Mw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D7E810168C0;
        Wed,  8 Dec 2021 13:08:01 +0000 (UTC)
Received: from workhorse.redhat.com (unknown [10.39.193.100])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 1A9FA5C23A;
        Wed,  8 Dec 2021 13:07:59 +0000 (UTC)
From:   Philipp Rudo <prudo@redhat.com>
To:     linux-s390@vger.kernel.org
Cc:     hca@linux.ibm.com, egorenar@linux.ibm.com, ltao@redhat.com
Subject: [PATCH v3 1/2] s390/kexec_file: print some more error messages
Date:   Wed,  8 Dec 2021 14:07:40 +0100
Message-Id: <20211208130741.5821-2-prudo@redhat.com>
In-Reply-To: <20211208130741.5821-1-prudo@redhat.com>
References: <20211208130741.5821-1-prudo@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Be kind and give some more information on what went wrong.

Signed-off-by: Philipp Rudo <prudo@redhat.com>
---
 arch/s390/kernel/machine_kexec_file.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)

diff --git a/arch/s390/kernel/machine_kexec_file.c b/arch/s390/kernel/machine_kexec_file.c
index 9975ad200d74..a8bfa7c8cbba 100644
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
@@ -290,9 +292,16 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 				     const Elf_Shdr *relsec,
 				     const Elf_Shdr *symtab)
 {
+	const char *strtab, *name, *shstrtab;
+	const Elf_Shdr *sechdrs;
 	Elf_Rela *relas;
 	int i, r_type;
 
+	/* String & section header string table */
+	sechdrs = (void *)pi->ehdr + pi->ehdr->e_shoff;
+	strtab = (char *)pi->ehdr + sechdrs[symtab->sh_link].sh_offset;
+	shstrtab = (char *)pi->ehdr + sechdrs[pi->ehdr->e_shstrndx].sh_offset;
+
 	relas = (void *)pi->ehdr + relsec->sh_offset;
 
 	for (i = 0; i < relsec->sh_size / sizeof(*relas); i++) {
@@ -304,15 +313,27 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 		sym = (void *)pi->ehdr + symtab->sh_offset;
 		sym += ELF64_R_SYM(relas[i].r_info);
 
-		if (sym->st_shndx == SHN_UNDEF)
+		if (sym->st_name)
+			name = strtab + sym->st_name;
+		else
+			name = shstrtab + sechdrs[sym->st_shndx].sh_name;
+
+		if (sym->st_shndx == SHN_UNDEF) {
+			pr_err("Undefined symbol: %s\n", name);
 			return -ENOEXEC;
+		}
 
-		if (sym->st_shndx == SHN_COMMON)
+		if (sym->st_shndx == SHN_COMMON) {
+			pr_err("symbol '%s' in common section\n", name);
 			return -ENOEXEC;
+		}
 
 		if (sym->st_shndx >= pi->ehdr->e_shnum &&
-		    sym->st_shndx != SHN_ABS)
+		    sym->st_shndx != SHN_ABS) {
+			pr_err("Invalid section %d for symbol %s\n",
+			       sym->st_shndx, name);
 			return -ENOEXEC;
+		}
 
 		loc = pi->purgatory_buf;
 		loc += section->sh_offset;
-- 
2.31.1

