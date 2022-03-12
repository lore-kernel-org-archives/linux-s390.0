Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7562EC35278
	for <linux-s390@archiver.kernel.org>; Sat, 12 Mar 2022 13:29:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiCLNaw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 12 Mar 2022 08:30:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231947AbiCLNar (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 12 Mar 2022 08:30:47 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DD116AA60
        for <linux-s390@vger.kernel.org>; Sat, 12 Mar 2022 05:29:35 -0800 (PST)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CDDB340160
        for <linux-s390@vger.kernel.org>; Sat, 12 Mar 2022 13:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1647091773;
        bh=wjZwot9f8/6VteNlj7+yTRpLXeLfeCZvZ3XmJn6m/ng=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=XbD4yeG8zEqpcOpeWAtk8ocxjWDyEhsopP2iX/RjPmzUYpOhcjay6H5J5v1tumuDR
         Uc7M3zX072fXEUPPvkdNEERkX64ZDZbmUZCThisLjuN5mTG2yvG6xNA1TsWOaHuuXP
         4RBzXQXiTvNt/9ken8ELipsrofW/zaHMgfmtdVx+G49aEvOyXc1MFTmrkkEi5rXu+8
         IJDOJiXMrPWRUJxU/G2KoclNxwh4CHzAyzKW1IE/LEZ8q8i3FKwdlDvPS6rd5H0ESe
         LvYLJ9uWegv3rWNYvCbWm1p4r0a1UuO/9xk3nKnjG0MxrU+ztkCQn2GNffSQuJeoRE
         OwM/6q8kuWFmQ==
Received: by mail-wm1-f70.google.com with SMTP id k41-20020a05600c1ca900b00389a2b983efso3523836wms.4
        for <linux-s390@vger.kernel.org>; Sat, 12 Mar 2022 05:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wjZwot9f8/6VteNlj7+yTRpLXeLfeCZvZ3XmJn6m/ng=;
        b=ERkTTtaqiRyM2sLPXLCfOhFL8heGuRh6mspp8IDe+55RU0GhkfT1emIxrgrY7sz2Vi
         3qaxkRri6+nYz2nZLTAGYruXqf15r9fxiiF/3QYTDpgxcBq0jt7Jr3B8SMc+sUe/7q+J
         8YXyB8Jjmz0lPATBfLsiBMFbzOWqu+YrfFp+T8i9fLnaeD7nmnJP4JKPnAkM71yV7ki6
         fZPuqUck6E4MLJtboPirr+nnr8Y86a7v5xIBpIbtFlHmawar9oeUTHeZqN4pRxLDO0Un
         PEAQge0k28/y3DVNYWKjxM+BEDg5fN+NVavNekjom2yCE+XWJYqNqAZ9k0lbvpYzYoxm
         Hofg==
X-Gm-Message-State: AOAM531/m9ea8H6vrZ1cKeupaJsGOBor6i0DMAryYxnQgT8UNcC6YiQY
        DbuQIdWPANnnVF1BuMTK3tRw6baBh5mJLi3Uswqr1KwdWKHZ+P026yzUyPp1R2zNTIIWT2BQJ5M
        uZwMww3sdhkEu+o0R3sw45faDDYvLDEb87G93UxI=
X-Received: by 2002:a05:6000:1d89:b0:1ed:b6d5:cbda with SMTP id bk9-20020a0560001d8900b001edb6d5cbdamr10364635wrb.514.1647091772814;
        Sat, 12 Mar 2022 05:29:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyelFNDw+KjZ7SCVNW/uSQN6y5Cx82RSy4B7GdAXYbkw1fNE1IGPsgLOaQGJqZ3rrBpRaBuDg==
X-Received: by 2002:a05:6000:1d89:b0:1ed:b6d5:cbda with SMTP id bk9-20020a0560001d8900b001edb6d5cbdamr10364629wrb.514.1647091772632;
        Sat, 12 Mar 2022 05:29:32 -0800 (PST)
Received: from localhost.localdomain (xdsl-188-155-174-239.adslplus.ch. [188.155.174.239])
        by smtp.gmail.com with ESMTPSA id p22-20020a1c5456000000b00389e7e62800sm5751550wmi.8.2022.03.12.05.29.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Mar 2022 05:29:32 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Stuart Yoder <stuyoder@gmail.com>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        stable@vger.kernel.org
Subject: [PATCH v4 10/11] slimbus: qcom-ngd: Fix kfree() of static memory on setting driver_override
Date:   Sat, 12 Mar 2022 14:28:55 +0100
Message-Id: <20220312132856.65163-11-krzysztof.kozlowski@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
References: <20220312132856.65163-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The driver_override field from platform driver should not be initialized
from static memory (string literal) because the core later kfree() it,
for example when driver_override is set via sysfs.

Use dedicated helper to set driver_override properly.

Fixes: 917809e2280b ("slimbus: ngd: Add qcom SLIMBus NGD driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index 7040293c2ee8..e5d9fdb81eb0 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1434,6 +1434,7 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 	const struct of_device_id *match;
 	struct device_node *node;
 	u32 id;
+	int ret;
 
 	match = of_match_node(qcom_slim_ngd_dt_match, parent->of_node);
 	data = match->data;
@@ -1455,7 +1456,17 @@ static int of_qcom_slim_ngd_register(struct device *parent,
 		}
 		ngd->id = id;
 		ngd->pdev->dev.parent = parent;
-		ngd->pdev->driver_override = QCOM_SLIM_NGD_DRV_NAME;
+
+		ret = driver_set_override(&ngd->pdev->dev,
+					  &ngd->pdev->driver_override,
+					  QCOM_SLIM_NGD_DRV_NAME,
+					  strlen(QCOM_SLIM_NGD_DRV_NAME));
+		if (ret) {
+			platform_device_put(ngd->pdev);
+			kfree(ngd);
+			of_node_put(node);
+			return ret;
+		}
 		ngd->pdev->dev.of_node = node;
 		ctrl->ngd = ngd;
 
-- 
2.32.0

