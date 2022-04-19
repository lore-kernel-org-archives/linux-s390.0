Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DD69C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 19 Apr 2022 11:35:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351433AbiDSLiR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 19 Apr 2022 07:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351494AbiDSLhr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 19 Apr 2022 07:37:47 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6856167CC
        for <linux-s390@vger.kernel.org>; Tue, 19 Apr 2022 04:35:04 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id u15so32219155ejf.11
        for <linux-s390@vger.kernel.org>; Tue, 19 Apr 2022 04:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za2ChgFa2MAb73hYI38RRAcoAzGnc/qyPQX8xgHdvQM=;
        b=zVkWhAv51DVC1p4aJpiAjPCoWQril/21gAKuMsm6z+0NXkTbr3mNaIqUaZFcjR39cY
         v4OMQBXlR/2rhpUCTx0VbESTsmsehL0V/OOEUkWQRkkVnA5m6023KnbBO9lJSa8rsIY2
         /tvt+ZeGz8iYq05ODrVkPfPZK8t74hDar82Awg+fciFFk2Qd2NRV/6z2dC+Ds9ob3PSI
         mNw5Vt41Pgcg5nBS6798wd5iqS4jiUWHQ3/NMJ/nlbxPJyi3xKd5m7ZfgU/xleQBIUs/
         ITljrACLgzODper1Rl5lTvuiSCAyj79YAn5Qn9t2W7PwalGl5eAtA378B8fj3iSS5XxU
         x/Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za2ChgFa2MAb73hYI38RRAcoAzGnc/qyPQX8xgHdvQM=;
        b=QzfUdqfWh3eDJXfgrFrwI2bLYmK3vsFWPqR/SWgPZ5mIe94p0GX5AmGM+lzsOYeIAl
         YZKoB4aZ+NxJy1bS03UkGwYZ2MnLHpeM3/7pIRYYhXFGasMVyCYdHy6GbUCeu+w4xrP0
         DtnfMyGaxUv0FRsCXrAb2sd5MrugLofMV6EawGbOI05R9ocOSg0ZYFrP56avUHcT+sVJ
         K2+MlyIpn/4eZkcbRFfzB/0Nzhw4tUfO7cUKeUTH9G2PIr+loxkQynVApT0qy4KLklND
         bdFjCInSxCiVqdQNxzWHv7YtHauWOvC9ygzUb/NVNkXCjBLPsUbCe1hV3DWJ3qTBH7SS
         x5JA==
X-Gm-Message-State: AOAM530INAtywD5guvLLJmzNoQc99ivxTCNMFcxYjSmDp+L2BYbXJ8S/
        bh0uK0CmPfA1MLl5kbRb/fAZyw==
X-Google-Smtp-Source: ABdhPJykXBXYimpAeumTHTNdPOwvvfUNc2rfx1d0CpWSKysWkExiziY11QDQTp0Hk2gdb+t7K6B5eQ==
X-Received: by 2002:a17:907:2d0f:b0:6e8:b710:a68 with SMTP id gs15-20020a1709072d0f00b006e8b7100a68mr12790234ejc.510.1650368103349;
        Tue, 19 Apr 2022 04:35:03 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id ce21-20020a170906b25500b006e89869cbf9sm5608802ejb.105.2022.04.19.04.35.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 04:35:02 -0700 (PDT)
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
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v7 10/12] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
Date:   Tue, 19 Apr 2022 13:34:33 +0200
Message-Id: <20220419113435.246203-11-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
References: <20220419113435.246203-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 0f29a08b4c09..0aa8408464ad 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1434,6 +1434,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	const struct of_device_id *match;
 	struct device_node *node;
 	u32 id;
+	int ret;
 
 	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
 	data = match->data;
@@ -1455,7 +1456,17 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		}
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
-		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
+
+		ret = driver_set_override(&ngd->pdev->dev,
+					  &ngd->pdev->driver_override,
+					  QCOM_SLIM_NGD_DRV_NAME,
+					  strlen(QCOM_SLIM_NGD_DRV_NAME));
+		if (ret) {
+			platform_device_put(ngd->pdev);
+			kfree(ngd);
+			of_node_put(node);
+			return ret;
+		}
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
 
-- 
2.32.0

