Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 393C7C4321E
	for <linux-s390@archiver.kernel.org>; Sun,  3 Apr 2022 18:39:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359854AbiDCSll (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:41:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359839AbiDCSlB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Apr 2022 14:41:01 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA4C911C38
        for <linux-s390@vger.kernel.org>; Sun,  3 Apr 2022 11:38:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k124-20020a1ca182000000b0038c9cf6e2a6so4426553wme.0
        for <linux-s390@vger.kernel.org>; Sun, 03 Apr 2022 11:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=za2ChgFa2MAb73hYI38RRAcoAzGnc/qyPQX8xgHdvQM=;
        b=NL0iTDdwYILas5e8no0oNpCa4PGm56oi2gs6Ima+ni2rAfmat5iF3ezJSbq4RfY5Wy
         seOcJlWOR1FYkb6joSmkvy/3ivMqQNHWCH4ihBK8+2yEHTLQm8HDq18hmNGFuAcd6xHK
         zViUuRxkF2ULgoz+NfPfi7GjvimyfKToTVwwOlZAmY2fKbW6nuo6IjKlJjXYhTluPsNy
         iuNzgI2gotaA7puE+gawJl/6nuoM9g3bhpncBY0pNs0vhaAdS5TsvX9Y/Z2DSOW5pMHr
         kQ/oJGH6Ba+QfJUn5Q8FrDGAfB9Ttl1ntCJmnTJ5uX/vI7MYePpL/Gmi92cw9JhfaNZN
         Yk2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=za2ChgFa2MAb73hYI38RRAcoAzGnc/qyPQX8xgHdvQM=;
        b=6nf58ee1mG0lucqJfa6tEV2zfjNbN+aI8FjXkjGERc50IYCaev0fLWaLwcU8bbPvvR
         zoeaaqbK64MD9vbl8GqKAzpB4xojl/E1EYv/ngbicWJ0FAJFY7RUSSi4qXTPpmiawxVI
         jdI6EnYtliLbvPa4rbvR5dKIvvE7MpOlfAyN8emh/U5uXUyrB6Hmi3bIOJMaKMkyww0N
         Tqws6F7aDmMCZjfjzaOxW4asxF/NbNGmjZ4rYEIRhZ2/XH0neCIRFQdIDuCvtB1Ouwva
         Es4vKNxlN/HVzUASumn5WACNj+AuovMuLXtcB7AqxU4Nq+gx1vyqwKGyQJIl/H8MT3ju
         zVXw==
X-Gm-Message-State: AOAM533oDDTVCPkolFFgDJrIbUYvXgQJS6zldx4Q4bP/PE44E4tbh3N3
        QStVPsM84YRhC+23dg7jmAH1xw==
X-Google-Smtp-Source: ABdhPJwn4Pop9jbCZKW264sWdvAlfR5X/MDrNqkj1NFdBBgFgDY4WLAE8Xeeikrkp3VburmLaYc0tQ==
X-Received: by 2002:a05:600c:354d:b0:38c:e71a:c230 with SMTP id i13-20020a05600c354d00b0038ce71ac230mr16387449wmq.86.1649011110782;
        Sun, 03 Apr 2022 11:38:30 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:30 -0700 (PDT)
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
Subject: [PATCH v6 10/12] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
Date:   Sun,  3 Apr 2022 20:37:56 +0200
Message-Id: <20220403183758.192236-11-krzysztof.kozlowski@linaro.org>
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

