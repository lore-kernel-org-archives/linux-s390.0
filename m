Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A8DC433EF
	for <linux-s390@archiver.kernel.org>; Wed,  3 Nov 2021 05:56:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DA5C61139
	for <linux-s390@archiver.kernel.org>; Wed,  3 Nov 2021 05:56:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230025AbhKCF7J (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 3 Nov 2021 01:59:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbhKCF7I (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 3 Nov 2021 01:59:08 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23B04C061714;
        Tue,  2 Nov 2021 22:56:33 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id t21so1755067plr.6;
        Tue, 02 Nov 2021 22:56:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7wqUhnpf2ljLZMeYQek9+0eByVdd6mRp60BpbWMryQ=;
        b=XzTUj8/oGxrAKfnwYmCHaL/KD+jX69gDINS4NSle1ndT6Xq4/AYSM21Z+wmrlprrJb
         9d7dumUxZSWpVmZBdnLV8U7V3m51gFSfAdnJETX2h3kpLDan9YbS+BHBM6Tjkiog3pgC
         4KWmz73c+mgPVyEUy9KJiz9cNSekXe2/SSbA5gxmTzYLOt0xn5ixuW+fjtrzMPubJ+1z
         uCUVGleLmqTuXZN47TikvAvxTa5wDJN4FrPxITpC8Jwfq6/r0mJiWOxqYtan5m1Mn4uQ
         Tr/MMwR+xHeG/aohJNxMWLmBznxBUd7v2I+IVfMc3fKQRlv9FndwEPgHdoY5tnXEK9YD
         CiXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=t7wqUhnpf2ljLZMeYQek9+0eByVdd6mRp60BpbWMryQ=;
        b=seeIDuRFcIo7pdZcxgMVyDK2VRBIr1LrIydfxWRSPQ7JGZlhGo06OF+cBJe33MrzHP
         NYPfhiUKt7ej10O/8KOEdOuWV1FHB7Wp4EcOtjy/wvfkZoJ6PqwLMPnak+MXBYTHl16a
         CXuEoeuoWELsdyOvqLn+yMcdqcQF37i9tOZ8mccJV08l2tLqHE2+HzgZLf6nW9Yvhci9
         xwXj8ggBqQsNLLI6/ViegUYJa16+3+cnHkF/VmDttMfIkgKRylURYDjtSvKGvE8NRnRe
         Fuc6ocUxButz9s0cv2UrKUL1uGAHIGfwpqjr2czztr6YvrsUPytGZse5k7cM+yJCR4eY
         HGhw==
X-Gm-Message-State: AOAM530bK2nEmImm4tEBtZU6wjNHX3JBIAHzTSt/+F6+sNGvfAjyh3RR
        f3q7+kAqTY3tSllNHvsx//Q=
X-Google-Smtp-Source: ABdhPJxTYnso3yZFt5DzHIUepYTD790GmzbWpUZ4pmudKFR/c2QWl9USJ+rf7FL55iu2Ta6Zu3Yc4Q==
X-Received: by 2002:a17:90a:9915:: with SMTP id b21mr12072347pjp.195.1635918992254;
        Tue, 02 Nov 2021 22:56:32 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id s28sm780757pgo.86.2021.11.02.22.56.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Nov 2021 22:56:31 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: zhang.mingyu@zte.com.cn
To:     hca@linux.ibm.com
Cc:     gor@linux.ibm.com, borntraeger@de.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, egorenar@linux.ibm.com, geert@linux-m68k.org,
        zhang.mingyu@zte.com.cn, frankja@linux.ibm.com,
        ebiederm@xmission.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] s390:Use BUG_ON instead of if condition followed by BUG.
Date:   Wed,  3 Nov 2021 05:56:22 +0000
Message-Id: <20211103055622.25441-1-zhang.mingyu@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

From: Zhang Mingyu <zhang.mingyu@zte.com.cn>

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Zhang Mingyu <zhang.mingyu@zte.com.cn>
---
 arch/s390/mm/fault.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/s390/mm/fault.c b/arch/s390/mm/fault.c
index d30f5986fa85..48a0231158c9 100644
--- a/arch/s390/mm/fault.c
+++ b/arch/s390/mm/fault.c
@@ -824,8 +824,7 @@ void do_secure_storage_access(struct pt_regs *regs)
 			break;
 		rc = arch_make_page_accessible(page);
 		put_page(page);
-		if (rc)
-			BUG();
+		BUG_ON(rc);
 		break;
 	case GMAP_FAULT:
 	default:
-- 
2.25.1

