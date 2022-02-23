Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FEBC43217
	for <linux-s390@archiver.kernel.org>; Wed, 23 Feb 2022 19:15:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244264AbiBWTQD (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 23 Feb 2022 14:16:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243222AbiBWTQC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 23 Feb 2022 14:16:02 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FD4C40A37
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 11:15:34 -0800 (PST)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 4648F3FCAF
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 19:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1645643733;
        bh=7X8ZF+SfQI2ha/R62opt5Mpi3EJQ2IXnqtdf8o/szaw=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=DcJ3ufoZ31z87+LDCxnkvt/AuCaaGDMUkZkdYolSZXexkyjTwEFMsW+rojpl3ICyW
         yQv7XN8sb6QhtdEXsohlYjnsB7P7QfMgd1PEyaNghyawfwBtsfY7c2+vnAFNRltXis
         GNOXDMeyFW0LmU0PHYlIQiGnbiejQ1k/UPwwaNPvqFw57g2shBWdX5QQ1GjG7VD9JU
         z2Km9A2v4qrh0g5ZAWudrakslAORCNjzMqBBLQ4XjvALPAdDZdm+hZ/kYsYrHV4HxP
         PjsSj0FAps3om5QghJ2bngZNvwyiygKufziLWQffAsY+O+9Db5OayKWPeIoNn8+/cS
         HcNw7HidVvFag==
Received: by mail-ed1-f71.google.com with SMTP id l3-20020a50cbc3000000b0041083c11173so14079263edi.4
        for <linux-s390@vger.kernel.org>; Wed, 23 Feb 2022 11:15:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7X8ZF+SfQI2ha/R62opt5Mpi3EJQ2IXnqtdf8o/szaw=;
        b=ATuHtNSjAhw+QpUq53zwDtCAsbQsvHSBsOV94zqKFuvbSOq2UR7FHY9EQi60fUSO+B
         9FvOOJB1CUmuXHftD9dprHUmZA9oWr3438YoH8KsLYpuIrVeTRMwIewMHoMZAX+6Xhyu
         k8trK8HgjgzX6j9nAJvrAaoctcqo7NvDQw5O97yhp316K2oJQJZRaNDdJDxplSfKO2J8
         VTg2NgATJGo4h2Bhy2b+k91We2eALyci7XYfKUrGnA0SPycIOMaRMSh9riGefnT1dh4S
         yACGiPO/ur5wFBhOjTq1qnVMA4KrSkB+HtmmZEx3Sn+ahjoHhom/YB7GCYNbh+2AUdy4
         SqHw==
X-Gm-Message-State: AOAM533AO28SzLSSLCYNwHBlrxBTzs1RjIUd797BSfYTaZtwt751VgGY
        LJyGtHImePvKn8ZEKBTduJOupB05QVHnRhw77SV3lAvf7QWRPDVTJO6Cy3Yk2BIZ/f2scjUuqqB
        LH9RRQW6PQ5fIrx2h2Dxvmm9Z9KAy8EgNwZ3818c=
X-Received: by 2002:a17:906:130a:b0:6b7:5e48:350a with SMTP id w10-20020a170906130a00b006b75e48350amr887349ejb.184.1645643731006;
        Wed, 23 Feb 2022 11:15:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzAUHN+IckyCUDaf6b+egXxiKcwH4G6el1z4Ve3vQHF0MnEv7U39pYdE62mAB1vpTAj/GhtQ==
X-Received: by 2002:a17:906:130a:b0:6b7:5e48:350a with SMTP id w10-20020a170906130a00b006b75e48350amr887325ejb.184.1645643730755;
        Wed, 23 Feb 2022 11:15:30 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-181-108.adslplus.ch. [188.155.181.108])
        by smtp.gmail.com with ESMTPSA id b3sm208368ejl.67.2022.02.23.11.15.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Feb 2022 11:15:30 -0800 (PST)
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
Subject: [PATCH v2 11/11] rpmsg: fix kfree() of static memory on setting driver_override
Date:   Wed, 23 Feb 2022 20:14:41 +0100
Message-Id: <20220223191441.348109-5-krzysztof.kozlowski@canonical.com>
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

Fixes: 950a7388f02b ("rpmsg: Turn name service into a stand alone driver")
Fixes: c0cdc19f84a4 ("rpmsg: Driver for user space endpoint interface")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
---
 drivers/rpmsg/rpmsg_internal.h | 13 +++++++++++--
 drivers/rpmsg/rpmsg_ns.c       | 14 ++++++++++++--
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/rpmsg/rpmsg_internal.h b/drivers/rpmsg/rpmsg_internal.h
index b1245d3ed7c6..c7bd0a3c802d 100644
--- a/drivers/rpmsg/rpmsg_internal.h
+++ b/drivers/rpmsg/rpmsg_internal.h
@@ -92,10 +92,19 @@ int rpmsg_release_channel(struct rpmsg_device *rpdev,
  */
 static inline int rpmsg_chrdev_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_chrdev");
-	rpdev->driver_override = "rpmsg_chrdev";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  "rpmsg_chrdev");
+	if (ret)
+		return ret;
+
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
 
-	return rpmsg_register_device(rpdev);
+	return ret;
 }
 
 #endif
diff --git a/drivers/rpmsg/rpmsg_ns.c b/drivers/rpmsg/rpmsg_ns.c
index 762ff1ae279f..1c9f9cf065b0 100644
--- a/drivers/rpmsg/rpmsg_ns.c
+++ b/drivers/rpmsg/rpmsg_ns.c
@@ -20,12 +20,22 @@
  */
 int rpmsg_ns_register_device(struct rpmsg_device *rpdev)
 {
+	int ret;
+
 	strcpy(rpdev->id.name, "rpmsg_ns");
-	rpdev->driver_override = "rpmsg_ns";
+	ret = driver_set_override(&rpdev->dev, &rpdev->driver_override,
+				  "rpmsg_ns");
+	if (ret)
+		return ret;
+
 	rpdev->src = RPMSG_NS_ADDR;
 	rpdev->dst = RPMSG_NS_ADDR;
 
-	return rpmsg_register_device(rpdev);
+	ret = rpmsg_register_device(rpdev);
+	if (ret)
+		kfree(rpdev->driver_override);
+
+	return ret;
 }
 EXPORT_SYMBOL(rpmsg_ns_register_device);
 
-- 
2.32.0

