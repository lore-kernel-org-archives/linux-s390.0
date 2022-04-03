Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA8E7C433FE
	for <linux-s390@archiver.kernel.org>; Sun,  3 Apr 2022 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376288AbiDCSlm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:41:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376275AbiDCSkn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Apr 2022 14:40:43 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9034E08A
        for <linux-s390@vger.kernel.org>; Sun,  3 Apr 2022 11:38:30 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r64so4630797wmr.4
        for <linux-s390@vger.kernel.org>; Sun, 03 Apr 2022 11:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qtEucOUUPP5N/mYQNy60J2tmYru2tvlYgmO9h18XcJE=;
        b=MzbOCsPtGwGO108/lSDaSaf1+XSDrXAe5yX1DdV0mfrCl06/DuHGGptcVp1iZ+OCZs
         Sr3xXPu+/LUQWaSua+Z9riHXtxnsjZYcgfudGMg0eGSJroXkQN+sAwRy7pi2DkWUc69u
         LRP1Jq0DgipVHVcL0TbLHQFLItz8svl7Y6g5raLhE3+qSjyR1t772d2IkpZCUfha5jsL
         eHrNfWm2+KC5ijYi8x8UCWcrLmspOUoun6wYfkN8lLtnfvh5BLRGN+hYx0WJnkU+ntJv
         MdIvqte1KodMeoX1CiPjM+5xKuzO5A1rzXr8OFxIaWEBogUpc8y4KWBCNDNf1jGVaH3J
         ayiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qtEucOUUPP5N/mYQNy60J2tmYru2tvlYgmO9h18XcJE=;
        b=hT8G83AWtMPofuRmG1ZcDLTopCrpXXCHRXMBih4KPaIp8esejNxg12ORRzCuPS5aZe
         RMAAG85fjIEOX3Q3FD0SQjuvKlSLbes9f0wXad7IaZcJeZPyy+hk60ylBz4JFN9QMsqO
         nO8/PTEozucjaFVbRvwHRKpzzQHJa+APrxxz/9bORo2V5imFzSQgijdHzWDvfpFG4Zde
         b3/uXHUsEHdifuym3kfHR5OE3Drt9bjuXl35x4e7fKeRgm1N5Zng3IruNg1a3gVTTh9j
         o402BCG6MrCCP5uB5ovWRBkd+7QCxWgTmEyDKFHhrg8qlFznGXk6s0Zm91SqJvOCPz0Q
         5dlw==
X-Gm-Message-State: AOAM533gpoLITjjP3V4ZFsB09sUzN3v7mesEd0pxBwa5YkrWr4O9XSwx
        5opvozOXJElhdhloxVKSZx/hPQ==
X-Google-Smtp-Source: ABdhPJyXl7rsWywHQpujLV7EDE78zSf60/dgWAa8SR6HS+xUHZ+OK90mFzRYvM677eBKG6B3suxzyQ==
X-Received: by 2002:a05:600c:3547:b0:38c:ac1c:53e9 with SMTP id i7-20020a05600c354700b0038cac1c53e9mr16601811wmq.159.1649011109253;
        Sun, 03 Apr 2022 11:38:29 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:28 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v6 09/12] clk: imx: scu: Fix kfree() of static memory on setting driver_override
Date:   Sun,  3 Apr 2022 20:37:55 +0200
Message-Id: <20220403183758.192236-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Acked-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/imx/clk-scu.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/imx/clk-scu.c b/drivers/clk/imx/clk-scu.c
index 083da31dc3ea..4b2268b7d0d0 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	pdev->driver_override = "imx-scu-clk";
+	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
+				  "imx-scu-clk", strlen("imx-scu-clk"));
+	if (ret) {
+		platform_device_put(pdev);
+		return ERR_PTR(ret);
+	}
 
 	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
-- 
2.32.0

