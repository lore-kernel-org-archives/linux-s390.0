Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B801CC04FF3
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 12:39:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 976BB613AD
	for <linux-s390@archiver.kernel.org>; Mon, 24 May 2021 12:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232782AbhEXMlD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 24 May 2021 08:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232851AbhEXMlC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 24 May 2021 08:41:02 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEFD3C061756;
        Mon, 24 May 2021 05:39:32 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id t21so14577628plo.2;
        Mon, 24 May 2021 05:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=WwZui2MaZsnR+vM9vgh9iCZJyd0Mb93BubAPUl4Tlxg=;
        b=k22zGg/94SCIBf2K3/i5x1KCfj/1eRtgJBhL7jpAv/Yw5q7fvMsyfDH8zznBjB7pHE
         HTjPUQLG7cPYgeOmf+lVYL7uRdKlrpXE8+HWEvEVVGEY54oJZKSEVw/8mK79bTWWpJ4D
         EyVg6Kl24+LLtiDhFGv6CxtRjRDKb7OyqRMIFsWjM9YgL3+ReT8pWY/4Baf2Z6aSegv4
         /N6twfmOME+cx383EbbZrMtWylg+sNnEc0QhFonZdPQaObNOMenF+uG9Qi+RLC5mvxUw
         lwGK22pFl3m5C3fPEu0WJZJAdYU+MflykgZjw1eSpDWriIRkijvw8gXPDZKmv9nootoU
         XfjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=WwZui2MaZsnR+vM9vgh9iCZJyd0Mb93BubAPUl4Tlxg=;
        b=jS+c/U1hL36zZkReZrs/FJ1zImP8stdMIizxDYaTSTIi9/gvfWR+P8aJRCu1wZUUGd
         YbS9RNlW0bUgi6HJHp93ja4JorUilljmqZndcHNVU0onXMPpB4qV8F4dcOwdvWW+8UHy
         7vlgMJQx9zLtRhwqfd2Z978LGHQNGO/qjaRc/k7qcCrH0adiHHt0KrUFyHpj5iy3USr2
         yfYIvkoHWHCjk2VDDeLAeU5r2LLDP03yWboMllQphg2JeLx0mLGdJoFeLkbqPtpM92+l
         q4hD+TS5w5RhZROtjm3txfgYfL/pafTHJx+mGE7e5sih576/FbEsnWr/f08DLl2FCxVg
         hvsw==
X-Gm-Message-State: AOAM533PSoZEC2TD3KLZ/yOoa6Gtxm2IjxXM76QOTXDa4io1UsXtsd3E
        4kpve/ma2kOlGKYs+Bu3bnU=
X-Google-Smtp-Source: ABdhPJzxHWx9lUBj5R0wGlHmcztVp2sGszwW7UJ+Qr12AETjdNJmGux1sBfwGPTlruttWGc6fNVumw==
X-Received: by 2002:a17:902:222:b029:f5:c251:a6ad with SMTP id 31-20020a1709020222b02900f5c251a6admr23465803plc.84.1621859972436;
        Mon, 24 May 2021 05:39:32 -0700 (PDT)
Received: from sz-dl-056.autox.sz ([45.67.53.159])
        by smtp.gmail.com with ESMTPSA id v3sm3413663pfb.203.2021.05.24.05.39.28
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 May 2021 05:39:32 -0700 (PDT)
From:   Yejune Deng <yejune.deng@gmail.com>
X-Google-Original-From: Yejune Deng <yejunedeng@gmail.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com,
        tglx@linutronix.de, keescook@chromium.org
Cc:     linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Yejune Deng <yejunedeng@gmail.com>
Subject: [PATCH] softirq/s390: Use the generic local_softirq_pending()
Date:   Mon, 24 May 2021 20:39:17 +0800
Message-Id: <1621859957-4880-1-git-send-email-yejunedeng@gmail.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Defined local_softirq_pending_ref macro and get rid of {local, set, or}
_softirq_pending macros. use {local, set, or}_softirq_pending
in <linux/interrupt.h> that rely on per-CPU mutators.

Signed-off-by: Yejune Deng <yejunedeng@gmail.com>
---
 arch/s390/include/asm/hardirq.h | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/hardirq.h b/arch/s390/include/asm/hardirq.h
index 58668ff..ea643d6 100644
--- a/arch/s390/include/asm/hardirq.h
+++ b/arch/s390/include/asm/hardirq.h
@@ -13,9 +13,7 @@
 
 #include <asm/lowcore.h>
 
-#define local_softirq_pending() (S390_lowcore.softirq_pending)
-#define set_softirq_pending(x) (S390_lowcore.softirq_pending = (x))
-#define or_softirq_pending(x)  (S390_lowcore.softirq_pending |= (x))
+#define local_softirq_pending_ref  S390_lowcore.softirq_pending
 
 #define __ARCH_IRQ_STAT
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED
-- 
2.7.4

