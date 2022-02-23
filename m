Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD41C43217
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 19:15:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244294AbiBWTQT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:16:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244330AbiBWTQS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Feb 2022 14:16:18 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7517840A0A
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 11:15:50 -0800 (PST)
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com [209.85.208.197])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 07E7C3FCAD
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 19:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643742;
        bh=H2keAgAmU9ZqqGFkafNbZlkvfevlWycDJlQlht8xanA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=WsnEoKZyGz9N+/uCCeuwyGJQSu7ZfM9BKKH9R2Tsp7DW+W2LOkPL1iiV+AOZpUIfG
         W2Qy5prVy4MiMgKzC/e65f4FPF+i/uMXt15SNq4NQmmVXN8fs3wAWwGropzB25HjHF
         xy9gQoI6VLZUl5SlL2ppFqTAYqsLoMO06/qt/vzVRUIjWcRNcGogeD/PDwF4bMZNnx
         dSee12cF9kOTu3VKmfGzjguFbfgNS1ZxwRuanMGBRl4ciBR/tMjebxcWtdNmy5qKmU
         CBIUmP0mtkGnYyIj3WUaVZxA4MQlBoRKUQ8qYGG2L1dyA5csTxK8rXj4peZTBaKIoZ
         V7PTTTRk+mITQ==
Received: by mail-lj1-f197.google.com with SMTP id 185-20020a2e05c2000000b002463aff775aso5692945ljf.17
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 11:15:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=H2keAgAmU9ZqqGFkafNbZlkvfevlWycDJlQlht8xanA=;
        b=gcakPlJ/RAAqFpskhV4xPHjIdQaJNJWXi+EFpw+RXAkThk2K+zpptE+2R9VImp9WCq
         mWhzdaW5xdcRv7phhRFtpD1VjFGra0pIs7pYYm4DhuKnO8t+0ds9ivJISOGoAwxLOauN
         mfSuifA34UvBXSSK/uX718iw9K9IxeYFGlaANlyFi3FDMobF4PwGZdtGtO42baUUnRKq
         2Raq6dRfQOugyVXQGxFLJ965AtcmcC9XLZ41Ud4JwQy41nuIJ4G3ZaYT5To+1ibqaJ9C
         HekzKBRNS+kOSszUFI1HSBn/rVxNLa0zLFdQ5ey6D7BFVz4TJRk7b9ReWnbj65cq69kB
         hyNw==
X-Gm-Message-State: AOAM530yHoKTxVj6MTrUKZGJgpIg1n6Y/UrJq9SM8Vv+isUaLc9ijPhz
        6ATWWd0Xvk33Xxsrwyqdb0utzmMKnzmCGjzR6MZgeu/PSG2//cls1L51+Gk3izjEc+OZeydoE14
        ah581PryvoRiw1GWmGjzq2KpHzubdJ5JSvTIFjW0=
X-Received: by 2002:a17:906:684a:b0:6ce:c1b4:b503 with SMTP id a10-20020a170906684a00b006cec1b4b503mr894502ejs.355.1645643725344;
        Wed, 23 Feb 2022 11:15:25 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwpQByhmcToLCr1i/g+5dfeJyrnQroTWuW6ciExOrKYOzQiErT2Fu468xjrk+1eigQXSikm5Q==
X-Received: by 2002:a17:906:684a:b0:6ce:c1b4:b503 with SMTP id a10-20020a170906684a00b006cec1b4b503mr894476ejs.355.1645643725160;
        Wed, 23 Feb 2022 11:15:25 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:24 -0800 (PST)
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
Subject: [PATCH v2 08/11] vdpa: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:14:38 +0100
Message-Id: <20220223191441.348109-2-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
References: <20220223191310.347669-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Use a helper for seting driver_override to reduce amount of duplicated
code.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/vdpa/vdpa.c | 25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index 9846c9de4bfa..76ce2dcae7cb 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -77,32 +77,15 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct vdpa_device *vdev = dev_to_vdpa(dev);
-	const char *driver_override, *old;
-	char *cp;
+	int ret;
 
 	/* We need to keep extra room for a newline */
 	if (count >= (PAGE_SIZE - 1))
 		return -EINVAL;
 
-	driver_override = kstrndup(buf, count, GFP_KERNEL);
-	if (!driver_override)
-		return -ENOMEM;
-
-	cp = strchr(driver_override, '\n');
-	if (cp)
-		*cp = '\0';
-
-	device_lock(dev);
-	old = vdev->driver_override;
-	if (strlen(driver_override)) {
-		vdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		vdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &vdev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

