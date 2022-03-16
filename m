Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFC93C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 16 Mar 2022 15:07:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357045AbiCPPIf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 16 Mar 2022 11:08:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356957AbiCPPIQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 16 Mar 2022 11:08:16 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D07E40A17
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:06:55 -0700 (PDT)
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com [209.85.167.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D21B23F312
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 15:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647443213;
        bh=QAEyo1xXNWnC/wTobDlvVW3kuxucr7Y+nryukeY/7zA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=NyeDO+TWm3ZwIeN/0z9fgKF/TFBs8rmu2rv2eR2saRDqZhDr3hB66ZCfJ5eYn8SB+
         dO6ffRbRdJG/w+7DkxzAbmiM3QLpEmwdyeorKWyTNYcWRfJNMCo6tvrpecl86Gp4MH
         Om38X3DGpIQsqbozonozKJh7rngyYrJrL2Iw4Ki+BMGRdVsV0xHYSkhGvHibHe5GDx
         hrePDPBjU+qT/wfkd2ZP3uvivYgB9EQ0hNZ54axSbMgTiYxIUMOXoMdOu/qq4I9ftQ
         Sp15kFPQpRY3tBC+nCG5iGQHfFCP3ma5SHU5PsNdF8YSMz5a1S1O6EW2cYN8HD6/WJ
         jxeBB9UpX9RYg==
Received: by mail-lf1-f69.google.com with SMTP id f27-20020ac251bb000000b004486c507f80so845672lfk.10
        for <linux-s390@vger.kernel.org>; Wed, 16 Mar 2022 08:06:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QAEyo1xXNWnC/wTobDlvVW3kuxucr7Y+nryukeY/7zA=;
        b=jttLKsYIs7JydZZv4by6npuViU12vozU7KfxDGdZp4BYmKDJkgqnrDx/2J9BBM9paO
         5Dsde7WGGreiYD2+/pjrO8UrdrPcR2U1SavzOoRzay6KDltd2aCiff1hAO1Kp/YMk5cN
         HcmzoOVpMWwgvs6A4tBQ+RCP5dggK6XYZEtIQuzzKLSuovXFhfHd66jXGiH3tVCzaGKF
         mcRtrDMALS09XwTojUzHLFPrKT6EUCcTx8XqBKQ58oqC7+bJaVzHcRHfzZ2w5NoukxEQ
         Cxy9suT/dGEoIIn+9LPumecyXiiNM/LKD+l9BYGD3bJDad7jQac2vd2c3kyrkYhv/Dbb
         YV1w==
X-Gm-Message-State: AOAM530CF0JJHKWUHJ6ckpDWA66PCcd4nrEY+ZG7kj+gVv+nqgQGOlV4
        pcXZqrPUfaBOJlihHQpGBZYVM/Ie/0FF5Ern77h1pt3xkl4Gr6YwdsxBxdaZRzOXHLjhjSGfm0c
        CzP2rB4TYVwlSdO7GRJWrV93qU3GFMt80Zch5DZg=
X-Received: by 2002:a5d:55c5:0:b0:1f0:7672:637d with SMTP id i5-20020a5d55c5000000b001f07672637dmr349062wrw.170.1647443202244;
        Wed, 16 Mar 2022 08:06:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxweeXNXzqSiK6jLHKTzxTuSJXVd/nxHPvdpHWEAERfetg3Sykd8n3TukHieLMV78+GWu3x+Q==
X-Received: by 2002:a5d:55c5:0:b0:1f0:7672:637d with SMTP id i5-20020a5d55c5000000b001f07672637dmr349028wrw.170.1647443202062;
        Wed, 16 Mar 2022 08:06:42 -0700 (PDT)
Received: from localhost.localdomain (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d59ae000000b00203dcc87d39sm3130155wrr.54.2022.03.16.08.06.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Mar 2022 08:06:41 -0700 (PDT)
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
Subject: [PATCH v5 06/11] s390/cio: Use driver_set_override() instead of open-coding
Date:   Wed, 16 Mar 2022 16:05:28 +0100
Message-Id: <20220316150533.421349-7-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
References: <20220316150533.421349-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use a helper to set driver_override to the reduce amount of duplicated
code.  Make the driver_override field const char, because it is not
modified by the core and it matches other subsystems.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Acked-by: Vineeth Vijayan <vneethv@linux.ibm.com>
---
 drivers/s390/cio/cio.h |  6 +++++-
 drivers/s390/cio/css.c | 28 ++++------------------------
 2 files changed, 9 insertions(+), 25 deletions(-)

diff --git a/drivers/s390/cio/cio.h b/drivers/s390/cio/cio.h
index 1cb9daf9c645..fa8df50bb49e 100644
--- a/drivers/s390/cio/cio.h
+++ b/drivers/s390/cio/cio.h
@@ -103,7 +103,11 @@ struct subchannel {
 	struct work_struct todo_work;
 	struct schib_config config;
 	u64 dma_mask;
-	char *driver_override; /* Driver name to force a match */
+	/*
+	 * Driver name to force a match.  Do not set directly, because core
+	 * frees it.  Use driver_set_override() to set or clear it.
+	 */
+	const char *driver_override;
 } __attribute__ ((aligned(8)));
 
 DECLARE_PER_CPU_ALIGNED(struct irb, cio_irb);
diff --git a/drivers/s390/cio/css.c b/drivers/s390/cio/css.c
index fa8293335077..913b6ddd040b 100644
--- a/drivers/s390/cio/css.c
+++ b/drivers/s390/cio/css.c
@@ -338,31 +338,11 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct subchannel *sch = to_subchannel(dev);
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
-	old = sch->driver_override;
-	if (strlen(driver_override)) {
-		sch->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		sch->driver_override = NULL;
-	}
-	device_unlock(dev);
+	int ret;
 
-	kfree(old);
+	ret = driver_set_override(dev, &sch->driver_override, buf, count);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

