Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0CF2C433F5
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 15:10:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357083AbiCPPLj (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357087AbiCPPLL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 11:11:11 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 676B968FB6
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:09:21 -0700 (PDT)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 084673F617
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 15:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443357;
        bh=T7JLnH9mqiYxWSJ2Xi+hqpmFTONALX95DZP9Prs/CTQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=lRj8DGnoBlfL3uTqvxZIbwD8OfglsYLoNStqzAJlzpCCzo/jgna7KiVxyeyGZpo2a
         Tf3SFtM6xj6NF7mlbXKBVnl/VFiCnuJGTturyS1TVhYx2nn8+YR+cMQil9pW4lpYPa
         4vgeuaCFKllAOktVwsb2Uz3WT0o6k0PwObCxiIyetD8gPATGA9E8uEVx6N7dkd+9ya
         d/nU+jTuoj2VBqnrr4d2l/kNT4JRE3GQC8nidjMqT449Dzc1/tEJGbYySKMjk9asQH
         ZL34I7+1rRbfbohixmxBr1AzVEStXAql7eXUwCmGLWoxLAu55gfCXqQPTAO6opm6+K
         VIjVU0ShAhgaQ==
Received: by mail-lf1-f70.google.com with SMTP id w25-20020a0565120b1900b004489048b5d9so847914lfu.8
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:09:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=T7JLnH9mqiYxWSJ2Xi+hqpmFTONALX95DZP9Prs/CTQ=;
        b=JyOAlfwZTPqEo3De0azp93gNqotJLk9QYTv7ER1Z4zDwiHi2sqPnjOOTjOR1ASv3ub
         KB9Jshcci/nxSaeo01PzZ82I8Z8bKpi5jCeJGaPoNXdNtUMeaIJuXW/zIcFXEXt+UpMy
         jyEYfdfMkyYkw+x1a2tzlk724qu7+56zIJ0PB6H4y6slmjjcrhSn/0l/JPjoiuezDXIU
         a/Jbo8kwJAVw+D4DtcgQ5kyoBwZiZvIWKvCLgHG6cR1yW1DBp84TW5D2Xz0tojSsV3vv
         kzgDxH5UqWm7vma1dOvSNBK1w4qy0QDeQFGMOb0YNd6V7l+C2amWp8jQPe/LtvqwqgH5
         9h7A==
X-Gm-Message-State: AOAM531Q+NldkoBZgkTAAL5csQ4Oi30OAiEkXD/l4jhM1XFh0NDDSdxT
        hxNTeIBqsoZKi1LdbfWOBpI3ohYRsRjDXHY1dat5M6WIeoqhWBlm/jZ2sBaPQbyx8m4ScuAr63y
        RmVWg8MCon27UWR2WPzV5wXlclKVtmhVzSGBdCX4=
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id 98-20020adf816b000000b002037faea245mr273609wrm.619.1647443343708;
        Wed, 16 Mar 2022 08:09:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyiZS5X9++Ir6ARAdY07waJfT3FXmo4jW7vzpJuptfIiZFzTOsJAweK7fuoToT0HCAq1Xxe+Q==
X-Received: by 2002:adf:816b:0:b0:203:7fae:a245 with SMTP id 98-20020adf816b000000b002037faea245mr273589wrm.619.1647443343503;
        Wed, 16 Mar 2022 08:09:03 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm1895105wrm.53.2022.03.16.08.09.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:09:01 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v5 10/11] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
Date:   Wed, 16 Mar 2022 16:08:02 +0100
Message-Id: <20220316150803.421897-4-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

