Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 413BAC4167B
	for <linux-s390@archiver.kernel.org>; Sun, 27 Feb 2022 13:53:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231282AbiB0Nya (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 27 Feb 2022 08:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231324AbiB0Ny1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 27 Feb 2022 08:54:27 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62A73140DB
        for <linux-s390@vger.kernel.org>; Sun, 27 Feb 2022 05:53:51 -0800 (PST)
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 1926E3FCAD
        for <linux-s390@vger.kernel.org>; Sun, 27 Feb 2022 13:53:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645970030;
        bh=x+DOMuEjhXppqlmSDNC0RKdzUzslcBqDhsGS9OsoQS4=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=pIptjmyqrdckXp3/9h/mcPjPuQzvCW8osfO1ayL3vIl5JKxm1Fzm657Obzb2NBqT6
         L84jCrREM1tga3eNK58TTm30121dISnejHG5thf9rsZD8KiDTK5mfzyM8cqn47YH3H
         EFWdtM74nO12qEHz890oeEjb+Q3rfsYxHAlHALnzPsXbQe8CBaDL8AkQ3+hbMgEMSh
         4FMF/zyHh3ugtBoNVf9P2FuYrp969n0Mvm1gDBTwlzD+Ho1HL7lQkEEFFIYmCZZHC4
         p9ceAKIeC0cbu/Da0HKXuxjPLoGPAvdiKyeOqefVzh8qsR1daGQXxjIPSz8UmLdaIJ
         fa46kXu//nBuA==
Received: by mail-wm1-f72.google.com with SMTP id ay7-20020a05600c1e0700b003813d7a7d03so3752151wmb.1
        for <linux-s390@vger.kernel.org>; Sun, 27 Feb 2022 05:53:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=x+DOMuEjhXppqlmSDNC0RKdzUzslcBqDhsGS9OsoQS4=;
        b=erBqScphuUuzfii0+/rSBoqsRvzOyUhWVWD1Kmf6srVhNo3LW58TWyDz/eu7TBZdtL
         m1K92oc3em81T58CUQ03rtmnZh4lwnRk690B6BlrKx69kGw+IyWxXlcrVRh6UA5SWOrk
         Do3cxgYSvCBWrJrTOSR9wRfhi9ABeC4y8hViPnogJrnBchPJ8a/MraZVRFfHLMqZF+hw
         209oKVU1goI/k4lk4fD0LZN+BYtRkqtBShRhvWWSQ43s74EIqJhPnO+ErSDpUKAACKhQ
         pcTvvUCNw9MeTJntwmWPsLoPRYuHcNd+UeeBAzY7JDCFY0A/eqtonSSL6lgHiu9tnq5h
         72Ug==
X-Gm-Message-State: AOAM532aCn0hM5JZnr52xQ1d/ouc2xx9TRb/98nDXNYEnltiE6/kojFg
        RaRWj6zaB1qW7W5H2ZgOVTS1lvCsAhpbqPTXDGVXj7Kgib3ZH4HmmjYxdsFshh48d0JysH49Lfz
        HOxGmJb8We2V0lEfj4sfvxIvCHtanrJLlj1F6TFI=
X-Received: by 2002:a17:906:354f:b0:6b4:1449:2d03 with SMTP id s15-20020a170906354f00b006b414492d03mr13078920eja.197.1645970019291;
        Sun, 27 Feb 2022 05:53:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyLkm/ya1hWTxNWHY0owECzZBrknUNuVIsi2Y1TI9mIZSzwklvOz9AjjK7v7g0U5lSZuOzjqQ==
X-Received: by 2002:a17:906:354f:b0:6b4:1449:2d03 with SMTP id s15-20020a170906354f00b006b414492d03mr13078900eja.197.1645970019102;
        Sun, 27 Feb 2022 05:53:39 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id w11-20020a056402128b00b00412ec3f5f74sm4600760edv.62.2022.02.27.05.53.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:53:38 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Stuart Yoder <stuyoder@gmail.com>,
        Laurentiu Tudor <laurentiu.tudor@nxp.com>,
        Abel Vesa <abel.vesa@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
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
        Andy Gross <agross@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-arm-kernel@lists.infradead.org, linux-hyperv@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, linux-spi@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v3 09/11] clk: imx: scu: Fix kfree() of static memory on setting driver_override
Date:   Sun, 27 Feb 2022 14:53:27 +0100
Message-Id: <20220227135329.145862-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
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
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

