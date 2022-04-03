Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22E1DC4707A
	for <linux-s390@archiver.kernel.org>; Sun,  3 Apr 2022 18:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359817AbiDCSkQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359822AbiDCSkP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Apr 2022 14:40:15 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0261393F4
        for <linux-s390@vger.kernel.org>; Sun,  3 Apr 2022 11:38:20 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u16so11427535wru.4
        for <linux-s390@vger.kernel.org>; Sun, 03 Apr 2022 11:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Keg7xeXtq8amo+bPOPiY0urtb62UU+nYY2PydP0Pktc=;
        b=oMDcsOp89xo7WCGlZaySjQ/SL9h0nzbICnZPF/l1L4/usr5Ql0XDHyOs8k4ehjMSBS
         wNLyu4xPPW/8LHM2Uedk1hGpH5fictG31y/jaW9+iVnJSqBp/jUgPgpae1FA5DICWkPl
         YRAMESUeV51a7RHc95N5iNDkYhYQTFttdVTgxIhYSFABzCUtxnFZt5jqPxICNNpdDyHs
         POzj/+QSYOjZLCMMMqS5ghku+l1wfklLbj2jy/IljcHTXhZXw1iJrrLT+I46o5bsitlo
         KU065Iswr+ZwwCsrhwgctLc+GzCy0ejsf5qoEOvNZuD0oCpZAaZA1eMhHX76M2B3fl79
         o24Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Keg7xeXtq8amo+bPOPiY0urtb62UU+nYY2PydP0Pktc=;
        b=aAJDNbzbcx0RHpkqrjRFqOO/f3laAOYjh8t2MUpw86U4ApGmz1dYlLoNWXwmhsXBwf
         o3RSvYuXwG3GcuoaCa/4w4FcIwUvSsL8vngJ7WqCeqyRLw+335zg7HVCwNJkzrdLi8+c
         VCYGUi1KPEv5Mcb/rksNJGjBV5a8aL+ZO/k86XULCfYuln6jjMPtDk20BB54s2vkIE1L
         Ek46aeDyypBQnnFnhGIoct2OPA6+Tj7C0Sabdur4KSPP1vHnHf4qdvGR7Pkmi3twdwMd
         uabgZuJZrIzVZRjZNPux3K9W8PI+FZPourqGqS1n8phK/Bj8a2FBmxcUyn8vOo4dDDM2
         907Q==
X-Gm-Message-State: AOAM5311xyg4XxPnZqTb1Y+eK+lkeLhRgxolgwOyFc94kTJWIzbHmym2
        j4dJt03NMoe/1ZtI5crlSKxcww==
X-Google-Smtp-Source: ABdhPJwQ3UAwO6FtrIbwy+YxLSghNLDrrLC/+v/7FNzcUG7RmOtZ5npIuu0YxFNm/NCl6vE9djrLbw==
X-Received: by 2002:a5d:55c7:0:b0:204:5ff7:74e2 with SMTP id i7-20020a5d55c7000000b002045ff774e2mr14445001wrw.50.1649011099197;
        Sun, 03 Apr 2022 11:38:19 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:18 -0700 (PDT)
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
        Michael Kelley <mikelley@microsoft.com>
Subject: [PATCH v6 04/12] hv: Use driver_set_override() instead of open-coding
Date:   Sun,  3 Apr 2022 20:37:50 +0200
Message-Id: <20220403183758.192236-5-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use a helper to set driver_override to the reduce amount of duplicated
code.  Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Michael Kelley <mikelley@microsoft.com>
---
 drivers/hv/vmbus_drv.c | 28 ++++------------------------
 include/linux/hyperv.h |  6 +++++-
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/hv/vmbus_drv.c b/drivers/hv/vmbus_drv.c
index 14de17087864..607e40aba18e 100644
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
index fe2e0179ed51..12e2336b23b7 100644
--- a/include/linux/hyperv.h
+++ b/include/linux/hyperv.h
@@ -1257,7 +1257,11 @@ struct hv_device {
 	u16 device_id;
 
 	struct device device;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 
 	struct vmbus_channel *channel;
 	struct kset	     *channels_kset;
-- 
2.32.0

