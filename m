Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8355C35296
	for <linux-s390@archiver.kernel.org>; Tue, 19 Apr 2022 11:35:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351421AbiDSLiP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351521AbiDSLht (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Apr 2022 07:37:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA061F60A
        for <linux-s390@vger.kernel.org>; Tue, 19 Apr 2022 04:35:06 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id y20so12115691eju.7
        for <linux-s390@vger.kernel.org>; Tue, 19 Apr 2022 04:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZB4AAiYpghp+j0HlvXqcm6S1oaOh86fqoD06sTrQvg=;
        b=EpULbiMcIyvOq1eTI1FkoG7wHTnnsB+t3uW7Gr9XJVTSv6M+N6+CpqVJ4tX3TkCJmj
         sx+dBtweIzXDc+/elWAvba2OBrbAX04zVGMt+UVOEGyNqFedX1c7G9LuvmQ/ozIthkTq
         Y3/IDX3dscPP1/B9ADdZKVAGu6XTtAEaCHeesCj2xtEjHqF5DWbZVPStC3571/pmn2Bq
         Jc6N0AFyt8OgU0gUmyQ0UxOeUpTVrV+LWpEZXyanIUvvzGU7ES/Sw3k+CIBiihhHS8LF
         G+8pz++8wqbv055aZZ2wCgi1Pz812gH503ntSZGp5dxdbkotFOTkn+daw5aiX/a4Di1V
         uI1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZB4AAiYpghp+j0HlvXqcm6S1oaOh86fqoD06sTrQvg=;
        b=nS968cZ0FcF81XRAyxF+0oSmehrOytIQgtwoQXr6GSn2tpBPV/thD7zcrQqdbG4Yu0
         +8dyGT+boAp3fkDGW1QddmdOjeAOD2B55gxFUHDiMMxeZyaf3UccoZjHIX8PEX7YGmga
         X1esc1uff2mWTtgmPuYxcT/KTR0QPFOG9AV2B1HGmkRFlHv4TBB0F/Hb+kEeNCCC3lT2
         QFSNLNBd1TWMHRY7fs8AC3UhAM+gK/Rulfi7DlCYlfACkXkqGwULbsmRO6UVSLYzryYU
         J6PR2DC5vtrIh76pcJznAjMseMvrPO7i2XVyVgl9wnM8rA3gZTCCM4thozSdegxlaSM5
         PrbA==
X-Gm-Message-State: AOAM533TFOtDPApRNz1oDzd+rOPyYVZ5yH/gv0vU2j69Y8CXB2D7edlV
        smQl3UpoPpP4BrrRnkd3KPrXfQ==
X-Google-Smtp-Source: ABdhPJz5IEvGiK922/vJClBDi+mKcO5SsMUlVd7BXDUmO4dQvqIub6KWUVkwOaaikp1xnTNTPgx3tw==
X-Received: by 2002:a17:907:7e92:b0:6e8:8df7:cf92 with SMTP id qb18-20020a1709077e9200b006e88df7cf92mr12502150ejc.541.1650368104852;
        Tue, 19 Apr 2022 04:35:04 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm5608802ejb.105.2022.04.19.04.35.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:35:04 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
        "K. Y. Srinivasan" <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        Stephen Hemminger <sthemmin@microsoft.com>,
        Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v7 11/12] rpmsg: Constify local variable in field store macro
Date:   Tue, 19 Apr 2022 13:34:34 +0200
Message-Id: <20220419113435.246203-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Memory pointed by variable 'old' in field store macro is not modified,
so it can be made a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 79368a957d89..95fc283f6af7 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -400,7 +400,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
-- 
2.32.0

