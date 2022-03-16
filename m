Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 693F3C433FE
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 15:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357124AbiCPPLO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357063AbiCPPLD (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 11:11:03 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B51D674CC
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:09:19 -0700 (PDT)
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 72E743F60E
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 15:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443354;
        bh=0TkaUHsdiaalOGmdOdYbrrLuoBcQ76N1kyxAw52pHyQ=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=uaNX+6lTP9qmxnJ3NdTtYdL8r61fnXk6rEhWx3i5Nq/P7UvKmc2GmDDHSknp4zMN0
         DN6k0q4scQs4JWJsuungU52CfPVZ4TRJk9mp+AESmoJJ76uieOKBLMk+pdMDhUZYHX
         cFgvu7dsdECRwcu8FgNJAYV0vSG+d45rU7jDKp3cngCEXnF7vmmPS45ZhtSDmDcxmC
         YvSxLl1Fr5wbUwbOg0Z3lMdxzzDGbZCdEOtADBsnKAyiYZhb9JDAfc4P/SrKkMHWSP
         oGlSIVfOsPgZMkUUV0JxH6xFOjvhhMTRbF/cAwFAOm4ToXtyrrGKXGm+1MRDt+QuhB
         w+ZpzABl1lHHQ==
Received: by mail-ed1-f72.google.com with SMTP id k25-20020a50ce59000000b00418b9066e47so1461493edj.22
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:09:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0TkaUHsdiaalOGmdOdYbrrLuoBcQ76N1kyxAw52pHyQ=;
        b=1/8zVmCiImTyCPDncXuxkj0BaI3orlBYb5QxZHZKhon+xZ2oPl+UnfmVvA36TpXBF1
         KZYTbkMazNgP13wpspAM3AYg6uXjJjaP+DhyngFTCgCMzaPAAUlJzn1C1623kHpovXLl
         q3ObI9EXbbbLLC6LLZLPPoGMMW1DzpoMy3G02/rbRgJEhwAAd6f9XpUXBRcjQ9BwI+Xo
         OXKO2IxGy8dUf+IuvT+jntHI3Po84d8q4qrlSJpsetA/GzohXsXqOfhdlbl+g1h82ZE5
         WAEIiHUU7v/ElOFnW28Dr8/V7IjtY/w1PUQdfYT/NA2P8Rifzt1o5H2wP7o7MEJZ4+0l
         f1IQ==
X-Gm-Message-State: AOAM531NwedUtu2QX27+IJvKg5r1EazZ927plrsBE3pkkm5lG7K6kNRI
        Z/aPVmbdzjMZggC4igwJJx1PaUxJ2V5oWtGQfHxudrSSZNAJzCVmKhxqQeJJUrIphjzag97TCIP
        jXx4dPpN+doPQijzz5RXfaVpQmXxBhkWkF35fu3E=
X-Received: by 2002:a5d:6442:0:b0:203:dff2:866c with SMTP id d2-20020a5d6442000000b00203dff2866cmr272586wrw.465.1647443340521;
        Wed, 16 Mar 2022 08:09:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnOg2aSuuzk/AN13SVnFGjUvC/KtTXL980cTeRfOeIj0D4M/X0M0ZN717fC4+xLvcCtZ4GNg==
X-Received: by 2002:a5d:6442:0:b0:203:dff2:866c with SMTP id d2-20020a5d6442000000b00203dff2866cmr272574wrw.465.1647443340291;
        Wed, 16 Mar 2022 08:09:00 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b001f04e9f215fsm1895105wrm.53.2022.03.16.08.08.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:08:59 -0700 (PDT)
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
        stable@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>
Subject: [PATCH v5 09/11] clk: imx: scu: Fix kfree() of static memory on setting driver_override
Date:   Wed, 16 Mar 2022 16:08:01 +0100
Message-Id: <20220316150803.421897-3-krzysztof.kozlowski@canonical.com>
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

Fixes: 77d8f3068c63 ("clk: imx: scu: add two cells binding support")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
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

