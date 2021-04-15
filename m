Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06EADC43460
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 17:18:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB3A5611BF
	for <linux-s390@archiver.kernel.org>; Thu, 15 Apr 2021 17:18:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234405AbhDORSp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 15 Apr 2021 13:18:45 -0400
Received: from pegase1.c-s.fr ([93.17.236.30]:15894 "EHLO pegase1.c-s.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234068AbhDORSm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 15 Apr 2021 13:18:42 -0400
Received: from localhost (mailhub1-int [192.168.12.234])
        by localhost (Postfix) with ESMTP id 4FLmJV2HD4z9twp2;
        Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
        by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
        with ESMTP id sbTtLwb0wT4h; Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
        by pegase1.c-s.fr (Postfix) with ESMTP id 4FLmJV1TDDz9twp0;
        Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id 080EE8B805;
        Thu, 15 Apr 2021 19:18:18 +0200 (CEST)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
        by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
        with ESMTP id 0MknObgQkv_3; Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
Received: from po16121vm.idsi0.si.c-s.fr (unknown [192.168.4.90])
        by messagerie.si.c-s.fr (Postfix) with ESMTP id B838C8B7F6;
        Thu, 15 Apr 2021 19:18:17 +0200 (CEST)
Received: by po16121vm.idsi0.si.c-s.fr (Postfix, from userid 0)
        id 96B23679F6; Thu, 15 Apr 2021 17:18:17 +0000 (UTC)
Message-Id: <f41a177a0fd5a71db616e586a9ec5c51102c6656.1618506910.git.christophe.leroy@csgroup.eu>
In-Reply-To: <cover.1618506910.git.christophe.leroy@csgroup.eu>
References: <cover.1618506910.git.christophe.leroy@csgroup.eu>
From:   Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 4/5] mm: ptdump: Support hugepd table entries
To:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Steven Price <steven.price@arm.com>, akpm@linux-foundation.org
Cc:     linux-arch@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org, x86@kernel.org, linux-mm@kvack.org
Date:   Thu, 15 Apr 2021 17:18:17 +0000 (UTC)
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Which hugepd, page table entries can be at any level
and can be of any size.

Add support for them.

Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 mm/ptdump.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/mm/ptdump.c b/mm/ptdump.c
index 61cd16afb1c8..6efdb8c15a7d 100644
--- a/mm/ptdump.c
+++ b/mm/ptdump.c
@@ -112,11 +112,24 @@ static int ptdump_pte_entry(pte_t *pte, unsigned long addr,
 {
 	struct ptdump_state *st = walk->private;
 	pte_t val = ptep_get(pte);
+	unsigned long page_size = next - addr;
+	int level;
+
+	if (page_size >= PGDIR_SIZE)
+		level = 0;
+	else if (page_size >= P4D_SIZE)
+		level = 1;
+	else if (page_size >= PUD_SIZE)
+		level = 2;
+	else if (page_size >= PMD_SIZE)
+		level = 3;
+	else
+		level = 4;
 
 	if (st->effective_prot)
-		st->effective_prot(st, 4, pte_val(val));
+		st->effective_prot(st, level, pte_val(val));
 
-	st->note_page(st, addr, 4, pte_val(val), PAGE_SIZE);
+	st->note_page(st, addr, level, pte_val(val), page_size);
 
 	return 0;
 }
-- 
2.25.0

