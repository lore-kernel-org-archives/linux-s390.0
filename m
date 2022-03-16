Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4071C4167B
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 15:06:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356933AbiCPPIM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356938AbiCPPIA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 11:08:00 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E10245B6
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:06:46 -0700 (PDT)
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 394524001E
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 15:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443202;
        bh=LxSp3r31kTKgdYVIAcfNeHGsMIq2YcJzJF2DRNz1kEo=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=cYJgP1yqU4+Hmmsj/xGdtkneK5MuyE1uEJl5dC93VKyT1GOQqG9UNyfseEHidQP5n
         NHyZ66ZH7Gh+D6cShrzYz1cXRMyvP3vt+/PXIGC/QOcdXK38GWu1WUIWXk9GgVsSNi
         bTxdz71wivTLhkHSpVuD4Q9WO9VZI/ogLs7SjVEJSVd/L85oUuzKnny39hZbyxV0vZ
         hO0BU7r3KXU6fZ/IY4o/Gu5ANAIFTeiPAr9f+VniuAuB90eBHv+T46w6XwjwwcO4Ik
         cuhIbSe9VBoRELeUpGqTE5l6ObEV8yMLJwBvlZviocED7NtyAKyBmoaH6SyvgqkeLT
         dMKTiUZNBy72A==
Received: by mail-wr1-f69.google.com with SMTP id t15-20020adfdc0f000000b001ef93643476so672432wri.2
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:06:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LxSp3r31kTKgdYVIAcfNeHGsMIq2YcJzJF2DRNz1kEo=;
        b=yszs/Bfb9/gDsvtc4C7O4KFoarePXMtU17nf5jxttiMMUYnCu0tku1Jt94GuFTL5be
         +XUkQw7LzfsOHXMgPk+G8nloqVUsgpCZ49MzPUKOER6AzmigYEVnc4BCQpEEkLVOKPF9
         z28iKF0tAqFE4w2wHf/csZpDtx1VqJfWvBFkQATlYdbIq4uir315mqhkWRoaXRMVU1ob
         P/eFSpOWIygqc6w0iyPuSQZgcrJX3fKLY/N8zFHH46BNdfJees2QczPK61BGFpMoc3fj
         qD8w4Q9qabVhrOeq/hqf3Vcz2kbqr/zc1ah3+gUg6TkJ6nZ1ROtFXyvbmJvx03KeQkuO
         u7ug==
X-Gm-Message-State: AOAM530E9vFErCY6GOUGAq39H1+RAN3ub51mM03lFw6GHG5tVyonkup7
        Ulg82m2yS2TGIWLrRnuOHBFL2B1dZchdIx2jZM+QUP0glcP56oARUJH7JLb5BmB18skJRbKQNMO
        xsuuzND8vLGzPnlTqbvXRAlVNaABAZu6I1DjxbpI=
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr130555wmk.58.1647443190543;
        Wed, 16 Mar 2022 08:06:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzdXtZV1RU4W+D/CxNpLgNYuPn/wREOODQjEf3w6MZJYByf0aAfpBebBFJL0kKpQw0vNQJhuw==
X-Received: by 2002:a7b:c5d0:0:b0:355:482a:6f44 with SMTP id n16-20020a7bc5d0000000b00355482a6f44mr130503wmk.58.1647443190091;
        Wed, 16 Mar 2022 08:06:30 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm3130155wrr.54.2022.03.16.08.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:06:28 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v5 02/11] amba: Use driver_set_override() instead of open-coding
Date:   Wed, 16 Mar 2022 16:05:24 +0100
Message-Id: <20220316150533.421349-3-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use a helper to set driver_override to reduce the amount of duplicated
code.  Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/amba/bus.c       | 28 ++++------------------------
 include/linux/amba/bus.h |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/amba/bus.c b/drivers/amba/bus.c
index d3bd14aaabf6..f3d26d698b77 100644
--- a/drivers/amba/bus.c
+++ b/drivers/amba/bus.c
@@ -94,31 +94,11 @@ static ssize_t driver_override_store(struct device *_dev,
 				     const char *buf, size_t count)
 {
 	struct amba_device *dev = to_amba_device(_dev);
-	char *driver_override, *old, *cp;
-
-	/* We need to keep extra room for a newline */
-	if (count >= (PAGE_SIZE - 1))
-		return -EINVAL;
-
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(_dev);
-	old = dev->driver_override;
-	if (strlen(driver_override)) {
-		dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		dev->driver_override = NULL;
-	}
-	device_unlock(_dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(_dev, &dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/amba/bus.h b/include/linux/amba/bus.h
index 6562f543c3e0..93799a72ff82 100644
--- a/include/linux/amba/bus.h
+++ b/include/linux/amba/bus.h
@@ -70,7 +70,11 @@ struct amba_device {
 	unsigned int		cid;
 	struct amba_cs_uci_id	uci;
 	unsigned int		irq[AMBA_NR_IRQS];
-	char			*driver_override;
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char		*driver_override;
 };
 
 struct amba_driver {
-- 
2.32.0

