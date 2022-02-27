Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE83EC43217
	for <linux-s390@archiver.kernel.org>; Sun, 27 Feb 2022 13:52:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiB0Nxd (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 27 Feb 2022 08:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231244AbiB0Nx3 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 27 Feb 2022 08:53:29 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BF5913E3B
        for <linux-s390@vger.kernel.org>; Sun, 27 Feb 2022 05:52:51 -0800 (PST)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8A2623FCB0
        for <linux-s390@vger.kernel.org>; Sun, 27 Feb 2022 13:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645969968;
        bh=pRyoy0wYqVh1vMWkfgiwvfL+uC0PF+MUz+uOlTyWlM0=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=dHnbdgZFaLDUXPzv8JBdQJvPDu7YPaPikVLiZuaCRzKnkgg9pLPu6rJwfc3l5p6cN
         a4wihb1sFHUmlwaW8pYPNLQLMarsp2L+moTJIb8S6uU7TQ1/OXR56U3Zr47JP+5TNR
         akcYl7M/YWel7DGMJXwNz0pIhrFv8uxiinkySlEcCi50k6cOh6rXTR0dbI4yprMwca
         6ptJGIfG6S3HcQX7zO3FFK7Hkq3d2oSpOY61WphUrvGoYgcof9MkAeyVb9PtPLVop+
         2wdq3rRFD+bhCP6zoPPMQPC+qwjJ38Iql2AGTXz0VQqTqejRXJ+zCi7frU9dMrWjGY
         tMH6ZMOUIQhZg==
Received: by mail-ed1-f70.google.com with SMTP id x22-20020a05640226d600b0041380e16645so2335227edd.8
        for <linux-s390@vger.kernel.org>; Sun, 27 Feb 2022 05:52:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=pRyoy0wYqVh1vMWkfgiwvfL+uC0PF+MUz+uOlTyWlM0=;
        b=mITs2MeOj1c5TI3Ifq+MWcve7a+tr/FLu4tpcIkmQSPpydoQkd1iKWM3d6O59KLIEu
         QQwLB9DYiyhxWR8/nOQkureA9j2rw0v8JU/QBZfCkEOOmSYM5+JRsEnB+y4fGp70eggn
         xMGYGAKQvk55/BGHOMFHugdl0cFT9uJWPPVZluDECV2hzlLErvAjbk25mSArxCSySuC9
         Xl2VraIOAJvMAhrWpWBV0HseKN4KwsK/u6ItpD8E6ekXk2c2QhZUsKuYFYMQVjxX59Pe
         7cu6n9dLBLrmtqJwgMYZPY3HcCCtV8M3Q93wzVYG9meDloTzHmUYrcVlegFhzkKEX4MN
         RYBg==
X-Gm-Message-State: AOAM532fZEivRO7nfZclyoW2LvFTfygvS5R7Yu2UsjMwsToGqRuyuC2t
        H8PRr23ifsFvZoCL2eRY+h6LFGbO5uWYCV6mIpSgHYJeuR4DfnTxf5I7VATEMdyn7uiO7ygHQfh
        BB3owtg2xJPKQYml+szeRUPnTIaxue+X0poEQeaI=
X-Received: by 2002:a05:6402:1a55:b0:410:a4b4:2a9d with SMTP id bf21-20020a0564021a5500b00410a4b42a9dmr15356211edb.45.1645969957670;
        Sun, 27 Feb 2022 05:52:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxMCUVqX+GQTf3SH7q4WKAqDIKbuRWwlLyTqLEz2lVHwA8GB9LJKefEiix56LpqtlrzGflkbw==
X-Received: by 2002:a05:6402:1a55:b0:410:a4b4:2a9d with SMTP id bf21-20020a0564021a5500b00410a4b42a9dmr15356182edb.45.1645969957475;
        Sun, 27 Feb 2022 05:52:37 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id r22-20020a17090638d600b006d584aaa9c9sm3393333ejd.133.2022.02.27.05.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 05:52:36 -0800 (PST)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v3 04/11] hv: Use driver_set_override() instead of open-coding
Date:   Sun, 27 Feb 2022 14:52:07 +0100
Message-Id: <20220227135214.145599-5-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
References: <20220227135214.145599-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use a helper for seting driver_override to reduce amount of duplicated
code. Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/hv/vmbus_drv.c | 28 ++++------------------------
 include/linux/hyperv.h |  7 ++++++-
 2 files changed, 10 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 12a2b37e87f3..a0ff4139c3d2 100644
--- a/drivers/hv/vmbus_drv.c
+++ b/drivers/hv/vmbus_drv.c
@@ -575,31 +575,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct hv_device *hv_dev = device_to_hv_device(dev);
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
-	device_lock(dev);
-	old = hv_dev->driver_override;
-	if (strlen(driver_override)) {
-		hv_dev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		hv_dev->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &hv_dev->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
index fe2e0179ed51..beea11874be2 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1257,7 +1257,12 @@ struct hv_device {
 	u16 device_id;
 
 	struct device device;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.
+	 * Do not set directly, because core frees it.
+	 * Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
-- 
2.32.0

