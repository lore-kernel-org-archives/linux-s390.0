Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25C14C433EF
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 19:14:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244327AbiBWTPR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:15:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244276AbiBWTPE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Feb 2022 14:15:04 -0500
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54575403F1
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 11:14:36 -0800 (PST)
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com [209.85.167.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id C06D93FCA5
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 19:14:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643671;
        bh=rf7a9EFQwPOyocENu81tYUT+5dnJvDmCZPPvLR/17AA=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=PFBr7dXlbLcAHA6UrmKevL74PYUyPbU1WAqpD/yas+Z5r4uD3ddVp8aASuOBNYl52
         uRxwlxUVX3hN9qdfama2uNcExZhXTZ8AnGlCQr8C9HvAsTsVV4lhPn+yMy7A9voCf+
         v6CdE9nejSOXiEetRWUlozGfdNlhFZ+0Mpi1RF2NUJGeM9MKSHN6eDEf+0Px2EjJ0f
         qPnXZ8rqv6XrlqwulekwWT3xY5GRAbuiNxog1OlVmTcFsjpka5WTMeZt8UVJmwzNdf
         DV3Qf+knbGvWdd32eq1yyMmwQgxjVhK4HqaPQtrYMHdnq6buUS1VLtaJLHqc+GVX9C
         3ybthL4O8AdNg==
Received: by mail-lf1-f70.google.com with SMTP id o25-20020a05651205d900b0043e6c10892bso3340484lfo.14
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 11:14:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=rf7a9EFQwPOyocENu81tYUT+5dnJvDmCZPPvLR/17AA=;
        b=OdEQpCgfNGzUT032z0zgJKHNlUREyjENlZXfVVT6e8mcrzLsMIAuWNVOewfTpRK3zr
         PWJoVFyPjwgwBsz5fqK8EuUHmx+vRIYLYGwwbTrmembEyHhbWuQRPH0au102iG4+vpcT
         WHT+hTKnMxhAjJ/mszpNoeqHNfWR9UPO8t51rsYWMPwcPTNObF6N3nXbO+si1vlvF0MO
         19Q5obxszdU0nnvGXRlc8pTi/P1qC2W9dztJHOgIHw73kX8TeDynyHLw/ThILt1b2CWT
         d3kxr0gKAeTFyG79ISHOypagcfNWSLwB6VDiGOEiZNQy8khm/2ocjSlUspRkJukWQclx
         s0Bw==
X-Gm-Message-State: AOAM531Pm1cuAPJ4VecZbF3AJ2BCKaEgy9KRxAmFa+ALuy3EIiUmZhs1
        JBATSdskzWfEzPhdqPLfYynm2PbbYktiRuPPbPbAg8AGzqR856K4w0SKtZbgXxjzu5LeRlfi92s
        fnWY/eAAh5ysTeYi3jFcR8xp4bTjNlSQbpYXRgkQ=
X-Received: by 2002:a17:906:e244:b0:6cd:24e3:ab8b with SMTP id gq4-20020a170906e24400b006cd24e3ab8bmr856445ejb.633.1645643640108;
        Wed, 23 Feb 2022 11:14:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyXgfLS9GHyX1kCvT/o1Mu24QLFIsYnwLPgsBOYcxKH/GiFu7jQtQB6sjAsK4TU39w3xnST4g==
X-Received: by 2002:a17:906:e244:b0:6cd:24e3:ab8b with SMTP id gq4-20020a170906e24400b006cd24e3ab8bmr856416ejb.633.1645643639914;
        Wed, 23 Feb 2022 11:13:59 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id q5sm212611ejc.115.2022.02.23.11.13.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:13:58 -0800 (PST)
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
Subject: [PATCH v2 05/11] pci: use helper for safer setting of driver_override
Date:   Wed, 23 Feb 2022 20:13:04 +0100
Message-Id: <20220223191310.347669-6-krzysztof.kozlowski@canonical.com>
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
 drivers/pci/pci-sysfs.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/pci-sysfs.c b/drivers/pci/pci-sysfs.c
index 602f0fb0b007..16a163d4623e 100644
--- a/drivers/pci/pci-sysfs.c
+++ b/drivers/pci/pci-sysfs.c
@@ -567,31 +567,15 @@ static ssize_t driver_override_store(struct device *dev,
 				     const char *buf, size_t count)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
-	char *driver_override, *old, *cp;
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
-	old = pdev->driver_override;
-	if (strlen(driver_override)) {
-		pdev->driver_override = driver_override;
-	} else {
-		kfree(driver_override);
-		pdev->driver_override = NULL;
-	}
-	device_unlock(dev);
-
-	kfree(old);
+	ret = driver_set_override(dev, &pdev->driver_override, buf);
+	if (ret)
+		return ret;
 
 	return count;
 }
-- 
2.32.0

