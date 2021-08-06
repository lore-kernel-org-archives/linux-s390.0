Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC9FC4338F
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 07:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92217610FC
	for <linux-s390@archiver.kernel.org>; Fri,  6 Aug 2021 07:54:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235850AbhHFHyz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 6 Aug 2021 03:54:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:58219 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231681AbhHFHyz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 6 Aug 2021 03:54:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628236479;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=82v8k5WCytfnknqaYr9f7tqs0sfjvgXeF/7J0N8OftI=;
        b=SRNePBXJgZaW5XXaKV+tkqAOt3j2+UmwzrzheXSW+kzwYbpURY6/MQEyH0xDvSXD0ZqcN9
        rYOXnSEvHCH1kynSq7oFaDcbqD/G7q2rqXNABEJqwvK2/eLuRKTKjiuKyLQL+VHVPMYcUA
        HB+logFPT4ssyRnk3aMSeqQW7t8GwiI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-445-rtPZvFOKPueb6w-bzLMvEA-1; Fri, 06 Aug 2021 03:54:38 -0400
X-MC-Unique: rtPZvFOKPueb6w-bzLMvEA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11144801AE7;
        Fri,  6 Aug 2021 07:54:37 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.192.224])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BA87C19C44;
        Fri,  6 Aug 2021 07:54:31 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     David Hildenbrand <david@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH v1] s390/mm: remove unused cmma functions
Date:   Fri,  6 Aug 2021 09:54:30 +0200
Message-Id: <20210806075430.6103-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The last user of arch_set_page_states(), arch_set_page_nodat() and
arch_test_page_nodat() was removed in commit 394216275c7d
("s390: remove broken hibernate / power management support"),
let's remove these functions.

Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/page.h |  3 ---
 arch/s390/mm/page-states.c   | 43 ------------------------------------
 2 files changed, 46 deletions(-)

diff --git a/arch/s390/include/asm/page.h b/arch/s390/include/asm/page.h
index 3ba945c6b9dc..d98d17a36c7b 100644
--- a/arch/s390/include/asm/page.h
+++ b/arch/s390/include/asm/page.h
@@ -144,9 +144,6 @@ struct page;
 void arch_free_page(struct page *page, int order);
 void arch_alloc_page(struct page *page, int order);
 void arch_set_page_dat(struct page *page, int order);
-void arch_set_page_nodat(struct page *page, int order);
-int arch_test_page_nodat(struct page *page);
-void arch_set_page_states(int make_stable);
 
 static inline int devmem_is_allowed(unsigned long pfn)
 {
diff --git a/arch/s390/mm/page-states.c b/arch/s390/mm/page-states.c
index 68b153083a92..18a6381097a9 100644
--- a/arch/s390/mm/page-states.c
+++ b/arch/s390/mm/page-states.c
@@ -228,46 +228,3 @@ void arch_set_page_dat(struct page *page, int order)
 		return;
 	set_page_stable_dat(page, order);
 }
-
-void arch_set_page_nodat(struct page *page, int order)
-{
-	if (cmma_flag < 2)
-		return;
-	set_page_stable_nodat(page, order);
-}
-
-int arch_test_page_nodat(struct page *page)
-{
-	unsigned char state;
-
-	if (cmma_flag < 2)
-		return 0;
-	state = get_page_state(page);
-	return !!(state & 0x20);
-}
-
-void arch_set_page_states(int make_stable)
-{
-	unsigned long flags, order, t;
-	struct list_head *l;
-	struct page *page;
-	struct zone *zone;
-
-	if (!cmma_flag)
-		return;
-	if (make_stable)
-		drain_local_pages(NULL);
-	for_each_populated_zone(zone) {
-		spin_lock_irqsave(&zone->lock, flags);
-		for_each_migratetype_order(order, t) {
-			list_for_each(l, &zone->free_area[order].free_list[t]) {
-				page = list_entry(l, struct page, lru);
-				if (make_stable)
-					set_page_stable_dat(page, order);
-				else
-					set_page_unused(page, order);
-			}
-		}
-		spin_unlock_irqrestore(&zone->lock, flags);
-	}
-}

base-commit: c500bee1c5b2f1d59b1081ac879d73268ab0ff17
-- 
2.31.1

