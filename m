Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63A20C433FE
	for <linux-s390@archiver.kernel.org>; Sun,  3 Apr 2022 18:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376268AbiDCSlS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 3 Apr 2022 14:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376310AbiDCSlO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 3 Apr 2022 14:41:14 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DF0413CDB
        for <linux-s390@vger.kernel.org>; Sun,  3 Apr 2022 11:38:34 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id w21so11444767wra.2
        for <linux-s390@vger.kernel.org>; Sun, 03 Apr 2022 11:38:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MZB4AAiYpghp+j0HlvXqcm6S1oaOh86fqoD06sTrQvg=;
        b=kQuFtN1ZJ7ZEWNRiYUTzh4L+FIyF2IAzdImkdOzevIE5eiZGdn+q3FmReheaQqVDJw
         RskYuVoBzzQ6cYTz5auNikNGSNT7g2fh8d8+oViTwXZxppZ5YQYKGht/zN9zBCRcL02E
         Xm+/QT3ElgFG38vFFRgHTSvJU9bPYGfYW4WgdLmDCkgrhbn69muqQabUVjTEdPkdeV8k
         opstQvC0WN5quf+I8FeG2fNS4A2gmCh4D1RdmllqzfnGn7vdJZ3yheVSM/EaXuPEj9Vc
         2fvCQmg7oO6EkJmNRgXmdRFFjq7jHRIoBMc3kPYgrbpi1W67+iVi6RBE3Qwoc0qLLSWK
         Xisw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MZB4AAiYpghp+j0HlvXqcm6S1oaOh86fqoD06sTrQvg=;
        b=772m7kY5RQrCl/Ir5m3NnF7uT65b5T1GQ3czcY4dUjTJqnd27GPjAY8yNOReEJjcuI
         4QdGAs319rJQ0aU0/6sENDwj2scaYFur4VQEzBBjwBU29d+q9Gcb8ZEHsxEHoltph59P
         660qf2JPpBIB3XDut2nE1xtIon+chpwQUTzAy+HminUeTU3oFavuZxdWFQUeWb72wjpR
         meyZwXg/WXyUlyr+5fXoEfNlzEia6qzBlmV8uu6J1ZSqXt86LJozxHbnyE0iIIMT5GX4
         qUl2fvCF03m74ZgKoxzz7WjiwSMfS3MZcGAvjcUO9nR+HgCAWwJ2YMYkQSbDXs2T9GYl
         I1FQ==
X-Gm-Message-State: AOAM533ojf4TvT2jRo8uCq4GvPmoyIt9UwMk6tI4A+n0jRVNst/76Foo
        nerqLs+lQSXhIAO0uLRSjs+C7w==
X-Google-Smtp-Source: ABdhPJyXLIonD8xJ04Ht+ZUS+MlZjOb0BB8xnHg1SPUSIK9rnAYM+w0VRFN1jjXeVcx09AL7w4RlJA==
X-Received: by 2002:a5d:5953:0:b0:206:b5c:dfe8 with SMTP id e19-20020a5d5953000000b002060b5cdfe8mr4209687wri.35.1649011112553;
        Sun, 03 Apr 2022 11:38:32 -0700 (PDT)
Received: from localhost.localdomain (xdsl-188-155-201-27.adslplus.ch. [188.155.201.27])
        by smtp.gmail.com with ESMTPSA id l28-20020a05600c1d1c00b0038e72a95ec4sm593851wms.13.2022.04.03.11.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 11:38:32 -0700 (PDT)
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
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH v6 11/12] rpmsg: Constify local variable in field store macro
Date:   Sun,  3 Apr 2022 20:37:57 +0200
Message-Id: <20220403183758.192236-12-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
References: <20220403183758.192236-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Memory pointed by variable 'old' in field store macro is not modified,
so it can be made a pointer to const.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/rpmsg/rpmsg_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/rpmsg/rpmsg_core.c b/drivers/rpmsg/rpmsg_core.c
index 79368a957d89..95fc283f6af7 100644
--- a/drivers/rpmsg/rpmsg_core.c
+++ b/drivers/rpmsg/rpmsg_core.c
@@ -400,7 +400,8 @@ field##_store(struct device *dev, struct device_attribute *attr,	\
 	      const char *buf, size_t sz)				\
 {									\
 	struct rpmsg_device *rpdev = to_rpmsg_device(dev);		\
-	char *new, *old;						\
+	const char *old;						\
+	char *new;							\
 									\
 	new = kstrndup(buf, sz, GFP_KERNEL);				\
 	if (!new)							\
-- 
2.32.0

