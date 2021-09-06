Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA521C43219
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 01:23:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E5B610E7
	for <linux-s390@archiver.kernel.org>; Mon,  6 Sep 2021 01:23:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239809AbhIFBY7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 5 Sep 2021 21:24:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38982 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S239808AbhIFBXy (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Sun, 5 Sep 2021 21:23:54 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 22186610A1;
        Mon,  6 Sep 2021 01:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630891307;
        bh=qAskCBBpKq/zf9yjTKNuIJvUaCw27lib7tPv62mN0jI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=BgbDl2mQb7YH5PwSkiMv7uWcasXgOmKiN5v3bPrk+rQcpvbNW7KMyzNch3g9ZiUPh
         2IiVdx3pJ6sEU4j74HaS3xGE3R94Clz+Yy4cXgIyCkKgft5NVYAM18DSm/+TSzfon0
         Dlo6NL9bQmVg0RkefEr+lUcZaxlyH8m8xRMsB0Ry9L2TUQ1nd7k9Z2QDcTZ2llAmHl
         0UZpqEhiojolWanhZ2gwvhm9cnHUZmiG4wz1Le58QOrAk63YuWbY7ddSgdz5Jh905O
         fVaHqIk/9pbQ9kp8vWxKpJORtJpBxGtLLMY/ZvGcTaAxZxypQX0+H805nFqtzLkbkd
         8hnsQeaGWcDwA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Sasha Levin <sashal@kernel.org>, kasan-dev@googlegroups.com,
        linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 5.13 42/46] s390/kasan: fix large PMD pages address alignment check
Date:   Sun,  5 Sep 2021 21:20:47 -0400
Message-Id: <20210906012052.929174-42-sashal@kernel.org>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210906012052.929174-1-sashal@kernel.org>
References: <20210906012052.929174-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Alexander Gordeev <agordeev@linux.ibm.com>

[ Upstream commit ddd63c85ef67ea9ea7282ad35eafb6568047126e ]

It is currently possible to initialize a large PMD page when
the address is not aligned on page boundary.

Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/s390/mm/kasan_init.c | 41 +++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 21 deletions(-)

diff --git a/arch/s390/mm/kasan_init.c b/arch/s390/mm/kasan_init.c
index db4d303aaaa9..d7fcfe97d168 100644
--- a/arch/s390/mm/kasan_init.c
+++ b/arch/s390/mm/kasan_init.c
@@ -108,6 +108,9 @@ static void __init kasan_early_pgtable_populate(unsigned long address,
 		sgt_prot &= ~_SEGMENT_ENTRY_NOEXEC;
 	}
 
+	/*
+	 * The first 1MB of 1:1 mapping is mapped with 4KB pages
+	 */
 	while (address < end) {
 		pg_dir = pgd_offset_k(address);
 		if (pgd_none(*pg_dir)) {
@@ -158,30 +161,26 @@ static void __init kasan_early_pgtable_populate(unsigned long address,
 
 		pm_dir = pmd_offset(pu_dir, address);
 		if (pmd_none(*pm_dir)) {
-			if (mode == POPULATE_ZERO_SHADOW &&
-			    IS_ALIGNED(address, PMD_SIZE) &&
+			if (IS_ALIGNED(address, PMD_SIZE) &&
 			    end - address >= PMD_SIZE) {
-				pmd_populate(&init_mm, pm_dir,
-						kasan_early_shadow_pte);
-				address = (address + PMD_SIZE) & PMD_MASK;
-				continue;
-			}
-			/* the first megabyte of 1:1 is mapped with 4k pages */
-			if (has_edat && address && end - address >= PMD_SIZE &&
-			    mode != POPULATE_ZERO_SHADOW) {
-				void *page;
-
-				if (mode == POPULATE_ONE2ONE) {
-					page = (void *)address;
-				} else {
-					page = kasan_early_alloc_segment();
-					memset(page, 0, _SEGMENT_SIZE);
+				if (mode == POPULATE_ZERO_SHADOW) {
+					pmd_populate(&init_mm, pm_dir, kasan_early_shadow_pte);
+					address = (address + PMD_SIZE) & PMD_MASK;
+					continue;
+				} else if (has_edat && address) {
+					void *page;
+
+					if (mode == POPULATE_ONE2ONE) {
+						page = (void *)address;
+					} else {
+						page = kasan_early_alloc_segment();
+						memset(page, 0, _SEGMENT_SIZE);
+					}
+					pmd_val(*pm_dir) = __pa(page) | sgt_prot;
+					address = (address + PMD_SIZE) & PMD_MASK;
+					continue;
 				}
-				pmd_val(*pm_dir) = __pa(page) | sgt_prot;
-				address = (address + PMD_SIZE) & PMD_MASK;
-				continue;
 			}
-
 			pt_dir = kasan_early_pte_alloc();
 			pmd_populate(&init_mm, pm_dir, pt_dir);
 		} else if (pmd_large(*pm_dir)) {
-- 
2.30.2

