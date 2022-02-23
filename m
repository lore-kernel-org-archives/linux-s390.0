Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE59C433FE
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 19:15:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239058AbiBWTP7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234808AbiBWTP6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Feb 2022 14:15:58 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3984403EE
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 11:15:30 -0800 (PST)
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com [209.85.218.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 7BAA0407AA
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 19:15:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643729;
        bh=WWBR/3RyyId0ctzqGYcSjorUZAyYEVp2bjQXWveQ/28=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=G3aWHWf5OfhGUIVQqjn8G+xNBfCnBKB07GueZlhBJ1IvCUB3eD++APC6ZXGyFhOWG
         5xMPqJdAfdoOPf4y0wDChBifJfbj3uanvWgHNcYvc1sRXuyxpBbXSiMZro/via8j7T
         oqKGzZI+QsuI0iBYnSBFbn4j4iJ8JPxT94nQi2otrf9LZqQFgsSHG26pOAyZB/ig7B
         wmk+LdIFUCqpVVVQcAU33lYBf4jIT7UFsQDYAPMu4xdAH/4498n4Z00wXox5w3kpa+
         ESCN3zsJBJwnMrN+4tISySBeio/kXl1TbncRwcbDun+CnV9bYO/OM+tZjem+Wv6Ppp
         D+fnNGYb8+lzQ==
Received: by mail-ej1-f71.google.com with SMTP id i20-20020a17090671d400b006d0ed9c68c1so4221691ejk.14
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 11:15:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWBR/3RyyId0ctzqGYcSjorUZAyYEVp2bjQXWveQ/28=;
        b=l3R6rjIbg6RVJ2kpLJ+9GqoqeyBnRNS8ADqmBZWkIXfy8KQFV1j4Ey//qHBoKSz6et
         9kwSGNTi1MZwWIQ5xReNT4TxLRRF9v4KsoD5FbdlBnRsPPzS6oXoGDm7MGMFSQQYlKPu
         eTKt1e2vRqiAx3I+PTUXI/nnQWufq7f5F/PKij3uPKgqyUMqtZ7p/2j+HzFdOY8XtCmu
         3ZXzqeJFKt8xD2SMuG0LjhC2luJDwTTjrolaxjZrOX9rsnfrkHpCreP9o5jFRYWjblJz
         SYPzagkC+Is4pvyF8CHpctUXosuLU0Z/KOUqrRe9RpL3OvAEXFDCouG6annXuQvM1M0o
         mNwg==
X-Gm-Message-State: AOAM531wZCdh4eNrs89m7AQHW/u8AQvn1r5Eq7Ghdd2tK6hghBapEibc
        8LDjqUdnwRCoGKd72gud6c3+zyUeYJlFj0NRB4mh/kjH85HoHlx8KFnmPCHP1XvrgcrIbpZIbjZ
        wbvPLq4XmrKhZn94pbvgjXeWeiXPdawxRfbzI4ro=
X-Received: by 2002:a05:6402:70d:b0:410:ba4d:736f with SMTP id w13-20020a056402070d00b00410ba4d736fmr891833edx.0.1645643727230;
        Wed, 23 Feb 2022 11:15:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw8vcySNYfbv43Pk2WXynTAOxXboVgUUSRQKZSxFWxW+kHULs5hedJTU2eFScz4UFZao2eyYQ==
X-Received: by 2002:a05:6402:70d:b0:410:ba4d:736f with SMTP id w13-20020a056402070d00b00410ba4d736fmr891811edx.0.1645643727044;
        Wed, 23 Feb 2022 11:15:27 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:26 -0800 (PST)
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
Subject: [PATCH v2 09/11] clk: imx: scu: fix kfree() of static memory on setting driver_override
Date:   Wed, 23 Feb 2022 20:14:39 +0100
Message-Id: <20220223191441.348109-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
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
index 083da31dc3ea..15e1d670e51f 100644
--- a/drivers/clk/imx/clk-scu.c
+++ b/drivers/clk/imx/clk-scu.c
@@ -683,7 +683,12 @@ struct clk_hw *imx_clk_scu_alloc_dev(const char *name,
 		return ERR_PTR(ret);
 	}
 
-	pdev->driver_override = "imx-scu-clk";
+	ret = driver_set_override(&pdev->dev, &pdev->driver_override,
+				  "imx-scu-clk");
+	if (ret) {
+		platform_device_put(pdev);
+		return ret;
+	}
 
 	ret = imx_clk_scu_attach_pd(&pdev->dev, rsrc_id);
 	if (ret)
-- 
2.32.0

