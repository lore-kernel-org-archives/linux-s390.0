Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46060C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 02:52:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26AF46108E
	for <linux-s390@archiver.kernel.org>; Fri, 20 Aug 2021 02:52:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237618AbhHTCw5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 Aug 2021 22:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237810AbhHTCwv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 Aug 2021 22:52:51 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8964C061575;
        Thu, 19 Aug 2021 19:52:14 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d9so6362603qty.12;
        Thu, 19 Aug 2021 19:52:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8qviJxekZI0W9oeMNNpxswXOhMmSMq6jYU5M5DVl1Y=;
        b=ZptjVme0tmW1VCpvcrBC2/CDLssJbqaoRo4Q3zTv2FyLpB1EZMmFxcHZevplDZTC3k
         ZZD4v6h9cJXEPhrfRVFXHzwSRzxdmJu2wmlK+IREiu4U7Indsy85FHIFCYBIt+asOOhr
         SHEt6lmnRXZIZF+LR/h7xVC0zG9KL4mApDQsaSX1EX712MuPJ2rDNR0leTpGBYI/Y6kg
         mA1Jqhha+IZdmuAvD/Z9bEBSL922Yg4LA610uR3FXVuSyrUiG/DctG3viXrnMZiVPzS3
         Y39n5znGQqn523b3OML9qLFJTDpPdi1Hu5YzglGY+RSv07az1BiNjgtgVtqIEzlHFbPA
         9epw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=u8qviJxekZI0W9oeMNNpxswXOhMmSMq6jYU5M5DVl1Y=;
        b=IGy94//JK2SANweg8s0iDH3hwzK8KjfL+8GF+xj3vwXw0kFW30tcYcEIAibj9z5FWK
         YFd1NL261xWlXKukYbNtzusXKm+E3p2EOaImsPZd74RHl8SK468HESop4C6E9UcHt17R
         np7RR2RF5zV72JrPN0x7hnrZ32NV4rWGVAFEC/RbruDC8dvOn960cCAPQRtXU4WBrJrw
         /5D2UgRS6d0u6UNs9dTjomsBlM3Ozw0bMkSVsIUDgWQXdaBduXBqt54tNhaAOsv+Vm2+
         9RUkQlIIPnwn+LuChB/h6wRPb9AXPfZaXCxgUYQWRgym3WHitLbO9mtc7H/yU7LcGFSq
         AfFQ==
X-Gm-Message-State: AOAM531Il8nnPcD+W9qMiG0qi55OWWVJov9OqLOPztyfL35065/RJTJI
        3XwNZouPrGw51Ptgq6vouKw=
X-Google-Smtp-Source: ABdhPJxmUkueYQ4YkroowaJHXiGU1LyZ97m6MhoVyq6AumGLSMkTyYII/KF2lyckupUGNQngSZjMcg==
X-Received: by 2002:aed:2029:: with SMTP id 38mr15816652qta.71.1629427933928;
        Thu, 19 Aug 2021 19:52:13 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 21sm2564270qkk.51.2021.08.19.19.52.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Aug 2021 19:52:13 -0700 (PDT)
From:   jing yangyang <cgel.zte@gmail.com>
X-Google-Original-From: jing yangyang <jing.yangyang@zte.com.cn>
To:     Heiko Carstens <hca@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Jiapeng Zhong <abaci-bugfix@linux.alibaba.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        jing yangyang <jing.yangyang@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH linux-next] s390:fix Coccinelle warnings
Date:   Thu, 19 Aug 2021 19:51:59 -0700
Message-Id: <20210820025159.11914-1-jing.yangyang@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

WARNING !A || A && B is equivalent to !A || B

This issue was detected with the help of Coccinelle.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: jing yangyang <jing.yangyang@zte.com.cn>
---
 arch/s390/include/asm/scsw.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/scsw.h b/arch/s390/include/asm/scsw.h
index a7c3ccf..754122d 100644
--- a/arch/s390/include/asm/scsw.h
+++ b/arch/s390/include/asm/scsw.h
@@ -691,9 +691,8 @@ static inline int scsw_tm_is_valid_pno(union scsw *scsw)
 {
 	return (scsw->tm.fctl != 0) &&
 	       (scsw->tm.stctl & SCSW_STCTL_STATUS_PEND) &&
-	       (!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
-		 ((scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) &&
-		  (scsw->tm.actl & SCSW_ACTL_SUSPENDED)));
+		(!(scsw->tm.stctl & SCSW_STCTL_INTER_STATUS) ||
+		(scsw->tm.actl & SCSW_ACTL_SUSPENDED));
 }
 
 /**
-- 
1.8.3.1


